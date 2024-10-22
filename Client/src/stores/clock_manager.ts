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
          endpoint: `/clocks`,
          method: HttpMethod.GET,
        });
        const { data } = await response.json();
        this.clocks = data;
      } catch (error) {
        console.error('Error fetching all clocks:', error);
      }
    },
    async getClocksByUser() {
      const authStore = useAuthStore();
      try { 
        const response = await fetch({
          endpoint: `/clocks/${authStore.user?.id}`,
          method: HttpMethod.GET,
        });
        const { data } = await response.json();
        this.clocks = data;
      } catch (error) {
        console.error('Error fetching clocks by user:', error);
      }
    },
    async clock() {
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/clocks/`,
          method: HttpMethod.POST,
          payload: { user_id: authStore.user?.id },
        });
        this.getAllClocks();
      } catch (error) {
        console.error('Error creating a clock state:', error);
      }
    },
    async getWeekstats() { 
      const authStore = useAuthStore();
      try {
        const response = await fetch({
          endpoint: `/clocks/week_stats/${authStore.user?.id}`,
          method: HttpMethod.GET,
        });
        const { data } = await response.json();
        console.log(data);
      } catch (error) {
        console.error('Error fetching week stats:', error);
      }
    },
  },
});