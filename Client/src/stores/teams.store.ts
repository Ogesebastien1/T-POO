import { fetch, HttpMethod } from '@/lib/proxy'
import type { UpdatedUserType, UserType } from '@/types'
import { defineStore } from 'pinia'

export const useTeamsStore = defineStore('teams', {
  state: () => ({
    teams: [] as any[]
  }),

  actions: {
    async create(payload: any): Promise<boolean> {
      try {
        const newTeam = { ...payload, id: Math.floor(Math.random() * 1000) }

        const response = await fetch({ endpoint: '/teams', method: HttpMethod.POST, payload })

        if (response.ok) {
          this.teams.push(newTeam)
          this.teams = [...this.teams]
          return true
        }

        return false
      } catch (error) {
        console.error('Error creating team:', error)
        return false
      }
    },

    async delete(id: string): Promise<boolean> {
      try {
        this.teams = [...this.teams.filter((user) => user.id !== id)]
        return true
      } catch (error) {
        console.error('Error deleting user:', error)
        return false;
      }
    }
  }
})
