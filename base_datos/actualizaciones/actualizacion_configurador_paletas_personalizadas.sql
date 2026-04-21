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
  KEY idx_product_attributes_product_id (product_id)
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
  KEY idx_product_variants_product (product_id)
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
  KEY idx_racket_builds_session (session_id)
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
  KEY idx_racket_rules_empresa (empresa_id)
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
  KEY idx_racket_settings_empresa (empresa_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------------
-- Ajuste idempotente (evita errores y completa columnas en instalaciones
-- donde alguna tabla ya exista por despliegues parciales).
-- ---------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS pvs_cfg_ensure_column;
DROP PROCEDURE IF EXISTS pvs_cfg_ensure_index;

DELIMITER $$

CREATE PROCEDURE pvs_cfg_ensure_column(
    IN p_table VARCHAR(64),
    IN p_column VARCHAR(64),
    IN p_definition TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = p_table
          AND COLUMN_NAME = p_column
    ) THEN
        SET @sql_text = CONCAT(
            'ALTER TABLE `', p_table, '` ADD COLUMN `', p_column, '` ', p_definition
        );
        PREPARE stmt FROM @sql_text;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END $$

CREATE PROCEDURE pvs_cfg_ensure_index(
    IN p_table VARCHAR(64),
    IN p_index VARCHAR(64),
    IN p_definition TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.STATISTICS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = p_table
          AND INDEX_NAME = p_index
    ) THEN
        SET @sql_text = CONCAT(
            'ALTER TABLE `', p_table, '` ADD ', p_definition
        );
        PREPARE stmt FROM @sql_text;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END $$

DELIMITER ;

-- product_attributes
CALL pvs_cfg_ensure_column('product_attributes', 'id', 'INT AUTO_INCREMENT PRIMARY KEY');
CALL pvs_cfg_ensure_column('product_attributes', 'product_id', 'INT NOT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'speed', 'DECIMAL(5,2) DEFAULT 0');
CALL pvs_cfg_ensure_column('product_attributes', 'control_score', 'DECIMAL(5,2) DEFAULT 0');
CALL pvs_cfg_ensure_column('product_attributes', 'spin', 'DECIMAL(5,2) DEFAULT 0');
CALL pvs_cfg_ensure_column('product_attributes', 'hardness', 'DECIMAL(5,2) DEFAULT 0');
CALL pvs_cfg_ensure_column('product_attributes', 'tacky_type', 'VARCHAR(60) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'arc', 'VARCHAR(60) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'weight_grams', 'DECIMAL(7,2) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'composition', 'VARCHAR(120) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'handle_type', 'VARCHAR(60) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'player_level', 'VARCHAR(40) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'play_style', 'VARCHAR(60) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'rubber_type', 'VARCHAR(60) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'category_role', 'ENUM(''blade'',''rubber'',''accessory'',''assembly_service'') NOT NULL DEFAULT ''accessory''');
CALL pvs_cfg_ensure_column('product_attributes', 'is_forehand_recommended', 'TINYINT(1) NOT NULL DEFAULT 0');
CALL pvs_cfg_ensure_column('product_attributes', 'is_backhand_recommended', 'TINYINT(1) NOT NULL DEFAULT 0');
CALL pvs_cfg_ensure_column('product_attributes', 'tags', 'VARCHAR(255) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'featured_order', 'INT NOT NULL DEFAULT 999');
CALL pvs_cfg_ensure_column('product_attributes', 'is_active', 'TINYINT(1) NOT NULL DEFAULT 1');
CALL pvs_cfg_ensure_column('product_attributes', 'created_at', 'DATETIME NOT NULL');
CALL pvs_cfg_ensure_column('product_attributes', 'updated_at', 'DATETIME NOT NULL');
CALL pvs_cfg_ensure_index('product_attributes', 'uq_product_attributes_product', 'UNIQUE KEY `uq_product_attributes_product` (`product_id`)');
CALL pvs_cfg_ensure_index('product_attributes', 'idx_product_attributes_product_id', 'KEY `idx_product_attributes_product_id` (`product_id`)');

-- product_variants
CALL pvs_cfg_ensure_column('product_variants', 'id', 'INT AUTO_INCREMENT PRIMARY KEY');
CALL pvs_cfg_ensure_column('product_variants', 'product_id', 'INT NOT NULL');
CALL pvs_cfg_ensure_column('product_variants', 'color', 'VARCHAR(40) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_variants', 'thickness', 'VARCHAR(40) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_variants', 'handle', 'VARCHAR(40) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_variants', 'sku', 'VARCHAR(90) DEFAULT NULL');
CALL pvs_cfg_ensure_column('product_variants', 'stock', 'INT DEFAULT 0');
CALL pvs_cfg_ensure_column('product_variants', 'extra_price', 'DECIMAL(10,2) DEFAULT 0');
CALL pvs_cfg_ensure_column('product_variants', 'is_active', 'TINYINT(1) NOT NULL DEFAULT 1');
CALL pvs_cfg_ensure_column('product_variants', 'created_at', 'DATETIME NOT NULL');
CALL pvs_cfg_ensure_column('product_variants', 'updated_at', 'DATETIME NOT NULL');
CALL pvs_cfg_ensure_index('product_variants', 'idx_product_variants_product', 'KEY `idx_product_variants_product` (`product_id`)');

-- racket_builds
CALL pvs_cfg_ensure_column('racket_builds', 'id', 'INT AUTO_INCREMENT PRIMARY KEY');
CALL pvs_cfg_ensure_column('racket_builds', 'empresa_id', 'INT NOT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'session_id', 'VARCHAR(120) NOT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'user_id', 'INT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'blade_product_id', 'INT NOT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'blade_variant_id', 'INT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'fh_rubber_product_id', 'INT NOT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'fh_variant_id', 'INT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'bh_rubber_product_id', 'INT NOT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'bh_variant_id', 'INT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'edge_tape_product_id', 'INT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'case_product_id', 'INT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'glue_product_id', 'INT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'cleaner_product_id', 'INT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'assembly_service_product_id', 'INT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'total_price', 'DECIMAL(12,2) NOT NULL DEFAULT 0');
CALL pvs_cfg_ensure_column('racket_builds', 'speed_total', 'DECIMAL(6,2) NOT NULL DEFAULT 0');
CALL pvs_cfg_ensure_column('racket_builds', 'control_total', 'DECIMAL(6,2) NOT NULL DEFAULT 0');
CALL pvs_cfg_ensure_column('racket_builds', 'spin_total', 'DECIMAL(6,2) NOT NULL DEFAULT 0');
CALL pvs_cfg_ensure_column('racket_builds', 'hardness_total', 'DECIMAL(6,2) NOT NULL DEFAULT 0');
CALL pvs_cfg_ensure_column('racket_builds', 'weight_total', 'DECIMAL(8,2) NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'player_profile', 'JSON NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'status', 'ENUM(''draft'',''cart'',''ordered'') NOT NULL DEFAULT ''draft''');
CALL pvs_cfg_ensure_column('racket_builds', 'build_payload', 'JSON NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'created_at', 'DATETIME NOT NULL');
CALL pvs_cfg_ensure_column('racket_builds', 'updated_at', 'DATETIME NOT NULL');
CALL pvs_cfg_ensure_index('racket_builds', 'idx_racket_builds_empresa_estado', 'KEY `idx_racket_builds_empresa_estado` (`empresa_id`, `status`)');
CALL pvs_cfg_ensure_index('racket_builds', 'idx_racket_builds_session', 'KEY `idx_racket_builds_session` (`session_id`)');

-- racket_recommendation_rules
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'id', 'INT AUTO_INCREMENT PRIMARY KEY');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'empresa_id', 'INT NOT NULL');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'rule_name', 'VARCHAR(120) NOT NULL');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'level', 'VARCHAR(50) DEFAULT NULL');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'style', 'VARCHAR(50) DEFAULT NULL');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'priority_metric', 'VARCHAR(50) DEFAULT NULL');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'budget_min', 'DECIMAL(12,2) DEFAULT 0');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'budget_max', 'DECIMAL(12,2) DEFAULT 0');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'transition_type', 'VARCHAR(40) DEFAULT NULL');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'blade_weight', 'DECIMAL(6,2) DEFAULT 1');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'fh_weight', 'DECIMAL(6,2) DEFAULT 1');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'bh_weight', 'DECIMAL(6,2) DEFAULT 1');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'created_at', 'DATETIME NOT NULL');
CALL pvs_cfg_ensure_column('racket_recommendation_rules', 'updated_at', 'DATETIME NOT NULL');
CALL pvs_cfg_ensure_index('racket_recommendation_rules', 'idx_racket_rules_empresa', 'KEY `idx_racket_rules_empresa` (`empresa_id`)');

-- racket_configuration_settings
CALL pvs_cfg_ensure_column('racket_configuration_settings', 'id', 'INT AUTO_INCREMENT PRIMARY KEY');
CALL pvs_cfg_ensure_column('racket_configuration_settings', 'empresa_id', 'INT NOT NULL');
CALL pvs_cfg_ensure_column('racket_configuration_settings', 'key', 'VARCHAR(120) NOT NULL');
CALL pvs_cfg_ensure_column('racket_configuration_settings', 'value', 'TEXT NULL');
CALL pvs_cfg_ensure_column('racket_configuration_settings', 'type', 'VARCHAR(30) DEFAULT ''text''');
CALL pvs_cfg_ensure_column('racket_configuration_settings', 'description', 'VARCHAR(255) DEFAULT NULL');
CALL pvs_cfg_ensure_column('racket_configuration_settings', 'updated_at', 'DATETIME NOT NULL');
CALL pvs_cfg_ensure_index('racket_configuration_settings', 'uq_racket_settings_empresa_key', 'UNIQUE KEY `uq_racket_settings_empresa_key` (`empresa_id`, `key`)');
CALL pvs_cfg_ensure_index('racket_configuration_settings', 'idx_racket_settings_empresa', 'KEY `idx_racket_settings_empresa` (`empresa_id`)');

DROP PROCEDURE IF EXISTS pvs_cfg_ensure_column;
DROP PROCEDURE IF EXISTS pvs_cfg_ensure_index;
