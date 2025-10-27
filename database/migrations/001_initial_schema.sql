/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Initial database schema for multi-tenant virtual dominance application
 * Architecture: Hierarchical isolation (Domina → Households → Servants → Tasks)
 */

-- Drop tables if exist (for clean reinstall)
DROP TABLE IF EXISTS activity_log;
DROP TABLE IF EXISTS punishments;
DROP TABLE IF EXISTS servant_levels;
DROP TABLE IF EXISTS points_ledger;
DROP TABLE IF EXISTS task_assignments;
DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS household_members;
DROP TABLE IF EXISTS households;
DROP TABLE IF EXISTS users;

-- Users table: Base identity (Domina or Servant)
CREATE TABLE users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('domina', 'servant') NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,

    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Households: Domina's domain (one Domina can have multiple households)
CREATE TABLE households (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    domina_id INT UNSIGNED NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (domina_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_domina (domina_id),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Household members: Servants assigned to specific households
CREATE TABLE household_members (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    household_id INT UNSIGNED NOT NULL,
    servant_id INT UNSIGNED NOT NULL,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'suspended', 'expelled') DEFAULT 'active',
    notes TEXT,

    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    FOREIGN KEY (servant_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_household_servant (household_id, servant_id),
    INDEX idx_household (household_id),
    INDEX idx_servant (servant_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tasks: Defined by Domina for household
CREATE TABLE tasks (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    household_id INT UNSIGNED NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    points_reward INT NOT NULL DEFAULT 10,
    difficulty ENUM('trivial', 'easy', 'medium', 'hard', 'extreme') DEFAULT 'medium',
    category VARCHAR(50),
    created_by INT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_recurring BOOLEAN DEFAULT FALSE,
    recurrence_pattern VARCHAR(100) COMMENT 'Cron-like pattern for recurring tasks',

    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_household (household_id),
    INDEX idx_difficulty (difficulty),
    INDEX idx_category (category),
    INDEX idx_recurring (is_recurring)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Task assignments: Individual task instances assigned to servants
CREATE TABLE task_assignments (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    task_id INT UNSIGNED NOT NULL,
    servant_id INT UNSIGNED NOT NULL,
    household_id INT UNSIGNED NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date TIMESTAMP NULL,
    status ENUM('pending', 'in_progress', 'completed', 'failed', 'cancelled') DEFAULT 'pending',
    completed_at TIMESTAMP NULL,
    verified_by INT UNSIGNED NULL COMMENT 'Domina who verified completion',
    verification_notes TEXT,
    servant_notes TEXT COMMENT 'Servant can add notes/proof of completion',

    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    FOREIGN KEY (servant_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    FOREIGN KEY (verified_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_task (task_id),
    INDEX idx_servant (servant_id),
    INDEX idx_household (household_id),
    INDEX idx_status (status),
    INDEX idx_due_date (due_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Points ledger: Complete history of point transactions
CREATE TABLE points_ledger (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    servant_id INT UNSIGNED NOT NULL,
    household_id INT UNSIGNED NOT NULL,
    amount INT NOT NULL COMMENT 'Positive for rewards, negative for penalties',
    reason VARCHAR(255) NOT NULL,
    task_assignment_id INT UNSIGNED NULL,
    punishment_id INT UNSIGNED NULL,
    created_by INT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (servant_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    FOREIGN KEY (task_assignment_id) REFERENCES task_assignments(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_servant (servant_id),
    INDEX idx_household (household_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Servant levels: Gamification layer
CREATE TABLE servant_levels (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    servant_id INT UNSIGNED NOT NULL,
    household_id INT UNSIGNED NOT NULL,
    current_level INT UNSIGNED DEFAULT 1,
    total_points INT DEFAULT 0,
    level_reached_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (servant_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    UNIQUE KEY unique_servant_household (servant_id, household_id),
    INDEX idx_servant (servant_id),
    INDEX idx_household (household_id),
    INDEX idx_level (current_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Punishments: Disciplinary records
CREATE TABLE punishments (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    servant_id INT UNSIGNED NOT NULL,
    household_id INT UNSIGNED NOT NULL,
    reason TEXT NOT NULL,
    severity ENUM('warning', 'minor', 'moderate', 'severe', 'critical') DEFAULT 'minor',
    point_penalty INT DEFAULT 0,
    issued_by INT UNSIGNED NOT NULL,
    issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL,
    resolution_notes TEXT,

    FOREIGN KEY (servant_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    FOREIGN KEY (issued_by) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_servant (servant_id),
    INDEX idx_household (household_id),
    INDEX idx_severity (severity),
    INDEX idx_issued_at (issued_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add foreign key for punishment_id in points_ledger (must be added after punishments table exists)
ALTER TABLE points_ledger
ADD CONSTRAINT fk_points_punishment
FOREIGN KEY (punishment_id) REFERENCES punishments(id) ON DELETE SET NULL;

-- Activity log: Real-time monitoring and audit trail
CREATE TABLE activity_log (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    household_id INT UNSIGNED NULL,
    action VARCHAR(100) NOT NULL,
    details JSON,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (household_id) REFERENCES households(id) ON DELETE CASCADE,
    INDEX idx_user (user_id),
    INDEX idx_household (household_id),
    INDEX idx_action (action),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create views for common queries
CREATE VIEW v_servant_stats AS
SELECT
    s.id as servant_id,
    s.display_name,
    h.id as household_id,
    h.name as household_name,
    sl.current_level,
    sl.total_points,
    COUNT(DISTINCT ta.id) as total_tasks,
    SUM(CASE WHEN ta.status = 'completed' THEN 1 ELSE 0 END) as completed_tasks,
    SUM(CASE WHEN ta.status = 'failed' THEN 1 ELSE 0 END) as failed_tasks,
    COUNT(DISTINCT p.id) as total_punishments
FROM users s
JOIN household_members hm ON s.id = hm.servant_id
JOIN households h ON hm.household_id = h.id
LEFT JOIN servant_levels sl ON s.id = sl.servant_id AND h.id = sl.household_id
LEFT JOIN task_assignments ta ON s.id = ta.servant_id AND h.id = ta.household_id
LEFT JOIN punishments p ON s.id = p.servant_id AND h.id = p.household_id
WHERE s.role = 'servant' AND hm.status = 'active'
GROUP BY s.id, h.id, sl.current_level, sl.total_points;
