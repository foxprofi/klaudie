/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Migration: Add household_key for servant registration
 */

-- Add household_key column (UUID for servant invitation)
ALTER TABLE households
ADD COLUMN household_key CHAR(36) NOT NULL UNIQUE AFTER domina_id,
ADD INDEX idx_household_key (household_key);

-- Generate UUID for existing households
UPDATE households
SET household_key = UUID()
WHERE household_key IS NULL OR household_key = '';
