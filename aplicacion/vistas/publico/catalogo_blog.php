<?php
$catalogoRutas = is_array($catalogoRutas ?? null) ? $catalogoRutas : [];
$homeUrl = (string) ($catalogoRutas['base'] ?? url('/'));
?>
<section class="container py-4">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb small">
      <li class="breadcrumb-item"><a href="<?= e($homeUrl) ?>">Inicio</a></li>
      <li class="breadcrumb-item active" aria-current="page">Blog</li>
    </ol>
  </nav>
  <h1 class="h2 fw-bold mb-3">Blog de tenis de mesa y ping pong en Chile</h1>
  <p class="text-secondary">Contenido informativo para captar búsquedas long tail y derivarlas a categorías comerciales.</p>

  <section class="mb-4">
    <h2 class="h4">Categorías del blog</h2>
    <ul class="mb-0">
      <li>Guías de compra</li>
      <li>Entrenamiento</li>
      <li>Productos y comparativas</li>
      <li>Principiantes</li>
      <li>Implementación para colegios y clubes</li>
    </ul>
  </section>

  <div class="row g-3 mt-2">
    <?php foreach ([
        ['titulo' => 'Cómo elegir una paleta de tenis de mesa en Chile', 'url' => '/paletas-tenis-de-mesa-chile'],
        ['titulo' => 'Diferencias entre paletas prearmadas y personalizadas', 'url' => '/paletas-tenis-de-mesa-chile'],
        ['titulo' => 'Qué goma de tenis de mesa elegir según tu nivel', 'url' => '/gomas-tenis-de-mesa-chile'],
        ['titulo' => 'Medidas oficiales de una mesa de tenis de mesa', 'url' => '/mesas-de-tenis-de-mesa-chile'],
        ['titulo' => 'Diferencia entre ping pong y tenis de mesa', 'url' => '/ping-pong-chile'],
        ['titulo' => 'Implementos básicos para empezar a jugar', 'url' => '/implementos-tenis-de-mesa-chile'],
        ['titulo' => 'Tenis de mesa para principiantes en Chile', 'url' => '/tenis-de-mesa-principiantes'],
        ['titulo' => 'Qué comprar para un club o colegio', 'url' => '/implementacion-tenis-de-mesa'],
        ['titulo' => 'Cómo cuidar una paleta y sus gomas', 'url' => '/gomas-tenis-de-mesa-chile'],
        ['titulo' => 'Mejores accesorios para entrenamiento de tenis de mesa', 'url' => '/accesorios-tenis-de-mesa-chile'],
    ] as $articulo): ?>
      <article class="col-12 col-md-6">
        <div class="card h-100">
          <div class="card-body">
            <h2 class="h5"><?= e($articulo['titulo']) ?></h2>
            <p class="small text-muted">Contenido recomendado para resolver dudas frecuentes y apoyar decisiones de compra.</p>
            <a href="<?= e(url((string) $articulo['url'])) ?>">Ir a categoría relacionada</a>
          </div>
        </div>
      </article>
    <?php endforeach; ?>
  </div>
</section>
