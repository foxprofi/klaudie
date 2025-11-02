/**
 * @Author: Klaudie <klaudie@foxprofi.cz>
 *
 * Klaudie - Frontend Application
 */

// Configuration
const API_BASE = '/api';

// Global state
const State = {
    user: null,
    currentView: 'dashboard',
    households: [],
    currentHousehold: null,
};

// API Client
const API = {
    async request(endpoint, options = {}) {
        const url = `${API_BASE}${endpoint}`;
        const config = {
            headers: {
                'Content-Type': 'application/json',
                ...options.headers,
            },
            ...options,
        };

        if (config.body && typeof config.body === 'object') {
            config.body = JSON.stringify(config.body);
        }

        UI.showLoading();

        try {
            const response = await fetch(url, config);
            const data = await response.json();

            UI.hideLoading();

            if (!response.ok) {
                throw new Error(data.error || 'Request failed');
            }

            return data;
        } catch (error) {
            UI.hideLoading();
            throw error;
        }
    },

    // Auth endpoints
    login(email, password) {
        return this.request('/auth/login', {
            method: 'POST',
            body: { email, password },
        });
    },

    register(email, password, display_name, role) {
        return this.request('/auth/register', {
            method: 'POST',
            body: { email, password, display_name, role },
        });
    },

    logout() {
        return this.request('/auth/logout', { method: 'POST' });
    },

    getMe() {
        return this.request('/auth/me');
    },

    // Dashboard
    getDashboard() {
        return this.request('/stats/dashboard');
    },

    // Households
    getHouseholds() {
        return this.request('/households');
    },

    createHousehold(name, description) {
        return this.request('/households', {
            method: 'POST',
            body: { name, description },
        });
    },

    getHousehold(id) {
        return this.request(`/households/${id}`);
    },

    // Tasks
    getMyAssignments() {
        return this.request('/assignments/my');
    },

    completeAssignment(assignmentId, notes) {
        return this.request(`/assignments/${assignmentId}/complete`, {
            method: 'PUT',
            body: { notes },
        });
    },

    getHouseholdTasks(householdId) {
        return this.request(`/households/${householdId}/tasks`);
    },

    createTask(householdId, data) {
        return this.request(`/households/${householdId}/tasks`, {
            method: 'POST',
            body: data,
        });
    },

    assignTask(taskId, servantId, dueDate) {
        return this.request(`/tasks/${taskId}/assign`, {
            method: 'POST',
            body: { servant_id: servantId, due_date: dueDate },
        });
    },

    verifyTask(assignmentId, approved, notes) {
        return this.request(`/assignments/${assignmentId}/verify`, {
            method: 'PUT',
            body: { approved, notes },
        });
    },

    // Password
    changePassword(currentPassword, newPassword) {
        return this.request('/auth/change-password', {
            method: 'PUT',
            body: { current_password: currentPassword, new_password: newPassword },
        });
    },

    // Punishments
    getMyPunishments(householdId) {
        return this.request('/my-punishments', {
            method: 'GET',
            body: { household_id: householdId },
        });
    },

    getHouseholdPunishments(householdId) {
        return this.request(`/households/${householdId}/punishments`);
    },

    issuePunishment(householdId, servantId, reason, severity) {
        return this.request(`/households/${householdId}/punishments`, {
            method: 'POST',
            body: { servant_id: servantId, reason, severity },
        });
    },
};

// UI Management
const UI = {
    showLoading() {
        document.getElementById('loading').classList.remove('hidden');
    },

    hideLoading() {
        document.getElementById('loading').classList.add('hidden');
    },

    showScreen(screenId) {
        document.querySelectorAll('.screen').forEach(screen => {
            screen.classList.remove('active');
        });
        document.getElementById(screenId).classList.add('active');
    },

    showView(viewId) {
        document.querySelectorAll('.view').forEach(view => {
            view.classList.remove('active');
        });
        document.getElementById(`view-${viewId}`).classList.add('active');

        document.querySelectorAll('.nav-link').forEach(link => {
            link.classList.remove('active');
        });
        document.querySelector(`[data-view="${viewId}"]`)?.classList.add('active');

        State.currentView = viewId;
    },

    showError(elementId, message) {
        const errorEl = document.getElementById(elementId);
        errorEl.textContent = message;
        errorEl.classList.add('show');
    },

    hideError(elementId) {
        const errorEl = document.getElementById(elementId);
        errorEl.classList.remove('show');
    },

    showModal(modalId) {
        document.getElementById('modal-overlay').classList.remove('hidden');
        document.getElementById(modalId).classList.remove('hidden');
    },

    closeModal() {
        document.getElementById('modal-overlay').classList.add('hidden');
        document.querySelectorAll('.modal').forEach(modal => modal.classList.add('hidden'));
    },

    renderDashboard(data) {
        const container = document.getElementById('dashboard-content');

        if (State.user.role === 'domina') {
            container.innerHTML = `
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-value">${data.total_households}</div>
                        <div class="stat-label">Domácnosti</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">${data.total_servants}</div>
                        <div class="stat-label">Servanti</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">${data.pending_verifications}</div>
                        <div class="stat-label">Čekající verifikace</div>
                    </div>
                </div>
            `;
        } else {
            // Servant dashboard
            let html = '';
            data.households.forEach(item => {
                const household = item.household;
                const level = item.level;
                const tasks = item.tasks;

                html += `
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">${household.name}</div>
                        </div>
                        <div class="card-body">
                            <div class="level-info">
                                <strong>Level ${level.current_level}</strong> - ${level.total_points} bodů
                                <div class="level-bar">
                                    <div class="level-progress" style="width: ${level.progress_percentage}%"></div>
                                </div>
                                <small>${level.points_to_next_level} bodů do dalšího levelu</small>
                            </div>
                            <div class="stats-grid">
                                <div>
                                    <strong>${tasks.completed || 0}</strong> dokončeno
                                </div>
                                <div>
                                    <strong>${tasks.pending || 0}</strong> čekající
                                </div>
                                <div>
                                    <strong>${tasks.failed || 0}</strong> selhání
                                </div>
                            </div>
                        </div>
                    </div>
                `;
            });
            container.innerHTML = html;
        }
    },

    renderHouseholds(households) {
        const container = document.getElementById('households-list');

        if (households.length === 0) {
            container.innerHTML = '<p class="text-center">Žádné domácnosti</p>';
            return;
        }

        let html = '';
        households.forEach(household => {
            html += `
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">${household.name}</div>
                    </div>
                    <div class="card-body">
                        <p>${household.description || 'Bez popisu'}</p>
                    </div>
                </div>
            `;
        });

        container.innerHTML = html;
    },

    renderTasks(tasks) {
        const container = document.getElementById('tasks-list');

        if (tasks.length === 0) {
            container.innerHTML = '<p class="text-center">Žádné úkoly</p>';
            return;
        }

        let html = '';
        tasks.forEach(task => {
            const statusClass = task.status === 'completed' ? 'success' :
                              task.status === 'failed' ? 'danger' : 'warning';

            html += `
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">${task.title}</div>
                        <span class="badge badge-${statusClass}">${task.status}</span>
                    </div>
                    <div class="card-body">
                        <p>${task.description || 'Bez popisu'}</p>
                        <p><strong>Body:</strong> ${task.points_reward}</p>
                        ${task.due_date ? `<p><strong>Termín:</strong> ${new Date(task.due_date).toLocaleString('cs')}</p>` : ''}
                        ${task.status === 'pending' ? `
                            <button class="btn btn-primary mt-2" onclick="App.completeTask(${task.id})">
                                Označit jako hotové
                            </button>
                        ` : ''}
                    </div>
                </div>
            `;
        });

        container.innerHTML = html;
    },
};

// Application
const App = {
    async init() {
        // Check if already logged in
        try {
            const response = await API.getMe();
            if (response.success) {
                State.user = response.data;
                this.showDashboard();
                return;
            }
        } catch (error) {
            // Not logged in, show auth screen
        }

        this.initAuthHandlers();
    },

    initAuthHandlers() {
        // Tab switching
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const tab = e.target.dataset.tab;

                document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                e.target.classList.add('active');

                document.querySelectorAll('.auth-form').forEach(form => form.classList.add('hidden'));
                document.getElementById(`${tab}-form`).classList.remove('hidden');
            });
        });

        // Login form
        document.getElementById('login-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            UI.hideError('login-error');

            const formData = new FormData(e.target);
            const email = formData.get('email');
            const password = formData.get('password');

            try {
                const response = await API.login(email, password);
                if (response.success) {
                    State.user = response.data.user;
                    this.showDashboard();
                }
            } catch (error) {
                UI.showError('login-error', error.message);
            }
        });

        // Register form
        document.getElementById('register-form').addEventListener('submit', async (e) => {
            e.preventDefault();
            UI.hideError('register-error');

            const formData = new FormData(e.target);
            const email = formData.get('email');
            const password = formData.get('password');
            const display_name = formData.get('display_name');
            const role = formData.get('role');

            try {
                const response = await API.register(email, password, display_name, role);
                if (response.success) {
                    State.user = response.data.user;
                    this.showDashboard();
                }
            } catch (error) {
                UI.showError('register-error', error.message);
            }
        });
    },

    async showDashboard() {
        UI.showScreen('dashboard-screen');

        // Update user info
        document.getElementById('user-name').textContent = State.user.display_name;
        document.getElementById('user-role').textContent = State.user.role;

        // Show/hide UI based on role
        if (State.user.role === 'domina') {
            document.getElementById('btn-create-household').classList.remove('hidden');
        } else {
            document.getElementById('nav-punishments').textContent = 'Moje tresty';
        }

        // Initialize dashboard handlers
        this.initDashboardHandlers();

        // Load initial data
        await this.loadDashboard();
    },

    initDashboardHandlers() {
        // Logout
        document.getElementById('logout-btn').addEventListener('click', async () => {
            try {
                await API.logout();
                State.user = null;
                UI.showScreen('auth-screen');
            } catch (error) {
                console.error('Logout failed:', error);
            }
        });

        // Change password button
        document.getElementById('btn-change-password').addEventListener('click', () => {
            UI.showModal('modal-change-password');
        });

        // Create household button
        const createHouseholdBtn = document.getElementById('btn-create-household');
        if (createHouseholdBtn) {
            createHouseholdBtn.addEventListener('click', () => {
                UI.showModal('modal-create-household');
            });
        }

        // Modal overlay click to close
        document.getElementById('modal-overlay').addEventListener('click', (e) => {
            if (e.target.id === 'modal-overlay') {
                this.closeModal();
            }
        });

        // Create household form
        document.getElementById('form-create-household').addEventListener('submit', async (e) => {
            e.preventDefault();
            UI.hideError('create-household-error');

            const formData = new FormData(e.target);
            const name = formData.get('name');
            const description = formData.get('description');

            try {
                const response = await API.createHousehold(name, description);
                if (response.success) {
                    UI.closeModal();
                    e.target.reset();
                    await this.loadHouseholds();
                    alert('Domácnost vytvořena!');
                }
            } catch (error) {
                UI.showError('create-household-error', error.message);
            }
        });

        // Change password form
        document.getElementById('form-change-password').addEventListener('submit', async (e) => {
            e.preventDefault();
            UI.hideError('change-password-error');

            const formData = new FormData(e.target);
            const currentPassword = formData.get('current_password');
            const newPassword = formData.get('new_password');
            const confirmPassword = formData.get('confirm_password');

            if (newPassword !== confirmPassword) {
                UI.showError('change-password-error', 'Hesla se neshodují');
                return;
            }

            try {
                const response = await API.changePassword(currentPassword, newPassword);
                if (response.success) {
                    UI.closeModal();
                    e.target.reset();
                    alert('Heslo bylo změněno!');
                }
            } catch (error) {
                UI.showError('change-password-error', error.message);
            }
        });

        // Navigation
        document.querySelectorAll('[data-view]').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const view = e.target.dataset.view;
                this.loadView(view);
            });
        });
    },

    async loadDashboard() {
        try {
            const response = await API.getDashboard();
            if (response.success) {
                UI.renderDashboard(response.data);
            }
        } catch (error) {
            console.error('Failed to load dashboard:', error);
        }
    },

    async loadView(view) {
        UI.showView(view);

        switch (view) {
            case 'dashboard':
                await this.loadDashboard();
                break;
            case 'households':
                await this.loadHouseholds();
                break;
            case 'tasks':
                await this.loadTasks();
                break;
            case 'punishments':
                await this.loadPunishments();
                break;
        }
    },

    async loadHouseholds() {
        try {
            const response = await API.getHouseholds();
            if (response.success) {
                State.households = response.data;
                UI.renderHouseholds(response.data);
            }
        } catch (error) {
            console.error('Failed to load households:', error);
        }
    },

    async loadTasks() {
        try {
            if (State.user.role === 'servant') {
                const response = await API.getMyAssignments();
                if (response.success) {
                    UI.renderTasks(response.data);
                }
            }
        } catch (error) {
            console.error('Failed to load tasks:', error);
        }
    },

    async loadPunishments() {
        // Implementation for punishments view
    },

    async completeTask(assignmentId) {
        try {
            const notes = prompt('Poznámky k dokončení úkolu (volitelné):');
            const response = await API.completeAssignment(assignmentId, notes);
            if (response.success) {
                alert('Úkol označen jako dokončený! Čeká se na verifikaci.');
                await this.loadTasks();
            }
        } catch (error) {
            alert('Chyba: ' + error.message);
        }
    },

    closeModal() {
        UI.closeModal();
    },
};

// Initialize application
document.addEventListener('DOMContentLoaded', () => {
    App.init();
});
