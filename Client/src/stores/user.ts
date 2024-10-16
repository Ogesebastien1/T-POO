import type { CreatedUserType, UpdatedUserType, UserType } from '@/types';
import axios from 'axios';
import { defineStore } from 'pinia';
import { useAuthStore } from '@/stores';
import { fetch, HttpMethod } from '@/lib/proxy';

const BACKEND_URL = 'http://localhost:4000/api';

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null as UserType | null,
  }),

  actions: {
    async createUser(userData: CreatedUserType) {
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/users`,
          method: HttpMethod.POST,
          payload: userData,
        })
        const { data } = await response.json()
        this.user = data;
      } catch (error) {
        console.error('Error creating user:', error);
      }
    },

    async updateUser(user: UpdatedUserType) {
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/users/${authStore.user?.id}`,
          method: HttpMethod.PUT,
          payload: user,
        })
        const { data } = await response.json()
        this.user = data;
      } catch (error) {
        console.error('Error updating user:', error);
      }
    },

    async deleteUser() {
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/users/${authStore.user?.id}`,
          method: HttpMethod.DELETE,
        })
        this.user = null;
      } catch (error) {
        console.error('Error deleting user:', error);
      }
    },

    async getUser() {
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/users/${authStore.user?.id}`,
        })
        const { data } = await response.json()
        this.user = data;
      } catch (error) {
        console.error('Error fetching user:', error);
      }
    },
  },
});