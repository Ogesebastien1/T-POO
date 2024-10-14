import { defineStore } from 'pinia'
import type { UserType } from '@/types'
import { router } from '../router'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    token: localStorage.getItem('token') || null,
    user: JSON.parse(localStorage.getItem('user') || 'null') as UserType | null,
    isLogged: localStorage.getItem('token') ? true : false
  }),

  getters: {
    isLoggedIn: (state): boolean => state.isLogged,
    hasRole: (state) => (role: 'admin' | 'manager') => {
      if (!state.user) return false
      if (role === 'admin') return state.user.is_admin
      if (role === 'manager') return state.user.is_manager
    },
    hasAnyRole: (state) => state.user?.is_admin || state.user?.is_manager,
    isAdmin: (state) => state.user?.is_admin || false,
    isManager: (state) => state.user?.is_manager || false
  },

  actions: {
    fakeLogin(email: string) {
      this.user = {
        id: 1,
        username: 'John Doe',
        is_manager: false,
        is_admin: false,
        email
      }
      this.token = 'fakeToken'
      this.isLogged = true

      console.log('User logged in')

      localStorage.setItem('user', JSON.stringify(this.user))
      localStorage.setItem('token', this.token)
      router.push('/')
    },
    fakeLogout() {
      this.user = null
      this.token = null
      this.isLogged = false
      localStorage.removeItem('user')
      localStorage.removeItem('token')
      router.push('/login')
    }
  }
})
