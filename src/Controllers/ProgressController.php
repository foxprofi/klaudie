<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Models\Household;
use Klaudie\Services\Auth;
use Klaudie\Services\DominaProgressService;
use Klaudie\Response;

/**
 * Progress Controller - Power-Based System
 * Domina progression tracking (level, points, Power Index)
 */
class ProgressController
{
    /**
     * GET /api/households/{householdId}/progress
     * Získat progress info dominy v household
     */
    public function getDominaProgress(int $householdId): string
    {
        $householdModel = new Household();
        $household = $householdModel->findById($householdId);

        if (!$household) {
            return Response::notFound('Household not found');
        }

        // Ověřit, že user patří do household (domina jako owner nebo servant jako member)
        $userId = Auth::id();
        $role = Auth::role();

        if ($role === 'domina') {
            if (!$householdModel->isOwner($householdId, $userId)) {
                return Response::forbidden('You are not the owner of this household');
            }
            $dominaId = $userId;
        } else {
            // Servant - zkontrolovat, že je členem household
            if (!$householdModel->isMember($householdId, $userId)) {
                return Response::forbidden('You are not a member of this household');
            }
            // Získat ID dominy z household
            $dominaId = (int) $household['domina_id'];
        }

        // Získat level info dominy
        $levelInfo = DominaProgressService::getLevelInfo($dominaId, $householdId);

        return Response::success([
            'domina_id' => $dominaId,
            'household_id' => $householdId,
            'progress' => $levelInfo,
        ]);
    }
}
