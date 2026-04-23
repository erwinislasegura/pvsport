<?php
$producto = $producto ?? null;
$categorias = $categorias ?? [];
$accion = $accion ?? url('/app/productos');
$textoBoton = $textoBoton ?? 'Guardar ítem';
$mostrarCancelar = $mostrarCancelar ?? false;
$rutaCancelar = $rutaCancelar ?? url('/app/productos');
$mostrarModalCategoria = $mostrarModalCategoria ?? true;
$modalId = $modalId ?? 'modalNuevaCategoria';
$redirigirA = $redirigirA ?? '/app/productos';
$unidadActual = $producto['unidad'] ?? 'unidad';
$imagenesCatalogo = $imagenesCatalogo ?? [];
$productoTecnico = is_array($productoTecnico ?? null) ? $productoTecnico : [];
$tagsTecnicos = [];
if (!empty($productoTecnico['tags'])) {
  $tmpTags = json_decode((string) $productoTecnico['tags'], true);
  if (is_array($tmpTags)) {
    $tagsTecnicos = $tmpTags;
  }
}
?>
<div class="alert alert-info info-modulo mb-3">
  <div class="fw-semibold mb-1">Uso y buenas prácticas para productos</div>
  <ul class="mb-0 small ps-3">
    <li>Incluye datos completos para que la cotización sea más clara para el cliente.</li>
    <li>Configura <strong>stock mínimo</strong> y <strong>stock crítico</strong> para alertas automáticas.</li>
    <li>Si el ítem no se ofrece temporalmente, cambia estado a <strong>inactivo</strong>.</li>
  </ul>
</div>
<form method="POST" action="<?= e($accion) ?>" class="row g-2" enctype="multipart/form-data">
  <?= csrf_campo() ?>
  <?php if (!$producto): ?>
    <input type="hidden" name="redirect_to" value="<?= e($redirigirA) ?>">
  <?php endif; ?>
  <div class="col-md-2">
    <label class="form-label">Tipo</label>
    <select name="tipo" class="form-select">
      <option value="producto" <?= ($producto['tipo'] ?? 'producto') === 'producto' ? 'selected' : '' ?>>Producto</option>
      <option value="servicio" <?= ($producto['tipo'] ?? '') === 'servicio' ? 'selected' : '' ?>>Servicio</option>
    </select>
  </div>
  <div class="col-md-3">
    <div class="d-flex justify-content-between align-items-center mb-1">
      <label class="form-label mb-0">Categoría</label>
      <?php if ($mostrarModalCategoria): ?>
        <button type="button" class="btn btn-link btn-sm p-0" data-bs-toggle="modal" data-bs-target="#<?= e($modalId) ?>">+ Nueva</button>
      <?php endif; ?>
    </div>
    <select name="categoria_id" id="categoria_id" class="form-select">
      <option value="">Sin categoría</option>
      <?php foreach($categorias as $cat): ?>
        <option value="<?= (int)$cat['id'] ?>" <?= (int)($producto['categoria_id'] ?? 0) === (int)$cat['id'] ? 'selected' : '' ?>><?= e($cat['nombre']) ?></option>
      <?php endforeach; ?>
    </select>
    <div class="form-text">Agrupa productos para encontrarlos más rápido.</div>
  </div>
  <div class="col-md-2">
    <label class="form-label" for="producto_codigo">Código interno</label>
    <input id="producto_codigo" name="codigo" class="form-control" value="<?= e($producto['codigo'] ?? '') ?>" required>
    <div class="form-text">Código corto para tu operación diaria.</div>
  </div>
  <div class="col-md-2">
    <label class="form-label">SKU</label>
    <input name="sku" class="form-control" value="<?= e($producto['sku'] ?? '') ?>" placeholder="SKU-0001">
  </div>
  <div class="col-md-3">
    <label class="form-label">Código de barras</label>
    <input name="codigo_barras" class="form-control" value="<?= e($producto['codigo_barras'] ?? '') ?>" placeholder="EAN/UPC">
  </div>
  <div class="col-md-3">
    <label class="form-label" for="producto_nombre">Nombre</label>
    <input id="producto_nombre" name="nombre" class="form-control" value="<?= e($producto['nombre'] ?? '') ?>" required>
  </div>
  <div class="col-md-3">
    <label class="form-label">Descripción</label>
    <input name="descripcion" class="form-control" value="<?= e($producto['descripcion'] ?? '') ?>">
  </div>
  <div class="col-md-2">
    <label class="form-label">Unidad de medida</label>
    <select name="unidad" class="form-select">
      <?php foreach (['unidad','kg','g','lb','litro','ml','metro','cm','caja','paquete','servicio','hora'] as $unidad): ?>
        <option value="<?= e($unidad) ?>" <?= $unidadActual === $unidad ? 'selected' : '' ?>><?= e(ucfirst($unidad)) ?></option>
      <?php endforeach; ?>
    </select>
  </div>
  <div class="col-md-2">
    <label class="form-label">Precio</label>
    <input type="number" step="0.01" min="0" name="precio" class="form-control" value="<?= e((string)($producto['precio'] ?? '')) ?>">
  </div>
  <div class="col-md-2">
    <label class="form-label">Precio oferta</label>
    <input type="number" step="0.01" min="0" name="precio_oferta" class="form-control" value="<?= e((string)($producto['precio_oferta'] ?? '')) ?>" placeholder="Opcional">
    <div class="form-text">Debe ser menor al precio normal.</div>
  </div>
  <div class="col-md-2">
    <label class="form-label">Costo</label>
    <input type="number" step="0.01" min="0" name="costo" class="form-control" value="<?= e((string)($producto['costo'] ?? '')) ?>">
  </div>
  <div class="col-md-2">
    <label class="form-label">Impuesto %</label>
    <input type="number" step="0.01" min="0" name="impuesto" class="form-control" value="<?= e((string)($producto['impuesto'] ?? 19)) ?>">
  </div>
  <div class="col-md-2">
    <label class="form-label">Desc. máximo %</label>
    <input type="number" step="0.01" min="0" name="descuento_maximo" class="form-control" value="<?= e((string)($producto['descuento_maximo'] ?? 0)) ?>">
  </div>
  <div class="col-md-2">
    <label class="form-label">Stock mínimo</label>
    <input type="number" step="0.01" min="0" name="stock_minimo" class="form-control" value="<?= e((string)($producto['stock_minimo'] ?? 0)) ?>">
    <div class="form-text">Nivel base para reposición.</div>
  </div>
  <div class="col-md-2">
    <label class="form-label">Stock crítico</label>
    <input type="number" step="0.01" min="0" name="stock_critico" class="form-control" value="<?= e((string)($producto['stock_critico'] ?? $producto['stock_aviso'] ?? 0)) ?>">
    <div class="form-text">Umbral para alerta crítica.</div>
  </div>
  <div class="col-md-2">
    <label class="form-label">Stock actual</label>
    <input type="number" step="0.01" min="0" name="stock_actual" class="form-control" value="<?= e((string)($producto['stock_actual'] ?? 0)) ?>">
  </div>
  <div class="col-md-2">
    <label class="form-label">Estado</label>
    <select name="estado" class="form-select">
      <option value="activo" <?= ($producto['estado'] ?? 'activo') === 'activo' ? 'selected' : '' ?>>Activo</option>
      <option value="inactivo" <?= ($producto['estado'] ?? '') === 'inactivo' ? 'selected' : '' ?>>Inactivo</option>
    </select>
  </div>
  <div class="col-md-4">
    <label class="form-label">Imágenes del producto (máximo 3)</label>
    <input type="file" name="imagenes_catalogo[]" class="form-control" accept="image/jpeg,image/png,image/webp" multiple>
    <div class="form-text">Puedes subir JPG, PNG o WEBP. Máximo 3 imágenes por producto.</div>
  </div>
  <div class="col-md-4 d-flex align-items-end">
    <div>
      <div class="form-check">
        <input class="form-check-input" type="checkbox" id="mostrar_catalogo" name="mostrar_catalogo" value="1" <?= (int) ($producto['mostrar_catalogo'] ?? 0) === 1 ? 'checked' : '' ?>>
        <label class="form-check-label" for="mostrar_catalogo">
          Mostrar en catálogo en línea
        </label>
      </div>
      <div class="form-check mt-1">
        <input class="form-check-input" type="checkbox" id="destacado_catalogo" name="destacado_catalogo" value="1" <?= (int) ($producto['destacado_catalogo'] ?? 0) === 1 ? 'checked' : '' ?>>
        <label class="form-check-label" for="destacado_catalogo">
          Marcar como destacado
        </label>
      </div>
      <div class="form-check mt-1">
        <input class="form-check-input" type="checkbox" id="proximo_catalogo" name="proximo_catalogo" value="1" <?= (int) ($producto['proximo_catalogo'] ?? 0) === 1 ? 'checked' : '' ?>>
        <label class="form-check-label" for="proximo_catalogo">
          Marcar como “Próximamente”
        </label>
      </div>
      <div class="form-text">Si activas destacado se mostrará la etiqueta “Destacado” en el catálogo.</div>
    </div>
  </div>
  <div class="col-md-2">
    <label class="form-label">Días de llegada</label>
    <input type="number" min="0" step="1" name="proximo_dias_catalogo" class="form-control" value="<?= e((string) ($producto['proximo_dias_catalogo'] ?? 0)) ?>">
    <div class="form-text">Usado para aviso en catálogo cuando está “Próximamente”.</div>
  </div>
  <div class="col-12"><hr><h6 class="mb-2">Datos técnicos para configurador de paletas</h6></div>
  <div class="col-md-2"><label class="form-label">Rol técnico</label>
    <select name="tech_category_role" class="form-select">
      <?php $rolTech = (string) ($productoTecnico['category_role'] ?? 'accessory'); ?>
      <option value="blade" <?= $rolTech === 'blade' ? 'selected' : '' ?>>Madero (blade)</option>
      <option value="rubber" <?= $rolTech === 'rubber' ? 'selected' : '' ?>>Goma (rubber)</option>
      <option value="accessory" <?= $rolTech === 'accessory' ? 'selected' : '' ?>>Accesorio</option>
      <option value="assembly_service" <?= $rolTech === 'assembly_service' ? 'selected' : '' ?>>Servicio armado</option>
    </select>
  </div>
  <div class="col-md-1"><label class="form-label">Velocidad</label><input type="number" step="0.1" min="0" max="10" name="tech_speed" class="form-control" value="<?= e((string) ($productoTecnico['speed'] ?? '0')) ?>"></div>
  <div class="col-md-1"><label class="form-label">Control</label><input type="number" step="0.1" min="0" max="10" name="tech_control_score" class="form-control" value="<?= e((string) ($productoTecnico['control_score'] ?? '0')) ?>"></div>
  <div class="col-md-1"><label class="form-label">Spin</label><input type="number" step="0.1" min="0" max="10" name="tech_spin" class="form-control" value="<?= e((string) ($productoTecnico['spin'] ?? '0')) ?>"></div>
  <div class="col-md-1 tech-rubber"><label class="form-label">Dureza</label><input type="number" step="0.1" min="0" max="60" name="tech_hardness" class="form-control" value="<?= e((string) ($productoTecnico['hardness'] ?? '0')) ?>"></div>
  <div class="col-md-2 tech-rubber"><label class="form-label">Adherencia</label>
    <select name="tech_tacky_type" class="form-select">
      <?php $adhActual = (string) ($productoTecnico['tacky_type'] ?? $tagsTecnicos['adherencia'] ?? ''); ?>
      <?php foreach (['','Baja','Media','Media-alta','Alta'] as $opt): ?>
        <option value="<?= e($opt) ?>" <?= $adhActual === $opt ? 'selected' : '' ?>><?= e($opt === '' ? 'Seleccionar' : $opt) ?></option>
      <?php endforeach; ?>
    </select>
  </div>
  <div class="col-md-2 tech-blade"><label class="form-label">Material/Composición</label><input name="tech_composition" class="form-control" value="<?= e((string) ($productoTecnico['composition'] ?? $tagsTecnicos['material'] ?? '')) ?>"></div>
  <div class="col-md-2"><label class="form-label">Tipo técnico</label>
    <?php $tipoActual = (string) ($tagsTecnicos['tipo'] ?? ''); ?>
    <select name="tech_tipo" class="form-select">
      <?php foreach (['','ALL','OFF-','OFF','OFF+','Control ofensivo','Balanceada','Ofensiva','No tacky moderna','Tensor moderna','Tacky ofensiva','Semi-tacky','Tacky híbrida','Ofensiva balance'] as $opt): ?>
        <option value="<?= e($opt) ?>" <?= $tipoActual === $opt ? 'selected' : '' ?>><?= e($opt === '' ? 'Seleccionar' : $opt) ?></option>
      <?php endforeach; ?>
    </select>
  </div>
  <div class="col-md-2 tech-blade"><label class="form-label">Capas</label><input name="tech_capas" class="form-control" value="<?= e((string) ($tagsTecnicos['capas'] ?? '')) ?>"></div>
  <div class="col-md-2 tech-blade"><label class="form-label">Flexibilidad</label>
    <?php $flexActual = (string) ($tagsTecnicos['flexibilidad'] ?? ''); ?>
    <select name="tech_flexibilidad" class="form-select">
      <?php foreach (['','Alta','Media','Media-baja','Baja'] as $opt): ?>
        <option value="<?= e($opt) ?>" <?= $flexActual === $opt ? 'selected' : '' ?>><?= e($opt === '' ? 'Seleccionar' : $opt) ?></option>
      <?php endforeach; ?>
    </select>
  </div>
  <div class="col-md-2 tech-blade"><label class="form-label">Rigidez</label>
    <?php $rigidezActual = (string) ($tagsTecnicos['rigidez'] ?? ''); ?>
    <select name="tech_rigidez" class="form-select">
      <?php foreach (['','Flexible','Semi flexible','Semi rígido','Rígido'] as $opt): ?>
        <option value="<?= e($opt) ?>" <?= $rigidezActual === $opt ? 'selected' : '' ?>><?= e($opt === '' ? 'Seleccionar' : $opt) ?></option>
      <?php endforeach; ?>
    </select>
  </div>
  <div class="col-md-2"><label class="form-label">Feeling</label>
    <?php $feelingActual = (string) ($tagsTecnicos['feeling'] ?? ''); ?>
    <select name="tech_feeling" class="form-select">
      <?php foreach (['','Suave','Medio','Balanceado','Controlado','Directo','Firme','Duro'] as $opt): ?>
        <option value="<?= e($opt) ?>" <?= $feelingActual === $opt ? 'selected' : '' ?>><?= e($opt === '' ? 'Seleccionar' : $opt) ?></option>
      <?php endforeach; ?>
    </select>
  </div>
  <input type="hidden" name="tech_arc" value="<?= e((string) ($productoTecnico['arc'] ?? '')) ?>">
  <input type="hidden" name="tech_weight_grams" value="<?= e((string) ($productoTecnico['weight_grams'] ?? '0')) ?>">
  <input type="hidden" name="tech_handle_type" value="<?= e((string) ($productoTecnico['handle_type'] ?? '')) ?>">
  <input type="hidden" name="tech_player_level" value="<?= e((string) ($productoTecnico['player_level'] ?? 'intermedio')) ?>">
  <input type="hidden" name="tech_play_style" value="<?= e((string) ($productoTecnico['play_style'] ?? 'allround')) ?>">
  <input type="hidden" name="tech_rubber_type" value="<?= e((string) ($productoTecnico['rubber_type'] ?? '')) ?>">
  <input type="hidden" name="tech_featured_order" value="<?= e((string) ($productoTecnico['featured_order'] ?? '999')) ?>">
  <input type="hidden" name="tech_tags_texto" value="<?= e((string) ($tagsTecnicos['tags_texto'] ?? '')) ?>">
  <?php if ((int) ($productoTecnico['is_forehand_recommended'] ?? 0) === 1): ?>
    <input type="hidden" name="tech_is_forehand_recommended" value="1">
  <?php endif; ?>
  <?php if ((int) ($productoTecnico['is_backhand_recommended'] ?? 0) === 1): ?>
    <input type="hidden" name="tech_is_backhand_recommended" value="1">
  <?php endif; ?>
  <?php if (!isset($productoTecnico['is_active']) || (int) ($productoTecnico['is_active'] ?? 1) === 1): ?>
    <input type="hidden" name="tech_is_active" value="1">
  <?php endif; ?>
  <?php if (!empty($imagenesCatalogo)): ?>
    <div class="col-12">
      <div class="border rounded p-2">
        <div class="small fw-semibold mb-2">Imágenes actuales</div>
        <div class="row g-2">
          <?php foreach ($imagenesCatalogo as $img): ?>
            <div class="col-md-4">
              <div class="border rounded p-2 h-100">
                <img src="<?= e(url('/media/producto/' . (int) ($img['id'] ?? 0))) ?>" alt="Imagen producto" style="width:100%;height:140px;object-fit:cover;border-radius:8px;">
                <div class="form-check mt-2">
                  <input class="form-check-input" type="radio" name="imagen_principal_id" value="<?= (int) $img['id'] ?>" id="img_principal_<?= (int) $img['id'] ?>" <?= (int) ($img['es_principal'] ?? 0) === 1 ? 'checked' : '' ?>>
                  <label class="form-check-label small" for="img_principal_<?= (int) $img['id'] ?>">Principal</label>
                </div>
                <div class="form-check mt-1">
                  <input class="form-check-input" type="checkbox" name="eliminar_imagen_ids[]" value="<?= (int) $img['id'] ?>" id="img_eliminar_<?= (int) $img['id'] ?>">
                  <label class="form-check-label small text-danger" for="img_eliminar_<?= (int) $img['id'] ?>">Eliminar</label>
                </div>
              </div>
            </div>
          <?php endforeach; ?>
        </div>
      </div>
    </div>
  <?php endif; ?>
  <div class="col-12">
    <button class="btn btn-primary btn-sm"><?= e($textoBoton) ?></button>
    <?php if ($mostrarCancelar): ?>
      <a class="btn btn-outline-secondary btn-sm" href="<?= e($rutaCancelar) ?>">Cancelar</a>
    <?php endif; ?>
  </div>
</form>

<?php if ($mostrarModalCategoria): ?>
<div class="modal fade" id="<?= e($modalId) ?>" tabindex="-1" aria-labelledby="<?= e($modalId) ?>Label" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form method="POST" action="<?= e(url('/app/categorias')) ?>">
        <?= csrf_campo() ?>
        <input type="hidden" name="redirect_to" value="<?= e($redirigirA) ?>">
        <div class="modal-header">
          <h5 class="modal-title" id="<?= e($modalId) ?>Label">Nueva categoría</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
        </div>
        <div class="modal-body row g-2">
          <div class="col-12"><label class="form-label" for="nueva_categoria_nombre_<?= e($modalId) ?>">Nombre</label><input id="nueva_categoria_nombre_<?= e($modalId) ?>" name="nombre" class="form-control" required></div>
          <div class="col-12"><label class="form-label">Descripción</label><input name="descripcion" class="form-control"></div>
          <div class="col-12"><label class="form-label">Estado</label><select name="estado" class="form-select"><option value="activo">Activo</option><option value="inactivo">Inactivo</option></select></div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">Cancelar</button>
          <button type="submit" class="btn btn-primary btn-sm">Guardar categoría</button>
        </div>
      </form>
    </div>
  </div>
</div>
<?php endif; ?>
<script>
(() => {
  const categoria = document.getElementById('categoria_id');
  const rolTech = document.querySelector('select[name="tech_category_role"]');
  if (!categoria || !rolTech) return;
  const bladeFields = document.querySelectorAll('.tech-blade');
  const rubberFields = document.querySelectorAll('.tech-rubber');
  const toggle = () => {
    const currentOption = categoria.options[categoria.selectedIndex] || null;
    const text = ((currentOption && currentOption.text) || '').toLowerCase();
    const isBlade = /mader|blade/.test(text);
    const isRubber = /goma|caucho|revest|rubber/.test(text);
    if (isBlade) rolTech.value = 'blade';
    if (isRubber) rolTech.value = 'rubber';
    bladeFields.forEach(el => el.style.display = isBlade ? '' : 'none');
    rubberFields.forEach(el => el.style.display = isRubber ? '' : 'none');
  };
  categoria.addEventListener('change', toggle);
  toggle();
})();
</script>
