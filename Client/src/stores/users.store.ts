import { fetch, HttpMethod } from '@/lib/proxy'
import { useAuthStore } from '@/stores'
import type { UpdatedUserType, UserType } from '@/types'
import { defineStore } from 'pinia'

export const useUsersStore = defineStore('users', {
  state: () => ({
    user: null as UserType | null,
    users: [] as UserType[]
  }),

  actions: {
    async create(payload: UserType) {
      try {
        // const response = await fetch({
        //   endpoint: '/users',
        //   method: HttpMethod.POST,
        //   payload: {
        //     user: payload
        //   }
        // })

        // const { data } = await response.json()
        this.users.push({ ...payload, id: Math.floor(Math.random() * 1000) } as UserType)
      } catch (error) {
        console.error('Error creating user:', error)
      }
    },

    async update(id: string, payload: any) {
      try {
        // const response = await fetch({
        //   endpoint: `/users/${id}`,
        //   method: HttpMethod.PUT,
        //   payload
        // })

        this.users = this.users.map((user) => {
          if (user.id.toString() === id.toString()) {
            return { ...user, ...payload } as UpdatedUserType
          }

          return user
        }) as UserType[]
      } catch (error) {
        console.error('Error updating user:', error)
      }
    },

    async delete(id: string) {
      try {
        // const response = await fetch({
        //   endpoint: `/users/${id}`,
        //   method: HttpMethod.DELETE,
        // })

        console.log(
          'Deleted user:',
          id,
          this.users.filter((user) => user.id.toString() !== id.toString())
        )
        this.users = this.users.filter((user) => user.id.toString() !== id.toString())
      } catch (error) {
        console.error('Error deleting user:', error)
      }
    },

    async getUser() {
      try {
        const authStore = useAuthStore()

        // const { data } = await axios.get(`${BACKEND_URL}/users/${authStore.user?.id}`, {
        //   headers: {
        //     'Content-Type': 'application/json'
        //   }
        // })
        // this.user = data
      } catch (error) {
        console.error('Error fetching user:', error)
      }
    },

    async getUsers(): Promise<any> {
      try {
        const response = await fetch({
          endpoint: '/users'
        })
        const { data } = await response.json()
        console.log(data)
        this.users = data
      } catch (error) {
        console.error('Error fetching users:', error)
      }
    }
  }
})
