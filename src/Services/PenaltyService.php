<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Services;

use Klaudie\Database;
use Klaudie\Models\Household;
use Klaudie\Models\TaskAssignment;

/**
 * Penalty Service
 * Negative point system for domina penalties
 */
class PenaltyService
{
    // Penalty amounts
    const PENALTY_NO_TASK_24H = -10;
    const PENALTY_TASK_REJECTED = -25;
    const PENALTY_DEADLINE_MISSED = -15;
    const PENALTY_RULE_VIOLATION = -20;
    const PENALTY_DISRESPECT = -50;

    /**
     * Check for servants with no completed task in last 24 hours
     * Called by cron job daily
     */
    public static function checkInactivityPenalties(): array
    {
        $db = Database::getInstance();
        $results = [];

        // Get all active households
        $households = $db->query("SELECT id, domina_id FROM households WHERE 1=1");

        foreach ($households as $household) {
            $householdId = $household['id'];
            $dominaId = $household['domina_id'];

            // Get all servants in this household
            $servants = $db->query(
                "SELECT user_id FROM household_members
                 WHERE household_id = ? AND role = 'servant'",
                [$householdId]
            );

            foreach ($servants as $servant) {
                $servantId = $servant['user_id'];

                // Check if servant completed any task in last 24 hours
                $lastCompleted = $db->queryOne(
                    "SELECT completed_at FROM task_assignments
                     WHERE servant_id = ? AND household_id = ?
                     AND status IN ('completed', 'verified')
                     AND completed_at >= DATE_SUB(NOW(), INTERVAL 24 HOUR)
                     ORDER BY completed_at DESC LIMIT 1",
                    [$servantId, $householdId]
                );

                if (!$lastCompleted) {
                    // No task completed in 24h - apply penalty
                    self::applyPenalty(
                        $dominaId,
                        $householdId,
                        self::PENALTY_NO_TASK_24H,
                        "Penalty: Servant #{$servantId} - no completed task in 24 hours",
                        [
                            'type' => 'inactivity_24h',
                            'servant_id' => $servantId,
                        ]
                    );

                    $results[] = [
                        'household_id' => $householdId,
                        'servant_id' => $servantId,
                        'penalty' => self::PENALTY_NO_TASK_24H,
                        'reason' => 'No task completed in 24h',
                    ];
                }
            }
        }

        return $results;
    }

    /**
     * Apply penalty when servant rejects a task
     */
    public static function applyTaskRejectionPenalty(
        int $dominaId,
        int $householdId,
        int $servantId,
        int $taskId
    ): void {
        self::applyPenalty(
            $dominaId,
            $householdId,
            self::PENALTY_TASK_REJECTED,
            "Penalty: Servant #{$servantId} rejected task #{$taskId}",
            [
                'type' => 'task_rejected',
                'servant_id' => $servantId,
                'task_id' => $taskId,
            ]
        );
    }

    /**
     * Check for missed deadlines and apply penalties
     * Called by cron job daily
     */
    public static function checkDeadlinePenalties(): array
    {
        $db = Database::getInstance();
        $results = [];

        // Find all assignments with missed deadlines (not completed, past due_date)
        $missedDeadlines = $db->query(
            "SELECT ta.*, h.domina_id, h.id as household_id
             FROM task_assignments ta
             JOIN households h ON ta.household_id = h.id
             WHERE ta.status = 'pending'
             AND ta.due_date IS NOT NULL
             AND ta.due_date < NOW()
             AND NOT EXISTS (
                 SELECT 1 FROM activity_log
                 WHERE household_id = ta.household_id
                 AND JSON_EXTRACT(metadata, '$.assignment_id') = ta.id
                 AND JSON_EXTRACT(metadata, '$.type') = 'deadline_missed'
             )"
        );

        foreach ($missedDeadlines as $assignment) {
            self::applyPenalty(
                $assignment['domina_id'],
                $assignment['household_id'],
                self::PENALTY_DEADLINE_MISSED,
                "Penalty: Missed deadline for task assignment #{$assignment['id']}",
                [
                    'type' => 'deadline_missed',
                    'assignment_id' => $assignment['id'],
                    'servant_id' => $assignment['servant_id'],
                    'task_id' => $assignment['task_id'],
                ]
            );

            $results[] = [
                'household_id' => $assignment['household_id'],
                'assignment_id' => $assignment['id'],
                'servant_id' => $assignment['servant_id'],
                'penalty' => self::PENALTY_DEADLINE_MISSED,
                'reason' => 'Deadline missed',
            ];
        }

        return $results;
    }

    /**
     * Apply manual penalty for rule violation
     */
    public static function applyRuleViolationPenalty(
        int $dominaId,
        int $householdId,
        int $servantId,
        string $reason
    ): void {
        self::applyPenalty(
            $dominaId,
            $householdId,
            self::PENALTY_RULE_VIOLATION,
            "Penalty: Rule violation - {$reason}",
            [
                'type' => 'rule_violation',
                'servant_id' => $servantId,
                'reason' => $reason,
            ]
        );
    }

    /**
     * Apply manual penalty for disrespect
     */
    public static function applyDisrespectPenalty(
        int $dominaId,
        int $householdId,
        int $servantId,
        string $reason
    ): void {
        self::applyPenalty(
            $dominaId,
            $householdId,
            self::PENALTY_DISRESPECT,
            "Penalty: Disrespect/argument - {$reason}",
            [
                'type' => 'disrespect',
                'servant_id' => $servantId,
                'reason' => $reason,
            ]
        );
    }

    /**
     * Core method to apply penalty (deduct points from domina)
     */
    private static function applyPenalty(
        int $dominaId,
        int $householdId,
        int $penaltyPoints,
        string $description,
        array $metadata = []
    ): void {
        // Deduct points from domina (negative points in Power-Based System)
        DominaProgressService::deductPoints(
            $dominaId,
            $householdId,
            abs($penaltyPoints),
            $description
        );

        // Log penalty to activity log
        ActivityLogger::log($dominaId, $householdId, 'penalty.applied', array_merge($metadata, [
            'penalty_points' => $penaltyPoints,
            'description' => $description,
        ]));
    }

    /**
     * Get penalty statistics for household
     */
    public static function getPenaltyStats(int $householdId): array
    {
        $db = Database::getInstance();

        $stats = $db->queryOne(
            "SELECT
                COUNT(*) as total_penalties,
                SUM(CAST(JSON_EXTRACT(metadata, '$.penalty_points') AS SIGNED)) as total_penalty_points,
                COUNT(DISTINCT JSON_EXTRACT(metadata, '$.servant_id')) as servants_penalized
             FROM activity_log
             WHERE household_id = ?
             AND action = 'penalty.applied'",
            [$householdId]
        );

        // Get penalty breakdown by type
        $breakdown = $db->query(
            "SELECT
                JSON_EXTRACT(metadata, '$.type') as penalty_type,
                COUNT(*) as count,
                SUM(CAST(JSON_EXTRACT(metadata, '$.penalty_points') AS SIGNED)) as points
             FROM activity_log
             WHERE household_id = ?
             AND action = 'penalty.applied'
             GROUP BY penalty_type",
            [$householdId]
        );

        return [
            'total_penalties' => (int) ($stats['total_penalties'] ?? 0),
            'total_penalty_points' => (int) ($stats['total_penalty_points'] ?? 0),
            'servants_penalized' => (int) ($stats['servants_penalized'] ?? 0),
            'breakdown' => $breakdown,
        ];
    }
}
