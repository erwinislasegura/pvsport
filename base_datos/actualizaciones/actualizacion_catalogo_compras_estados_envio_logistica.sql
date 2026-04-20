UPDATE catalogo_compras
SET estado_envio = CASE estado_envio
  WHEN 'preparando' THEN 'aprobado'
  WHEN 'enviado' THEN 'despachado'
  WHEN 'cancelado' THEN 'pendiente'
  ELSE estado_envio
END
WHERE estado_envio IN ('preparando', 'enviado', 'cancelado');

ALTER TABLE catalogo_compras
  MODIFY COLUMN estado_envio ENUM('pendiente','aprobado','en_transito','despachado','en_reparto','entregado')
  NOT NULL DEFAULT 'pendiente';
