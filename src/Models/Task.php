<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Models;

/**
 * Task model
 * Represents task templates created by Domina
 */
class Task extends Model
{
    protected string $table = 'tasks';

    /**
     * Get all tasks for household
     */
    public function getByHousehold(int $householdId): array
    {
        return $this->findAll(['household_id' => $householdId], ['created_at' => 'DESC']);
    }

    /**
     * Get tasks by category
     */
    public function getByCategory(int $householdId, string $category): array
    {
        return $this->findAll([
            'household_id' => $householdId,
            'category' => $category,
        ]);
    }

    /**
     * Get recurring tasks
     */
    public function getRecurring(int $householdId): array
    {
        return $this->findAll([
            'household_id' => $householdId,
            'is_recurring' => true,
        ]);
    }

    /**
     * Calculate final points based on difficulty
     */
    public function calculatePoints(int $basePoints, string $difficulty): int
    {
        $config = require __DIR__ . '/../../config/config.php';
        $multiplier = $config['points']['task_difficulty_multipliers'][$difficulty] ?? 1;

        return (int) ($basePoints * $multiplier);
    }
}
