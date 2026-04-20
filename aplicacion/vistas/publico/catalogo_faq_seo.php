<?php $catalogoRutas = is_array($catalogoRutas ?? null) ? $catalogoRutas : []; ?>
<section class="container py-4">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb small">
      <li class="breadcrumb-item"><a href="<?= e((string) ($catalogoRutas['base'] ?? url('/'))) ?>">Inicio</a></li>
      <li class="breadcrumb-item active" aria-current="page">FAQ tenis de mesa Chile</li>
    </ol>
  </nav>

  <h1 class="h2 fw-bold mb-3">Preguntas frecuentes: tenis de mesa y ping pong en Chile</h1>
  <p class="text-secondary">Respuestas cortas y claras para resolver dudas de compra, implementación y envío dentro de Chile.</p>

  <div class="accordion" id="faqSeoChile">
    <?php foreach (($faqItems ?? []) as $index => $faq): ?>
      <div class="accordion-item">
        <h2 class="accordion-header">
          <button class="accordion-button <?= $index > 0 ? 'collapsed' : '' ?>" type="button" data-bs-toggle="collapse" data-bs-target="#faqChile<?= $index ?>">
            <?= e((string) ($faq['q'] ?? '')) ?>
          </button>
        </h2>
        <div id="faqChile<?= $index ?>" class="accordion-collapse collapse <?= $index === 0 ? 'show' : '' ?>" data-bs-parent="#faqSeoChile">
          <div class="accordion-body"><?= e((string) ($faq['a'] ?? '')) ?></div>
        </div>
      </div>
    <?php endforeach; ?>
  </div>
</section>
