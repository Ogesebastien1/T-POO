import { fetch } from '@/lib/proxy'
import type { UpdatedUserType, UserType } from '@/types'
import { defineStore } from 'pinia'

export const useTeamsStore = defineStore('teams', {
  state: () => ({
    teams: [] as any[]
  }),

  actions: {
    async create(payload: any) {
      try {
        const newTeam = { ...payload, id: Math.floor(Math.random() * 1000) }
        this.teams.push(newTeam)
        this.teams = [...this.teams] // Nouvelle instance du tableau
      } catch (error) {
        console.error('Error creating team:', error)
      }
    },

    async delete(id: string) {
      try {
        this.teams = [...this.teams.filter((user) => user.id !== id)]
      } catch (error) {
        console.error('Error deleting user:', error)
      }
    }
  }
})
