<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Models\Punishment;
use Klaudie\Models\Household;
use Klaudie\Services\Auth;
use Klaudie\Services\ActivityLogger;
use Klaudie\Services\PointsService;
use Klaudie\Services\DominaProgressService;
use Klaudie\Services\AchievementService;
use Klaudie\Response;

/**
 * Punishment controller
 * Disciplinary system management
 */
class PunishmentController
{
    /**
     * POST /api/households/{householdId}/punishments
     * Issue punishment (Domina only)
     */
    public function create(int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden();
        }

        $data = json_decode(file_get_contents('php://input'), true);

        $errors = [];
        if (!isset($data['servant_id'])) {
            $errors['servant_id'] = 'Servant ID is required';
        }
        if (!isset($data['reason']) || strlen($data['reason']) < 5) {
            $errors['reason'] = 'Reason is required (min 5 characters)';
        }
        if (isset($data['severity']) && !in_array($data['severity'], ['warning', 'minor', 'moderate', 'severe', 'critical'])) {
            $errors['severity'] = 'Invalid severity level';
        }

        if (!empty($errors)) {
            return Response::validationError($errors);
        }

        // Verify servant is member
        if (!$householdModel->isMember($householdId, $data['servant_id'])) {
            return Response::error('Servant is not member of this household');
        }

        $severity = $data['severity'] ?? 'minor';

        // Get penalty points from config
        $config = require __DIR__ . '/../../config/config.php';
        $penaltyPoints = $config['punishments']['severity_penalties'][$severity];

        $punishmentModel = new Punishment();
        $punishmentId = $punishmentModel->insert([
            'servant_id' => $data['servant_id'],
            'household_id' => $householdId,
            'reason' => $data['reason'],
            'severity' => $severity,
            'point_penalty' => $penaltyPoints,
            'issued_by' => Auth::id(),
        ]);

        // Note: In Power-Based System, servant has no points
        // Punishment is recorded for statistics only

        ActivityLogger::log(Auth::id(), $householdId, 'punishment.issue', [
            'punishment_id' => $punishmentId,
            'servant_id' => $data['servant_id'],
            'severity' => $severity,
        ]);

        // Award points to domina for issuing punishment (Power-Based System)
        DominaProgressService::addPoints(
            Auth::id(),
            $householdId,
            15,
            "Issued punishment: {$data['reason']} (severity: {$severity})"
        );

        // Check achievements
        $newAchievements = AchievementService::checkAchievements(Auth::id(), $householdId);

        return Response::success([
            'id' => $punishmentId,
            'new_achievements' => $newAchievements
        ], 'Punishment issued', 201);
    }

    /**
     * GET /api/households/{householdId}/punishments
     * List punishments for household (Domina)
     */
    public function index(int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden();
        }

        $punishmentModel = new Punishment();
        $punishments = $punishmentModel->getByHousehold($householdId);

        return Response::success($punishments);
    }

    /**
     * GET /api/my-punishments?household_id={id}
     * Get my punishments (Servant)
     */
    public function myPunishments(): string
    {
        if (!Auth::isServant()) {
            return Response::forbidden();
        }

        $householdId = $_GET['household_id'] ?? null;

        if (!$householdId) {
            return Response::validationError(['household_id' => 'Household ID is required']);
        }

        $punishmentModel = new Punishment();
        $punishments = $punishmentModel->getByServant(Auth::id(), (int)$householdId);

        return Response::success($punishments);
    }

    /**
     * PUT /api/punishments/{punishmentId}/resolve
     * Resolve punishment (Domina only)
     */
    public function resolve(int $punishmentId): string
    {
        $punishmentModel = new Punishment();
        $punishment = $punishmentModel->find($punishmentId);

        if (!$punishment) {
            return Response::notFound('Punishment not found');
        }

        $householdModel = new Household();
        if (!$householdModel->isOwner($punishment['household_id'], Auth::id())) {
            return Response::forbidden();
        }

        $data = json_decode(file_get_contents('php://input'), true);

        $punishmentModel->resolve($punishmentId, $data['notes'] ?? null);

        ActivityLogger::log(Auth::id(), $punishment['household_id'], 'punishment.resolve', [
            'punishment_id' => $punishmentId,
        ]);

        return Response::success(null, 'Punishment resolved');
    }
}
