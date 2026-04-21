<div class="d-flex justify-content-between align-items-center mb-3">
  <div>
    <h1 class="h3 mb-1">Configurador de Paletas</h1>
    <p class="text-muted mb-0">Configura productos elegibles, reglas de recomendación, ponderaciones y revisa configuraciones guardadas.</p>
  </div>
  <a class="btn btn-outline-dark" target="_blank" href="<?= e(url('/catalogo/' . (int) (empresa_actual_id() ?? 0) . '/configurador-paletas')) ?>">Ver landing pública</a>
</div>

<div class="row g-3">
  <div class="col-lg-6">
    <div class="card shadow-sm">
      <div class="card-body">
        <h2 class="h5">1) Configuración general</h2>
        <form method="POST" action="<?= e(url('/app/configurador-paletas/configuracion')) ?>" class="row g-2">
          <?= csrf_input() ?>
          <?php $get = static fn(string $k, string $d='') => (string) (($settings[$k]['value'] ?? $d)); ?>
          <div class="col-md-4"><label class="form-label">Peso vel. madero</label><input class="form-control" name="blade_speed" value="<?= e($get('blade_speed', '0.5')) ?>"></div>
          <div class="col-md-4"><label class="form-label">Peso vel. FH</label><input class="form-control" name="fh_speed" value="<?= e($get('fh_speed', '0.3')) ?>"></div>
          <div class="col-md-4"><label class="form-label">Peso vel. BH</label><input class="form-control" name="bh_speed" value="<?= e($get('bh_speed', '0.2')) ?>"></div>
          <div class="col-md-6"><label class="form-label">Mensaje tiempo armado</label><input class="form-control" name="assembly_lead_time_message" value="<?= e($get('assembly_lead_time_message', '24 a 72 horas hábiles con armado profesional.')) ?>"></div>
          <div class="col-md-6"><label class="form-label">Política comercial</label><input class="form-control" name="commercial_policy_message" value="<?= e($get('commercial_policy_message', 'Producto armado a pedido, sujeto a validación de stock.')) ?>"></div>
          <div class="col-12"><button class="btn btn-dark">Guardar configuración</button></div>
        </form>
      </div>
    </div>
  </div>

  <div class="col-lg-6">
    <div class="card shadow-sm">
      <div class="card-body">
        <h2 class="h5">2) Reglas de recomendación</h2>
        <form method="POST" action="<?= e(url('/app/configurador-paletas/reglas')) ?>" class="row g-2">
          <?= csrf_input() ?>
          <div class="col-md-6"><input class="form-control" name="rule_name" placeholder="Nombre regla" required></div>
          <div class="col-md-3"><select class="form-select" name="level"><option>principiante</option><option selected>intermedio</option><option>avanzado</option></select></div>
          <div class="col-md-3"><select class="form-select" name="style"><option>control</option><option selected>allround</option><option>ofensivo</option><option>muy-ofensivo</option></select></div>
          <div class="col-md-3"><input class="form-control" name="budget_min" placeholder="Pres. mín"></div>
          <div class="col-md-3"><input class="form-control" name="budget_max" placeholder="Pres. máx"></div>
          <div class="col-md-2"><input class="form-control" name="blade_weight" placeholder="W madero" value="1"></div>
          <div class="col-md-2"><input class="form-control" name="fh_weight" placeholder="W FH" value="1"></div>
          <div class="col-md-2"><input class="form-control" name="bh_weight" placeholder="W BH" value="1"></div>
          <div class="col-md-12"><button class="btn btn-dark btn-sm">Agregar regla</button></div>
        </form>
        <div class="table-responsive mt-3" style="max-height:220px;overflow:auto"><table class="table table-sm align-middle"><thead><tr><th>Regla</th><th>Nivel/Estilo</th><th>Presupuesto</th></tr></thead><tbody><?php foreach ($reglas as $r): ?><tr><td><?= e((string) $r['rule_name']) ?></td><td><?= e((string) $r['level']) ?> / <?= e((string) $r['style']) ?></td><td>$<?= number_format((float) ($r['budget_min'] ?? 0),0,',','.') ?> - $<?= number_format((float) ($r['budget_max'] ?? 0),0,',','.') ?></td></tr><?php endforeach; ?></tbody></table></div>
      </div>
    </div>
  </div>

  <div class="col-12">
    <div class="card shadow-sm">
      <div class="card-body">
        <h2 class="h5">3) Activar productos para configurador</h2>
        <form method="POST" action="<?= e(url('/app/configurador-paletas/atributos')) ?>" class="row g-2">
          <?= csrf_input() ?>
          <div class="col-md-4"><label class="form-label">Producto</label><select class="form-select" name="product_id" required><option value="">Selecciona</option><?php foreach ($productos as $p): ?><option value="<?= (int) $p['id'] ?>"><?= e((string) $p['nombre']) ?></option><?php endforeach; ?></select></div>
          <div class="col-md-2"><label class="form-label">Rol</label><select class="form-select" name="category_role"><option value="blade">Madero</option><option value="rubber">Goma</option><option value="accessory">Extra</option><option value="assembly_service">Armado</option></select></div>
          <div class="col-md-2"><label class="form-label">Velocidad</label><input class="form-control" name="speed"></div>
          <div class="col-md-2"><label class="form-label">Control</label><input class="form-control" name="control_score"></div>
          <div class="col-md-2"><label class="form-label">Spin</label><input class="form-control" name="spin"></div>
          <div class="col-md-2"><label class="form-label">Dureza</label><input class="form-control" name="hardness"></div>
          <div class="col-md-2"><label class="form-label">Peso (g)</label><input class="form-control" name="weight_grams"></div>
          <div class="col-md-2"><label class="form-label">Mango</label><input class="form-control" name="handle_type"></div>
          <div class="col-md-2"><label class="form-label">Composición</label><input class="form-control" name="composition"></div>
          <div class="col-md-4"><label class="form-label">Tags comerciales</label><input class="form-control" name="tags" placeholder="control,spin,ofensiva"></div>
          <div class="col-md-12 d-flex gap-3"><div class="form-check"><input class="form-check-input" type="checkbox" name="is_forehand_recommended" value="1" id="fhRec"><label class="form-check-label" for="fhRec">Recomendada FH</label></div><div class="form-check"><input class="form-check-input" type="checkbox" name="is_backhand_recommended" value="1" id="bhRec"><label class="form-check-label" for="bhRec">Recomendada BH</label></div></div>
          <div class="col-12"><button class="btn btn-dark">Guardar atributos técnicos</button></div>
        </form>

        <div class="table-responsive mt-3"><table class="table table-sm align-middle"><thead><tr><th>Producto</th><th>Rol</th><th>Vel</th><th>Ctrl</th><th>Spin</th><th>Dureza</th><th>Tags</th></tr></thead><tbody><?php foreach ($atributos as $a): ?><tr><td><?= e((string) $a['nombre']) ?></td><td><span class="badge text-bg-light border"><?= e((string) $a['category_role']) ?></span></td><td><?= e((string) $a['speed']) ?></td><td><?= e((string) $a['control_score']) ?></td><td><?= e((string) $a['spin']) ?></td><td><?= e((string) $a['hardness']) ?></td><td class="small text-muted"><?= e((string) ($a['tags'] ?? '')) ?></td></tr><?php endforeach; ?></tbody></table></div>
      </div>
    </div>
  </div>

  <div class="col-12">
    <div class="card shadow-sm"><div class="card-body"><h2 class="h5">4) Configuraciones guardadas / pedidos armados</h2>
      <div class="table-responsive"><table class="table table-sm align-middle"><thead><tr><th>#</th><th>Estado</th><th>Total</th><th>Métricas</th><th>Fecha</th></tr></thead><tbody><?php foreach ($builds as $b): ?><tr><td><?= (int) $b['id'] ?></td><td><?= e((string) $b['status']) ?></td><td>$<?= number_format((float) ($b['total_price'] ?? 0), 0, ',', '.') ?></td><td>V <?= e((string) $b['speed_total']) ?> · C <?= e((string) $b['control_total']) ?> · S <?= e((string) $b['spin_total']) ?></td><td><?= e((string) $b['created_at']) ?></td></tr><?php endforeach; ?></tbody></table></div>
    </div></div>
  </div>
</div>
