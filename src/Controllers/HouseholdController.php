<?php
/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 */

namespace Klaudie\Controllers;

use Klaudie\Models\Household;
use Klaudie\Services\Auth;
use Klaudie\Services\ActivityLogger;
use Klaudie\Response;

/**
 * Household controller
 * Manages households (Domina's domains)
 */
class HouseholdController
{
    /**
     * GET /api/households
     * List all households for current user
     */
    public function index(): string
    {
        $householdModel = new Household();

        if (Auth::isDomina()) {
            $households = $householdModel->getByDomina(Auth::id());
        } else {
            $households = $householdModel->getByServant(Auth::id());
        }

        return Response::success($households);
    }

    /**
     * POST /api/households
     * Create new household (Domina only)
     */
    public function create(): string
    {
        $data = json_decode(file_get_contents('php://input'), true);

        $errors = [];
        if (!isset($data['name']) || strlen($data['name']) < 2) {
            $errors['name'] = 'Name is required (min 2 characters)';
        }

        if (!empty($errors)) {
            return Response::validationError($errors);
        }

        $householdModel = new Household();
        $householdId = $householdModel->insert([
            'domina_id' => Auth::id(),
            'name' => $data['name'],
            'description' => $data['description'] ?? null,
        ]);

        ActivityLogger::log(Auth::id(), $householdId, 'household.create', [
            'name' => $data['name'],
        ]);

        return Response::success([
            'id' => $householdId,
        ], 'Household created', 201);
    }

    /**
     * GET /api/households/{id}
     * Get household details
     */
    public function show(int $id): string
    {
        $householdModel = new Household();
        $household = $householdModel->find($id);

        if (!$household) {
            return Response::notFound('Household not found');
        }

        // Check access
        if (Auth::isDomina() && !$householdModel->isOwner($id, Auth::id())) {
            return Response::forbidden();
        }

        if (Auth::isServant() && !$householdModel->isMember($id, Auth::id())) {
            return Response::forbidden();
        }

        // Add servants list
        $household['servants'] = $householdModel->getServants($id);

        return Response::success($household);
    }

    /**
     * PUT /api/households/{id}
     * Update household (Domina only)
     */
    public function update(int $id): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($id, Auth::id())) {
            return Response::forbidden();
        }

        $data = json_decode(file_get_contents('php://input'), true);

        $updateData = [];
        if (isset($data['name'])) {
            $updateData['name'] = $data['name'];
        }
        if (isset($data['description'])) {
            $updateData['description'] = $data['description'];
        }

        if (empty($updateData)) {
            return Response::error('No data to update');
        }

        $householdModel->update($id, $updateData);

        ActivityLogger::log(Auth::id(), $id, 'household.update', $updateData);

        return Response::success(null, 'Household updated');
    }

    /**
     * DELETE /api/households/{id}
     * Deactivate household (Domina only)
     */
    public function delete(int $id): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($id, Auth::id())) {
            return Response::forbidden();
        }

        $householdModel->update($id, ['is_active' => false]);

        ActivityLogger::log(Auth::id(), $id, 'household.delete', []);

        return Response::success(null, 'Household deactivated');
    }

    /**
     * POST /api/households/{id}/servants
     * Add servant to household (Domina only)
     */
    public function addServant(int $id): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($id, Auth::id())) {
            return Response::forbidden();
        }

        $data = json_decode(file_get_contents('php://input'), true);

        if (!isset($data['servant_id'])) {
            return Response::validationError(['servant_id' => 'Servant ID is required']);
        }

        $householdModel->addServant($id, $data['servant_id'], $data['notes'] ?? null);

        ActivityLogger::log(Auth::id(), $id, 'household.add_servant', [
            'servant_id' => $data['servant_id'],
        ]);

        return Response::success(null, 'Servant added to household');
    }

    /**
     * DELETE /api/households/{id}/servants/{servantId}
     * Remove servant from household (Domina only)
     */
    public function removeServant(int $id, int $servantId): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($id, Auth::id())) {
            return Response::forbidden();
        }

        $householdModel->removeServant($id, $servantId);

        ActivityLogger::log(Auth::id(), $id, 'household.remove_servant', [
            'servant_id' => $servantId,
        ]);

        return Response::success(null, 'Servant removed from household');
    }

    /**
     * PUT /api/households/{id}/regenerate-key
     * Regenerate household key (Domina only, invalidates old key)
     */
    public function regenerateKey(int $id): string
    {
        $householdModel = new Household();

        if (!$householdModel->isOwner($id, Auth::id())) {
            return Response::forbidden();
        }

        $newKey = $householdModel->regenerateKey($id);

        ActivityLogger::log(Auth::id(), $id, 'household.regenerate_key', []);

        return Response::success([
            'household_key' => $newKey,
        ], 'Household key regenerated');
    }
}
