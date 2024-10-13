import { defineStore } from 'pinia'
import type { user } from './user'
import { router } from '../router'

export const useAuthStore = defineStore('auth', {
  state: () => ({
    token: localStorage.getItem('token') || null,
    user: JSON.parse(localStorage.getItem('user') || 'null') as user | null,
    isLogged: localStorage.getItem('token') ? true : false
  }),

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
