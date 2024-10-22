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
      return state.user.role === role
    },
    hasAnyRole: (state) => ['admin', 'manager'].some(role => state.user?.role === role),
    isAdmin: (state) => state.user?.role === 'admin',
    isManager: (state) => state.user?.role === 'manager'
  },

  actions: {
    async login(payload: LoginPayload): Promise<boolean> {
      try {
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
          this.isLoading = false
          router.push('/')
          return true
        } else {
          this.isLoading = false
          return false
        }
      } catch (error) {
        console.error(error)
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
      router.replace('/login')
    },
    async register(payload: RegisterPayload): Promise<any> {
      try {
        this.isLoading = true
        const response = await fetch({
          endpoint: '/registration',
          method: HttpMethod.POST,
          payload,
          withToken: false
        })

        const errors = await extractResponseErrors(response)

        this.isLoading = false
        return {
          ok: response.ok,
          errors
        }
      } catch (error) {
        this.isLoading = false
        console.error(error)
        return {
          ok: false,
          errors: null
        }
      }
    },
    async me() {
      try {
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
      } catch (error) {
        console.error(error)
        this.logout()
      }
    },
    async delete() {
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/users/${authStore.user?.id}`,
          method: HttpMethod.DELETE,
        })
        this.logout();
      } catch (error) {
        console.error('Error deleting user:', error);
      }
    },
    async updatePassword(password: string) {
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/users/${authStore.user?.id}`,
          method: HttpMethod.PUT,
          payload: {
            user: {
              password
            }
          }
        })
        const { data } = await response.json()
        this.user = data;
        console.log('Password updated');
      } catch (error) {
        console.error('Error updating password:', error);
      }
    },
    async updateUsername(username: string) {
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/users/${authStore.user?.id}`,
          method: HttpMethod.PUT,
          payload: {
            user: {
              username
            }
          }
        })
        this.me();
        console.log('Username updated');
      } catch (error) {
        console.error('Error updating username:', error);
      }
    }
  }
})
