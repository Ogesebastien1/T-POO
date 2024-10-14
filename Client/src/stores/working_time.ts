import axios from 'axios';
import { defineStore } from 'pinia';
import type { CreatedWorkingTime, UpdatedWorkingTime } from '@/types';

const BACKEND_URL = 'http://localhost:4000/api';

export const useWorkingTimeStore = defineStore('workingTime', {
  state: () => ({
    workingTimes: [] as any[],
  }),
  actions: {
    async getWorkingTimes(userId: string, startTime: string, endTime: string) {
      try {
        const { data } = await axios.get(`${BACKEND_URL}/workingtimes/${userId}`, {
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
    async createWorkingTime(createdWorkingTime: CreatedWorkingTime) {
      try {
        const { data } = await axios.post(`${BACKEND_URL}/workingtimes/${createdWorkingTime.userID}`, createdWorkingTime, {
          headers: {
            'Content-Type': 'application/json',
          },
        });
      } catch (error) {
        console.error('Error creating working time:', error);
      }
    },

    async updateWorkingTime(updatedWorkingTime: UpdatedWorkingTime) {
      try {
        const { data } = await axios.put(`${BACKEND_URL}/workingtimes/${updatedWorkingTime.id}`, updatedWorkingTime, {
          headers: {
            'Content-Type': 'application/json',
          },
        });
      } catch (error) {
        console.error('Error updating working time:', error);
      }
    },

    async deleteWorkingTime(workingTimeId: string) {
      try {
        await axios.delete(`${BACKEND_URL}/workingtimes/${workingTimeId}`, {
          headers: {
            'Content-Type': 'application/json',
          },
        });
      } catch (error) {
        console.error('Error deleting working time:', error);
      }
    },
  },
});