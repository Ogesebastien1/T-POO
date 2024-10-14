import { defineStore } from 'pinia';
import axios from 'axios';
import type { CreatedClockType, CreatedClock } from '@/types';
import moment from 'moment';
import { set } from 'zod';

const BACKEND_URL = 'http://localhost:4000/api';

export const useClockManagerStore = defineStore('clockManager', {
  state: () => ({
    clocks: [] as any[],
  }),
  getters: {
    getClocks: (state) => state.clocks,
  },
  actions: {
    async getAllClocks(userId: string) {
      try { 
        const response = await axios.get(`${BACKEND_URL}/clocks/${userId}`);
        this.clocks = response.data.data;
      } catch (error) {
        console.error('Error fetching all clocks :', error);
      }
    },
    async clock(userId: string, createdClock: CreatedClockType) {
      try {
        await axios.post(`${BACKEND_URL}/clocks/${userId}`, createdClock);
      } catch (error) {
        console.error('Error creating a clock state:', error);
      }
    },
  },
});