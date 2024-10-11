import axios from 'axios';
import { defineStore } from 'pinia';



const BACKEND_URL = 'http://localhost:4000';

export type createdWorkingTime = {
  userID: string;
  working_time: {
    end: string;
    start: string;
  }
};

export type updatedWorkingTime = {
  id: string;
  working_time: {
    end_time: string;
    start_time: string;
  }
};

export const useWorkingTimeStore = defineStore('workingTime', {  
    actions: {  
      async createWorkingTime(createdWorkingTime: createdWorkingTime) {
        try {
          const { data } = await axios.post(`${BACKEND_URL}/api/workingtimes/${createdWorkingTime.userID}`, createdWorkingTime, {
            headers: {
              'Content-Type': 'application/json',
            },
          });
        } catch (error) {
          console.error('Error creating working time:', error);
        }
      },
  
      async updateWorkingTime(updatedWorkingTime: updatedWorkingTime) {
        try {
          const { data } = await axios.put(`${BACKEND_URL}/api/workingtimes/${updatedWorkingTime.id}`, updatedWorkingTime, {
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
          await axios.delete(`${BACKEND_URL}/api/workingtimes/${workingTimeId}`, {
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