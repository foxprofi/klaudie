<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Models\Task;
use Klaudie\Models\TaskAssignment;
use Klaudie\Models\Household;
use Klaudie\Services\Auth;
use Klaudie\Services\ActivityLogger;
use Klaudie\Services\PointsService;
use Klaudie\Services\DominaProgressService;
use Klaudie\Response;

/**
 * Task controller
 * Manages task templates and assignments
 */
class TaskController
{
    /**
     * GET /api/households/{householdId}/tasks
     * List all tasks for household
     */
    public function index(int $householdId): string
    {
        $householdModel = new Household();

        // Check access
        if (Auth::isDomina() && !$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden();
        }
        if (Auth::isServant() && !$householdModel->isMember($householdId, Auth::id())) {
            return Response::forbidden();
        }

        $taskModel = new Task();
        $tasks = $taskModel->getByHousehold($householdId);

        return Response::success($tasks);
    }

    /**
     * POST /api/households/{householdId}/tasks
     * Create new task (Domina only)
     */
    public function create(int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden();
        }

        $data = json_decode(file_get_contents('php://input'), true);

        $errors = [];
        if (!isset($data['title']) || strlen($data['title']) < 2) {
            $errors['title'] = 'Title is required (min 2 characters)';
        }
        if (!isset($data['points_reward']) || $data['points_reward'] < 1) {
            $errors['points_reward'] = 'Points reward must be at least 1';
        }
        if (isset($data['difficulty']) && !in_array($data['difficulty'], ['trivial', 'easy', 'medium', 'hard', 'extreme'])) {
            $errors['difficulty'] = 'Invalid difficulty level';
        }

        if (!empty($errors)) {
            return Response::validationError($errors);
        }

        $taskModel = new Task();
        $taskId = $taskModel->insert([
            'household_id' => $householdId,
            'title' => $data['title'],
            'description' => $data['description'] ?? null,
            'points_reward' => $data['points_reward'],
            'difficulty' => $data['difficulty'] ?? 'medium',
            'category' => $data['category'] ?? null,
            'created_by' => Auth::id(),
            'is_recurring' => $data['is_recurring'] ?? false,
            'recurrence_pattern' => $data['recurrence_pattern'] ?? null,
        ]);

        ActivityLogger::log(Auth::id(), $householdId, 'task.create', [
            'task_id' => $taskId,
            'title' => $data['title'],
        ]);

        // Award points to domina for creating task (Power-Based System)
        DominaProgressService::addPoints(
            Auth::id(),
            $householdId,
            5,
            "Created task: {$data['title']}"
        );

        return Response::success(['id' => $taskId], 'Task created', 201);
    }

    /**
     * POST /api/tasks/{taskId}/assign
     * Assign task to servant (Domina only)
     */
    public function assign(int $taskId): string
    {
        $taskModel = new Task();
        $task = $taskModel->find($taskId);

        if (!$task) {
            return Response::notFound('Task not found');
        }

        $householdModel = new Household();
        if (!$householdModel->isOwner($task['household_id'], Auth::id())) {
            return Response::forbidden();
        }

        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['servant_id'])) {
            return Response::validationError(['servant_id' => 'Servant ID is required']);
        }

        // Verify servant is member of household
        if (!$householdModel->isMember($task['household_id'], $data['servant_id'])) {
            return Response::error('Servant is not member of this household');
        }

        $assignmentModel = new TaskAssignment();
        $assignmentId = $assignmentModel->insert([
            'task_id' => $taskId,
            'servant_id' => $data['servant_id'],
            'household_id' => $task['household_id'],
            'due_date' => $data['due_date'] ?? null,
        ]);

        ActivityLogger::log(Auth::id(), $task['household_id'], 'task.assign', [
            'task_id' => $taskId,
            'assignment_id' => $assignmentId,
            'servant_id' => $data['servant_id'],
        ]);

        return Response::success(['id' => $assignmentId], 'Task assigned', 201);
    }

    /**
     * GET /api/assignments/my
     * Get my task assignments (Servant)
     */
    public function myAssignments(): string
    {
        if (!Auth::isServant()) {
            return Response::forbidden();
        }

        $assignmentModel = new TaskAssignment();
        $assignments = $assignmentModel->getByServant(Auth::id());

        return Response::success($assignments);
    }

    /**
     * PUT /api/assignments/{assignmentId}/complete
     * Mark assignment as completed (Servant)
     */
    public function complete(int $assignmentId): string
    {
        $assignmentModel = new TaskAssignment();
        $assignment = $assignmentModel->find($assignmentId);

        if (!$assignment) {
            return Response::notFound('Assignment not found');
        }

        if ($assignment['servant_id'] != Auth::id()) {
            return Response::forbidden();
        }

        $data = json_decode(file_get_contents('php://input'), true);

        $assignmentModel->markCompleted($assignmentId, $data['notes'] ?? null);

        ActivityLogger::log(Auth::id(), $assignment['household_id'], 'task.complete', [
            'assignment_id' => $assignmentId,
        ]);

        return Response::success(null, 'Task marked as completed');
    }

    /**
     * PUT /api/assignments/{assignmentId}/verify
     * Verify task completion (Domina only)
     */
    public function verify(int $assignmentId): string
    {
        $assignmentModel = new TaskAssignment();
        $assignment = $assignmentModel->find($assignmentId);

        if (!$assignment) {
            return Response::notFound('Assignment not found');
        }

        $householdModel = new Household();
        if (!$householdModel->isOwner($assignment['household_id'], Auth::id())) {
            return Response::forbidden();
        }

        $data = json_decode(file_get_contents('php://input'), true);
        $approved = $data['approved'] ?? true;

        if ($approved) {
            $assignmentModel->verify($assignmentId, Auth::id(), $data['notes'] ?? null);

            // Get task details
            $taskModel = new Task();
            $task = $taskModel->find($assignment['task_id']);

            // Award points to domina (Power-Based System)
            // Base: 10 points for verification
            // Bonus: points based on task difficulty
            $difficultyPoints = [
                'trivial' => 5,
                'easy' => 10,
                'medium' => 15,
                'hard' => 20,
                'extreme' => 25,
            ];

            $taskDifficulty = $task['difficulty'] ?? 'medium';
            $bonusPoints = $difficultyPoints[$taskDifficulty] ?? 15;
            $totalPoints = 10 + $bonusPoints;

            DominaProgressService::addPoints(
                Auth::id(),
                $assignment['household_id'],
                $totalPoints,
                "Verified task: {$task['title']} (difficulty: {$taskDifficulty})"
            );

            ActivityLogger::log(Auth::id(), $assignment['household_id'], 'task.verify_approved', [
                'assignment_id' => $assignmentId,
                'points_awarded_domina' => $totalPoints,
                'verification_points' => 10,
                'difficulty_bonus' => $bonusPoints,
            ]);

            return Response::success(null, 'Task verified and points awarded');
        } else {
            $assignmentModel->markFailed($assignmentId, $data['notes'] ?? null);

            ActivityLogger::log(Auth::id(), $assignment['household_id'], 'task.verify_failed', [
                'assignment_id' => $assignmentId,
            ]);

            return Response::success(null, 'Task marked as failed');
        }
    }

    /**
     * GET /api/households/{householdId}/assignments
     * Get all assignments for household (Domina)
     */
    public function householdAssignments(int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden();
        }

        $assignmentModel = new TaskAssignment();
        $assignments = $assignmentModel->getByHousehold($householdId);

        return Response::success($assignments);
    }
}
