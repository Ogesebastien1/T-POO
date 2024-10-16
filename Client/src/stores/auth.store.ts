import { defineStore } from 'pinia'
import type { UserType } from '@/types'
import { router } from '@/router'
import { fetch, HttpMethod } from '@/lib/proxy'

interface LoginPayload {
  email: string
  password: string
}

interface RegisterPayload {
  username: string
  email: string
  password: string
}

interface ResponseError {
  [key: string]: string[]
}

const extractResponseErrors = async (response: Response): Promise<ResponseError | null> => {
  if (response.status === 422) {
    const data = await response.json()
    return data.errors
  }

  return null
}

export const useAuthStore = defineStore('auth', {
  state: () => ({
    token: localStorage.getItem('token') || null,
    user: JSON.parse(localStorage.getItem('user') || 'null') as UserType | null,
    isLogged: localStorage.getItem('token') ? true : false,
    isLoading: false
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
      this.isLoading = true
      const response = await fetch({
        endpoint: '/auth',
        method: HttpMethod.POST,
        payload,
        withToken: false
      })

      if (response.ok) {
        const data = await response.json()
        this.token = data.token
        this.user = data.user
        this.isLogged = true
        localStorage.setItem('token', this.token || '')
        localStorage.setItem('user', JSON.stringify(this.user))
        // console.log(data, "Set isLoading to false")
        this.isLoading = false
        router.push('/')
        return true
      } else {
        this.isLoading = false
        return false
      }
    },
    async logout() {
      this.token = null
      this.user = null
      this.isLogged = false
      localStorage.removeItem('token')
      localStorage.removeItem('user')
      router.push('/login')
    },
    async register(payload: RegisterPayload): Promise<any> {
      const response = await fetch({
        endpoint: '/registration',
        method: HttpMethod.POST,
        payload,
        withToken: false
      })

      const errors = await extractResponseErrors(response)

      return {
        ok: response.ok,
        errors
      }
    },
    async me() {
      this.isLoading = true
      const response = await fetch({
        endpoint: '/auth/me',
        method: HttpMethod.GET,
        payload: null,
        withToken: true
      })

      if (response.ok) {
        const data = await response.json()
        this.user = data.user
        this.token = data.token
        localStorage.setItem('token', this.token || '')
        localStorage.setItem('user', JSON.stringify(this.user))
        this.isLoading = false
      } else {
        this.logout()
      }
    }
  }
})
