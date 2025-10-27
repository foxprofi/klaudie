<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Models;

/**
 * TaskAssignment model
 * Represents specific task instances assigned to servants
 */
class TaskAssignment extends Model
{
    protected string $table = 'task_assignments';

    /**
     * Get assignments for servant
     */
    public function getByServant(int $servantId, ?string $status = null): array
    {
        $conditions = ['servant_id' => $servantId];
        if ($status) {
            $conditions['status'] = $status;
        }

        $sql = "SELECT ta.*, t.title, t.description, t.points_reward, t.difficulty, t.category
                FROM task_assignments ta
                JOIN tasks t ON ta.task_id = t.id
                WHERE ta.servant_id = ?" . ($status ? " AND ta.status = ?" : "") . "
                ORDER BY ta.due_date ASC, ta.assigned_at DESC";

        $params = $status ? [$servantId, $status] : [$servantId];
        return $this->db->query($sql, $params);
    }

    /**
     * Get assignments for household
     */
    public function getByHousehold(int $householdId, ?string $status = null): array
    {
        $conditions = ['household_id' => $householdId];
        if ($status) {
            $conditions['status'] = $status;
        }

        $sql = "SELECT ta.*, t.title, t.description, t.points_reward, t.difficulty,
                       u.display_name as servant_name
                FROM task_assignments ta
                JOIN tasks t ON ta.task_id = t.id
                JOIN users u ON ta.servant_id = u.id
                WHERE ta.household_id = ?" . ($status ? " AND ta.status = ?" : "") . "
                ORDER BY ta.assigned_at DESC";

        $params = $status ? [$householdId, $status] : [$householdId];
        return $this->db->query($sql, $params);
    }

    /**
     * Mark assignment as completed by servant
     */
    public function markCompleted(int $assignmentId, ?string $notes = null): int
    {
        return $this->update($assignmentId, [
            'status' => 'completed',
            'completed_at' => date('Y-m-d H:i:s'),
            'servant_notes' => $notes,
        ]);
    }

    /**
     * Verify completion by Domina
     */
    public function verify(int $assignmentId, int $dominaId, ?string $notes = null): int
    {
        return $this->update($assignmentId, [
            'verified_by' => $dominaId,
            'verification_notes' => $notes,
        ]);
    }

    /**
     * Mark assignment as failed
     */
    public function markFailed(int $assignmentId, ?string $reason = null): int
    {
        return $this->update($assignmentId, [
            'status' => 'failed',
            'verification_notes' => $reason,
        ]);
    }

    /**
     * Get overdue assignments
     */
    public function getOverdue(int $householdId): array
    {
        $sql = "SELECT ta.*, t.title, u.display_name as servant_name
                FROM task_assignments ta
                JOIN tasks t ON ta.task_id = t.id
                JOIN users u ON ta.servant_id = u.id
                WHERE ta.household_id = ?
                  AND ta.status IN ('pending', 'in_progress')
                  AND ta.due_date < NOW()
                ORDER BY ta.due_date ASC";

        return $this->db->query($sql, [$householdId]);
    }

    /**
     * Get completion statistics for servant
     */
    public function getServantStats(int $servantId, int $householdId): array
    {
        $sql = "SELECT
                    COUNT(*) as total,
                    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed,
                    SUM(CASE WHEN status = 'failed' THEN 1 ELSE 0 END) as failed,
                    SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending,
                    SUM(CASE WHEN status = 'in_progress' THEN 1 ELSE 0 END) as in_progress
                FROM task_assignments
                WHERE servant_id = ? AND household_id = ?";

        return $this->db->queryOne($sql, [$servantId, $householdId]) ?? [];
    }
}
