import { createRouter, createWebHistory } from 'vue-router'

import WorkingTimes from '../components/WorkingTimes.vue'
import WorkingTime from '../components/WorkingTime.vue'
import ClockManager from '../components/ClockManager.vue'
import ChartManager from '../components/ChartManager.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/login',
      name: 'login',
      component: () => import('../views/auth/Login.vue')
    },
    {
      path: '/register',
      name: 'register',
      component: () => import('../views/auth/Register.vue')
    },
    {
      path: '/',
      name: 'dashboard',
      component: () => import('../views/DashboardView.vue')
    },
    {
      path: '/stats',
      name: 'stats',
      component: () => import('../views/StatsView.vue')
    },
    {
      path: '/settings',
      name: 'settings',
      component: () => import('../views/Settings.vue')
    },
    {
      path: '/teams',
      name: 'teams',
      component: () => import('../views/Teams.vue')
    },
    { path: '/workingTimes/:userID', component: WorkingTimes },
    { path: '/workingTime/:userid', component: WorkingTime },
    { path: '/workingTime/:userid/:workingtimeid', component: WorkingTime },
    { path: '/clock/:userid', component: ClockManager },
    { path: '/chartManager/:userid', component: ChartManager },
    {
      path: '/agenda',
      name: 'agenda',
      component: () => import('../views/Agenda.vue')
    }
  ]
})

export default router
