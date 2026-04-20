<?php
$catalogoRutas = is_array($catalogoRutas ?? null) ? $catalogoRutas : [];
$homeUrl = (string) ($catalogoRutas['base'] ?? url('/'));
$blogUrl = url('/blog');
$faqUrl = url('/faq-tenis-de-mesa-chile');
$resolverImagenProducto = static function (?string $ruta): string {
    $ruta = trim((string) $ruta);
    if ($ruta === '') {
        return url('/img/placeholder-producto.svg');
    }
    return str_starts_with($ruta, 'http') ? $ruta : url('/media/archivo?ruta=' . rawurlencode($ruta));
};
?>
<section class="container py-4">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb small">
      <li class="breadcrumb-item"><a href="<?= e($homeUrl) ?>">Inicio</a></li>
      <li class="breadcrumb-item active" aria-current="page"><?= e((string) ($seoLanding['h1'] ?? 'Categoría')) ?></li>
    </ol>
  </nav>

  <h1 class="h2 fw-bold mb-3"><?= e((string) ($seoLanding['h1'] ?? 'Tienda de tenis de mesa en Chile')) ?></h1>
  <p class="lead text-secondary mb-4">
    Compra productos de tenis de mesa y ping pong con enfoque en Chile: despacho a regiones, asesoría comercial y stock actualizado para entrenamiento, recreación y competencia.
  </p>

  <div class="row g-3 mb-4">
    <?php foreach ($productos as $producto): ?>
      <?php
      $nombre = trim((string) ($producto['nombre'] ?? 'Producto'));
      $precio = (float) ($producto['precio_venta'] ?? 0);
      $descripcion = trim((string) ($producto['descripcion'] ?? ''));
      ?>
      <article class="col-12 col-md-6 col-lg-3">
        <div class="card h-100 shadow-sm">
          <img src="<?= e($resolverImagenProducto($producto['imagen_catalogo'] ?? '')) ?>" alt="<?= e($nombre) ?>" loading="lazy" class="card-img-top" style="aspect-ratio:1/1;object-fit:contain;background:#fff;">
          <div class="card-body d-flex flex-column">
            <h2 class="h6"><?= e($nombre) ?></h2>
            <p class="small text-muted flex-grow-1"><?= e($descripcion !== '' ? mb_substr($descripcion, 0, 120) . '…' : 'Producto disponible en tienda.') ?></p>
            <p class="fw-bold mb-0">$<?= e(number_format($precio, 0, ',', '.')) ?></p>
          </div>
        </div>
      </article>
    <?php endforeach; ?>
  </div>

  <section class="mb-4">
    <h2 class="h4">Cómo elegir bien antes de comprar</h2>
    <ul>
      <li>Define tu nivel: principiante, intermedio o profesional.</li>
      <li>Evalúa control, velocidad y spin según tu estilo de juego.</li>
      <li>Prioriza productos con buena postventa y reposición en Chile.</li>
    </ul>
  </section>

  <section class="mb-4">
    <h2 class="h4">Preguntas frecuentes de compra</h2>
    <div class="accordion" id="faqLandingSeo">
      <?php foreach ([['q' => '¿Hacen envíos a regiones de Chile?', 'a' => 'Sí, despachamos a todo Chile con opciones según comuna y región.'], ['q' => '¿Puedo comprar equipamiento para colegio o club?', 'a' => 'Sí, trabajamos con compras unitarias y proyectos de implementación.'], ['q' => '¿Qué diferencia hay entre paleta armada y personalizada?', 'a' => 'La armada viene lista para jugar; la personalizada te permite elegir madera y gomas.']] as $i => $faq): ?>
        <div class="accordion-item">
          <h3 class="accordion-header">
            <button class="accordion-button <?= $i > 0 ? 'collapsed' : '' ?>" type="button" data-bs-toggle="collapse" data-bs-target="#faqSeo<?= $i ?>">
              <?= e($faq['q']) ?>
            </button>
          </h3>
          <div id="faqSeo<?= $i ?>" class="accordion-collapse collapse <?= $i === 0 ? 'show' : '' ?>" data-bs-parent="#faqLandingSeo">
            <div class="accordion-body"><?= e($faq['a']) ?></div>
          </div>
        </div>
      <?php endforeach; ?>
    </div>
  </section>

  <section class="mb-3">
    <h2 class="h5">Enlaces útiles</h2>
    <p class="mb-0">
      Revisa también nuestra <a href="<?= e($faqUrl) ?>">sección FAQ de tenis de mesa en Chile</a> y el <a href="<?= e($blogUrl) ?>">blog con guías para elegir paletas, gomas y mesas</a>.
    </p>
  </section>
</section>
