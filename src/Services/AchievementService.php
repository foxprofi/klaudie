<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Services;

use Klaudie\Database;

/**
 * Achievement Service - Detekce a odemykání achievementů
 * Pouze pro dominu (Power-Based System)
 */
class AchievementService
{
    /**
     * Zkontrolovat achievementy pro dominu a odemknout nové
     */
    public static function checkAchievements(int $dominaId, int $householdId): array
    {
        $db = Database::getInstance();
        $unlockedNew = [];

        // Získat všechny achievementy
        $achievements = $db->query("SELECT * FROM achievements ORDER BY id");

        foreach ($achievements as $achievement) {
            // Zkontrolovat, jestli už je odemčený
            $existing = $db->queryOne(
                "SELECT id FROM domina_achievements
                 WHERE domina_id = ? AND household_id = ? AND achievement_id = ?",
                [$dominaId, $householdId, $achievement['id']]
            );

            if ($existing) {
                continue; // Už odemčený
            }

            // Zkontrolovat, jestli splňuje requirements
            if (self::meetsRequirement($dominaId, $householdId, $achievement)) {
                // Odemknout achievement
                $db->execute(
                    "INSERT INTO domina_achievements (domina_id, household_id, achievement_id)
                     VALUES (?, ?, ?)",
                    [$dominaId, $householdId, $achievement['id']]
                );

                // Přidat body za achievement (pokud má reward)
                if ($achievement['points_reward'] > 0) {
                    DominaProgressService::addPoints(
                        $dominaId,
                        $householdId,
                        $achievement['points_reward'],
                        "Achievement unlocked: {$achievement['name']}"
                    );
                }

                ActivityLogger::log($dominaId, $householdId, 'achievement.unlocked', [
                    'achievement_id' => $achievement['id'],
                    'achievement_name' => $achievement['name'],
                    'points_reward' => $achievement['points_reward'],
                ]);

                $unlockedNew[] = $achievement;
            }
        }

        return $unlockedNew;
    }

    /**
     * Zkontrolovat, jestli domina splňuje requirement pro achievement
     */
    private static function meetsRequirement(int $dominaId, int $householdId, array $achievement): bool
    {
        $db = Database::getInstance();
        $type = $achievement['requirement_type'];
        $value = (int) $achievement['requirement_value'];

        switch ($type) {
            case 'task_verified_count':
                // Počet verifikovaných úkolů
                $result = $db->queryOne(
                    "SELECT COUNT(*) as count FROM task_assignments
                     WHERE household_id = ? AND verified_by = ? AND status = 'verified'",
                    [$householdId, $dominaId]
                );
                return ($result && (int)$result['count'] >= $value);

            case 'punishment_issued_count':
                // Počet udělených trestů
                $result = $db->queryOne(
                    "SELECT COUNT(*) as count FROM punishments
                     WHERE household_id = ? AND issued_by = ?",
                    [$householdId, $dominaId]
                );
                return ($result && (int)$result['count'] >= $value);

            case 'points_reached':
                // Dosažení určitého počtu bodů
                $levelInfo = DominaProgressService::getLevelInfo($dominaId, $householdId);
                return ($levelInfo['total_points'] >= $value);

            case 'level_reached':
                // Dosažení určitého levelu
                $levelInfo = DominaProgressService::getLevelInfo($dominaId, $householdId);
                return ($levelInfo['current_level'] >= $value);

            case 'power_index_days':
                // Power Index > 70% po dobu X dní
                $result = $db->queryOne(
                    "SELECT power_index_history FROM domina_progress
                     WHERE domina_id = ? AND household_id = ?",
                    [$dominaId, $householdId]
                );

                if (!$result || !$result['power_index_history']) {
                    return false;
                }

                $history = json_decode($result['power_index_history'], true);
                if (!$history) {
                    return false;
                }

                // Zkontrolovat poslední X dní
                $consecutiveDays = 0;
                $history = array_reverse($history); // Nejnovější první

                foreach ($history as $day) {
                    if ($day['power_index'] >= 70) {
                        $consecutiveDays++;
                        if ($consecutiveDays >= $value) {
                            return true;
                        }
                    } else {
                        break; // Přerušena série
                    }
                }

                return false;

            default:
                return false;
        }
    }

    /**
     * Získat všechny odemčené achievementy dominy
     */
    public static function getUnlockedAchievements(int $dominaId, int $householdId): array
    {
        $db = Database::getInstance();

        return $db->query(
            "SELECT a.*, da.unlocked_at
             FROM achievements a
             JOIN domina_achievements da ON a.id = da.achievement_id
             WHERE da.domina_id = ? AND da.household_id = ?
             ORDER BY da.unlocked_at DESC",
            [$dominaId, $householdId]
        );
    }

    /**
     * Získat všechny achievementy (odemčené + zamčené)
     */
    public static function getAllAchievementsWithStatus(int $dominaId, int $householdId): array
    {
        $db = Database::getInstance();

        $achievements = $db->query("SELECT * FROM achievements ORDER BY id");
        $unlocked = self::getUnlockedAchievements($dominaId, $householdId);

        $unlockedIds = array_column($unlocked, 'id');

        foreach ($achievements as &$achievement) {
            $achievement['unlocked'] = in_array($achievement['id'], $unlockedIds);
        }

        return $achievements;
    }
}
