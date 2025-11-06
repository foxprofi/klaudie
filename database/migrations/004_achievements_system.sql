-- =====================================================
-- ACHIEVEMENTS SYSTEM - MIGRATION
-- =====================================================
-- @Author: Klaudie <klaudie@foxprofi.cz>
--
-- Achievement systém pro sledování pokroku dominy
-- Automatická detekce a odemykání achievementů

USE klaudie;

-- Tabulka achievementů (katalog)
CREATE TABLE IF NOT EXISTS achievements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE COMMENT 'Unikátní kód achievementu (first_task, week_streak, etc.)',
    title VARCHAR(255) NOT NULL COMMENT 'Název achievementu',
    description TEXT COMMENT 'Popis achievementu',
    category ENUM('tasks', 'punishments', 'streak', 'level', 'power') NOT NULL COMMENT 'Kategorie achievementu',
    requirement_type ENUM('count', 'streak', 'threshold', 'milestone') NOT NULL COMMENT 'Typ požadavku',
    requirement_value INT NOT NULL COMMENT 'Hodnota požadavku (např. 10 úkolů)',
    icon VARCHAR(50) DEFAULT NULL COMMENT 'Ikona achievementu',
    points_reward INT DEFAULT 0 COMMENT 'Odměna bodů za odemčení',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_category (category),
    INDEX idx_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Katalog achievementů - definice všech možných achievementů';

-- Tabulka odemčených achievementů (user achievements)
CREATE TABLE IF NOT EXISTS domina_achievements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    domina_id INT UNSIGNED NOT NULL COMMENT 'ID dominy',
    household_id INT UNSIGNED NOT NULL COMMENT 'ID household',
    achievement_id INT NOT NULL COMMENT 'ID achievementu',
    unlocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'Kdy byl achievement odemčen',

    FOREIGN KEY (domina_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE,

    UNIQUE KEY unique_achievement (domina_id, household_id, achievement_id),
    INDEX idx_domina_household (domina_id, household_id),
    INDEX idx_achievement (achievement_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
COMMENT='Odemčené achievementy dominy - many-to-many vztah';

-- =====================================================
-- ROLLBACK
-- =====================================================
-- DROP TABLE IF EXISTS domina_achievements;
-- DROP TABLE IF EXISTS achievements;
