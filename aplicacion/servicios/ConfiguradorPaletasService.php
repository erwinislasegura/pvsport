<?php

namespace Aplicacion\Servicios;

class ConfiguradorPaletasService
{
    public function calcularMetricas(array $blade, array $fh, array $bh, array $settings = []): array
    {
        $w = $this->obtenerPesos($settings);

        $speed = $this->ponderar([
            (float) ($blade['speed'] ?? 0) => $w['blade_speed'],
            (float) ($fh['speed'] ?? 0) => $w['fh_speed'],
            (float) ($bh['speed'] ?? 0) => $w['bh_speed'],
        ]);
        $control = $this->ponderar([
            (float) ($blade['control_score'] ?? 0) => $w['blade_control'],
            (float) ($fh['control_score'] ?? 0) => $w['fh_control'],
            (float) ($bh['control_score'] ?? 0) => $w['bh_control'],
        ]);
        $spin = $this->ponderar([
            (float) ($blade['spin'] ?? 0) => $w['blade_spin'],
            (float) ($fh['spin'] ?? 0) => $w['fh_spin'],
            (float) ($bh['spin'] ?? 0) => $w['bh_spin'],
        ]);
        $hardness = $this->ponderar([
            (float) ($fh['hardness'] ?? 0) => $w['fh_hardness'],
            (float) ($bh['hardness'] ?? 0) => $w['bh_hardness'],
        ]);

        $weight = (float) ($blade['weight_grams'] ?? 0)
            + (float) ($fh['weight_grams'] ?? 0)
            + (float) ($bh['weight_grams'] ?? 0);

        return [
            'speed_total' => round($speed, 2),
            'control_total' => round($control, 2),
            'spin_total' => round($spin, 2),
            'hardness_total' => round($hardness, 2),
            'weight_total' => $weight > 0 ? round($weight, 1) : null,
            'balance' => round($speed - $control, 2),
        ];
    }

    public function recomendar(array $productos, array $reglas, array $perfil): array
    {
        $blades = array_values(array_filter($productos, static fn(array $p): bool => ($p['category_role'] ?? '') === 'blade'));
        $rubbers = array_values(array_filter($productos, static fn(array $p): bool => ($p['category_role'] ?? '') === 'rubber'));

        $target = $this->resolverTargets($perfil);
        $scored = [];

        foreach (array_slice($blades, 0, 20) as $blade) {
            foreach (array_slice($rubbers, 0, 30) as $fh) {
                foreach (array_slice($rubbers, 0, 30) as $bh) {
                    $precio = (float) ($blade['precio'] ?? 0) + (float) ($fh['precio'] ?? 0) + (float) ($bh['precio'] ?? 0);
                    $score = $this->scoreCombinacion($blade, $fh, $bh, $target, $perfil, $reglas, $precio);
                    $scored[] = [
                        'score' => $score,
                        'blade' => $blade,
                        'fh' => $fh,
                        'bh' => $bh,
                        'price' => $precio,
                        'message' => $this->mensajeComercial($perfil, $fh, $bh),
                    ];
                }
            }
        }

        usort($scored, static fn(array $a, array $b): int => $b['score'] <=> $a['score']);
        return array_slice($scored, 0, 6);
    }

    private function scoreCombinacion(array $blade, array $fh, array $bh, array $target, array $perfil, array $reglas, float $precio): float
    {
        $score = 100;
        foreach ([
            [(float) ($blade['speed'] ?? 0), $target['speed'], 1.0],
            [(float) ($blade['control_score'] ?? 0), $target['control'], 1.2],
            [(float) ($fh['spin'] ?? 0), $target['spin'], 1.1],
            [(float) ($bh['control_score'] ?? 0), $target['bh_control'], 1.2],
        ] as [$valor, $ideal, $peso]) {
            $score -= abs($valor - $ideal) * $peso;
        }

        if (($perfil['transition'] ?? 'suave') === 'suave') {
            $score += (float) ($bh['control_score'] ?? 0) * 0.6;
        }

        if (($perfil['priority'] ?? '') === 'spin') {
            $score += ((float) ($fh['spin'] ?? 0) + (float) ($bh['spin'] ?? 0)) * 0.5;
        }

        foreach ($reglas as $regla) {
            if (($regla['level'] ?? '') === ($perfil['level'] ?? '') && ($regla['style'] ?? '') === ($perfil['style'] ?? '')) {
                if ($precio >= (float) ($regla['budget_min'] ?? 0) && $precio <= (float) ($regla['budget_max'] ?? 999999999)) {
                    $score += ((float) ($regla['blade_weight'] ?? 1) * (float) ($blade['control_score'] ?? 0)) * 0.12;
                    $score += ((float) ($regla['fh_weight'] ?? 1) * (float) ($fh['spin'] ?? 0)) * 0.12;
                    $score += ((float) ($regla['bh_weight'] ?? 1) * (float) ($bh['control_score'] ?? 0)) * 0.12;
                }
            }
        }

        return round($score, 3);
    }

    private function mensajeComercial(array $perfil, array $fh, array $bh): string
    {
        if (($perfil['level'] ?? '') === 'intermedio') {
            return 'Ideal para jugadores intermedios que quieren subir nivel sin perder control.';
        }
        if ((float) ($fh['spin'] ?? 0) > (float) ($bh['spin'] ?? 0) + 1.5) {
            return 'Más efecto en derecho y mayor seguridad en revés.';
        }
        return 'Combinación equilibrada para entrenar y competir con confianza.';
    }

    private function resolverTargets(array $perfil): array
    {
        $base = ['speed' => 7, 'control' => 7, 'spin' => 7, 'bh_control' => 7.5];
        $style = (string) ($perfil['style'] ?? 'allround');
        if ($style === 'control') {
            $base = ['speed' => 6.2, 'control' => 8.4, 'spin' => 6.8, 'bh_control' => 8.6];
        } elseif ($style === 'ofensivo') {
            $base = ['speed' => 8.4, 'control' => 6.4, 'spin' => 8.2, 'bh_control' => 7.2];
        } elseif ($style === 'muy-ofensivo') {
            $base = ['speed' => 9.1, 'control' => 5.8, 'spin' => 8.9, 'bh_control' => 6.4];
        }
        return $base;
    }

    private function obtenerPesos(array $settings): array
    {
        $defaults = [
            'blade_speed' => 0.5, 'fh_speed' => 0.3, 'bh_speed' => 0.2,
            'blade_control' => 0.45, 'fh_control' => 0.3, 'bh_control' => 0.25,
            'blade_spin' => 0.15, 'fh_spin' => 0.5, 'bh_spin' => 0.35,
            'fh_hardness' => 0.55, 'bh_hardness' => 0.45,
        ];

        foreach ($defaults as $key => $default) {
            if (isset($settings[$key]['value']) && is_numeric($settings[$key]['value'])) {
                $defaults[$key] = (float) $settings[$key]['value'];
            }
        }

        return $defaults;
    }

    private function ponderar(array $valores): float
    {
        $pesoTotal = 0.0;
        $acumulado = 0.0;
        foreach ($valores as $valor => $peso) {
            $pesoTotal += (float) $peso;
            $acumulado += ((float) $valor) * (float) $peso;
        }
        if ($pesoTotal <= 0) {
            return 0.0;
        }

        return $acumulado / $pesoTotal;
    }
}
