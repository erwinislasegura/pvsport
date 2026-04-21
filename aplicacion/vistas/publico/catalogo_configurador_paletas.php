<?php
$catalogoRutas = is_array($catalogoRutas ?? null) ? $catalogoRutas : [];
$catalogoBaseUrl = (string) ($catalogoRutas['base'] ?? url('/catalogo/' . (int) ($empresa['id'] ?? 0)));
$catalogoContactoUrl = (string) ($catalogoRutas['contacto'] ?? ($catalogoBaseUrl . '/contacto'));
$catalogoFaqUrl = (string) ($catalogoRutas['faq'] ?? ($catalogoBaseUrl . '/preguntas-frecuentes'));
$catalogoNosotrosUrl = (string) ($catalogoRutas['nosotros'] ?? ($catalogoBaseUrl . '/nosotros'));
$colorPrimario = trim((string) ($catalogoTopbar['color_primario'] ?? ''));
if (preg_match('/^#([A-Fa-f0-9]{6})$/', $colorPrimario) !== 1) {
    $colorPrimario = '#FF3131';
}
$colorAcento = trim((string) ($catalogoTopbar['color_acento'] ?? ''));
if (preg_match('/^#([A-Fa-f0-9]{6})$/', $colorAcento) !== 1) {
    $colorAcento = '#7B2CBF';
}
$colorAcento = $colorPrimario;
$topbarTexto = trim((string) ($catalogoTopbar['texto'] ?? ''));
if ($topbarTexto === '') {
    $topbarTexto = 'Envíos a todo el país • Garantía en todos los productos';
}
$socialesTopbar = [
    ['id' => 'facebook', 'url' => trim((string) ($catalogoTopbar['sociales']['facebook'] ?? '')), 'label' => 'Facebook'],
    ['id' => 'instagram', 'url' => trim((string) ($catalogoTopbar['sociales']['instagram'] ?? '')), 'label' => 'Instagram'],
    ['id' => 'tiktok', 'url' => trim((string) ($catalogoTopbar['sociales']['tiktok'] ?? '')), 'label' => 'TikTok'],
    ['id' => 'linkedin', 'url' => trim((string) ($catalogoTopbar['sociales']['linkedin'] ?? '')), 'label' => 'LinkedIn'],
    ['id' => 'youtube', 'url' => trim((string) ($catalogoTopbar['sociales']['youtube'] ?? '')), 'label' => 'YouTube'],
];
$socialesTopbar = array_values(array_filter($socialesTopbar, static fn(array $red): bool => $red['url'] !== ''));
$renderIconoRed = static function (string $id): string {
    return match ($id) {
        'facebook' => '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M13.5 21v-8.2h2.8l.5-3.2h-3.3V7.5c0-.9.3-1.6 1.6-1.6h1.8V3.1c-.3 0-1.3-.1-2.5-.1-2.5 0-4.2 1.5-4.2 4.3v2.4H8v3.2h2.4V21h3.1z"/></svg>',
        'instagram' => '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M7.8 2h8.4A5.8 5.8 0 0 1 22 7.8v8.4a5.8 5.8 0 0 1-5.8 5.8H7.8A5.8 5.8 0 0 1 2 16.2V7.8A5.8 5.8 0 0 1 7.8 2zm0 1.9A3.9 3.9 0 0 0 3.9 7.8v8.4a3.9 3.9 0 0 0 3.9 3.9h8.4a3.9 3.9 0 0 0 3.9-3.9V7.8a3.9 3.9 0 0 0-3.9-3.9H7.8zm8.9 1.5a1.2 1.2 0 1 1 0 2.3 1.2 1.2 0 0 1 0-2.3zM12 7a5 5 0 1 1 0 10 5 5 0 0 1 0-10zm0 1.9a3.1 3.1 0 1 0 0 6.2 3.1 3.1 0 0 0 0-6.2z"/></svg>',
        'tiktok' => '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M14.7 3h2.7c.2 1.5 1 2.8 2.3 3.6.9.6 1.9.9 3 .9V10a8 8 0 0 1-4.9-1.7v7.3a5.6 5.6 0 1 1-5.6-5.6c.4 0 .7 0 1 .1v2.7a2.9 2.9 0 1 0 1.5 2.5V3z"/></svg>',
        'linkedin' => '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6.4 8.9H3.5V21h2.9V8.9zM5 3A1.8 1.8 0 1 0 5 6.6 1.8 1.8 0 0 0 5 3zM21 13.8c0-3.3-1.8-5.3-4.6-5.3-2.1 0-3 .8-3.6 1.6V8.9h-2.9V21h2.9v-6.7c0-1.8 1-2.8 2.5-2.8s2.2 1 2.2 2.8V21H21v-7.2z"/></svg>',
        'youtube' => '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M23 12s0-3.2-.4-4.7a3 3 0 0 0-2.1-2.1C18.9 4.8 12 4.8 12 4.8s-6.9 0-8.5.4a3 3 0 0 0-2.1 2.1C1 8.8 1 12 1 12s0 3.2.4 4.7a3 3 0 0 0 2.1 2.1c1.6.4 8.5.4 8.5.4s6.9 0 8.5-.4a3 3 0 0 0 2.1-2.1c.4-1.5.4-4.7.4-4.7zm-13.8 3.9V8.1l6.1 3.9-6.1 3.9z"/></svg>',
        default => '<svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="8"/></svg>',
    };
};
$fmon = static fn(float $m): string => '$' . number_format($m, 0, ',', '.');
$jsonFlags = JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_INVALID_UTF8_SUBSTITUTE;
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
$whatsappDestino = preg_replace('/\D+/', '', (string) ($settingsMap['whatsapp_phone'] ?? $empresa['telefono'] ?? '56900000000'));
if ($whatsappDestino === '') {
    $whatsappDestino = '56900000000';
}
$inferirRolFallback = static function (array $item): string {
    $categoria = mb_strtolower(trim((string) ($item['categoria'] ?? '')));
    $categoriaNorm = preg_replace('/[^a-z0-9]+/u', '', $categoria ?? '');
    if (in_array($categoriaNorm, ['madero', 'maderos'], true)) {
        return 'blade';
    }
    if (in_array($categoriaNorm, ['goma', 'gomas', 'rubber', 'rubbers'], true)) {
        return 'rubber';
    }
    return 'accessory';
};
$productosBladeFallback = [];
$productosRubberFallback = [];
$resolverPrecioProducto = static function (array $item): float {
    $precio = (float) ($item['precio'] ?? 0);
    $precioOferta = (float) ($item['precio_oferta'] ?? 0);
    if ($precioOferta > 0 && ($precio <= 0 || $precioOferta < $precio)) {
        return $precioOferta;
    }
    return $precio;
};
foreach (($productos ?? []) as $productoItem) {
    $rolItem = $inferirRolFallback((array) $productoItem);
    if ($rolItem === 'blade') {
        $productosBladeFallback[] = (array) $productoItem;
        continue;
    }
    if ($rolItem === 'rubber') {
        $productosRubberFallback[] = (array) $productoItem;
    }
}
$fallbackOpciones = [
    'blades' => array_map(static function (array $item) use ($resolverPrecioProducto): array {
        return ['id' => (int) ($item['id'] ?? 0), 'nombre' => (string) ($item['nombre'] ?? ''), 'precio' => $resolverPrecioProducto($item)];
    }, $productosBladeFallback),
    'rubbers' => array_map(static function (array $item) use ($resolverPrecioProducto): array {
        return ['id' => (int) ($item['id'] ?? 0), 'nombre' => (string) ($item['nombre'] ?? ''), 'precio' => $resolverPrecioProducto($item)];
    }, $productosRubberFallback),
];
$fallbackOpcionesB64 = base64_encode((string) json_encode($fallbackOpciones, $jsonFlags));
$productosBladeB64 = base64_encode((string) json_encode(array_values($productosBladeFallback), $jsonFlags));
$productosRubberB64 = base64_encode((string) json_encode(array_values($productosRubberFallback), $jsonFlags));
?>
<style>
  :root{--primary:<?= e($colorPrimario) ?>;--accent:<?= e($colorAcento) ?>;--bg:#eef2f7;--border:#dbe3ee;--muted:#64748b;--text:#0f172a;--shadow:0 10px 25px rgba(15,23,42,.08)}
  .catalogo-page{background:var(--bg);min-height:100vh}
  .catalogo-container{width:min(1280px,92%);margin:0 auto}
  .catalogo-topbar{background:var(--primary);color:#fff;padding:8px 0;font-size:13px}
  .catalogo-topbar__content{display:flex;justify-content:space-between;gap:16px;flex-wrap:wrap}
  .catalogo-topbar__sociales{display:flex;align-items:center;gap:10px}
  .catalogo-topbar__sociales a{display:inline-flex;align-items:center;justify-content:center;width:30px;height:30px;border-radius:999px;border:1px solid rgba(255,255,255,.5);color:#fff;text-decoration:none}
  .catalogo-topbar__sociales a svg{width:14px;height:14px;fill:#fff}
  .catalogo-header{position:sticky;top:0;z-index:45;background:rgba(255,255,255,.94);backdrop-filter:blur(10px);border-bottom:1px solid var(--border)}
  .catalogo-navbar{display:grid;grid-template-columns:340px minmax(0,1fr) auto auto;gap:10px;align-items:center;padding:10px 0}
  .catalogo-logo{display:flex;align-items:center;gap:.55rem;color:var(--text);font-size:16px;font-weight:800;text-decoration:none;line-height:1.05}
  .catalogo-logo img{width:120px;height:60px;object-fit:contain;background:transparent}
  .catalogo-mobile-toggle{display:none;align-items:center;justify-content:center;flex-direction:column;gap:4px;width:42px;height:42px;border-radius:12px;border:1px solid var(--primary);background:var(--primary);color:#fff}
  .catalogo-mobile-toggle span{display:block;width:18px;height:2px;background:currentColor;border-radius:999px;transition:all .2s ease}
  .catalogo-header.is-mobile-open .catalogo-mobile-toggle span:nth-child(1){transform:translateY(6px) rotate(45deg)}
  .catalogo-header.is-mobile-open .catalogo-mobile-toggle span:nth-child(2){opacity:0}
  .catalogo-header.is-mobile-open .catalogo-mobile-toggle span:nth-child(3){transform:translateY(-6px) rotate(-45deg)}
  .search-box{display:flex;align-items:center;background:#fff;border:1px solid var(--border);border-radius:999px;overflow:hidden;min-width:0}
  .search-box input{width:100%;padding:10px 14px;border:none;outline:none;background:transparent;font-size:14px}
  .search-box button{background:var(--accent);color:#fff;padding:10px 18px;font-weight:700;border:none}
  .nav-actions{display:flex;gap:10px;align-items:center;flex-wrap:wrap}
  .menu-link{padding:9px 6px;font-weight:600;color:var(--primary);text-decoration:none;border:none;background:transparent;white-space:nowrap}
  .menu-link:hover{color:var(--accent)}
  .btn-outline,.btn-primary-custom,.btn-soft,.btn-danger-soft{padding:9px 13px;border-radius:10px;font-weight:700;border:1px solid var(--border);background:#fff;color:var(--text)}
  .btn-primary-custom{background:var(--accent);border-color:var(--accent);color:#fff}
  .catalogo-navbar .btn-primary-custom,.catalogo-navbar .btn-primary-custom span,.catalogo-navbar .btn-primary-custom svg{color:#fff !important;fill:#fff !important;stroke:#fff !important;text-decoration:none !important}
  .footer{position:relative;color:#fff;padding:30px 0 20px;margin-top:20px;background:linear-gradient(120deg,var(--primary),var(--accent))}
  .footer-content{display:grid;grid-template-columns:1.1fr .9fr 1fr .9fr;gap:22px}
  .footer-col h4{font-size:18px;font-weight:600;margin:0 0 10px}
  .footer-brand img{width:128px;height:60px;object-fit:contain;background:#fff;border-radius:10px;padding:4px 8px;border:1px solid rgba(255,255,255,.35);margin-bottom:8px}
  .footer-brand p,.footer-contact p,.footer-menu a,.footer-follow p{font-size:13px;color:rgba(255,255,255,.92);margin:0}
  .footer-contact{display:grid;gap:8px}
  .footer-contact p{display:flex;align-items:center;gap:8px}
  .footer-contact p .dot{width:24px;height:24px;border-radius:999px;border:1px solid rgba(255,255,255,.45);display:inline-flex;align-items:center;justify-content:center}
  .footer-contact p .dot svg{width:12px;height:12px;stroke:#fff;fill:none;stroke-width:2;stroke-linecap:round;stroke-linejoin:round}
  .footer-menu{display:grid;gap:8px}
  .footer-menu a,.footer-menu a:link,.footer-menu a:visited{color:#fff !important;text-decoration:none}
  .footer-menu a:hover{text-decoration:underline}
  .footer-follow{display:grid;gap:10px}
  .footer-sociales{display:flex;gap:8px;margin-top:10px;flex-wrap:wrap}
  .footer-sociales a{display:inline-flex;align-items:center;justify-content:center;width:32px;height:32px;border-radius:999px;border:1px solid rgba(255,255,255,.45);background:rgba(255,255,255,.08);color:#fff;text-decoration:none}
  .footer-sociales a svg{width:14px;height:14px;fill:#fff}
  .footer-bottom{background:#fff;border-top:1px solid #e5e7eb;padding:10px 0}
  .footer-bottom__content{display:flex;justify-content:space-between;align-items:center;color:#4b5563;font-size:13px;font-weight:500;gap:12px}
  .footer-bottom__content a{color:#3f2a84;font-weight:700;text-decoration:none}
  .footer-bottom__content a:hover{text-decoration:underline}
  .cfg-next-btn{background:var(--primary) !important;border:1px solid var(--primary) !important;color:#fff !important;box-shadow:none !important;background-image:none !important}
  .cfg-next-btn:hover{background:var(--accent) !important;border-color:var(--accent) !important;color:#fff !important}
  body.public-page > footer.border-top.bg-white.mt-5{display:none}
  footer.border-top.bg-white.mt-5{display:none !important}
  :root{--cfg-primary:<?= e($colorPrimario) ?>;--cfg-text:#0f172a;--cfg-muted:#64748b;--cfg-border:#dbe3ee;--cfg-bg:#eef2f7;--cfg-card:#fff;--cfg-ok:#16a34a}
  .cfg-page{background:var(--cfg-bg)} .cfg-wrap{width:min(1280px,92%);margin:0 auto;padding:18px 0 36px}
  .cfg-grid{display:grid;grid-template-columns:1fr 340px;gap:18px}.cfg-card{background:#fff;border:1px solid var(--cfg-border);border-radius:16px;padding:16px}
  .cfg-progress{display:grid;grid-template-columns:repeat(6,1fr);gap:8px}.cfg-step{font-size:12px;padding:8px;border-radius:999px;background:#f1f5f9;text-align:center}
  .cfg-step.active{background:var(--cfg-primary);color:#fff;font-weight:700}.cfg-list{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:12px}
  .cfg-item{border:1px solid var(--cfg-border);border-radius:12px;padding:10px;cursor:pointer}.cfg-item.active{border-color:var(--cfg-primary);box-shadow:0 0 0 2px color-mix(in srgb,var(--cfg-primary) 28%,transparent)}
  .cfg-item img{width:100%;height:120px;object-fit:contain;background:#fff;border-radius:10px}.cfg-item h4{font-size:14px;margin:8px 0 6px}
  .cfg-meta{font-size:12px;color:var(--cfg-muted);display:grid;gap:2px}.cfg-chip{display:inline-block;padding:2px 8px;border-radius:999px;background:#e2e8f0;font-size:11px;margin:2px 2px 0 0}
  .cfg-sidebar{position:sticky;top:84px;height:fit-content}.cfg-total{font-size:30px;font-weight:800}.cfg-kpi{display:grid;gap:6px;margin-top:8px}
  .cfg-kpi span{display:flex;justify-content:space-between;font-size:13px}.cfg-actions{display:grid;gap:8px;margin-top:10px}
  .cfg-mobile-bar{display:none;position:fixed;left:10px;right:10px;bottom:10px;background:#fff;border:1px solid var(--cfg-border);box-shadow:0 10px 24px rgba(15,23,42,.16);border-radius:12px;padding:10px;z-index:70}
  .cfg-hero{margin-top:12px;background:#fff;border:1px solid var(--cfg-border);border-radius:18px;padding:16px}.cfg-hero h1{font-size:30px;margin:0 0 8px}
  .cfg-faq{margin-top:20px}
  @media (max-width:1100px){
    .catalogo-navbar,.footer-content{grid-template-columns:1fr}
    .catalogo-navbar{gap:12px}
    .search-box{width:100%}
    .nav-actions{justify-content:flex-start}
  }
  @media (max-width:980px){.cfg-grid{grid-template-columns:1fr}.cfg-list{grid-template-columns:repeat(2,minmax(0,1fr))}.cfg-sidebar{position:static}.cfg-mobile-bar{display:block}}
  @media (max-width:720px){
    .catalogo-topbar__content{flex-direction:column;align-items:flex-start}
    .catalogo-navbar{display:grid;grid-template-columns:minmax(0,1fr) auto;align-items:center;gap:10px}
    .catalogo-logo{justify-content:flex-start}
    .catalogo-logo img{width:110px;height:56px}
    .catalogo-mobile-toggle{display:inline-flex}
    .search-box,.nav-actions,.catalogo-navbar > .btn-primary-custom{display:none}
    .catalogo-header.is-mobile-open .search-box{display:flex;grid-column:1/-1}
    .catalogo-header.is-mobile-open .nav-actions{display:flex;grid-column:1/-1}
    .catalogo-header.is-mobile-open .catalogo-navbar > .btn-primary-custom{display:flex;grid-column:1/-1}
    .search-box{border-radius:14px}
    .search-box input,.search-box button{font-size:13px}
    .search-box button{padding:10px 14px}
    .nav-actions{justify-content:space-between;gap:6px}
    .menu-link{flex:1;text-align:center;padding:8px 8px;border:1px solid color-mix(in srgb,var(--primary) 25%,#fff);border-radius:10px;background:#fff;color:var(--primary);font-size:13px;font-weight:500}
    .catalogo-navbar .btn-primary-custom{width:100%;justify-content:center;font-size:14px;font-weight:600}
    .catalogo-header.is-mobile-open .catalogo-navbar > .btn-primary-custom{width:100%}
    .cfg-list{grid-template-columns:1fr}
    .cfg-progress{grid-template-columns:repeat(2,1fr)}
    .cfg-hero h1{font-size:22px}
  }
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
        <div id="cfgMain">
          <h2 class="h5">Configuración rápida en 2 pasos</h2>
          <?php if ($productosBladeFallback === [] && $productosRubberFallback === []): ?>
            <div class="alert alert-warning mb-0">No encontramos productos clasificados para el configurador. Revisa categorías/atributos en el panel.</div>
          <?php else: ?>
            <?php if ($productosBladeFallback !== []): ?>
              <div class="cfg-card mt-3">
              <h3 class="h6 mb-2">Paso 1 · Selecciona tu madero</h3>
              <div class="cfg-list">
                <?php foreach (array_slice($productosBladeFallback, 0, 18) as $item): ?>
                  <article class="cfg-item">
                    <img src="<?= e(!empty($item['imagen']) ? '/media/archivo?ruta=' . rawurlencode((string) $item['imagen']) : '/img/placeholder-producto.svg') ?>" alt="<?= e((string) ($item['nombre'] ?? 'Producto')) ?>">
                    <h4><?= e((string) ($item['nombre'] ?? 'Producto')) ?></h4>
                    <div class="cfg-meta">
                      <span><?= e((string) ($item['categoria'] ?? '')) ?></span>
                      <span><?= $fmon($resolverPrecioProducto((array) $item)) ?></span>
                      <?php if ((int) ($item['proximo_catalogo'] ?? 0) === 1): ?>
                        <span class="badge bg-success-subtle text-success">Próximamente · llega en <?= max(0, (int) ($item['proximo_dias_catalogo'] ?? 0)) ?> día(s)</span>
                      <?php endif; ?>
                    </div>
                  </article>
                <?php endforeach; ?>
              </div>
              </div>
            <?php endif; ?>
            <?php if ($productosRubberFallback !== []): ?>
              <div class="cfg-card mt-3">
              <h3 class="h6 mb-2">Paso 2 · Selecciona tus gomas (derecho y revés)</h3>
              <p class="small text-muted mb-2">Puedes elegir la misma goma para ambos lados si quieres.</p>
              <div class="cfg-list">
                <?php foreach (array_slice($productosRubberFallback, 0, 24) as $item): ?>
                  <article class="cfg-item">
                    <img src="<?= e(!empty($item['imagen']) ? '/media/archivo?ruta=' . rawurlencode((string) $item['imagen']) : '/img/placeholder-producto.svg') ?>" alt="<?= e((string) ($item['nombre'] ?? 'Producto')) ?>">
                    <h4><?= e((string) ($item['nombre'] ?? 'Producto')) ?></h4>
                    <div class="cfg-meta">
                      <span><?= e((string) ($item['categoria'] ?? '')) ?></span>
                      <span><?= $fmon($resolverPrecioProducto((array) $item)) ?></span>
                      <?php if ((int) ($item['proximo_catalogo'] ?? 0) === 1): ?>
                        <span class="badge bg-success-subtle text-success">Próximamente · llega en <?= max(0, (int) ($item['proximo_dias_catalogo'] ?? 0)) ?> día(s)</span>
                      <?php endif; ?>
                    </div>
                  </article>
                <?php endforeach; ?>
              </div>
              </div>
            <?php endif; ?>
            <?php if ($productosBladeFallback !== [] && $productosRubberFallback !== []): ?>
              <div class="cfg-card mt-3">
                <h3 class="h6 mb-2">Selección rápida</h3>
                <form method="POST" action="<?= e(url('/catalogo/' . (int) ($empresa['id'] ?? 0) . '/configurador-paletas/guardar')) ?>" id="fallbackConfigForm">
                  <?= csrf_campo() ?>
                  <input type="hidden" name="mode" value="experto">
                  <div class="row g-2">
                    <div class="col-md-4">
                      <label class="form-label small">Madero</label>
                      <select class="form-select" id="fallback_blade" name="blade_product_id" required>
                        <option value="">Selecciona madero</option>
                        <?php foreach ($productosBladeFallback as $item): ?>
                          <option value="<?= (int) ($item['id'] ?? 0) ?>"><?= e((string) ($item['nombre'] ?? '')) ?></option>
                        <?php endforeach; ?>
                      </select>
                    </div>
                    <div class="col-md-4">
                      <label class="form-label small">Goma FH (derecho)</label>
                      <select class="form-select" id="fallback_fh" name="fh_rubber_product_id" required>
                        <option value="">Selecciona goma FH</option>
                        <?php foreach ($productosRubberFallback as $item): ?>
                          <option value="<?= (int) ($item['id'] ?? 0) ?>"><?= e((string) ($item['nombre'] ?? '')) ?></option>
                        <?php endforeach; ?>
                      </select>
                    </div>
                    <div class="col-md-4">
                      <label class="form-label small">Goma BH (revés)</label>
                      <select class="form-select" id="fallback_bh" name="bh_rubber_product_id" required>
                        <option value="">Selecciona goma BH</option>
                        <?php foreach ($productosRubberFallback as $item): ?>
                          <option value="<?= (int) ($item['id'] ?? 0) ?>"><?= e((string) ($item['nombre'] ?? '')) ?></option>
                        <?php endforeach; ?>
                      </select>
                    </div>
                  </div>
                  <div class="small text-muted mt-2">Puedes elegir la misma goma en FH y BH.</div>
                  <div class="small mt-2" id="fallbackDetalle"></div>
                  <div class="h5 mt-1" id="fallbackTotal">$0</div>
                  <button type="submit" class="btn btn-dark btn-sm mt-2">Guardar selección</button>
                </form>
              </div>
            <?php endif; ?>
          <?php endif; ?>
        </div>
      </main>
      <aside class="cfg-card cfg-sidebar">
        <h3 class="h5 mb-2">Resumen técnico</h3>
        <div id="cfgSummaryEmpty" class="text-muted small">Selecciona madero y gomas para completar tu paleta.</div>
        <div id="cfgSummary">
          <div class="small" id="cfgCombo"></div>
          <div class="cfg-kpi" id="cfgKpis"></div>
          <div class="cfg-total" id="cfgTotal"><?= $fmon(0) ?></div>
          <div class="small text-muted" id="cfgPolicy"><?= e((string) ($settingsMap['commercial_policy_message'] ?? 'Producto configurado a pedido. Sujeto a disponibilidad y validación técnica.')) ?></div>
        </div>
        <div class="cfg-actions">
          <button class="btn btn-dark" id="cfgSaveBtn" disabled>Agregar al carrito</button>
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
      <button class="btn btn-dark btn-sm" id="cfgMobileSave" disabled>Agregar</button>
    </div>
  </div>

  <form id="cfgForm" method="POST" action="<?= e(url('/catalogo/' . (int) ($empresa['id'] ?? 0) . '/configurador-paletas/guardar')) ?>" class="d-none">
    <?= csrf_campo() ?>
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
  const productosBlade = JSON.parse(atob('<?= e($productosBladeB64) ?>') || '[]');
  const productosRubber = JSON.parse(atob('<?= e($productosRubberB64) ?>') || '[]');
  const productosFuente = [...productosBlade, ...productosRubber];
  const settings = JSON.parse(atob('<?= e($settingsB64) ?>') || '{}');
  const steps = ['Madero','Goma FH','Goma BH','Resumen'];
  const empresaId = <?= (int) ($empresa['id'] ?? 0) ?>;
  const cartStorageKey = `pvsport_catalogo_carrito_${empresaId}`;
  const whatsappDestino = '<?= e((string) $whatsappDestino) ?>';
  const state = {step:0, mode:'experto', profile:{}, blade:null, fh:null, bh:null, extras:[]};

  const elMain = document.getElementById('cfgMain');
  const elProgress = document.getElementById('cfgProgress');
  const saveBtn = document.getElementById('cfgSaveBtn');
  const saveBtnMobile = document.getElementById('cfgMobileSave');

  const inferRole = (item) => {
    const currentRole = String((item && item.category_role) || '').toLowerCase().trim();
    if (currentRole && currentRole !== 'unknown') return currentRole;
    const categoria = String((item && item.categoria) || '').toLowerCase();
    const categoriaNorm = categoria.replace(/[^a-z0-9]+/g, '');
    if (['madero','maderos'].includes(categoriaNorm)) return 'blade';
    if (['goma','gomas','rubber','rubbers'].includes(categoriaNorm)) return 'rubber';
    return 'accessory';
  };
  const byRole = (role) => {
    if (role === 'blade') return productosBlade;
    if (role === 'rubber') return productosRubber;
    return productos.filter(p => inferRole(p) === role);
  };
  const clp = n => '$' + Math.round(Number(n || 0)).toLocaleString('es-CL');
  const parseTags = (item) => {
    const raw = String((item && item.tags) || '').trim();
    if (!raw) return {};
    try {
      const data = JSON.parse(raw);
      return (data && typeof data === 'object') ? data : {};
    } catch (e) {
      return {};
    }
  };
  const getTech = (item, role) => {
    const tags = parseTags(item);
    if (!item) return null;
    const hasTagData = ['capas','layers','material','tipo','flexibilidad','flex','rigidez','feeling','adherencia','tags_texto'].some(k => String(tags[k] || '').trim() !== '');
    const hasMetricData = Number(item.speed || 0) > 0 || Number(item.control_score || 0) > 0 || Number(item.spin || 0) > 0 || Number(item.hardness || 0) > 0;
    const hasTextData = String(item.composition || '').trim() !== '' || String(item.play_style || '').trim() !== '' || String(item.tacky_type || '').trim() !== '' || String(item.rubber_type || '').trim() !== '';
    if (!hasTagData && !hasMetricData && !hasTextData) return null;
    if (role === 'blade') {
      return {
        capas: tags.capas || tags.layers || '-',
        material: tags.material || item.composition || '-',
        tipo: tags.tipo || tags.blade_type || item.play_style || '-',
        flexibilidad: tags.flexibilidad || tags.flex || '-',
        rigidez: tags.rigidez || '-',
        feeling: tags.feeling || '-',
        velocidad: Number(item.speed || 0).toFixed(1),
        control: Number(item.control_score || 0).toFixed(1),
        rotacion: Number(item.spin || 0).toFixed(1)
      };
    }
    return {
      tipo: tags.tipo || tags.rubber_type || item.rubber_type || '-',
      dureza: tags.dureza || (item.hardness ? Number(item.hardness).toFixed(1) : '-'),
      adherencia: tags.adherencia || item.tacky_type || '-',
      feeling: tags.feeling || '-',
      velocidad: Number(item.speed || 0).toFixed(1),
      control: Number(item.control_score || 0).toFixed(1),
      spin: Number(item.spin || 0).toFixed(1)
    };
  };
  const techToHtml = (label, item, role) => {
    const tech = getTech(item, role);
    if (!tech) return `<div class="small text-muted">${label}: sin ficha técnica cargada para este modelo.</div>`;
    const fields = role === 'blade'
      ? `<li><b>Capas:</b> ${tech.capas}</li><li><b>Material:</b> ${tech.material}</li><li><b>Tipo:</b> ${tech.tipo}</li><li><b>Flexibilidad:</b> ${tech.flexibilidad}</li><li><b>Rigidez:</b> ${tech.rigidez}</li><li><b>Feeling:</b> ${tech.feeling}</li>`
      : `<li><b>Tipo:</b> ${tech.tipo}</li><li><b>Dureza:</b> ${tech.dureza}</li><li><b>Adherencia:</b> ${tech.adherencia}</li><li><b>Feeling:</b> ${tech.feeling}</li>`;
    return `<div class="border rounded p-2 mb-2"><div class="small fw-semibold">${label} · ${(item && item.nombre) || '-'}</div><ul class="small mb-0">${fields}<li><b>Velocidad:</b> ${tech.velocidad}</li><li><b>Control:</b> ${tech.control}</li><li><b>Spin:</b> ${tech.spin || tech.rotacion || '-'}</li></ul></div>`;
  };
  const getPrice = (item) => {
    const price = Number((item && item.precio) || 0);
    const offer = Number((item && item.precio_oferta) || 0);
    return (offer > 0 && (price <= 0 || offer < price)) ? offer : price;
  };
  const getImage = (item) => (item && item.imagen) ? ('/media/archivo?ruta=' + encodeURIComponent(item.imagen)) : '/img/placeholder-producto.svg';

  function renderProgress(){
    elProgress.innerHTML = steps.map((s,i)=>`<div class="cfg-step ${i===state.step?'active':''}">${i+1}. ${s}</div>`).join('');
  }

  function renderCards(items, key){
    const selected = state[key] ? Number(state[key].id) : 0;
    return `<div class="cfg-list">${items.map(item=>{
      const price = getPrice(item);
      const tags = (item.tags || '').split(',').filter(Boolean).slice(0,3).map(t=>`<span class="cfg-chip">${t.trim()}</span>`).join('');
      const incoming = Number(item.proximo_catalogo || 0) === 1 ? `<span class="cfg-chip" style="background:#dcfce7;color:#166534">Próximamente · ${Math.max(0, Number(item.proximo_dias_catalogo || 0))} día(s)</span>` : '';
      return `<article class="cfg-item ${selected===Number(item.id)?'active':''}" data-pick="${key}" data-id="${item.id}">
        <img src="${item.imagen ? '/media/archivo?ruta='+encodeURIComponent(item.imagen) : '/img/placeholder-producto.svg'}" alt="${item.nombre}">
        <h4>${item.nombre}</h4><div class="cfg-meta"><span>${item.categoria||''}</span><span>Vel ${item.speed||'-'} · Ctrl ${item.control_score||'-'} · Spin ${item.spin||'-'}</span><span>${clp(price)}</span>${incoming}</div>${tags}</article>`;
    }).join('')}</div>`;
  }

  function renderStep(){
    renderProgress();
    if(state.step===0){ elMain.innerHTML = `<h2 class="h5">Paso 1 · Selecciona tu madero</h2><button class="btn cfg-next-btn btn-sm mb-2" id="cfgNextTop">Siguiente</button>${renderCards(byRole('blade'),'blade')}<button class="btn cfg-next-btn mt-3" id="cfgNext">Siguiente</button>`;
    } else if(state.step===1){ elMain.innerHTML = `<h2 class="h5">Paso 2 · Selecciona goma para derecho (FH)</h2><button class="btn cfg-next-btn btn-sm mb-2" id="cfgNextTop">Siguiente</button>${renderCards(byRole('rubber'),'fh')}<button class="btn cfg-next-btn mt-3" id="cfgNext">Siguiente</button>`;
    } else if(state.step===2){
      elMain.innerHTML = `<h2 class="h5">Paso 3 · Selecciona goma para revés (BH)</h2><button class="btn cfg-next-btn btn-sm mb-2" id="cfgNextTop">Ir al resumen</button><p class="small text-muted">Si quieres la misma goma del derecho, selecciónala nuevamente.</p>${renderCards(byRole('rubber'),'bh')}<button class="btn cfg-next-btn mt-3" id="cfgNext">Ir al resumen</button>`;
    } else {
      const bladePrice = state.blade ? getPrice(state.blade) : 0;
      const fhPrice = state.fh ? getPrice(state.fh) : 0;
      const bhPrice = state.bh ? getPrice(state.bh) : 0;
      const total = bladePrice + fhPrice + bhPrice;
      elMain.innerHTML = `<h2 class="h5">Paso 4 · Resumen final detallado</h2>
      <div class="table-responsive"><table class="table table-sm">
        <thead><tr><th>Componente</th><th>Foto</th><th>Producto</th><th class="text-end">Precio</th></tr></thead>
        <tbody>
          <tr><td>Madero</td><td><img src="${getImage(state.blade)}" alt="Madero" style="width:54px;height:54px;object-fit:contain;border-radius:8px;border:1px solid #dbe3ee;background:#fff"></td><td>${(state.blade && state.blade.nombre) || '-'}</td><td class="text-end">${clp(bladePrice)}</td></tr>
          <tr><td>Goma FH</td><td><img src="${getImage(state.fh)}" alt="Goma FH" style="width:54px;height:54px;object-fit:contain;border-radius:8px;border:1px solid #dbe3ee;background:#fff"></td><td>${(state.fh && state.fh.nombre) || '-'}</td><td class="text-end">${clp(fhPrice)}</td></tr>
          <tr><td>Goma BH</td><td><img src="${getImage(state.bh)}" alt="Goma BH" style="width:54px;height:54px;object-fit:contain;border-radius:8px;border:1px solid #dbe3ee;background:#fff"></td><td>${(state.bh && state.bh.nombre) || '-'}</td><td class="text-end">${clp(bhPrice)}</td></tr>
          <tr><td colspan="3"><strong>Total</strong></td><td class="text-end"><strong>${clp(total)}</strong></td></tr>
        </tbody>
      </table></div>
      <h3 class="h6 mt-3">Análisis técnico real de la combinación</h3>
      ${techToHtml('Madero', state.blade, 'blade')}
      ${techToHtml('Goma FH', state.fh, 'rubber')}
      ${techToHtml('Goma BH', state.bh, 'rubber')}
      <div class="alert alert-light border">Tiempo de preparación: ${settings.assembly_lead_time_message || '24 a 72 horas hábiles con armado profesional.'}</div>`;
    }

    bindStepEvents();
    recalc();
  }

  function recalc(){
    const selected = [state.blade, state.fh, state.bh].filter(Boolean);
    const extrasPrice = state.extras.reduce((acc,x)=>acc + Number(x.price||0),0);
    const subtotal = selected.reduce((acc,p)=>acc + getPrice(p),0) + extrasPrice;
    const avg = (field)=> selected.length ? (selected.reduce((a,p)=>a+Number(p[field]||0),0)/selected.length).toFixed(1) : '0.0';

    const summary = document.getElementById('cfgSummary');
    const empty = document.getElementById('cfgSummaryEmpty');
    if (state.useSameBh && state.fh) { state.bh = state.fh; }
    const full = Boolean(state.blade && state.fh && state.bh);

    summary.style.display = 'block';
    empty.style.display = full ? 'none' : 'block';
    document.getElementById('cfgCombo').innerHTML = `${(state.blade && state.blade.nombre) || '-'}<br>${(state.fh && state.fh.nombre) || '-'} (FH)<br>${(state.bh && state.bh.nombre) || '-'} (BH)`;
    document.getElementById('cfgKpis').innerHTML = `<span><b>Velocidad</b><b>${avg('speed')}</b></span><span><b>Control</b><b>${avg('control_score')}</b></span><span><b>Efecto</b><b>${avg('spin')}</b></span><span><b>Dureza</b><b>${avg('hardness')}</b></span>`;
    document.getElementById('cfgTotal').textContent = clp(subtotal);
    document.getElementById('cfgMobileTotal').textContent = clp(subtotal);

    saveBtn.disabled = !full;
    saveBtnMobile.disabled = !full;
    const wa = document.getElementById('cfgWaBtn');
    if(full){
      const txt = encodeURIComponent(`Hola PV Sport, quiero asesoría para esta paleta: ${state.blade.nombre} + ${state.fh.nombre} (FH) + ${state.bh.nombre} (BH).`);
      wa.href = `https://wa.me/${whatsappDestino}?text=${txt}`;
      wa.style.display='inline-block';
    }
  }

  function bindStepEvents(){
    elMain.querySelectorAll('[data-mode]').forEach(btn=>btn.onclick = ()=>{ state.mode=btn.dataset.mode; });
    elMain.querySelectorAll('[data-pick]').forEach(card=>card.onclick=()=>{const key = card.dataset.pick; const id=Number(card.dataset.id); state[key]=productosFuente.find(p=>Number(p.id)===id)||null; renderStep();});
    const goNext = () => { state.step=Math.min(3,state.step+1); renderStep(); };
    const n = document.getElementById('cfgNext'); if(n) n.onclick = goNext;
    const nt = document.getElementById('cfgNextTop'); if(nt) nt.onclick = goNext;
    elMain.querySelectorAll('.form-check-input').forEach(i=>i.onchange = captureExtras);
  }

  function captureExtras(){ state.extras=[...elMain.querySelectorAll('.form-check-input:checked')].map(i=>({code:i.value,price:Number(i.dataset.price||0)})); recalc(); }

  function submitForm(){
    if (!(state.blade && state.fh && state.bh)) return;
    const components = [state.blade, state.fh, state.bh];
    let cart = [];
    try { cart = JSON.parse(localStorage.getItem(cartStorageKey) || '[]'); } catch (e) { cart = []; }
    cart = Array.isArray(cart) ? cart : [];
    components.forEach((item) => {
      const id = Number(item.id || 0);
      if (id <= 0) return;
      const price = getPrice(item);
      const oldPrice = Number(item.precio || 0);
      const existing = cart.find((i) => Number(i.id || 0) === id);
      if (existing) {
        existing.quantity = Number(existing.quantity || 1) + 1;
      } else {
        cart.push({
          id,
          name: item.nombre || 'Producto',
          description: item.descripcion || '',
          image: getImage(item),
          price,
          oldPrice: oldPrice > price ? oldPrice : 0,
          quantity: 1,
          proximo: Number(item.proximo_catalogo || 0) === 1,
          proximoDias: Number(item.proximo_dias_catalogo || 0)
        });
      }
    });
    localStorage.setItem(cartStorageKey, JSON.stringify(cart));
    window.location.href = `<?= e($catalogoBaseUrl) ?>`;
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

(() => {
  try {
    var data = JSON.parse(atob('<?= e($fallbackOpcionesB64) ?>') || '{}');
    var blades = Array.isArray(data.blades) ? data.blades : [];
    var rubbers = Array.isArray(data.rubbers) ? data.rubbers : [];
    var bladeSel = document.getElementById('fallback_blade');
    var fhSel = document.getElementById('fallback_fh');
    var bhSel = document.getElementById('fallback_bh');
    var detalle = document.getElementById('fallbackDetalle');
    var total = document.getElementById('fallbackTotal');
    if (!bladeSel || !fhSel || !bhSel || !detalle || !total) { return; }

    var byId = function (arr, id) {
      for (var i = 0; i < arr.length; i += 1) {
        if (Number(arr[i].id || 0) === Number(id || 0)) { return arr[i]; }
      }
      return null;
    };
    var clp = function (n) { return '$' + Math.round(Number(n || 0)).toLocaleString('es-CL'); };
    var refresh = function () {
      var b = byId(blades, bladeSel.value);
      var fh = byId(rubbers, fhSel.value);
      var bh = byId(rubbers, bhSel.value);
      var sum = Number((b && b.precio) || 0) + Number((fh && fh.precio) || 0) + Number((bh && bh.precio) || 0);
      detalle.innerHTML = (b ? ('Madero: <strong>' + b.nombre + '</strong><br>') : '')
        + (fh ? ('FH: <strong>' + fh.nombre + '</strong><br>') : '')
        + (bh ? ('BH: <strong>' + bh.nombre + '</strong>') : '');
      total.textContent = clp(sum);
      var combo = document.getElementById('cfgCombo');
      var totalSide = document.getElementById('cfgTotal');
      var empty = document.getElementById('cfgSummaryEmpty');
      if (combo) {
        combo.innerHTML = (b ? b.nombre : '-') + '<br>' + (fh ? fh.nombre : '-') + ' (FH)<br>' + (bh ? bh.nombre : '-') + ' (BH)';
      }
      if (totalSide) {
        totalSide.textContent = clp(sum);
      }
      if (empty) {
        empty.style.display = (b && fh && bh) ? 'none' : 'block';
      }
    };

    bladeSel.addEventListener('change', refresh);
    fhSel.addEventListener('change', refresh);
    bhSel.addEventListener('change', refresh);
    refresh();
  } catch (e) {
    console.error('Fallback selector error', e);
  }
})();
</script>
