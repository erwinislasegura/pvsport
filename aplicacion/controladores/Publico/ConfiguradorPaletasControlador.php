<?php

namespace Aplicacion\Controladores\Publico;

use Aplicacion\Nucleo\Controlador;
use Aplicacion\Nucleo\BaseDatos;
use Aplicacion\Modelos\Empresa;
use Aplicacion\Modelos\ConfiguradorPaletas;
use Aplicacion\Servicios\ConfiguradorPaletasService;

class ConfiguradorPaletasControlador extends Controlador
{
    public function landingPorDominio(): void
    {
        $empresaId = $this->resolverEmpresaDominio();
        if ($empresaId <= 0) {
            http_response_code(404);
            require __DIR__ . '/../../vistas/errores/404.php';
            return;
        }

        $this->landing($empresaId);
    }

    public function landing(int $empresaId): void
    {
        $empresa = (new Empresa())->buscar($empresaId);
        if (!$empresa) {
            http_response_code(404);
            require __DIR__ . '/../../vistas/errores/404.php';
            return;
        }

        $modelo = new ConfiguradorPaletas();
        $productos = $modelo->listarProductosConfigurador($empresaId);
        $settings = $modelo->obtenerSettings($empresaId);
        $reglas = $modelo->listarReglas($empresaId);

        $catalogoRutas = [
            'base' => url('/catalogo/' . $empresaId),
            'nosotros' => url('/catalogo/' . $empresaId . '/nosotros'),
            'contacto' => url('/catalogo/' . $empresaId . '/contacto'),
            'faq' => url('/catalogo/' . $empresaId . '/preguntas-frecuentes'),
        ];
        $catalogoTopbar = [
            'texto' => trim((string) ($empresa['catalogo_topbar_texto'] ?? '')),
            'color_primario' => trim((string) ($empresa['catalogo_color_primario'] ?? '')),
            'color_acento' => trim((string) ($empresa['catalogo_color_acento'] ?? '')),
            'sociales' => [
                'facebook' => trim((string) ($empresa['catalogo_social_facebook'] ?? '')),
                'instagram' => trim((string) ($empresa['catalogo_social_instagram'] ?? '')),
                'tiktok' => trim((string) ($empresa['catalogo_social_tiktok'] ?? '')),
                'linkedin' => trim((string) ($empresa['catalogo_social_linkedin'] ?? '')),
                'youtube' => trim((string) ($empresa['catalogo_social_youtube'] ?? '')),
            ],
        ];
        $logoCatalogo = url('/catalogo/' . $empresaId . '/logo?v=' . rawurlencode((string) ($empresa['fecha_actualizacion'] ?? time())));
        $socialesTopbar = [];
        $topbarTexto = (string) ($catalogoTopbar['texto'] !== '' ? $catalogoTopbar['texto'] : 'Configurador premium PV Sport • Armado profesional y asesoría experta');
        $renderIconoRed = static fn(string $id): string => '';
        $catalogoBaseUrl = $catalogoRutas['base'];
        $catalogoNosotrosUrl = $catalogoRutas['nosotros'];
        $catalogoContactoUrl = $catalogoRutas['contacto'];
        $catalogoFaqUrl = $catalogoRutas['faq'];

        $seoSchema = [[
            '@context' => 'https://schema.org',
            '@type' => 'FAQPage',
            'mainEntity' => [
                ['@type' => 'Question', 'name' => '¿Puedo pedir mi paleta armada lista para jugar?', 'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'Sí, puedes seleccionar armado profesional y PV Sport la despacha lista para usar.']],
                ['@type' => 'Question', 'name' => '¿Cómo elijo goma para derecho y revés?', 'acceptedAnswer' => ['@type' => 'Answer', 'text' => 'El modo guiado sugiere combinaciones según nivel, estilo y prioridad de juego.']],
            ],
        ]];

        $this->vista('publico/catalogo_configurador_paletas', [
            'empresa' => $empresa,
            'productos' => $productos,
            'settings' => $settings,
            'reglas' => $reglas,
            'catalogoRutas' => $catalogoRutas,
            'catalogoTopbar' => $catalogoTopbar,
            'logoCatalogo' => $logoCatalogo,
            'socialesTopbar' => $socialesTopbar,
            'topbarTexto' => $topbarTexto,
            'renderIconoRed' => $renderIconoRed,
            'catalogoBaseUrl' => $catalogoBaseUrl,
            'catalogoNosotrosUrl' => $catalogoNosotrosUrl,
            'catalogoContactoUrl' => $catalogoContactoUrl,
            'catalogoFaqUrl' => $catalogoFaqUrl,
            'meta_title' => 'Configurador de paletas personalizadas en Chile | PV Sport',
            'meta_description' => 'Arma tu paleta de tenis de mesa con madero + goma derecho + goma revés. Configurador premium PV Sport con recomendaciones por estilo de juego en Chile.',
            'meta_keywords' => 'armar paleta tenis de mesa chile, paleta personalizada tenis de mesa chile, configurar paleta ping pong chile',
            'meta_canonical' => url('/catalogo/' . $empresaId . '/configurador-paletas'),
            'seo_schema' => $seoSchema,
            'ocultarNavbarPublico' => true,
        ], 'publico');
    }

    public function recomendar(int $empresaId): void
    {
        header('Content-Type: application/json; charset=UTF-8');
        $modelo = new ConfiguradorPaletas();
        $productos = $modelo->listarProductosConfigurador($empresaId);
        $reglas = $modelo->listarReglas($empresaId);

        $perfil = [
            'level' => trim((string) ($_POST['level'] ?? 'intermedio')),
            'style' => trim((string) ($_POST['style'] ?? 'allround')),
            'priority' => trim((string) ($_POST['priority'] ?? 'equilibrio')),
            'transition' => trim((string) ($_POST['transition'] ?? 'suave')),
        ];

        $recomendadas = (new ConfiguradorPaletasService())->recomendar($productos, $reglas, $perfil);
        echo json_encode(['ok' => true, 'items' => $recomendadas], JSON_UNESCAPED_UNICODE);
        exit;
    }

    public function guardarBuild(int $empresaId): void
    {
        validar_csrf();

        $bladeId = (int) ($_POST['blade_product_id'] ?? 0);
        $fhId = (int) ($_POST['fh_rubber_product_id'] ?? 0);
        $bhId = (int) ($_POST['bh_rubber_product_id'] ?? 0);

        if ($bladeId <= 0 || $fhId <= 0 || $bhId <= 0) {
            flash('danger', 'Para guardar la configuración debes elegir madero, goma FH y goma BH.');
            $this->redirigir('/catalogo/' . $empresaId . '/configurador-paletas');
        }

        $modelo = new ConfiguradorPaletas();
        $blade = $modelo->obtenerProductoConfigurador($empresaId, $bladeId);
        $fh = $modelo->obtenerProductoConfigurador($empresaId, $fhId);
        $bh = $modelo->obtenerProductoConfigurador($empresaId, $bhId);
        if (!$blade || !$fh || !$bh) {
            flash('danger', 'No pudimos validar los productos seleccionados.');
            $this->redirigir('/catalogo/' . $empresaId . '/configurador-paletas');
        }

        $settings = $modelo->obtenerSettings($empresaId);
        $metricas = (new ConfiguradorPaletasService())->calcularMetricas($blade, $fh, $bh, $settings);

        $extrasPrecio = (float) ($_POST['extras_price'] ?? 0);
        $total = (float) ($blade['precio'] ?? 0) + (float) ($fh['precio'] ?? 0) + (float) ($bh['precio'] ?? 0) + $extrasPrecio;

        $payload = [
            'mode' => (string) ($_POST['mode'] ?? 'experto'),
            'profile' => [
                'level' => (string) ($_POST['profile_level'] ?? ''),
                'style' => (string) ($_POST['profile_style'] ?? ''),
                'priority' => (string) ($_POST['profile_priority'] ?? ''),
                'budget' => (string) ($_POST['profile_budget'] ?? ''),
                'transition' => (string) ($_POST['profile_transition'] ?? ''),
            ],
            'extras' => json_decode((string) ($_POST['extras_json'] ?? '[]'), true),
            'notes' => (string) ($_POST['notes'] ?? ''),
        ];

        $buildId = $modelo->guardarBuild([
            'empresa_id' => $empresaId,
            'session_id' => session_id(),
            'user_id' => null,
            'blade_product_id' => $bladeId,
            'blade_variant_id' => (int) ($_POST['blade_variant_id'] ?? 0) ?: null,
            'fh_rubber_product_id' => $fhId,
            'fh_variant_id' => (int) ($_POST['fh_variant_id'] ?? 0) ?: null,
            'bh_rubber_product_id' => $bhId,
            'bh_variant_id' => (int) ($_POST['bh_variant_id'] ?? 0) ?: null,
            'edge_tape_product_id' => (int) ($_POST['edge_tape_product_id'] ?? 0) ?: null,
            'case_product_id' => (int) ($_POST['case_product_id'] ?? 0) ?: null,
            'glue_product_id' => (int) ($_POST['glue_product_id'] ?? 0) ?: null,
            'cleaner_product_id' => (int) ($_POST['cleaner_product_id'] ?? 0) ?: null,
            'assembly_service_product_id' => (int) ($_POST['assembly_service_product_id'] ?? 0) ?: null,
            'total_price' => $total,
            'speed_total' => (float) $metricas['speed_total'],
            'control_total' => (float) $metricas['control_total'],
            'spin_total' => (float) $metricas['spin_total'],
            'hardness_total' => (float) $metricas['hardness_total'],
            'weight_total' => $metricas['weight_total'],
            'player_profile' => json_encode($payload['profile'], JSON_UNESCAPED_UNICODE),
            'status' => 'draft',
            'build_payload' => json_encode($payload, JSON_UNESCAPED_UNICODE),
        ]);

        $mensaje = rawurlencode("Hola PV Sport, quiero asesoría para la configuración #{$buildId}. Madero: {$blade['nombre']}, FH: {$fh['nombre']}, BH: {$bh['nombre']}.");
        $_SESSION['configurador_build_' . $empresaId] = [
            'build_id' => $buildId,
            'blade' => $blade,
            'fh' => $fh,
            'bh' => $bh,
            'total' => $total,
            'metrics' => $metricas,
        ];

        flash('success', 'Tu configuración fue guardada. Puedes seguir al checkout o pedir asesoría.');
        $this->redirigir('/catalogo/' . $empresaId . '/configurador-paletas?build=' . $buildId . '&wa=' . $mensaje);
    }

    private function resolverEmpresaDominio(): int
    {
        $host = strtolower((string) ($_SERVER['HTTP_HOST'] ?? ''));
        if ($host === '') {
            return 0;
        }

        $stmt = BaseDatos::obtener()->prepare('SELECT id FROM empresas WHERE estado = "activa" AND dominio_catalogo = :host LIMIT 1');
        $stmt->execute(['host' => $host]);
        $id = (int) $stmt->fetchColumn();
        if ($id > 0) {
            return $id;
        }

        return 77;
    }
}
