import axios from 'axios';
import { defineStore } from 'pinia';

const BACKEND_URL = 'http://localhost:4000';

export const useWorkingTimesStore = defineStore('workingTimes', {
  state: () => ({
    userId: '',
    workingTimes: [] as any[],
  }),

  actions: {
    async getWorkingTimes(userId: string, startTime: string, endTime: string) {
      try {
        const { data } = await axios.get(`${BACKEND_URL}/api/workingtimes/${userId}`, {
            params: {
              start_time: startTime,
              end_time: endTime,
            },
            headers: {
              'Content-Type': 'application/json',
            },
          });
          this.workingTimes = data;
      } catch (error) {
        console.error('Error fetching working times:', error);
      }
    },
  },
});