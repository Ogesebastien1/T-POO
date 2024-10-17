import { defineStore } from 'pinia';
import axios from 'axios';
import type { CreatedClockType, CreatedClock } from '@/types';
import moment from 'moment';
import { set } from 'zod';
import { useAuthStore } from '@/stores';
import { fetch, HttpMethod } from '@/lib/proxy';

export const useClockManagerStore = defineStore('clockManager', {
  state: () => ({
    clocks: [] as any[],
  }),
  actions: {
    async getAllClocks() {
    const authStore = useAuthStore();
      try { 
        const response = await fetch({
          endpoint: `/clocks/${authStore.user?.id}`,
        })
        const { data } = await response.json()
        this.clocks = data;
      } catch (error) {
        console.error('Error fetching all clocks :', error);
      }
    },
    async clock(createdClock: CreatedClockType) {
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/clocks/${authStore.user?.id}`,
          method: HttpMethod.POST,
          payload: {
            clock: {
              ...createdClock,
              user_id: authStore.user?.id,
            }
          }
        })
        const { data } = await response.json()
        this.clocks.push(data);
      } catch (error) {
        console.error('Error creating a clock state:', error);
      }
    },
  },
});