<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Models\Household;
use Klaudie\Services\Auth;
use Klaudie\Services\PenaltyService;
use Klaudie\Response;

/**
 * Penalty controller
 * Manual penalties for rule violations and disrespect
 */
class PenaltyController
{
    /**
     * POST /api/households/{householdId}/penalties/rule-violation
     * Apply manual penalty for rule violation (Domina only)
     * -20 points
     */
    public function ruleViolation(int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden('You are not the owner of this household');
        }

        $data = json_decode(file_get_contents('php://input'), true);

        $errors = [];
        if (!isset($data['servant_id'])) {
            $errors['servant_id'] = 'Servant ID is required';
        }
        if (!isset($data['reason']) || strlen($data['reason']) < 3) {
            $errors['reason'] = 'Reason is required (min 3 characters)';
        }

        if (!empty($errors)) {
            return Response::validationError($errors);
        }

        // Verify servant is member of household
        if (!$householdModel->isMember($householdId, $data['servant_id'])) {
            return Response::error('Servant is not member of this household');
        }

        PenaltyService::applyRuleViolationPenalty(
            Auth::id(),
            $householdId,
            $data['servant_id'],
            $data['reason']
        );

        return Response::success(null, 'Rule violation penalty applied (-20 points)');
    }

    /**
     * POST /api/households/{householdId}/penalties/disrespect
     * Apply manual penalty for disrespect/argument (Domina only)
     * -50 points
     */
    public function disrespect(int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden('You are not the owner of this household');
        }

        $data = json_decode(file_get_contents('php://input'), true);

        $errors = [];
        if (!isset($data['servant_id'])) {
            $errors['servant_id'] = 'Servant ID is required';
        }
        if (!isset($data['reason']) || strlen($data['reason']) < 3) {
            $errors['reason'] = 'Reason is required (min 3 characters)';
        }

        if (!empty($errors)) {
            return Response::validationError($errors);
        }

        // Verify servant is member of household
        if (!$householdModel->isMember($householdId, $data['servant_id'])) {
            return Response::error('Servant is not member of this household');
        }

        PenaltyService::applyDisrespectPenalty(
            Auth::id(),
            $householdId,
            $data['servant_id'],
            $data['reason']
        );

        return Response::success(null, 'Disrespect penalty applied (-50 points)');
    }

    /**
     * GET /api/households/{householdId}/penalties/stats
     * Get penalty statistics for household (Domina only)
     */
    public function stats(int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden('You are not the owner of this household');
        }

        $stats = PenaltyService::getPenaltyStats($householdId);

        return Response::success($stats);
    }
}
