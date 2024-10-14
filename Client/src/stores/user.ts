import type { CreatedUserType, UpdatedUserType, UserType } from '@/types';
import axios from 'axios';
import { defineStore } from 'pinia';

const BACKEND_URL = 'http://localhost:4000';

export const useUserStore = defineStore('user', {
  state: () => ({
    user: null as UserType | null,
  }),

  actions: {
    async createUser(userData: CreatedUserType) {
      try {
        const { data } = await axios.post(`${BACKEND_URL}/api/users`, userData, {
          headers: {
            'Content-Type': 'application/json',
          },
        });
        this.user = data;
      } catch (error) {
        console.error('Error creating user:', error);
      }
    },

    async updateUser(user: UpdatedUserType) {
      try {
        const { data } = await axios.put(`${BACKEND_URL}/api/users/${user.id}`, user, {
          headers: {
            'Content-Type': 'application/json',
          },
        });
        this.user = data;
      } catch (error) {
        console.error('Error updating user:', error);
      }
    },

    async deleteUser(userId: string) {
      try {
        await axios.delete(`${BACKEND_URL}/api/users/${userId}`, {
          headers: {
            'Content-Type': 'application/json',
          },
        });
        this.user = null;
      } catch (error) {
        console.error('Error deleting user:', error);
      }
    },

    async getUser(userId: string) {
      try {
        const { data } = await axios.get(`${BACKEND_URL}/api/users/${userId}`, {
          headers: {
            'Content-Type': 'application/json',
          },
        });
        this.user = data;
      } catch (error) {
        console.error('Error fetching user:', error);
      }
    },
  },
});