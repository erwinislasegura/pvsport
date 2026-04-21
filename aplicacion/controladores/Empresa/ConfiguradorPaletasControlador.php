<?php

namespace Aplicacion\Controladores\Empresa;

use Aplicacion\Nucleo\Controlador;
use Aplicacion\Modelos\ConfiguradorPaletas;
use Aplicacion\Modelos\Producto;

class ConfiguradorPaletasControlador extends Controlador
{
    public function index(): void
    {
        $empresaId = (int) (empresa_actual_id() ?? 0);
        $modelo = new ConfiguradorPaletas();

        $productos = (new Producto())->listar($empresaId);
        $atributos = $modelo->listarProductosConfigurador($empresaId);
        $reglas = $modelo->listarReglas($empresaId);
        $settings = $modelo->obtenerSettings($empresaId);
        $builds = $modelo->listarBuilds($empresaId, 150);

        $this->vista('empresa/configurador_paletas/index', compact('productos', 'atributos', 'reglas', 'settings', 'builds'), 'empresa');
    }

    public function guardarAtributos(): void
    {
        validar_csrf();
        $empresaId = (int) (empresa_actual_id() ?? 0);
        $productoId = (int) ($_POST['product_id'] ?? 0);
        $producto = (new Producto())->obtenerPorId($empresaId, $productoId);
        if (!$producto) {
            flash('danger', 'Producto no válido para esta empresa.');
            $this->redirigir('/app/configurador-paletas');
        }

        (new ConfiguradorPaletas())->upsertAtributosProducto($productoId, $_POST);
        flash('success', 'Atributos técnicos del configurador guardados.');
        $this->redirigir('/app/configurador-paletas');
    }

    public function guardarRegla(): void
    {
        validar_csrf();
        $empresaId = (int) (empresa_actual_id() ?? 0);
        (new ConfiguradorPaletas())->guardarRegla($empresaId, $_POST);
        flash('success', 'Regla de recomendación guardada correctamente.');
        $this->redirigir('/app/configurador-paletas');
    }

    public function guardarConfiguracion(): void
    {
        validar_csrf();
        $empresaId = (int) (empresa_actual_id() ?? 0);
        $modelo = new ConfiguradorPaletas();

        $campos = [
            'blade_speed', 'fh_speed', 'bh_speed',
            'blade_control', 'fh_control', 'bh_control',
            'blade_spin', 'fh_spin', 'bh_spin',
            'fh_hardness', 'bh_hardness',
            'assembly_lead_time_message', 'commercial_policy_message',
        ];

        foreach ($campos as $campo) {
            if (!array_key_exists($campo, $_POST)) {
                continue;
            }
            $valor = trim((string) $_POST[$campo]);
            $tipo = is_numeric($valor) ? 'number' : 'text';
            $modelo->upsertSetting($empresaId, $campo, $valor, $tipo, 'Configuración módulo configurador');
        }

        flash('success', 'Configuración general del configurador actualizada.');
        $this->redirigir('/app/configurador-paletas');
    }
}
