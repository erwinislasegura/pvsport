# Actualización: Configurador de Paletas Personalizadas

## 1) Resumen funcional
Se incorporó un módulo nativo de **Configurador de Paletas Personalizadas** con flujo guiado/experto, selección de madero + goma FH + goma BH + extras, cálculo dinámico de precio y métricas técnicas, guardado de configuración y CTA comercial a WhatsApp.

## 2) Archivos creados/modificados
- `aplicacion/controladores/Publico/ConfiguradorPaletasControlador.php`
- `aplicacion/controladores/Empresa/ConfiguradorPaletasControlador.php`
- `aplicacion/modelos/ConfiguradorPaletas.php`
- `aplicacion/servicios/ConfiguradorPaletasService.php`
- `aplicacion/vistas/publico/catalogo_configurador_paletas.php`
- `aplicacion/vistas/empresa/configurador_paletas/index.php`
- `aplicacion/vistas/parciales/sidebar_empresa.php`
- `rutas/web.php`
- `rutas/empresa.php`
- `base_datos/actualizaciones/actualizacion_configurador_paletas_personalizadas.sql`

## 3) Script SQL / migración
Aplicar `base_datos/actualizaciones/actualizacion_configurador_paletas_personalizadas.sql`.

Ejemplo (formato correcto del bloque inicial):

```sql
-- Modulo: Configurador de Paletas Personalizadas PV Sport
-- Fecha: 2026-04-21

CREATE TABLE IF NOT EXISTS product_attributes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  speed DECIMAL(5,2) DEFAULT 0,
  control_score DECIMAL(5,2) DEFAULT 0,
  spin DECIMAL(5,2) DEFAULT 0,
  hardness DECIMAL(5,2) DEFAULT 0,
  tacky_type VARCHAR(60) DEFAULT NULL,
  arc VARCHAR(60) DEFAULT NULL,
  weight_grams DECIMAL(7,2) DEFAULT NULL,
  composition VARCHAR(120) DEFAULT NULL,
  handle_type VARCHAR(60) DEFAULT NULL,
  player_level VARCHAR(40) DEFAULT NULL,
  play_style VARCHAR(60) DEFAULT NULL,
  rubber_type VARCHAR(60) DEFAULT NULL,
  category_role ENUM('blade','rubber','accessory','assembly_service') NOT NULL DEFAULT 'accessory',
  is_forehand_recommended TINYINT(1) NOT NULL DEFAULT 0,
  is_backhand_recommended TINYINT(1) NOT NULL DEFAULT 0,
  tags VARCHAR(255) DEFAULT NULL,
  featured_order INT NOT NULL DEFAULT 999,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  UNIQUE KEY uq_product_attributes_product (product_id),
  CONSTRAINT fk_product_attributes_product FOREIGN KEY (product_id) REFERENCES productos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

Incluye tablas:
- `product_attributes`
- `product_variants`
- `racket_builds`
- `racket_recommendation_rules`
- `racket_configuration_settings`

## 4) Reglas de cálculo
Servicio: `ConfiguradorPaletasService::calcularMetricas()`.

Métricas calculadas:
- `speed_total`
- `control_total`
- `spin_total`
- `hardness_total`
- `weight_total`
- `balance` (speed - control)

Ponderaciones editables desde admin mediante settings:
- `blade_speed`, `fh_speed`, `bh_speed`
- `blade_control`, `fh_control`, `bh_control`
- `blade_spin`, `fh_spin`, `bh_spin`
- `fh_hardness`, `bh_hardness`

## 5) Reglas del recomendador
Servicio: `ConfiguradorPaletasService::recomendar()`:
- perfil: nivel + estilo + prioridad + transición
- score por cercanía a objetivos técnicos del perfil
- ajuste por reglas de negocio (`racket_recommendation_rules`)
- orden final por score descendente

## 6) Activación de productos en admin
Ruta: `/app/configurador-paletas`

Pasos:
1. Seleccionar producto.
2. Asignar rol (`blade`, `rubber`, `accessory`, `assembly_service`).
3. Completar atributos técnicos y tags.
4. Marcar recomendación FH/BH según aplique.
5. Guardar.

## 7) Checklist de pruebas
- [ ] Carga landing pública del configurador.
- [ ] Selección de modo guiado y experto.
- [ ] Selección de madero/FH/BH.
- [ ] Cálculo de total y KPI en resumen.
- [ ] Guardado de configuración (`racket_builds`).
- [ ] Visualización de builds en admin.
- [ ] Alta de reglas y settings desde admin.

## 8) Notas de mejoras futuras
- Integrar variantes color/espesor/handle en UX avanzada.
- Persistencia de progreso automático por sesión.
- Integración directa a carrito catálogo con item compuesto.
- Métricas de abandono/conversión por paso.
- Ranking de configuraciones más armadas.
