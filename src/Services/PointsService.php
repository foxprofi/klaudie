<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Services;

use Klaudie\Database;

/**
 * Points and leveling service
 * Handles point transactions and level calculations
 */
class PointsService
{
    /**
     * Award points to servant
     */
    public static function awardPoints(
        int $servantId,
        int $householdId,
        int $points,
        string $reason,
        ?int $taskAssignmentId = null
    ): void {
        $db = Database::getInstance();

        // Record points transaction
        $db->execute(
            "INSERT INTO points_ledger (servant_id, household_id, amount, reason, task_assignment_id, created_by)
             VALUES (?, ?, ?, ?, ?, ?)",
            [$servantId, $householdId, $points, $reason, $taskAssignmentId, Auth::id()]
        );

        // Update servant level
        self::updateServantLevel($servantId, $householdId);

        ActivityLogger::log($servantId, $householdId, 'points.award', [
            'amount' => $points,
            'reason' => $reason,
        ]);
    }

    /**
     * Deduct points (punishment)
     */
    public static function deductPoints(
        int $servantId,
        int $householdId,
        int $points,
        string $reason,
        ?int $punishmentId = null
    ): void {
        $db = Database::getInstance();

        $db->execute(
            "INSERT INTO points_ledger (servant_id, household_id, amount, reason, punishment_id, created_by)
             VALUES (?, ?, ?, ?, ?, ?)",
            [$servantId, $householdId, -$points, $reason, $punishmentId, Auth::id()]
        );

        self::updateServantLevel($servantId, $householdId);

        ActivityLogger::log($servantId, $householdId, 'points.deduct', [
            'amount' => $points,
            'reason' => $reason,
        ]);
    }

    /**
     * Get total points for servant in household
     */
    public static function getTotalPoints(int $servantId, int $householdId): int
    {
        $db = Database::getInstance();

        $result = $db->queryOne(
            "SELECT COALESCE(SUM(amount), 0) as total
             FROM points_ledger
             WHERE servant_id = ? AND household_id = ?",
            [$servantId, $householdId]
        );

        return (int) ($result['total'] ?? 0);
    }

    /**
     * Calculate level from points
     */
    public static function calculateLevel(int $points): int
    {
        $config = require __DIR__ . '/../../config/config.php';
        $multiplier = $config['points']['level_multiplier'];

        // Level formula: points / multiplier (rounded down)
        return max(1, (int) floor($points / $multiplier));
    }

    /**
     * Update servant level based on current points
     */
    private static function updateServantLevel(int $servantId, int $householdId): void
    {
        $db = Database::getInstance();

        $totalPoints = self::getTotalPoints($servantId, $householdId);
        $newLevel = self::calculateLevel($totalPoints);

        // Get current level
        $current = $db->queryOne(
            "SELECT current_level FROM servant_levels WHERE servant_id = ? AND household_id = ?",
            [$servantId, $householdId]
        );

        if ($current) {
            // Update existing
            $db->execute(
                "UPDATE servant_levels SET current_level = ?, total_points = ?
                 WHERE servant_id = ? AND household_id = ?",
                [$newLevel, $totalPoints, $servantId, $householdId]
            );

            // Check for level up
            if ($newLevel > $current['current_level']) {
                ActivityLogger::log($servantId, $householdId, 'level.up', [
                    'old_level' => $current['current_level'],
                    'new_level' => $newLevel,
                ]);
            }
        } else {
            // Create new
            $db->execute(
                "INSERT INTO servant_levels (servant_id, household_id, current_level, total_points)
                 VALUES (?, ?, ?, ?)",
                [$servantId, $householdId, $newLevel, $totalPoints]
            );
        }
    }

    /**
     * Get servant level info
     */
    public static function getLevelInfo(int $servantId, int $householdId): array
    {
        $db = Database::getInstance();

        $level = $db->queryOne(
            "SELECT * FROM servant_levels WHERE servant_id = ? AND household_id = ?",
            [$servantId, $householdId]
        );

        if (!$level) {
            return [
                'current_level' => 1,
                'total_points' => 0,
                'points_to_next_level' => self::getPointsForLevel(2),
                'progress_percentage' => 0,
            ];
        }

        $currentLevel = $level['current_level'];
        $totalPoints = $level['total_points'];
        $pointsForCurrentLevel = self::getPointsForLevel($currentLevel);
        $pointsForNextLevel = self::getPointsForLevel($currentLevel + 1);

        $pointsInCurrentLevel = $totalPoints - $pointsForCurrentLevel;
        $pointsNeededForNext = $pointsForNextLevel - $pointsForCurrentLevel;

        return [
            'current_level' => $currentLevel,
            'total_points' => $totalPoints,
            'points_in_current_level' => $pointsInCurrentLevel,
            'points_to_next_level' => $pointsNeededForNext - $pointsInCurrentLevel,
            'progress_percentage' => ($pointsInCurrentLevel / $pointsNeededForNext) * 100,
        ];
    }

    /**
     * Get points required for specific level
     */
    private static function getPointsForLevel(int $level): int
    {
        $config = require __DIR__ . '/../../config/config.php';
        $multiplier = $config['points']['level_multiplier'];

        return ($level - 1) * $multiplier;
    }

    /**
     * Get points history for servant
     */
    public static function getHistory(int $servantId, int $householdId, int $limit = 50): array
    {
        $db = Database::getInstance();

        return $db->query(
            "SELECT * FROM points_ledger
             WHERE servant_id = ? AND household_id = ?
             ORDER BY created_at DESC
             LIMIT ?",
            [$servantId, $householdId, $limit]
        );
    }
}
