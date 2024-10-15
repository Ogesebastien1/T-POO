import type { CreatedUserType, UpdatedUserType, UserType } from '@/types'
import axios from 'axios'
import { defineStore } from 'pinia'
import { fetch } from '@/lib/proxy'
import { useAuthStore } from '@/stores'

const BACKEND_URL = 'http://localhost:4000/api'

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null as UserType | null,
    users: [] as UserType[]
  }),

  actions: {
    async createUser(userData: CreatedUserType) {
      try {
        const { data } = await axios.post(`${BACKEND_URL}/users`, userData, {
          headers: {
            'Content-Type': 'application/json'
          }
        })
        this.user = data
      } catch (error) {
        console.error('Error creating user:', error)
      }
    },

    async updateUser(user: UpdatedUserType) {
      try {
        const { data } = await axios.put(`${BACKEND_URL}/users/${user.id}`, user, {
          headers: {
            'Content-Type': 'application/json'
          }
        })
        this.user = data
      } catch (error) {
        console.error('Error updating user:', error)
      }
    },

    async deleteUser(userId: string) {
      try {
        await axios.delete(`${BACKEND_URL}/users/${userId}`, {
          headers: {
            'Content-Type': 'application/json'
          }
        })
        this.user = null
      } catch (error) {
        console.error('Error deleting user:', error)
      }
    },

    async getUser() {
      try {
        const authStore = useAuthStore()

        const { data } = await axios.get(`${BACKEND_URL}/users/${authStore.user?.id}`, {
          headers: {
            'Content-Type': 'application/json'
          }
        })
        this.user = data
      } catch (error) {
        console.error('Error fetching user:', error)
      }
    },

    async getUsers(): Promise<any> {
      try {
        const response = await fetch({
          endpoint: '/users',
        });
        const { data } = await response.json()
        console.log(data)
        this.users = data
      } catch (error) {
        console.error('Error fetching users:', error)
      }
    }
  }
})
