<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Models\Household;
use Klaudie\Services\Auth;
use Klaudie\Services\AchievementService;
use Klaudie\Response;

/**
 * Achievement Controller
 * Správa achievementů (pouze domina)
 */
class AchievementController
{
    /**
     * GET /api/households/{householdId}/achievements
     * Získat všechny achievementy s statusem (odemčené/zamčené)
     */
    public function index(int $householdId): string
    {
        $householdModel = new Household();

        // Ověřit přístup
        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden('You are not the owner of this household');
        }

        $achievements = AchievementService::getAllAchievementsWithStatus(Auth::id(), $householdId);

        return Response::success($achievements);
    }

    /**
     * GET /api/households/{householdId}/achievements/unlocked
     * Získat pouze odemčené achievementy
     */
    public function unlocked(int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden('You are not the owner of this household');
        }

        $achievements = AchievementService::getUnlockedAchievements(Auth::id(), $householdId);

        return Response::success($achievements);
    }
}
