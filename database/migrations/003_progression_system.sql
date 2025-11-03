/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Migration: Power-Based Progression System (#036)
 * POUZE DOMINA sbírá body a leveluje. Servant je závislý na jejím výkonu (Power Index).
 */

-- ============================================================================
-- 1. LEVELS TABLE (5 levelů - pouze pro DOMINU)
-- ============================================================================

CREATE TABLE levels (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    level_number INT UNSIGNED NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    min_points INT NOT NULL,
    max_points INT NOT NULL,
    description TEXT,
    unlocked_features JSON COMMENT 'Seznam odemčených funkcí pro tento level',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_level_number (level_number),
    INDEX idx_points (min_points, max_points)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed základních levelů
INSERT INTO levels (level_number, name, min_points, max_points, description, unlocked_features) VALUES
(1, 'Začátečnice', 0, 999, 'Household úkoly, Protocol basics', '["household_tasks", "protocol_basics"]'),
(2, 'Učící se', 1000, 2999, 'BDSM soft, Mental domination', '["household_tasks", "protocol_basics", "bdsm_soft", "mental_domination"]'),
(3, 'Sebevědomá', 3000, 5999, 'BDSM medium, tresty, vlastní pravidla', '["household_tasks", "protocol_basics", "bdsm_soft", "bdsm_medium", "mental_domination", "custom_rules", "punishments"]'),
(4, 'Zkušená', 6000, 9999, 'BDSM hard, pokročilé úkoly, full control', '["household_tasks", "protocol_basics", "bdsm_soft", "bdsm_medium", "bdsm_hard", "mental_domination", "custom_rules", "punishments", "advanced_tasks", "full_control"]'),
(5, 'Expertka', 10000, 999999, 'Vše bez omezení, vlastní obsah dominuje', '["all_features"]');

-- ============================================================================
-- 2. ACHIEVEMENTS TABLE (odznaky - pouze pro DOMINU)
-- ============================================================================

CREATE TABLE achievements (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    icon VARCHAR(50) COMMENT 'Emoji nebo ikonka',
    category ENUM('tasks', 'points', 'power', 'special') NOT NULL,
    requirement_type VARCHAR(50) NOT NULL COMMENT 'task_verified_count, points_reached, power_index_days, etc.',
    requirement_value INT NOT NULL,
    points_reward INT DEFAULT 0 COMMENT 'Bonus body za odemčení (pouze domina)',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_category (category),
    INDEX idx_requirement (requirement_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed achievementů (pouze pro dominu)
INSERT INTO achievements (name, description, icon, category, requirement_type, requirement_value, points_reward) VALUES
('První verifikace', 'Verifikuj první úkol servanta', '🎯', 'tasks', 'task_verified_count', 1, 10),
('Týden na plný výkon', '7 dní Power Index > 95%', '📅', 'power', 'power_index_days_above_95', 7, 50),
('10 verifikací', 'Verifikuj 10 úkolů', '✅', 'tasks', 'task_verified_count', 10, 25),
('50 verifikací', 'Verifikuj 50 úkolů', '⭐', 'tasks', 'task_verified_count', 50, 100),
('100 verifikací', 'Verifikuj 100 úkolů', '💯', 'tasks', 'task_verified_count', 100, 200),
('Level 2', 'Dosáhni Level 2', '🔓', 'points', 'level_reached', 2, 50),
('Level 3', 'Dosáhni Level 3', '🔓', 'points', 'level_reached', 3, 100),
('Level 4', 'Dosáhni Level 4', '🔓', 'points', 'level_reached', 4, 200),
('Level 5 - Expertka', 'Dosáhni Level 5', '👑', 'points', 'level_reached', 5, 500),
('Měsíc > 90% Power', '30 dní Power Index > 90%', '🏆', 'power', 'power_index_days_above_90', 30, 300);

-- ============================================================================
-- 3. USER ACHIEVEMENTS TABLE (vazba domina ↔ achievement)
-- ============================================================================

CREATE TABLE user_achievements (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL COMMENT 'Pouze domina ID',
    household_id INT UNSIGNED NOT NULL,
    achievement_id INT UNSIGNED NOT NULL,
    unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_achievement (user_id, household_id, achievement_id),
    INDEX idx_user (user_id),
    INDEX idx_household (household_id),
    INDEX idx_achievement (achievement_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 4. TASK LIBRARY (720 úkolů)
-- ============================================================================

CREATE TABLE task_library (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category ENUM('household', 'protocol', 'bdsm', 'mental', 'fitness', 'physical', 'creative', 'feminine_power') NOT NULL,
    subcategory VARCHAR(50) NULL COMMENT 'Např. bdsm → soft/medium/hard, fitness → cardio/strength',
    difficulty ENUM('trivial', 'easy', 'medium', 'hard', 'extreme') NOT NULL,
    level_required INT UNSIGNED DEFAULT 1 COMMENT 'Minimální level dominy pro použití',
    bdsm_intensity ENUM('none', 'soft', 'medium', 'hard') DEFAULT 'none',
    preferences_required JSON NULL COMMENT 'Array required preferences např. ["impact_play", "bondage"]',
    duration_minutes INT NULL COMMENT 'Odhadovaná doba trvání',
    instructions TEXT NULL COMMENT 'Detailní instrukce pro servant',
    safety_notes TEXT NULL COMMENT 'Bezpečnostní poznámky',
    is_custom BOOLEAN DEFAULT FALSE COMMENT 'TRUE pokud vytvořeno dominou (ne z seed)',
    created_by INT UNSIGNED NULL COMMENT 'ID dominy pokud is_custom=TRUE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_category (category),
    INDEX idx_subcategory (subcategory),
    INDEX idx_difficulty (difficulty),
    INDEX idx_level_required (level_required),
    INDEX idx_bdsm_intensity (bdsm_intensity),
    INDEX idx_custom (is_custom)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 5. DOMINA PROGRESS (pouze pro DOMINU - body, level, Power Index)
-- ============================================================================

CREATE TABLE domina_progress (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    domina_id INT UNSIGNED NOT NULL,
    household_id INT UNSIGNED NOT NULL,
    current_level INT UNSIGNED DEFAULT 1,
    total_points INT DEFAULT 0,

    -- Statistiky aktivity
    tasks_created INT UNSIGNED DEFAULT 0,
    tasks_verified INT UNSIGNED DEFAULT 0,
    punishments_issued INT UNSIGNED DEFAULT 0,

    -- Power Index (0-100%)
    power_index DECIMAL(5,2) DEFAULT 0.00 COMMENT 'Ukazatel výkonu dominy za posledních 7 dní (0-100%)',
    power_index_history JSON NULL COMMENT 'Historie Power Index po dnech',

    -- Aktivity tracking
    last_task_created_at TIMESTAMP NULL,
    last_task_verified_at TIMESTAMP NULL,
    last_checklist_completed_at TIMESTAMP NULL,
    last_activity_at TIMESTAMP NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (domina_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    UNIQUE KEY unique_domina_household (domina_id, household_id),
    INDEX idx_domina (domina_id),
    INDEX idx_household (household_id),
    INDEX idx_level (current_level),
    INDEX idx_points (total_points),
    INDEX idx_power_index (power_index)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 6. SERVANT STATS (read-only statistiky, ŽÁDNÉ body)
-- ============================================================================

CREATE TABLE servant_stats (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    servant_id INT UNSIGNED NOT NULL,
    household_id INT UNSIGNED NOT NULL,

    -- Read-only metriky (ne body!)
    tasks_completed INT UNSIGNED DEFAULT 0,
    tasks_failed INT UNSIGNED DEFAULT 0,
    punishments_received INT UNSIGNED DEFAULT 0,
    current_streak_days INT UNSIGNED DEFAULT 0 COMMENT 'Dny v řadě bez selhání',
    longest_streak_days INT UNSIGNED DEFAULT 0,

    -- Tracking
    last_task_completed_at TIMESTAMP NULL,
    last_failure_at TIMESTAMP NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (servant_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    UNIQUE KEY unique_servant_household (servant_id, household_id),
    INDEX idx_servant (servant_id),
    INDEX idx_household (household_id),
    INDEX idx_streak (current_streak_days)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 7. FITNESS TRACKING (denní záznamy váhy, měření, kroky, kalorie, foto)
-- ============================================================================

CREATE TABLE fitness_tracking (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL COMMENT 'Servant ID',
    household_id INT UNSIGNED NOT NULL,
    tracking_date DATE NOT NULL,
    weight_kg DECIMAL(5,2) NULL,
    waist_cm DECIMAL(5,2) NULL,
    hips_cm DECIMAL(5,2) NULL,
    chest_cm DECIMAL(5,2) NULL,
    steps INT UNSIGNED NULL,
    calories_intake INT UNSIGNED NULL,
    calories_burned INT UNSIGNED NULL,
    photo_path VARCHAR(255) NULL COMMENT 'Cesta k dennímu progress foto',
    notes TEXT NULL,
    verified_by INT UNSIGNED NULL COMMENT 'Domina ID',
    verified_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL,
    UNIQUE KEY unique_user_date (user_id, household_id, tracking_date),
    INDEX idx_user (user_id),
    INDEX idx_household (household_id),
    INDEX idx_date (tracking_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 8. PUNISHMENT LIBRARY (100 trestů)
-- ============================================================================

CREATE TABLE punishment_library (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category ENUM('physical', 'mental', 'restrictive', 'creative', 'universal') NOT NULL,
    subcategory VARCHAR(50) NULL COMMENT 'impact, bondage, humiliation, denial, chores, etc.',
    intensity ENUM('light', 'medium', 'severe') NOT NULL,
    duration_minutes INT NULL,
    preferences_required JSON NULL COMMENT 'Co musí být v preferencích household',
    is_physical_discipline BOOLEAN DEFAULT FALSE COMMENT 'TRUE pro kategorii 1 (výchovné tresty)',
    is_universal BOOLEAN DEFAULT FALSE COMMENT 'TRUE pokud lze použít i když je vše v preferencích',
    instructions TEXT NULL,
    safety_notes TEXT NULL,
    severity_multiplier DECIMAL(3,2) DEFAULT 1.0 COMMENT 'Koeficient pro Power Index < 95% (např. 10 ran * 1.3 = 13 ran)',
    is_custom BOOLEAN DEFAULT FALSE,
    created_by INT UNSIGNED NULL COMMENT 'ID dominy pokud custom',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_category (category),
    INDEX idx_physical (is_physical_discipline),
    INDEX idx_universal (is_universal),
    INDEX idx_intensity (intensity)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 9. DOMINA DAILY CHECKLIST (denní checklist dominy - Feminine Power)
-- ============================================================================

CREATE TABLE domina_daily_checklist (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    domina_id INT UNSIGNED NOT NULL,
    household_id INT UNSIGNED NOT NULL,
    checklist_date DATE NOT NULL,
    items_required JSON NOT NULL COMMENT 'Seznam požadovaných položek pro daný level',
    items_completed JSON NULL COMMENT 'Seznam dokončených položek',
    completion_percentage INT UNSIGNED DEFAULT 0,
    verified_by_servant INT UNSIGNED NULL COMMENT 'Servant ID jako witness',
    verified_at TIMESTAMP NULL,
    points_earned INT DEFAULT 0 COMMENT 'Body přidané domině',
    penalty_applied INT DEFAULT 0 COMMENT 'Penalizace pokud nesplněno',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (domina_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    FOREIGN KEY (verified_by_servant) REFERENCES users(id) ON DELETE SET NULL,
    UNIQUE KEY unique_domina_date (domina_id, household_id, checklist_date),
    INDEX idx_domina (domina_id),
    INDEX idx_household (household_id),
    INDEX idx_date (checklist_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 10. ÚPRAVA EXISTUJÍCÍCH TABULEK
-- ============================================================================

-- 10.1 Households - přidat preferences a fitness_goals
ALTER TABLE households
ADD COLUMN preferences JSON NULL COMMENT 'BDSM preferences, lifestyle focus, hard/soft limits, interests' AFTER description,
ADD COLUMN fitness_goals JSON NULL COMMENT 'Target weight, measurements, tolerance' AFTER preferences;

-- 10.2 Tasks - rozšíření pro Recurring Tasks (#051) + přiřazení
ALTER TABLE tasks
ADD COLUMN recurrence_interval INT NULL COMMENT 'Pro every_x_days (2-30)' AFTER recurrence_pattern,
ADD COLUMN recurrence_day_of_week INT NULL COMMENT 'Pro weekly (1-7, pondělí-neděle)' AFTER recurrence_interval,
ADD COLUMN recurrence_day_of_month INT NULL COMMENT 'Pro monthly (1-31)' AFTER recurrence_day_of_week,
ADD COLUMN recurring_task_id INT UNSIGNED NULL COMMENT 'ID parent recurring task' AFTER recurrence_day_of_month,
ADD COLUMN recurrence_end_date DATE NULL COMMENT 'Volitelné datum ukončení' AFTER recurring_task_id,
ADD COLUMN recurrence_active BOOLEAN DEFAULT TRUE COMMENT 'Domina může vypnout' AFTER recurrence_end_date,
ADD COLUMN deadline TIMESTAMP NULL COMMENT 'Deadline úkolu' AFTER recurrence_active,
ADD COLUMN status ENUM('pending', 'in_progress', 'completed', 'failed', 'cancelled') DEFAULT 'pending' AFTER deadline,
ADD COLUMN assigned_to INT UNSIGNED NULL COMMENT 'Servant ID' AFTER status,
ADD COLUMN completed_at TIMESTAMP NULL AFTER assigned_to,
ADD COLUMN verified_by INT UNSIGNED NULL AFTER completed_at,
ADD COLUMN verified_at TIMESTAMP NULL AFTER verified_by,
ADD INDEX idx_recurring_parent (recurring_task_id),
ADD INDEX idx_status (status),
ADD INDEX idx_assigned_to (assigned_to),
ADD INDEX idx_deadline (deadline);

-- Foreign keys pro tasks
ALTER TABLE tasks
ADD CONSTRAINT fk_tasks_recurring_parent FOREIGN KEY (recurring_task_id) REFERENCES tasks(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_tasks_assigned_to FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE CASCADE,
ADD CONSTRAINT fk_tasks_verified_by FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL;

-- 10.3 Punishments - rozšíření pro Automatic Punishment System (#052)
ALTER TABLE punishments
ADD COLUMN title VARCHAR(255) NULL COMMENT 'Název trestu' AFTER servant_id,
ADD COLUMN description TEXT NULL COMMENT 'Popis trestu' AFTER title,
ADD COLUMN deadline TIMESTAMP NULL COMMENT 'Do kdy musí být splněno' AFTER severity,
ADD COLUMN status ENUM('pending', 'completed', 'verified', 'failed') DEFAULT 'pending' AFTER deadline,
ADD COLUMN punishment_library_id INT UNSIGNED NULL COMMENT 'Odkaz na punishment_library' AFTER status,
ADD COLUMN related_task_id INT UNSIGNED NULL COMMENT 'Úkol, kvůli kterému byl trest přiřazen' AFTER punishment_library_id,
ADD COLUMN completed_at TIMESTAMP NULL AFTER related_task_id,
ADD COLUMN completion_note TEXT NULL COMMENT 'Poznámka servanta při dokončení' AFTER completed_at,
ADD COLUMN verified_by INT UNSIGNED NULL AFTER completion_note,
ADD COLUMN verified_at TIMESTAMP NULL AFTER verified_by,
ADD COLUMN rejection_count INT UNSIGNED DEFAULT 0 COMMENT 'Počet odmítnutí dominou' AFTER verified_at,
ADD COLUMN applied_severity_multiplier DECIMAL(3,2) DEFAULT 1.0 COMMENT 'Aplikovaný koeficient z Power Index' AFTER rejection_count,
ADD INDEX idx_status_punishment (status),
ADD INDEX idx_deadline_punishment (deadline),
ADD INDEX idx_library (punishment_library_id);

-- Foreign keys pro punishments
ALTER TABLE punishments
ADD CONSTRAINT fk_punishments_library FOREIGN KEY (punishment_library_id) REFERENCES punishment_library(id) ON DELETE SET NULL,
ADD CONSTRAINT fk_punishments_task FOREIGN KEY (related_task_id) REFERENCES tasks(id) ON DELETE SET NULL,
ADD CONSTRAINT fk_punishments_verified_by FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL;

-- ============================================================================
-- HOTOVO - Power-Based Progression System
-- ============================================================================
