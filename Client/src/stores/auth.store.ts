import { defineStore } from 'pinia'
import type { UserType } from '@/types'
import { router } from '../router'

interface LoginPayload {
  email: string
  password: string
}

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
    async login(payload: LoginPayload): Promise<boolean> {
      const response = await fetch('http://localhost:4000/api/auth', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(payload)
      })

      if (response.ok) {
        const data = await response.json()
        console.log(data)
        this.token = data.token
        this.user = data.user
        this.isLogged = true
        localStorage.setItem('token', this.token || '')
        localStorage.setItem('user', JSON.stringify(this.user))
        return true;
      } else {
        return false;
      }
    },
    async logout() {
      const response = await fetch('http://localhost:4000/api/auth/logout', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${this.token}`
        }
      })

      if (response.ok) {
        this.token = null
        this.user = null
        this.isLogged = false
        localStorage.removeItem('token')
        localStorage.removeItem('user')
        router.push('/login')
      }
    }
  }
})
