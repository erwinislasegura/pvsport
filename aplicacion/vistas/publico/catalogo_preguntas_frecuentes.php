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
  .hero-faq{margin-top:12px;border-radius:20px;min-height:190px;display:flex;align-items:flex-end;padding:24px;background-size:cover;background-position:center;position:relative;overflow:hidden;box-shadow:0 18px 34px rgba(15,23,42,.16)}
  .hero-faq::before{content:"";position:absolute;inset:0;background:linear-gradient(95deg,color-mix(in srgb,var(--primary) 82%,#000 18%),rgba(15,23,42,.35))}
  .hero-faq h1{position:relative;color:#fff;font-size:34px;font-weight:700;margin:0}
  .faq-wrap{padding:28px 0 46px}
  .faq-card{padding:22px;background:#fff;border:1px solid var(--border);border-radius:18px;box-shadow:var(--shadow)}
  .faq-intro h2{font-size:24px;line-height:1.2;color:var(--primary);font-weight:800;margin:0 0 10px}
  .faq-intro p{color:var(--muted);line-height:1.7;font-size:16px;margin:0 0 18px}
  .faq-item{border:1px solid var(--border);border-radius:14px;background:#fff;overflow:hidden}
  .faq-item + .faq-item{margin-top:10px}
  .faq-item details summary{list-style:none;cursor:pointer;padding:14px 16px;font-weight:700;color:var(--text);display:flex;justify-content:space-between;gap:10px}
  .faq-item details summary::-webkit-details-marker{display:none}
  .faq-item details summary::after{content:'+';color:var(--accent);font-size:18px;line-height:1}
  .faq-item details[open] summary::after{content:'−'}
  .faq-item__answer{padding:0 16px 14px;color:var(--muted);line-height:1.7;font-size:15px}
  .faq-keywords{margin-top:16px;padding:14px 16px;border-radius:14px;background:color-mix(in srgb,var(--accent) 8%,#fff);border:1px solid color-mix(in srgb,var(--accent) 20%,#fff)}
  .faq-keywords strong{color:var(--text)}
  .faq-keywords ul{margin:8px 0 0;padding-left:18px;color:var(--muted)}
  @media (max-width:720px){.hero-faq{min-height:150px;padding:18px}.hero-faq h1{font-size:22px}.faq-wrap{padding:18px 0 30px}.faq-card{padding:16px}}
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

        <div class="faq-keywords">
          <strong>Guía rápida SEO</strong>
          <ul>
            <li>Tenis de mesa en Chile</li>
            <li>Implementación tenis de mesa</li>
            <li>Comprar paletas ping pong</li>
          </ul>
        </div>
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
