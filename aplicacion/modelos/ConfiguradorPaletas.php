<?php

namespace Aplicacion\Modelos;

use Aplicacion\Nucleo\Modelo;

class ConfiguradorPaletas extends Modelo
{
    public function listarProductosConfigurador(int $empresaId, string $rol = ''): array
    {
        $sql = 'SELECT p.id, p.nombre, p.descripcion, p.precio, p.precio_oferta, p.stock_actual, p.estado, c.nombre AS categoria,
                       pa.speed, pa.control_score, pa.spin, pa.hardness, pa.tacky_type, pa.arc, pa.weight_grams,
                       pa.composition, pa.handle_type, pa.player_level, pa.play_style, pa.rubber_type, pa.category_role,
                       pa.is_forehand_recommended, pa.is_backhand_recommended, pa.tags,
                       (SELECT pi.ruta FROM productos_imagenes pi WHERE pi.producto_id = p.id ORDER BY pi.es_principal DESC, pi.id ASC LIMIT 1) AS imagen
                FROM productos p
                INNER JOIN product_attributes pa ON pa.product_id = p.id AND pa.is_active = 1
                LEFT JOIN categorias_productos c ON c.id = p.categoria_id
                WHERE p.empresa_id = :empresa_id
                  AND p.fecha_eliminacion IS NULL
                  AND p.estado = "activo"
                  AND COALESCE(p.mostrar_catalogo, 1) = 1';

        $params = ['empresa_id' => $empresaId];
        if ($rol !== '') {
            $sql .= ' AND pa.category_role = :rol';
            $params['rol'] = $rol;
        }

        $sql .= ' ORDER BY COALESCE(pa.featured_order, 9999) ASC, p.nombre ASC';

        $stmt = $this->db->prepare($sql);
        $stmt->execute($params);
        $items = $stmt->fetchAll() ?: [];

        foreach ($items as &$item) {
            $item['variants'] = $this->listarVariantesProducto((int) ($item['id'] ?? 0));
        }
        unset($item);

        return $items;
    }

    public function listarVariantesProducto(int $productoId): array
    {
        $stmt = $this->db->prepare('SELECT * FROM product_variants WHERE product_id = :product_id AND is_active = 1 ORDER BY id ASC');
        $stmt->execute(['product_id' => $productoId]);
        return $stmt->fetchAll() ?: [];
    }

    public function obtenerProductoConfigurador(int $empresaId, int $productoId): ?array
    {
        $stmt = $this->db->prepare('SELECT p.id, p.nombre, p.descripcion, p.precio, p.precio_oferta, p.stock_actual, p.estado,
                                           pa.speed, pa.control_score, pa.spin, pa.hardness, pa.tacky_type, pa.arc, pa.weight_grams,
                                           pa.composition, pa.handle_type, pa.player_level, pa.play_style, pa.rubber_type, pa.category_role,
                                           pa.is_forehand_recommended, pa.is_backhand_recommended, pa.tags,
                                           (SELECT pi.ruta FROM productos_imagenes pi WHERE pi.producto_id = p.id ORDER BY pi.es_principal DESC, pi.id ASC LIMIT 1) AS imagen
                                    FROM productos p
                                    INNER JOIN product_attributes pa ON pa.product_id = p.id AND pa.is_active = 1
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
            $producto['variants'] = $this->listarVariantesProducto((int) $producto['id']);
        }
        return $producto;
    }

    public function listarReglas(int $empresaId): array
    {
        $stmt = $this->db->prepare('SELECT * FROM racket_recommendation_rules WHERE empresa_id = :empresa_id ORDER BY id DESC');
        $stmt->execute(['empresa_id' => $empresaId]);
        return $stmt->fetchAll() ?: [];
    }

    public function guardarRegla(int $empresaId, array $data): void
    {
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
        $stmt = $this->db->prepare('SELECT * FROM racket_builds WHERE empresa_id = :empresa_id ORDER BY id DESC LIMIT :limite');
        $stmt->bindValue(':empresa_id', $empresaId, \PDO::PARAM_INT);
        $stmt->bindValue(':limite', max(1, $limite), \PDO::PARAM_INT);
        $stmt->execute();
        return $stmt->fetchAll() ?: [];
    }

    public function upsertSetting(int $empresaId, string $key, string $value, string $type = 'text', string $description = ''): void
    {
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
}
