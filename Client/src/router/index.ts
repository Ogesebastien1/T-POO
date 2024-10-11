import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

import WorkingTimes from '../components/WorkingTimes.vue'
import WorkingTime from '../components/WorkingTime.vue'
import ClockManager from '../components/ClockManager.vue'
import ChartManager from '../components/ChartManager.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue')
    },
    { path: '/workingTimes/:userID', component: WorkingTimes },
    { path: '/workingTime/:userid', component: WorkingTime },
    { path: '/workingTime/:userid/:workingtimeid', component: WorkingTime },
    { path: '/clock/:userid', component: ClockManager },
    { path: '/chartManager/:userid', component: ChartManager },
  ]
})

export default router
