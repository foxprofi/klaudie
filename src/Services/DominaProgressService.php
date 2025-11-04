<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Services;

use Klaudie\Database;

/**
 * Domina Progress Service - Power-Based System
 * Pouze domina má body a level. Servant závisí na Power Index.
 */
class DominaProgressService
{
    /**
     * Level thresholdy podle Power-Based System
     */
    private const LEVEL_THRESHOLDS = [
        1 => 0,      // 0-999
        2 => 1000,   // 1000-2999
        3 => 3000,   // 3000-5999
        4 => 6000,   // 6000-9999
        5 => 10000,  // 10000+
    ];

    /**
     * Level názvy
     */
    private const LEVEL_NAMES = [
        1 => 'Začátečnice',
        2 => 'Učící se',
        3 => 'Sebevědomá',
        4 => 'Zkušená',
        5 => 'Expertka',
    ];

    /**
     * Vypočítat level z bodů
     */
    public static function calculateLevel(int $points): int
    {
        if ($points >= self::LEVEL_THRESHOLDS[5]) return 5;
        if ($points >= self::LEVEL_THRESHOLDS[4]) return 4;
        if ($points >= self::LEVEL_THRESHOLDS[3]) return 3;
        if ($points >= self::LEVEL_THRESHOLDS[2]) return 2;
        return 1;
    }

    /**
     * Získat info o levelu dominy
     */
    public static function getLevelInfo(int $dominaId, int $householdId): array
    {
        $db = Database::getInstance();

        $progress = $db->queryOne(
            "SELECT current_level, total_points, power_index
             FROM domina_progress
             WHERE domina_id = ? AND household_id = ?",
            [$dominaId, $householdId]
        );

        if (!$progress) {
            return [
                'current_level' => 1,
                'level_name' => self::LEVEL_NAMES[1],
                'total_points' => 0,
                'points_for_current_level' => 0,
                'points_to_next_level' => 1000,
                'next_level_threshold' => 1000,
                'progress_percentage' => 0,
                'power_index' => 0.00,
            ];
        }

        $currentLevel = (int) $progress['current_level'];
        $totalPoints = (int) $progress['total_points'];
        $powerIndex = (float) $progress['power_index'];

        $currentThreshold = self::LEVEL_THRESHOLDS[$currentLevel];
        $nextLevel = min(5, $currentLevel + 1);
        $nextThreshold = self::LEVEL_THRESHOLDS[$nextLevel] ?? PHP_INT_MAX;

        $pointsInCurrentLevel = $totalPoints - $currentThreshold;
        $pointsNeeded = $nextThreshold - $currentThreshold;

        // Pokud je level 5, nemá další level
        if ($currentLevel === 5) {
            $pointsToNext = 0;
            $progressPercentage = 100;
        } else {
            $pointsToNext = $nextThreshold - $totalPoints;
            $progressPercentage = ($pointsInCurrentLevel / $pointsNeeded) * 100;
        }

        return [
            'current_level' => $currentLevel,
            'level_name' => self::LEVEL_NAMES[$currentLevel],
            'total_points' => $totalPoints,
            'points_for_current_level' => $pointsInCurrentLevel,
            'points_to_next_level' => $pointsToNext,
            'next_level_threshold' => $nextThreshold,
            'progress_percentage' => round($progressPercentage, 2),
            'power_index' => $powerIndex,
        ];
    }

    /**
     * Přidat body domině
     */
    public static function addPoints(
        int $dominaId,
        int $householdId,
        int $points,
        string $reason
    ): void {
        $db = Database::getInstance();

        // Získat nebo vytvořit progress
        $progress = $db->queryOne(
            "SELECT id, total_points, current_level
             FROM domina_progress
             WHERE domina_id = ? AND household_id = ?",
            [$dominaId, $householdId]
        );

        if (!$progress) {
            // Vytvořit nový záznam
            $db->execute(
                "INSERT INTO domina_progress (domina_id, household_id, total_points, current_level)
                 VALUES (?, ?, ?, ?)",
                [$dominaId, $householdId, 0, 1]
            );

            $progress = ['id' => $db->lastInsertId(), 'total_points' => 0, 'current_level' => 1];
        }

        $oldPoints = (int) $progress['total_points'];
        $oldLevel = (int) $progress['current_level'];
        $newPoints = $oldPoints + $points;
        $newLevel = self::calculateLevel($newPoints);

        // Update bodů a levelu
        $db->execute(
            "UPDATE domina_progress
             SET total_points = ?, current_level = ?, last_activity_at = NOW()
             WHERE domina_id = ? AND household_id = ?",
            [$newPoints, $newLevel, $dominaId, $householdId]
        );

        // Log aktivity
        ActivityLogger::log($dominaId, $householdId, 'domina.points.add', [
            'amount' => $points,
            'reason' => $reason,
            'old_points' => $oldPoints,
            'new_points' => $newPoints,
        ]);

        // Level up?
        if ($newLevel > $oldLevel) {
            ActivityLogger::log($dominaId, $householdId, 'domina.level.up', [
                'old_level' => $oldLevel,
                'new_level' => $newLevel,
                'total_points' => $newPoints,
            ]);
        }
    }

    /**
     * Odečíst body (penalizace)
     */
    public static function deductPoints(
        int $dominaId,
        int $householdId,
        int $points,
        string $reason
    ): void {
        $db = Database::getInstance();

        $progress = $db->queryOne(
            "SELECT total_points, current_level
             FROM domina_progress
             WHERE domina_id = ? AND household_id = ?",
            [$dominaId, $householdId]
        );

        if (!$progress) {
            return;
        }

        $oldPoints = (int) $progress['total_points'];
        $oldLevel = (int) $progress['current_level'];
        $newPoints = max(0, $oldPoints - $points); // Nesmí jít pod 0
        $newLevel = self::calculateLevel($newPoints);

        $db->execute(
            "UPDATE domina_progress
             SET total_points = ?, current_level = ?
             WHERE domina_id = ? AND household_id = ?",
            [$newPoints, $newLevel, $dominaId, $householdId]
        );

        ActivityLogger::log($dominaId, $householdId, 'domina.points.deduct', [
            'amount' => $points,
            'reason' => $reason,
            'old_points' => $oldPoints,
            'new_points' => $newPoints,
        ]);

        // Level down?
        if ($newLevel < $oldLevel) {
            ActivityLogger::log($dominaId, $householdId, 'domina.level.down', [
                'old_level' => $oldLevel,
                'new_level' => $newLevel,
                'total_points' => $newPoints,
            ]);
        }
    }

    /**
     * Získat Power Index dominy
     */
    public static function getPowerIndex(int $dominaId, int $householdId): float
    {
        $db = Database::getInstance();

        $result = $db->queryOne(
            "SELECT power_index FROM domina_progress
             WHERE domina_id = ? AND household_id = ?",
            [$dominaId, $householdId]
        );

        return $result ? (float) $result['power_index'] : 0.00;
    }
}
