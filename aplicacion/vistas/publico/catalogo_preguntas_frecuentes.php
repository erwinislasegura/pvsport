<?php
$catalogoRutas = is_array($catalogoRutas ?? null) ? $catalogoRutas : [];
$catalogoBaseUrl = (string) ($catalogoRutas['base'] ?? url('/catalogo/' . (int) ($empresa['id'] ?? 0)));
$catalogoContactoUrl = (string) ($catalogoRutas['contacto'] ?? ($catalogoBaseUrl . '/contacto'));
$catalogoNosotrosUrl = (string) ($catalogoRutas['nosotros'] ?? ($catalogoBaseUrl . '/nosotros'));
$catalogoFaqUrl = (string) ($catalogoRutas['faq'] ?? ($catalogoBaseUrl . '/preguntas-frecuentes'));
$colorPrimario = trim((string) ($catalogoTopbar['color_primario'] ?? ''));
if (preg_match('/^#([A-Fa-f0-9]{6})$/', $colorPrimario) !== 1) {
    $colorPrimario = '#FF3131';
}
$colorAcento = trim((string) ($catalogoTopbar['color_acento'] ?? ''));
if (preg_match('/^#([A-Fa-f0-9]{6})$/', $colorAcento) !== 1) {
    $colorAcento = '#7B2CBF';
}
$topbarTexto = trim((string) ($catalogoTopbar['texto'] ?? ''));
if ($topbarTexto === '') {
    $topbarTexto = 'Envíos a todo el país • Garantía en todos los productos';
}
$sliderImagen = trim((string) ($catalogoTopbar['nosotros_banner_imagen'] ?? ''));
if ($sliderImagen === '') {
    $sliderImagen = trim((string) ($sliderCatalogo['imagen'] ?? ''));
    if ($sliderImagen === '') {
        $sliderImagen = url('/img/placeholder-producto.svg');
    }
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
$faqs = [
    ['pregunta' => '¿Qué es el tenis de mesa o ping pong?', 'respuesta' => 'El tenis de mesa, también conocido como ping pong, es un deporte de paleta que se juega en una mesa con red y pelotas de 40 mm, ideal tanto para recreación como nivel profesional.'],
    ['pregunta' => '¿Qué implementación necesito para jugar tenis de mesa?', 'respuesta' => 'Necesitas paletas (raquetas), pelotas, mesa de ping pong y red. También puedes usar accesorios como fundas, gomas y limpiadores.'],
    ['pregunta' => '¿Cuál es la diferencia entre ping pong y tenis de mesa?', 'respuesta' => 'El ping pong es más recreativo, mientras que el tenis de mesa es la versión profesional regulada por federaciones.'],
    ['pregunta' => '¿Cómo elegir una paleta de tenis de mesa adecuada?', 'respuesta' => "Depende de tu nivel: Principiante: paletas prearmadas. Intermedio: paletas con mejor control. Avanzado: maderas + gomas personalizadas."],
    ['pregunta' => '¿Qué son las gomas de tenis de mesa y para qué sirven?', 'respuesta' => 'Las gomas se adhieren a la paleta y determinan el efecto, velocidad y control de cada golpe.'],
    ['pregunta' => '¿Qué tipo de pelotas de ping pong debo usar?', 'respuesta' => 'Las pelotas oficiales son de 40+ mm, generalmente de plástico ABS, utilizadas en competencia.'],
    ['pregunta' => '¿Qué incluye una implementación completa de tenis de mesa?', 'respuesta' => 'Paletas, gomas, pelotas, mesa, red, accesorios y equipamiento deportivo complementario.'],
    ['pregunta' => '¿Venden implementación de tenis de mesa para principiantes?', 'respuesta' => 'Sí, existen kits de inicio con paletas y pelotas ideales para comenzar.'],
    ['pregunta' => '¿Qué marcas de tenis de mesa son recomendadas?', 'respuesta' => 'Marcas profesionales incluyen Andro, Gewo, Victas y otras especializadas en alto rendimiento.'],
    ['pregunta' => '¿Realizan envíos de implementación de tenis de mesa en Chile?', 'respuesta' => 'Sí, puedes comprar online y recibir tus productos en distintas regiones del país.'],
    ['pregunta' => '¿Cuánto demora el envío de productos de ping pong?', 'respuesta' => 'Generalmente entre 1 a 5 días hábiles dependiendo de la región y disponibilidad.'],
    ['pregunta' => '¿Puedo comprar paletas y gomas por separado?', 'respuesta' => 'Sí, puedes armar tu paleta personalizada eligiendo madera y gomas según tu estilo de juego.'],
    ['pregunta' => '¿Qué accesorios de tenis de mesa son importantes?', 'respuesta' => 'Fundas, limpiadores, pegamentos, cintas protectoras, toallas y bolsos deportivos.'],
    ['pregunta' => '¿Cómo mejorar mi juego de tenis de mesa?', 'respuesta' => 'Practicar técnica, elegir la paleta correcta y usar gomas adecuadas según tu nivel.'],
    ['pregunta' => '¿Qué diferencia hay entre una paleta profesional y una básica?', 'respuesta' => 'Las profesionales permiten mayor control, velocidad y efecto gracias a mejores materiales.'],
    ['pregunta' => '¿Se pueden usar estas implementaciones para uso recreativo?', 'respuesta' => 'Sí, el tenis de mesa es ideal tanto para uso recreativo como competitivo.'],
    ['pregunta' => '¿Qué tamaño tiene una mesa de tenis de mesa?', 'respuesta' => 'Mide aproximadamente 2,74 m de largo por 1,525 m de ancho.'],
    ['pregunta' => '¿Ofrecen asesoría para elegir productos de ping pong?', 'respuesta' => 'Sí, puedes recibir recomendaciones según tu nivel y tipo de juego.'],
    ['pregunta' => '¿Es mejor comprar una paleta armada o personalizada?', 'respuesta' => 'Armada: fácil y rápida. Personalizada: mejor rendimiento.'],
    ['pregunta' => '¿Dónde comprar implementación de tenis de mesa en Chile?', 'respuesta' => 'En tiendas especializadas online como PVSPORT, donde encuentras paletas, gomas, pelotas y accesorios en un solo lugar.'],
];
$faqSchema = ['@context' => 'https://schema.org', '@type' => 'FAQPage', 'mainEntity' => []];
foreach ($faqs as $faq) {
    $faqSchema['mainEntity'][] = [
        '@type' => 'Question',
        'name' => $faq['pregunta'],
        'acceptedAnswer' => ['@type' => 'Answer', 'text' => $faq['respuesta']],
    ];
}
?>
<style>
  :root{--primary:<?= e($colorPrimario) ?>;--accent:<?= e($colorAcento) ?>;--bg:#eef2f7;--border:#dbe3ee;--muted:#64748b;--text:#0f172a;--shadow:0 10px 25px rgba(15,23,42,.08)}
  .catalogo-page{background:var(--bg);min-height:100vh}
  .catalogo-container{width:min(1280px,92%);margin:0 auto}
  .catalogo-topbar{background:var(--primary);color:#fff;padding:8px 0;font-size:13px}
  .catalogo-topbar__content{display:flex;justify-content:space-between;gap:16px;flex-wrap:wrap}
  .catalogo-topbar__sociales{display:flex;align-items:center;gap:10px}
  .catalogo-topbar__sociales a{display:inline-flex;align-items:center;justify-content:center;width:30px;height:30px;border-radius:999px;border:1px solid rgba(255,255,255,.5);color:#fff;text-decoration:none}
  .catalogo-topbar__sociales a svg{width:14px;height:14px;fill:#fff;display:block}
  .catalogo-header{position:sticky;top:0;z-index:45;background:rgba(255,255,255,.94);backdrop-filter:blur(10px);border-bottom:1px solid var(--border)}
  .catalogo-navbar{display:grid;grid-template-columns:340px minmax(0,1fr) auto auto;gap:10px;align-items:center;padding:10px 0}
  .catalogo-logo{display:flex;align-items:center;gap:.55rem;color:var(--text);font-size:16px;font-weight:800;text-decoration:none;line-height:1.05}
  .catalogo-logo img{width:120px;height:60px;object-fit:contain;background:transparent}
  .search-box{display:flex;align-items:center;background:#fff;border:1px solid var(--border);border-radius:999px;overflow:hidden;min-width:0}
  .search-box input{width:100%;padding:10px 14px;border:none;outline:none;background:transparent;font-size:14px}
  .search-box button{background:var(--accent);color:#fff;padding:10px 18px;font-weight:700;border:none}
  .nav-actions{display:flex;gap:10px;align-items:center;flex-wrap:wrap}
  .menu-link{padding:9px 6px;font-weight:600;color:var(--primary);text-decoration:none;border:none;background:transparent;white-space:nowrap}
  .menu-link:hover{color:var(--accent)}
  .btn-outline,.btn-primary-custom,.btn-soft,.btn-danger-soft{padding:9px 13px;border-radius:10px;font-weight:700;border:1px solid var(--border);background:#fff;color:var(--text)}
  .btn-primary-custom{background:var(--accent);border-color:var(--accent);color:#fff}
  .catalogo-navbar .btn-primary-custom,.catalogo-navbar .btn-primary-custom span,.catalogo-navbar .btn-primary-custom svg{color:#fff !important;fill:#fff !important;stroke:#fff !important;text-decoration:none !important}
  .catalogo-mobile-toggle{display:none;align-items:center;justify-content:center;flex-direction:column;gap:4px;width:42px;height:42px;border-radius:12px;border:1px solid var(--primary);background:var(--primary);color:#fff}
  .catalogo-mobile-toggle span{display:block;width:18px;height:2px;background:currentColor;border-radius:999px;transition:all .2s ease}
  .catalogo-header.is-mobile-open .catalogo-mobile-toggle span:nth-child(1){transform:translateY(6px) rotate(45deg)}
  .catalogo-header.is-mobile-open .catalogo-mobile-toggle span:nth-child(2){opacity:0}
  .catalogo-header.is-mobile-open .catalogo-mobile-toggle span:nth-child(3){transform:translateY(-6px) rotate(-45deg)}

  .hero-faq{margin-top:12px;border-radius:20px;min-height:190px;display:flex;align-items:flex-end;padding:24px;background-size:cover;background-position:center;position:relative;overflow:hidden;box-shadow:0 18px 34px rgba(15,23,42,.16)}
  .hero-faq::before{content:"";position:absolute;inset:0;background:linear-gradient(95deg,color-mix(in srgb,var(--primary) 82%,#000 18%),rgba(15,23,42,.35))}
  .hero-faq::after{content:"";position:absolute;inset:0;background:radial-gradient(circle at 78% 28%,color-mix(in srgb,var(--accent) 35%,transparent),transparent 40%)}
  .hero-faq h1{position:relative;color:#fff;font-size:34px;font-weight:700;margin:0}
  .faq-wrap{padding:28px 0 46px}
  .faq-card{padding:22px;background:#fff;border:1px solid var(--border);border-radius:18px;box-shadow:var(--shadow)}
  .faq-intro h2{font-size:24px;line-height:1.2;color:var(--primary);font-weight:800;margin:0 0 10px}
  .faq-intro p{color:var(--muted);line-height:1.7;font-size:16px;margin:0 0 18px;text-align:justify;text-wrap:pretty}
  .faq-item{border:1px solid var(--border);border-radius:14px;background:#fff;overflow:hidden}
  .faq-item + .faq-item{margin-top:10px}
  .faq-item details summary{list-style:none;cursor:pointer;padding:14px 16px;font-weight:700;color:var(--text);display:flex;justify-content:space-between;gap:10px}
  .faq-item details summary::-webkit-details-marker{display:none}
  .faq-item details summary::after{content:'+';color:var(--accent);font-size:18px;line-height:1}
  .faq-item details[open] summary::after{content:'−'}
  .faq-item__answer{padding:0 16px 14px;color:var(--muted);line-height:1.7;font-size:15px;text-align:justify;text-wrap:pretty}
  .faq-keywords{margin-top:16px;padding:14px 16px;border-radius:14px;background:color-mix(in srgb,var(--accent) 8%,#fff);border:1px solid color-mix(in srgb,var(--accent) 20%,#fff)}
  .faq-keywords strong{color:var(--text)}
  .faq-keywords ul{margin:8px 0 0;padding-left:18px;color:var(--muted)}

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
  body.public-page > footer.border-top.bg-white.mt-5{display:none}

  @media (max-width:1100px){
    .catalogo-navbar,.footer-content{grid-template-columns:1fr}
    .catalogo-navbar{gap:12px}
    .search-box{width:100%}
    .hero-faq{min-height:170px}
    .hero-faq h1{font-size:28px;font-weight:600}
    .faq-intro h2{font-size:22px}
  }
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
    .hero-faq{min-height:150px;padding:18px}
    .hero-faq h1{font-size:22px;font-weight:600}
    .faq-wrap{padding:18px 0 30px}
    .faq-card{padding:16px}
    .faq-intro p,.faq-item__answer{text-align:left}
    .footer-content{grid-template-columns:1fr}
    .footer-bottom__content{flex-direction:column;align-items:flex-start}
  }
</style>
<div class="catalogo-page">
  <?php
    $catalogoHeaderSearchAction = $catalogoBaseUrl;
    $catalogoHeaderSearchMethod = 'GET';
    $catalogoHeaderSearchName = 'q';
    $catalogoHeaderSearchValue = '';
    $catalogoHeaderCartAsButton = false;
    $catalogoHeaderCartHref = $catalogoBaseUrl;
    require __DIR__ . '/partials/catalogo_header.php';
  ?>
  <section class="catalogo-container">
    <div class="hero-faq" style="background-image:url('<?= e($sliderImagen) ?>')">
      <h1>Preguntas frecuentes</h1>
    </div>
  </section>
  <section class="faq-wrap">
    <div class="catalogo-container">
      <article class="faq-card">
        <div class="faq-intro">
          <h2>Tenis de mesa en Chile: dudas frecuentes</h2>
          <p>Resuelve rápidamente preguntas sobre implementación tenis de mesa, compra de paletas de ping pong y recomendaciones por nivel de juego.</p>
        </div>
        <?php foreach ($faqs as $faq): ?>
          <div class="faq-item">
            <details>
              <summary><?= e($faq['pregunta']) ?></summary>
              <div class="faq-item__answer"><?= e($faq['respuesta']) ?></div>
            </details>
          </div>
        <?php endforeach; ?>

      </article>
    </div>
  </section>
  <?php
    $catalogoFooterInicioUrl = $catalogoBaseUrl . '#catalogoProductos';
    $catalogoFooterProductosUrl = $catalogoBaseUrl . '#catalogoProductos';
    require __DIR__ . '/partials/catalogo_footer.php';
  ?>
</div>
<script type="application/ld+json"><?= json_encode($faqSchema, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) ?></script>
