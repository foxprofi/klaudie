<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Models\Household;
use Klaudie\Models\TaskAssignment;
use Klaudie\Models\Punishment;
use Klaudie\Services\Auth;
use Klaudie\Services\PointsService;
use Klaudie\Services\DominaProgressService;
use Klaudie\Response;

/**
 * Statistics controller
 * Dashboard and analytics
 */
class StatsController
{
    /**
     * GET /api/stats/dashboard
     * Get dashboard overview for current user
     */
    public function dashboard(): string
    {
        if (Auth::isDomina()) {
            return $this->dominaDashboard();
        } else {
            return $this->servantDashboard();
        }
    }

    /**
     * Domina dashboard
     */
    private function dominaDashboard(): string
    {
        $householdModel = new Household();
        $households = $householdModel->getByDomina(Auth::id());

        $stats = [
            'total_households' => count($households),
            'total_servants' => 0,
            'total_tasks' => 0,
            'pending_verifications' => 0,
            'recent_activities' => [],
            'progress' => [],
        ];

        foreach ($households as $household) {
            $servants = $householdModel->getServants($household['id']);
            $stats['total_servants'] += count($servants);

            $assignmentModel = new TaskAssignment();
            $pendingVerifications = $assignmentModel->getByHousehold($household['id'], 'completed');
            $stats['pending_verifications'] += count($pendingVerifications);

            // Get domina progress for this household (Power-Based System)
            $levelInfo = DominaProgressService::getLevelInfo(Auth::id(), $household['id']);
            $stats['progress'][] = [
                'household_id' => $household['id'],
                'household_name' => $household['name'],
                'level_info' => $levelInfo,
            ];
        }

        return Response::success($stats);
    }

    /**
     * Servant dashboard
     */
    private function servantDashboard(): string
    {
        $householdModel = new Household();
        $households = $householdModel->getByServant(Auth::id());

        $stats = [
            'households' => [],
        ];

        foreach ($households as $household) {
            $householdId = $household['id'];
            $dominaId = (int) $household['domina_id'];

            $assignmentModel = new TaskAssignment();
            $taskStats = $assignmentModel->getServantStats(Auth::id(), $householdId);

            // In Power-Based System, servant sees domina's level (not their own)
            $dominaLevelInfo = DominaProgressService::getLevelInfo($dominaId, $householdId);

            $punishmentModel = new Punishment();
            $punishmentStats = $punishmentModel->getServantStats(Auth::id(), $householdId);

            $stats['households'][] = [
                'household' => $household,
                'domina_level' => $dominaLevelInfo,
                'tasks' => $taskStats,
                'punishments' => $punishmentStats,
            ];
        }

        return Response::success($stats);
    }

    /**
     * GET /api/stats/servant/{servantId}/household/{householdId}
     * Get detailed stats for specific servant in household (Domina)
     */
    public function servantStats(int $servantId, int $householdId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($householdId, Auth::id())) {
            return Response::forbidden();
        }

        // In Power-Based System, servant has no points/level
        // Show only task and punishment statistics

        $assignmentModel = new TaskAssignment();
        $taskStats = $assignmentModel->getServantStats($servantId, $householdId);

        $punishmentModel = new Punishment();
        $punishmentStats = $punishmentModel->getServantStats($servantId, $householdId);

        // Get domina's level info as context
        $dominaLevelInfo = DominaProgressService::getLevelInfo(Auth::id(), $householdId);

        return Response::success([
            'domina_level' => $dominaLevelInfo,
            'tasks' => $taskStats,
            'punishments' => $punishmentStats,
        ]);
    }
}
