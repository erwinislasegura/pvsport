<?php
$catalogoRutas = is_array($catalogoRutas ?? null) ? $catalogoRutas : [];
$homeUrl = (string) ($catalogoRutas['base'] ?? url('/'));
$faqItems = is_array($faqItems ?? null) ? $faqItems : [];
$faqAgrupado = [];
foreach ($faqItems as $item) {
    $grupo = (string) ($item['grupo'] ?? 'General');
    $faqAgrupado[$grupo][] = $item;
}
?>
<section class="container py-4">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb small">
      <li class="breadcrumb-item"><a href="<?= e($homeUrl) ?>">Inicio</a></li>
      <li class="breadcrumb-item active" aria-current="page">FAQ tenis de mesa Chile</li>
    </ol>
  </nav>

  <h1 class="h2 fw-bold mb-3">Preguntas frecuentes de tenis de mesa y ping pong en Chile</h1>
  <p class="text-secondary mb-4">Respuestas prácticas para decidir mejor tu compra, entender diferencias técnicas y elegir productos según nivel.</p>

  <?php foreach ($faqAgrupado as $grupo => $itemsGrupo): ?>
    <section class="mb-4">
      <h2 class="h4 mb-3"><?= e($grupo) ?></h2>
      <div class="accordion" id="faq<?= e(md5($grupo)) ?>">
        <?php foreach ($itemsGrupo as $index => $faq): ?>
          <div class="accordion-item">
            <h3 class="accordion-header">
              <button class="accordion-button <?= $index > 0 ? 'collapsed' : '' ?>" type="button" data-bs-toggle="collapse" data-bs-target="#faqItem<?= e(md5($grupo . $index)) ?>">
                <?= e((string) ($faq['q'] ?? '')) ?>
              </button>
            </h3>
            <div id="faqItem<?= e(md5($grupo . $index)) ?>" class="accordion-collapse collapse <?= $index === 0 ? 'show' : '' ?>" data-bs-parent="#faq<?= e(md5($grupo)) ?>">
              <div class="accordion-body">
                <p class="mb-2"><?= e((string) ($faq['a'] ?? '')) ?></p>
                <?php if (!empty($faq['url'])): ?>
                  <a href="<?= e(url((string) $faq['url'])) ?>">Ver categoría relacionada</a>
                <?php endif; ?>
              </div>
            </div>
          </div>
        <?php endforeach; ?>
      </div>
    </section>
  <?php endforeach; ?>
</section>
