import { defineStore } from 'pinia';
import axios from 'axios';

import moment from 'moment';

const BACKEND_URL = 'http://localhost:4000';

export const useClockManagerStore = defineStore('clockManager', {
  state: () => ({
    userId: '',
    startDateTime: '',
    clockIn: false,
  }),

  actions: {
    setUserId(userId: string) {
      this.userId = userId;
    },
    async refresh(userId: string) {
      try {
        const response = await axios.get(`${BACKEND_URL}/clocks/${userId}`);
        const data = response.data;
      } catch (error) {
        console.error('Error refreshing clock data:', error);
      }
    },
    async clock(userId: string) {
      try {
        await axios.post(`${BACKEND_URL}/clocks/${userId}`);
      } catch (error) {
        console.error('Error toggling clock state:', error);
      }
    },
  },
});