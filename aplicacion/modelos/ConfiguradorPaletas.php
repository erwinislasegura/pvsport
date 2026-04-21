<?php

namespace Aplicacion\Modelos;

use Aplicacion\Nucleo\Modelo;

class ConfiguradorPaletas extends Modelo
{
    private array $cacheTablas = [];

    public function listarProductosConfigurador(int $empresaId, string $rol = ''): array
    {
        $joinAtributos = $this->tieneTabla('product_attributes')
            ? 'LEFT JOIN product_attributes pa ON pa.product_id = p.id AND pa.is_active = 1'
            : 'LEFT JOIN (SELECT NULL AS product_id, NULL AS speed, NULL AS control_score, NULL AS spin, NULL AS hardness,
                                 NULL AS tacky_type, NULL AS arc, NULL AS weight_grams, NULL AS composition, NULL AS handle_type,
                                 NULL AS player_level, NULL AS play_style, NULL AS rubber_type, NULL AS category_role,
                                 NULL AS is_forehand_recommended, NULL AS is_backhand_recommended, NULL AS tags, NULL AS featured_order) pa ON 1=0';

        $sql = 'SELECT p.id, p.nombre, p.descripcion, p.precio, p.precio_oferta, p.stock_actual, p.proximo_catalogo, p.proximo_dias_catalogo, p.estado, c.nombre AS categoria,
                       pa.speed, pa.control_score, pa.spin, pa.hardness, pa.tacky_type, pa.arc, pa.weight_grams,
                       pa.composition, pa.handle_type, pa.player_level, pa.play_style, pa.rubber_type, pa.category_role,
                       pa.is_forehand_recommended, pa.is_backhand_recommended, pa.tags,
                       (SELECT pi.ruta FROM productos_imagenes pi WHERE pi.producto_id = p.id ORDER BY pi.es_principal DESC, pi.id ASC LIMIT 1) AS imagen
                FROM productos p
                ' . $joinAtributos . '
                LEFT JOIN categorias_productos c ON c.id = p.categoria_id
                WHERE p.empresa_id = :empresa_id
                  AND p.fecha_eliminacion IS NULL
                  AND p.estado = "activo"
                  AND COALESCE(p.mostrar_catalogo, 1) = 1';

        $params = ['empresa_id' => $empresaId];
        $sql .= ' ORDER BY COALESCE(pa.featured_order, 9999) ASC, p.nombre ASC';

        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        $items = $stmt->fetchAll() ?: [];

        $filtrados = [];
        foreach ($items as &$item) {
            $item['category_role'] = $this->inferirRolConfigurador($item);
            $this->normalizarMetricas($item);
            $item['variants'] = $this->listarVariantesProducto((int) ($item['id'] ?? 0));
            if ($rol !== '' && $item['category_role'] !== $rol) {
                continue;
            }
            $filtrados[] = $item;
        }
        unset($item);

        return $filtrados;
    }

    public function listarVariantesProducto(int $productoId): array
    {
        if (!$this->tieneTabla('product_variants')) {
            return [];
        }

        $stmt = $this->db->prepare('SELECT * FROM product_variants WHERE product_id = :product_id AND is_active = 1 ORDER BY id ASC');
        $stmt->execute(['product_id' => $productoId]);
        return $stmt->fetchAll() ?: [];
    }

    public function obtenerProductoConfigurador(int $empresaId, int $productoId): ?array
    {
        $joinAtributos = $this->tieneTabla('product_attributes')
            ? 'LEFT JOIN product_attributes pa ON pa.product_id = p.id AND pa.is_active = 1'
            : 'LEFT JOIN (SELECT NULL AS product_id, NULL AS speed, NULL AS control_score, NULL AS spin, NULL AS hardness,
                                 NULL AS tacky_type, NULL AS arc, NULL AS weight_grams, NULL AS composition, NULL AS handle_type,
                                 NULL AS player_level, NULL AS play_style, NULL AS rubber_type, NULL AS category_role,
                                 NULL AS is_forehand_recommended, NULL AS is_backhand_recommended, NULL AS tags) pa ON 1=0';

        $stmt = $this->db->prepare('SELECT p.id, p.nombre, p.descripcion, p.precio, p.precio_oferta, p.stock_actual, p.proximo_catalogo, p.proximo_dias_catalogo, p.estado,
                                           c.nombre AS categoria,
                                           pa.speed, pa.control_score, pa.spin, pa.hardness, pa.tacky_type, pa.arc, pa.weight_grams,
                                           pa.composition, pa.handle_type, pa.player_level, pa.play_style, pa.rubber_type, pa.category_role,
                                           pa.is_forehand_recommended, pa.is_backhand_recommended, pa.tags,
                                           (SELECT pi.ruta FROM productos_imagenes pi WHERE pi.producto_id = p.id ORDER BY pi.es_principal DESC, pi.id ASC LIMIT 1) AS imagen
                                    FROM productos p
                                    ' . $joinAtributos . '
                                    LEFT JOIN categorias_productos c ON c.id = p.categoria_id
                                    WHERE p.empresa_id = :empresa_id
                                      AND p.id = :id
                                      AND p.fecha_eliminacion IS NULL
                                    LIMIT 1');
        $stmt->execute([
            'empresa_id' => $empresaId,
            'id' => $productoId,
        ]);
        $producto = $stmt->fetch() ?: null;
        if ($producto) {
            $producto['category_role'] = $this->inferirRolConfigurador($producto);
            $this->normalizarMetricas($producto);
            $producto['variants'] = $this->listarVariantesProducto((int) $producto['id']);
        }
        return $producto;
    }

    public function listarReglas(int $empresaId): array
    {
        if (!$this->tieneTabla('racket_recommendation_rules')) {
            return [];
        }

        $stmt = $this->db->prepare('SELECT * FROM racket_recommendation_rules WHERE empresa_id = :empresa_id ORDER BY id DESC');
        $stmt->execute(['empresa_id' => $empresaId]);
        return $stmt->fetchAll() ?: [];
    }

    public function guardarRegla(int $empresaId, array $data): void
    {
        if (!$this->tieneTabla('racket_recommendation_rules')) {
            return;
        }

        $stmt = $this->db->prepare('INSERT INTO racket_recommendation_rules
            (empresa_id, rule_name, level, style, priority_metric, budget_min, budget_max, transition_type, blade_weight, fh_weight, bh_weight, created_at, updated_at)
            VALUES
            (:empresa_id, :rule_name, :level, :style, :priority_metric, :budget_min, :budget_max, :transition_type, :blade_weight, :fh_weight, :bh_weight, NOW(), NOW())');

        $stmt->execute([
            'empresa_id' => $empresaId,
            'rule_name' => trim((string) ($data['rule_name'] ?? 'Regla')),
            'level' => trim((string) ($data['level'] ?? 'intermedio')),
            'style' => trim((string) ($data['style'] ?? 'allround')),
            'priority_metric' => trim((string) ($data['priority_metric'] ?? 'equilibrio')),
            'budget_min' => (float) ($data['budget_min'] ?? 0),
            'budget_max' => (float) ($data['budget_max'] ?? 999999999),
            'transition_type' => trim((string) ($data['transition_type'] ?? 'suave')),
            'blade_weight' => (float) ($data['blade_weight'] ?? 1),
            'fh_weight' => (float) ($data['fh_weight'] ?? 1),
            'bh_weight' => (float) ($data['bh_weight'] ?? 1),
        ]);
    }

    public function guardarBuild(array $data): int
    {
        if (!$this->tieneTabla('racket_builds')) {
            return 0;
        }

        $stmt = $this->db->prepare('INSERT INTO racket_builds
            (empresa_id, session_id, user_id, blade_product_id, blade_variant_id, fh_rubber_product_id, fh_variant_id,
             bh_rubber_product_id, bh_variant_id, edge_tape_product_id, case_product_id, glue_product_id, cleaner_product_id,
             assembly_service_product_id, total_price, speed_total, control_total, spin_total, hardness_total, weight_total,
             player_profile, status, build_payload, created_at, updated_at)
            VALUES
            (:empresa_id, :session_id, :user_id, :blade_product_id, :blade_variant_id, :fh_rubber_product_id, :fh_variant_id,
             :bh_rubber_product_id, :bh_variant_id, :edge_tape_product_id, :case_product_id, :glue_product_id, :cleaner_product_id,
             :assembly_service_product_id, :total_price, :speed_total, :control_total, :spin_total, :hardness_total, :weight_total,
             :player_profile, :status, :build_payload, NOW(), NOW())');

        $stmt->execute($data);
        return (int) $this->db->lastInsertId();
    }

    public function listarBuilds(int $empresaId, int $limite = 80): array
    {
        if (!$this->tieneTabla('racket_builds')) {
            return [];
        }

        $stmt = $this->db->prepare('SELECT * FROM racket_builds WHERE empresa_id = :empresa_id ORDER BY id DESC LIMIT :limite');
        $stmt->bindValue(':empresa_id', $empresaId, \PDO::PARAM_INT);
        $stmt->bindValue(':limite', max(1, $limite), \PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll() ?: [];
    }

    public function upsertSetting(int $empresaId, string $key, string $value, string $type = 'text', string $description = ''): void
    {
        if (!$this->tieneTabla('racket_configuration_settings')) {
            return;
        }

        $stmt = $this->db->prepare('INSERT INTO racket_configuration_settings (empresa_id, `key`, `value`, `type`, `description`, updated_at)
            VALUES (:empresa_id, :key_name, :value, :type, :description, NOW())
            ON DUPLICATE KEY UPDATE `value` = VALUES(`value`), `type` = VALUES(`type`), `description` = VALUES(`description`), updated_at = NOW()');
        $stmt->execute([
            'empresa_id' => $empresaId,
            'key_name' => $key,
            'value' => $value,
            'type' => $type,
            'description' => $description,
        ]);
    }

    public function obtenerSettings(int $empresaId): array
    {
        if (!$this->tieneTabla('racket_configuration_settings')) {
            return [];
        }

        $stmt = $this->db->prepare('SELECT `key`, `value`, `type`, `description` FROM racket_configuration_settings WHERE empresa_id = :empresa_id');
        $stmt->execute(['empresa_id' => $empresaId]);
        $rows = $stmt->fetchAll() ?: [];
        $map = [];
        foreach ($rows as $row) {
            $map[(string) $row['key']] = $row;
        }
        return $map;
    }

    public function upsertAtributosProducto(int $productoId, array $data): void
    {
        if (!$this->tieneTabla('product_attributes')) {
            return;
        }

        $stmt = $this->db->prepare('INSERT INTO product_attributes
            (product_id, speed, control_score, spin, hardness, tacky_type, arc, weight_grams, composition, handle_type,
             player_level, play_style, rubber_type, category_role, is_forehand_recommended, is_backhand_recommended,
             tags, featured_order, is_active, created_at, updated_at)
            VALUES
            (:product_id, :speed, :control_score, :spin, :hardness, :tacky_type, :arc, :weight_grams, :composition, :handle_type,
             :player_level, :play_style, :rubber_type, :category_role, :is_forehand_recommended, :is_backhand_recommended,
             :tags, :featured_order, :is_active, NOW(), NOW())
            ON DUPLICATE KEY UPDATE
            speed = VALUES(speed), control_score = VALUES(control_score), spin = VALUES(spin), hardness = VALUES(hardness),
            tacky_type = VALUES(tacky_type), arc = VALUES(arc), weight_grams = VALUES(weight_grams), composition = VALUES(composition),
            handle_type = VALUES(handle_type), player_level = VALUES(player_level), play_style = VALUES(play_style),
            rubber_type = VALUES(rubber_type), category_role = VALUES(category_role),
            is_forehand_recommended = VALUES(is_forehand_recommended), is_backhand_recommended = VALUES(is_backhand_recommended),
            tags = VALUES(tags), featured_order = VALUES(featured_order), is_active = VALUES(is_active), updated_at = NOW()');

        $stmt->execute([
            'product_id' => $productoId,
            'speed' => (float) ($data['speed'] ?? 0),
            'control_score' => (float) ($data['control_score'] ?? 0),
            'spin' => (float) ($data['spin'] ?? 0),
            'hardness' => (float) ($data['hardness'] ?? 0),
            'tacky_type' => trim((string) ($data['tacky_type'] ?? '')),
            'arc' => trim((string) ($data['arc'] ?? '')),
            'weight_grams' => (float) ($data['weight_grams'] ?? 0),
            'composition' => trim((string) ($data['composition'] ?? '')),
            'handle_type' => trim((string) ($data['handle_type'] ?? '')),
            'player_level' => trim((string) ($data['player_level'] ?? 'intermedio')),
            'play_style' => trim((string) ($data['play_style'] ?? 'allround')),
            'rubber_type' => trim((string) ($data['rubber_type'] ?? '')),
            'category_role' => trim((string) ($data['category_role'] ?? 'accessory')),
            'is_forehand_recommended' => !empty($data['is_forehand_recommended']) ? 1 : 0,
            'is_backhand_recommended' => !empty($data['is_backhand_recommended']) ? 1 : 0,
            'tags' => trim((string) ($data['tags'] ?? '')),
            'featured_order' => (int) ($data['featured_order'] ?? 999),
            'is_active' => isset($data['is_active']) ? ((int) $data['is_active']) : 1,
        ]);
    }

    private function tieneTabla(string $tabla): bool
    {
        if (array_key_exists($tabla, $this->cacheTablas)) {
            return $this->cacheTablas[$tabla];
        }

        $stmt = $this->db->prepare('SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :tabla');
        $stmt->execute(['tabla' => $tabla]);
        $this->cacheTablas[$tabla] = ((int) $stmt->fetchColumn()) > 0;
        return $this->cacheTablas[$tabla];
    }

    private function inferirRolConfigurador(array $item): string
    {
        $rolActual = trim((string) ($item['category_role'] ?? ''));
        if ($rolActual !== '') {
            return $rolActual;
        }

        $texto = mb_strtolower(
            trim((string) ($item['categoria'] ?? '') . ' ' . (string) ($item['nombre'] ?? '') . ' ' . (string) ($item['descripcion'] ?? ''))
        );

        if ($texto === '') {
            return 'unknown';
        }
        if (preg_match('/mader|blade|paleta|raqueta|racket|mango fl|mango an|mango st|allwood|carbon|wood/', $texto) === 1) {
            return 'blade';
        }
        if (preg_match('/goma|caucho|revest|rubber|tacky|tensor|esponja|spin|forehand|backhand/', $texto) === 1) {
            return 'rubber';
        }
        if (preg_match('/armado|pegado|ensamblado/', $texto) === 1) {
            return 'assembly_service';
        }
        if (preg_match('/funda|cinta|pegamento|cleaner|limpiador|protector/', $texto) === 1) {
            return 'accessory';
        }

        return 'unknown';
    }

    private function normalizarMetricas(array &$item): void
    {
        $item['speed'] = (float) ($item['speed'] ?? 0);
        $item['control_score'] = (float) ($item['control_score'] ?? 0);
        $item['spin'] = (float) ($item['spin'] ?? 0);
        $item['hardness'] = (float) ($item['hardness'] ?? 0);

        $texto = mb_strtolower((string) ($item['descripcion'] ?? ''));
        if ($item['speed'] <= 0) {
            $item['speed'] = str_contains($texto, 'rápid') || str_contains($texto, 'rapid') ? 8.2 : 7.0;
        }
        if ($item['control_score'] <= 0) {
            $item['control_score'] = str_contains($texto, 'control') ? 8.2 : 7.0;
        }
        if ($item['spin'] <= 0) {
            $item['spin'] = str_contains($texto, 'spin') || str_contains($texto, 'efecto') ? 8.0 : 7.0;
        }
        if ($item['hardness'] <= 0) {
            $item['hardness'] = str_contains($texto, 'duro') ? 8.0 : 6.8;
        }
    }
}
