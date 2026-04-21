-- Modulo: Configurador de Paletas Personalizadas PV Sport
-- Fecha: 2026-04-21

CREATE TABLE IF NOT EXISTS product_attributes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  speed DECIMAL(5,2) DEFAULT 0,
  control_score DECIMAL(5,2) DEFAULT 0,
  spin DECIMAL(5,2) DEFAULT 0,
  hardness DECIMAL(5,2) DEFAULT 0,
  tacky_type VARCHAR(60) DEFAULT NULL,
  arc VARCHAR(60) DEFAULT NULL,
  weight_grams DECIMAL(7,2) DEFAULT NULL,
  composition VARCHAR(120) DEFAULT NULL,
  handle_type VARCHAR(60) DEFAULT NULL,
  player_level VARCHAR(40) DEFAULT NULL,
  play_style VARCHAR(60) DEFAULT NULL,
  rubber_type VARCHAR(60) DEFAULT NULL,
  category_role ENUM('blade','rubber','accessory','assembly_service') NOT NULL DEFAULT 'accessory',
  is_forehand_recommended TINYINT(1) NOT NULL DEFAULT 0,
  is_backhand_recommended TINYINT(1) NOT NULL DEFAULT 0,
  tags VARCHAR(255) DEFAULT NULL,
  featured_order INT NOT NULL DEFAULT 999,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  UNIQUE KEY uq_product_attributes_product (product_id),
  CONSTRAINT fk_product_attributes_product FOREIGN KEY (product_id) REFERENCES productos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS product_variants (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  color VARCHAR(40) DEFAULT NULL,
  thickness VARCHAR(40) DEFAULT NULL,
  handle VARCHAR(40) DEFAULT NULL,
  sku VARCHAR(90) DEFAULT NULL,
  stock INT DEFAULT 0,
  extra_price DECIMAL(10,2) DEFAULT 0,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  KEY idx_product_variants_product (product_id),
  CONSTRAINT fk_product_variants_product FOREIGN KEY (product_id) REFERENCES productos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS racket_builds (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empresa_id INT NOT NULL,
  session_id VARCHAR(120) NOT NULL,
  user_id INT NULL,
  blade_product_id INT NOT NULL,
  blade_variant_id INT NULL,
  fh_rubber_product_id INT NOT NULL,
  fh_variant_id INT NULL,
  bh_rubber_product_id INT NOT NULL,
  bh_variant_id INT NULL,
  edge_tape_product_id INT NULL,
  case_product_id INT NULL,
  glue_product_id INT NULL,
  cleaner_product_id INT NULL,
  assembly_service_product_id INT NULL,
  total_price DECIMAL(12,2) NOT NULL DEFAULT 0,
  speed_total DECIMAL(6,2) NOT NULL DEFAULT 0,
  control_total DECIMAL(6,2) NOT NULL DEFAULT 0,
  spin_total DECIMAL(6,2) NOT NULL DEFAULT 0,
  hardness_total DECIMAL(6,2) NOT NULL DEFAULT 0,
  weight_total DECIMAL(8,2) NULL,
  player_profile JSON NULL,
  status ENUM('draft','cart','ordered') NOT NULL DEFAULT 'draft',
  build_payload JSON NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  KEY idx_racket_builds_empresa_estado (empresa_id, status),
  KEY idx_racket_builds_session (session_id),
  CONSTRAINT fk_racket_builds_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS racket_recommendation_rules (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empresa_id INT NOT NULL,
  rule_name VARCHAR(120) NOT NULL,
  level VARCHAR(50) DEFAULT NULL,
  style VARCHAR(50) DEFAULT NULL,
  priority_metric VARCHAR(50) DEFAULT NULL,
  budget_min DECIMAL(12,2) DEFAULT 0,
  budget_max DECIMAL(12,2) DEFAULT 0,
  transition_type VARCHAR(40) DEFAULT NULL,
  blade_weight DECIMAL(6,2) DEFAULT 1,
  fh_weight DECIMAL(6,2) DEFAULT 1,
  bh_weight DECIMAL(6,2) DEFAULT 1,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  KEY idx_racket_rules_empresa (empresa_id),
  CONSTRAINT fk_racket_rules_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS racket_configuration_settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  empresa_id INT NOT NULL,
  `key` VARCHAR(120) NOT NULL,
  `value` TEXT NULL,
  `type` VARCHAR(30) DEFAULT 'text',
  `description` VARCHAR(255) DEFAULT NULL,
  updated_at DATETIME NOT NULL,
  UNIQUE KEY uq_racket_settings_empresa_key (empresa_id, `key`),
  KEY idx_racket_settings_empresa (empresa_id),
  CONSTRAINT fk_racket_settings_empresa FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
