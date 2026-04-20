<?php $catalogoRutas = is_array($catalogoRutas ?? null) ? $catalogoRutas : []; ?>
<section class="container py-4">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb small">
      <li class="breadcrumb-item"><a href="<?= e((string) ($catalogoRutas['base'] ?? url('/'))) ?>">Inicio</a></li>
      <li class="breadcrumb-item active" aria-current="page">Blog</li>
    </ol>
  </nav>
  <h1 class="h2 fw-bold mb-3">Blog de tenis de mesa y ping pong en Chile</h1>
  <p class="text-secondary">Contenido informativo para captar búsquedas long tail y ayudar a elegir mejor antes de comprar.</p>

  <div class="row g-3 mt-2">
    <?php foreach ([
        'Cómo elegir una paleta de tenis de mesa',
        'Diferencias entre paletas para principiantes y avanzados',
        'Mejores gomas de tenis de mesa según estilo de juego',
        'Cómo cuidar una paleta de ping pong',
        'Medidas oficiales de una mesa de tenis de mesa',
        'Reglas básicas del tenis de mesa',
        'Diferencias entre ping pong y tenis de mesa',
        'Implementos necesarios para jugar tenis de mesa',
    ] as $titulo): ?>
      <article class="col-12 col-md-6">
        <div class="card h-100">
          <div class="card-body">
            <h2 class="h5"><?= e($titulo) ?></h2>
            <p class="small text-muted mb-0">Artículo recomendado para SEO informativo y derivación a categorías comerciales.</p>
          </div>
        </div>
      </article>
    <?php endforeach; ?>
  </div>
</section>
