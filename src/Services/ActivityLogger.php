<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Services;

use Klaudie\Database;

/**
 * Activity logging service
 * Records all significant user actions for audit trail
 */
class ActivityLogger
{
    /**
     * Log activity to database
     */
    public static function log(
        int $userId,
        ?int $householdId,
        string $action,
        array $details = []
    ): void {
        $db = Database::getInstance();

        $db->execute(
            "INSERT INTO activity_log (user_id, household_id, action, details, ip_address, user_agent)
             VALUES (?, ?, ?, ?, ?, ?)",
            [
                $userId,
                $householdId,
                $action,
                json_encode($details),
                $_SERVER['REMOTE_ADDR'] ?? null,
                $_SERVER['HTTP_USER_AGENT'] ?? null,
            ]
        );
    }

    /**
     * Get recent activities for user
     */
    public static function getUserActivities(int $userId, int $limit = 50): array
    {
        $db = Database::getInstance();

        return $db->query(
            "SELECT * FROM activity_log
             WHERE user_id = ?
             ORDER BY created_at DESC
             LIMIT ?",
            [$userId, $limit]
        );
    }

    /**
     * Get recent activities for household
     */
    public static function getHouseholdActivities(int $householdId, int $limit = 50): array
    {
        $db = Database::getInstance();

        return $db->query(
            "SELECT al.*, u.display_name
             FROM activity_log al
             JOIN users u ON al.user_id = u.id
             WHERE al.household_id = ?
             ORDER BY al.created_at DESC
             LIMIT ?",
            [$householdId, $limit]
        );
    }
}
