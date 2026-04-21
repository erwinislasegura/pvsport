<?php
$fmon = static fn(float $m): string => '$' . number_format($m, 0, ',', '.');
$jsonFlags = JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT;
$productosJson = json_encode($productos, $jsonFlags);
$settingsMap = [];
foreach (($settings ?? []) as $k => $v) {
    $settingsMap[$k] = $v['value'] ?? null;
}
$settingsJson = json_encode($settingsMap, $jsonFlags);
$rulesJson = json_encode($reglas ?? [], $jsonFlags);
$productosB64 = base64_encode((string) ($productosJson !== false ? $productosJson : '[]'));
$settingsB64 = base64_encode((string) ($settingsJson !== false ? $settingsJson : '{}'));
$rulesB64 = base64_encode((string) ($rulesJson !== false ? $rulesJson : '[]'));
?>
<style>
  :root{--primary:#ff3131;--accent:#7b2cbf;--bg:#eef2f7;--border:#dbe3ee;--muted:#64748b;--text:#0f172a;--shadow:0 10px 25px rgba(15,23,42,.08)}
  .catalogo-page{background:var(--bg);min-height:100vh}
  .catalogo-container{width:min(1280px,92%);margin:0 auto}
  .catalogo-topbar{background:var(--primary);color:#fff;padding:8px 0;font-size:13px}
  .catalogo-topbar__content{display:flex;justify-content:space-between;gap:16px;flex-wrap:wrap}
  .catalogo-header{position:sticky;top:0;z-index:45;background:rgba(255,255,255,.94);backdrop-filter:blur(10px);border-bottom:1px solid var(--border)}
  .catalogo-navbar{display:grid;grid-template-columns:340px minmax(0,1fr) auto auto;gap:10px;align-items:center;padding:10px 0}
  .catalogo-logo{display:flex;align-items:center;gap:.55rem;color:var(--text);font-size:16px;font-weight:800;text-decoration:none;line-height:1.05}
  .catalogo-logo img{width:120px;height:60px;object-fit:contain}
  .catalogo-mobile-toggle{display:none}
  .search-box{display:flex;align-items:center;background:#fff;border:1px solid var(--border);border-radius:999px;overflow:hidden;min-width:0}
  .search-box input{width:100%;padding:10px 14px;border:none;outline:none;background:transparent;font-size:14px}
  .search-box button{background:var(--accent);color:#fff;padding:10px 18px;font-weight:700;border:none}
  .nav-actions{display:flex;gap:10px;align-items:center;flex-wrap:wrap}
  .menu-link{padding:9px 6px;font-weight:600;color:var(--primary);text-decoration:none;border:none;background:transparent;white-space:nowrap}
  .menu-link:hover{color:var(--accent)}
  .btn-primary-custom{display:inline-flex;align-items:center;gap:8px;padding:9px 13px;border-radius:10px;font-weight:700;border:1px solid var(--accent);background:var(--accent);color:#fff;text-decoration:none}
  .btn-primary-custom svg{stroke:#fff;fill:none}
  .footer{position:relative;color:#fff;padding:30px 0 20px;margin-top:20px;background:linear-gradient(120deg,var(--primary),var(--accent))}
  .footer-content{display:grid;grid-template-columns:1.1fr .9fr 1fr .9fr;gap:22px}
  .footer-col h4{font-size:18px;font-weight:600;margin:0 0 10px}
  .footer-bottom{background:#fff;border-top:1px solid #e5e7eb;padding:10px 0}
  .footer-bottom__content{display:flex;justify-content:space-between;align-items:center;color:#4b5563;font-size:13px;font-weight:500;gap:12px}
  body.public-page > footer.border-top.bg-white.mt-5{display:none}
  :root{--cfg-primary:#ff3131;--cfg-text:#0f172a;--cfg-muted:#64748b;--cfg-border:#dbe3ee;--cfg-bg:#eef2f7;--cfg-card:#fff;--cfg-ok:#16a34a}
  .cfg-page{background:var(--cfg-bg)} .cfg-wrap{width:min(1280px,92%);margin:0 auto;padding:18px 0 36px}
  .cfg-grid{display:grid;grid-template-columns:1fr 340px;gap:18px}.cfg-card{background:#fff;border:1px solid var(--cfg-border);border-radius:16px;padding:16px}
  .cfg-progress{display:grid;grid-template-columns:repeat(6,1fr);gap:8px}.cfg-step{font-size:12px;padding:8px;border-radius:999px;background:#f1f5f9;text-align:center}
  .cfg-step.active{background:var(--cfg-primary);color:#fff;font-weight:700}.cfg-list{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:12px}
  .cfg-item{border:1px solid var(--cfg-border);border-radius:12px;padding:10px;cursor:pointer}.cfg-item.active{border-color:var(--cfg-primary);box-shadow:0 0 0 2px rgba(255,49,49,.14)}
  .cfg-item img{width:100%;height:120px;object-fit:contain;background:#fff;border-radius:10px}.cfg-item h4{font-size:14px;margin:8px 0 6px}
  .cfg-meta{font-size:12px;color:var(--cfg-muted);display:grid;gap:2px}.cfg-chip{display:inline-block;padding:2px 8px;border-radius:999px;background:#e2e8f0;font-size:11px;margin:2px 2px 0 0}
  .cfg-sidebar{position:sticky;top:84px;height:fit-content}.cfg-total{font-size:30px;font-weight:800}.cfg-kpi{display:grid;gap:6px;margin-top:8px}
  .cfg-kpi span{display:flex;justify-content:space-between;font-size:13px}.cfg-actions{display:grid;gap:8px;margin-top:10px}
  .cfg-mobile-bar{display:none;position:fixed;left:10px;right:10px;bottom:10px;background:#fff;border:1px solid var(--cfg-border);box-shadow:0 10px 24px rgba(15,23,42,.16);border-radius:12px;padding:10px;z-index:70}
  .cfg-hero{margin-top:12px;background:#fff;border:1px solid var(--cfg-border);border-radius:18px;padding:16px}.cfg-hero h1{font-size:30px;margin:0 0 8px}
  .cfg-faq{margin-top:20px}
  @media (max-width:1100px){.catalogo-navbar,.footer-content{grid-template-columns:1fr}.search-box{width:100%}}
  @media (max-width:980px){.cfg-grid{grid-template-columns:1fr}.cfg-list{grid-template-columns:repeat(2,minmax(0,1fr))}.cfg-sidebar{position:static}.cfg-mobile-bar{display:block}}
  @media (max-width:720px){.cfg-list{grid-template-columns:1fr}.cfg-progress{grid-template-columns:repeat(2,1fr)}.cfg-hero h1{font-size:22px}}
</style>

<div class="cfg-page">
  <?php
    $catalogoHeaderSearchAction = $catalogoBaseUrl;
    $catalogoHeaderSearchMethod = 'GET';
    $catalogoHeaderSearchName = 'q';
    $catalogoHeaderSearchValue = '';
    $catalogoHeaderCartAsButton = false;
    $catalogoHeaderCartHref = $catalogoBaseUrl;
    require __DIR__ . '/partials/catalogo_header.php';
  ?>
  <section class="cfg-wrap">
    <article class="cfg-hero">
      <h1>Configurador de Paletas Personalizadas</h1>
      <p class="text-muted mb-2">Arma tu setup ideal con madero + goma FH + goma BH, calcula precio y métricas en tiempo real y envíalo directo por WhatsApp o guarda configuración.</p>
      <small><a href="<?= e($catalogoBaseUrl) ?>">Ver catálogo</a> · <a href="<?= e($catalogoBaseUrl . '?q=madero') ?>">Maderos</a> · <a href="<?= e($catalogoBaseUrl . '?q=goma') ?>">Gomas</a></small>
    </article>

    <div class="cfg-card mt-3">
      <div class="cfg-progress" id="cfgProgress"></div>
    </div>

    <div class="cfg-grid mt-3">
      <main class="cfg-card">
        <div id="cfgMain"></div>
      </main>
      <aside class="cfg-card cfg-sidebar">
        <h3 class="h5 mb-2">Resumen técnico</h3>
        <div id="cfgSummaryEmpty" class="text-muted small">Selecciona madero y gomas para completar tu paleta.</div>
        <div id="cfgSummary" style="display:none">
          <div class="small" id="cfgCombo"></div>
          <div class="cfg-kpi" id="cfgKpis"></div>
          <div class="cfg-total" id="cfgTotal"><?= $fmon(0) ?></div>
          <div class="small text-muted" id="cfgPolicy"><?= e((string) ($settingsMap['commercial_policy_message'] ?? 'Producto configurado a pedido. Sujeto a disponibilidad y validación técnica.')) ?></div>
        </div>
        <div class="cfg-actions">
          <button class="btn btn-dark" id="cfgSaveBtn" disabled>Guardar configuración</button>
          <a class="btn btn-success" id="cfgWaBtn" href="#" target="_blank" rel="noopener" style="display:none">Pedir asesoría por WhatsApp</a>
        </div>
      </aside>
    </div>

    <section class="cfg-faq cfg-card">
      <h2 class="h5">FAQ del configurador</h2>
      <div class="small text-muted">
        <p><strong>¿Qué incluye el armado profesional?</strong> Pegado y ajuste listo para jugar con control de calidad.</p>
        <p><strong>¿Puedo usar la misma goma en ambos lados?</strong> Sí, en modo experto puedes repetir la goma.</p>
      </div>
    </section>
  </section>

  <div class="cfg-mobile-bar" id="cfgMobileBar">
    <div class="d-flex justify-content-between align-items-center">
      <strong id="cfgMobileTotal"><?= $fmon(0) ?></strong>
      <button class="btn btn-dark btn-sm" id="cfgMobileSave" disabled>Guardar</button>
    </div>
  </div>

  <form id="cfgForm" method="POST" action="<?= e(url('/catalogo/' . (int) ($empresa['id'] ?? 0) . '/configurador-paletas/guardar')) ?>" class="d-none">
    <?= csrf_input() ?>
    <input type="hidden" name="mode" id="form_mode">
    <input type="hidden" name="profile_level" id="form_profile_level">
    <input type="hidden" name="profile_style" id="form_profile_style">
    <input type="hidden" name="profile_priority" id="form_profile_priority">
    <input type="hidden" name="profile_budget" id="form_profile_budget">
    <input type="hidden" name="profile_transition" id="form_profile_transition">
    <input type="hidden" name="blade_product_id" id="form_blade_product_id">
    <input type="hidden" name="fh_rubber_product_id" id="form_fh_rubber_product_id">
    <input type="hidden" name="bh_rubber_product_id" id="form_bh_rubber_product_id">
    <input type="hidden" name="extras_json" id="form_extras_json">
    <input type="hidden" name="extras_price" id="form_extras_price">
  </form>

  <?php
    $catalogoFooterInicioUrl = $catalogoBaseUrl;
    $catalogoFooterProductosUrl = $catalogoBaseUrl;
    require __DIR__ . '/partials/catalogo_footer.php';
  ?>
</div>

<script>
(() => {
  try {
  const productos = JSON.parse(atob('<?= e($productosB64) ?>') || '[]');
  const settings = JSON.parse(atob('<?= e($settingsB64) ?>') || '{}');
  const steps = ['Modo','Madero','Goma FH','Goma BH','Extras','Resumen'];
  const state = {step:0, mode:'guiado', profile:{}, blade:null, fh:null, bh:null, extras:[]};

  const elMain = document.getElementById('cfgMain');
  const elProgress = document.getElementById('cfgProgress');
  const saveBtn = document.getElementById('cfgSaveBtn');
  const saveBtnMobile = document.getElementById('cfgMobileSave');

  const byRole = (role) => productos.filter(p => p.category_role === role);
  const clp = n => '$' + Math.round(Number(n || 0)).toLocaleString('es-CL');

  function renderProgress(){
    elProgress.innerHTML = steps.map((s,i)=>`<div class="cfg-step ${i===state.step?'active':''}">${i+1}. ${s}</div>`).join('');
  }

  function renderCards(items, key){
    const selected = state[key] ? Number(state[key].id) : 0;
    return `<div class="cfg-list">${items.map(item=>{
      const price = Number(item.precio_oferta||0) > 0 && Number(item.precio_oferta) < Number(item.precio) ? Number(item.precio_oferta) : Number(item.precio || 0);
      const tags = (item.tags || '').split(',').filter(Boolean).slice(0,3).map(t=>`<span class="cfg-chip">${t.trim()}</span>`).join('');
      return `<article class="cfg-item ${selected===Number(item.id)?'active':''}" data-pick="${key}" data-id="${item.id}">
        <img src="${item.imagen ? '/media/archivo?ruta='+encodeURIComponent(item.imagen) : '/img/placeholder-producto.svg'}" alt="${item.nombre}">
        <h4>${item.nombre}</h4><div class="cfg-meta"><span>${item.categoria||''}</span><span>Vel ${item.speed||'-'} · Ctrl ${item.control_score||'-'} · Spin ${item.spin||'-'}</span><span>${clp(price)}</span></div>${tags}</article>`;
    }).join('')}</div>`;
  }

  function renderStep(){
    renderProgress();
    if(state.step===0){
      elMain.innerHTML = `<h2 class="h5">Elige modo de compra</h2><div class="d-flex gap-2 flex-wrap mb-3"><button class="btn btn-dark" data-mode="guiado">Modo guiado</button><button class="btn btn-outline-dark" data-mode="experto">Modo experto</button></div>
      <div class="row g-2"><div class="col-md-4"><select class="form-select" id="pf_level"><option value="principiante">Principiante</option><option value="intermedio" selected>Intermedio</option><option value="avanzado">Avanzado</option></select></div><div class="col-md-4"><select class="form-select" id="pf_style"><option value="control">Control</option><option value="allround" selected>Allround</option><option value="ofensivo">Ofensivo</option><option value="muy-ofensivo">Muy ofensivo</option></select></div><div class="col-md-4"><select class="form-select" id="pf_priority"><option value="control">Control</option><option value="spin">Efecto</option><option value="speed">Velocidad</option><option value="equilibrio" selected>Equilibrio</option></select></div></div>
      <div class="mt-2"><button class="btn btn-primary" id="cfgNext0">Continuar</button></div>`;
    } else if(state.step===1){ elMain.innerHTML = `<h2 class="h5">Paso 2 · Elige madero</h2>${renderCards(byRole('blade'),'blade')}<button class="btn btn-primary mt-3" id="cfgNext">Siguiente</button>`;
    } else if(state.step===2){ elMain.innerHTML = `<h2 class="h5">Paso 3 · Elige goma derecho (FH)</h2>${renderCards(byRole('rubber'),'fh')}<button class="btn btn-primary mt-3" id="cfgNext">Siguiente</button>`;
    } else if(state.step===3){ elMain.innerHTML = `<h2 class="h5">Paso 4 · Elige goma revés (BH)</h2>${renderCards(byRole('rubber'),'bh')}<button class="btn btn-primary mt-3" id="cfgNext">Siguiente</button>`;
    } else if(state.step===4){ elMain.innerHTML = `<h2 class="h5">Paso 5 · Extras</h2><div class="form-check"><input class="form-check-input" type="checkbox" value="armado" id="extraArmado" data-price="6900"><label class="form-check-label" for="extraArmado">Armado profesional (+${clp(6900)})</label></div><div class="form-check"><input class="form-check-input" type="checkbox" value="cinta" id="extraCinta" data-price="2500"><label class="form-check-label" for="extraCinta">Cinta lateral (+${clp(2500)})</label></div><div class="form-check"><input class="form-check-input" type="checkbox" value="funda" id="extraFunda" data-price="7900"><label class="form-check-label" for="extraFunda">Funda/protector (+${clp(7900)})</label></div><button class="btn btn-primary mt-3" id="cfgNext">Ir al resumen</button>`;
    } else { elMain.innerHTML = `<h2 class="h5">Paso 6 · Resumen final</h2><p class="text-muted">Revisa métricas, guarda tu configuración o solicita asesoría por WhatsApp.</p><div class="alert alert-light border">Tiempo de preparación: ${settings.assembly_lead_time_message || '24 a 72 horas hábiles con armado profesional.'}</div>`; }

    bindStepEvents();
    recalc();
  }

  function recalc(){
    const selected = [state.blade, state.fh, state.bh].filter(Boolean);
    const extrasPrice = state.extras.reduce((acc,x)=>acc + Number(x.price||0),0);
    const subtotal = selected.reduce((acc,p)=>acc + Number(p.precio||0),0) + extrasPrice;
    const avg = (field)=> selected.length ? (selected.reduce((a,p)=>a+Number(p[field]||0),0)/selected.length).toFixed(1) : '-';

    const summary = document.getElementById('cfgSummary');
    const empty = document.getElementById('cfgSummaryEmpty');
    const full = Boolean(state.blade && state.fh && state.bh);

    if(full){ summary.style.display='block'; empty.style.display='none'; } else { summary.style.display='none'; empty.style.display='block'; }
    document.getElementById('cfgCombo').innerHTML = `${state.blade?.nombre||'-'}<br>${state.fh?.nombre||'-'} (FH)<br>${state.bh?.nombre||'-'} (BH)`;
    document.getElementById('cfgKpis').innerHTML = `<span><b>Velocidad</b><b>${avg('speed')}</b></span><span><b>Control</b><b>${avg('control_score')}</b></span><span><b>Efecto</b><b>${avg('spin')}</b></span><span><b>Dureza</b><b>${avg('hardness')}</b></span>`;
    document.getElementById('cfgTotal').textContent = clp(subtotal);
    document.getElementById('cfgMobileTotal').textContent = clp(subtotal);

    saveBtn.disabled = !full;
    saveBtnMobile.disabled = !full;
    const wa = document.getElementById('cfgWaBtn');
    if(full){
      const txt = encodeURIComponent(`Hola PV Sport, quiero asesoría para esta paleta: ${state.blade.nombre} + ${state.fh.nombre} (FH) + ${state.bh.nombre} (BH).`);
      wa.href = `https://wa.me/56900000000?text=${txt}`;
      wa.style.display='inline-block';
    }
  }

  function bindStepEvents(){
    elMain.querySelectorAll('[data-mode]').forEach(btn=>btn.onclick = ()=>{ state.mode=btn.dataset.mode; });
    const n0 = document.getElementById('cfgNext0');
    if(n0) n0.onclick = ()=>{state.profile={level:document.getElementById('pf_level').value,style:document.getElementById('pf_style').value,priority:document.getElementById('pf_priority').value}; state.step=1; renderStep();};
    elMain.querySelectorAll('[data-pick]').forEach(card=>card.onclick=()=>{const key = card.dataset.pick; const id=Number(card.dataset.id); state[key]=productos.find(p=>Number(p.id)===id)||null; renderStep();});
    const n = document.getElementById('cfgNext'); if(n) n.onclick = ()=>{ state.step=Math.min(5,state.step+1); if(state.step===5){ captureExtras(); } renderStep(); };
    elMain.querySelectorAll('.form-check-input').forEach(i=>i.onchange = captureExtras);
  }

  function captureExtras(){ state.extras=[...elMain.querySelectorAll('.form-check-input:checked')].map(i=>({code:i.value,price:Number(i.dataset.price||0)})); recalc(); }

  function submitForm(){
    const extrasPrice = state.extras.reduce((acc,x)=>acc + Number(x.price||0),0);
    document.getElementById('form_mode').value = state.mode || 'experto';
    document.getElementById('form_profile_level').value = state.profile.level || '';
    document.getElementById('form_profile_style').value = state.profile.style || '';
    document.getElementById('form_profile_priority').value = state.profile.priority || '';
    document.getElementById('form_profile_budget').value = state.profile.budget || '';
    document.getElementById('form_profile_transition').value = state.profile.transition || 'suave';
    document.getElementById('form_blade_product_id').value = state.blade?.id || '';
    document.getElementById('form_fh_rubber_product_id').value = state.fh?.id || '';
    document.getElementById('form_bh_rubber_product_id').value = state.bh?.id || '';
    document.getElementById('form_extras_json').value = JSON.stringify(state.extras || []);
    document.getElementById('form_extras_price').value = extrasPrice;
    document.getElementById('cfgForm').submit();
  }

  saveBtn.addEventListener('click', submitForm);
  saveBtnMobile.addEventListener('click', submitForm);

  renderStep();
  } catch (error) {
    const host = document.getElementById('cfgMain');
    if (host) {
      host.innerHTML = '<div class="alert alert-warning">No pudimos cargar el configurador en este navegador. Recarga la página o contáctanos por WhatsApp.</div>';
    }
    console.error('Configurador error:', error);
  }
})();
</script>
