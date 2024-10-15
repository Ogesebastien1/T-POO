<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { employeesColumns } from '@/components/data-table/columns'
import { ref, watch } from 'vue'
import { useUserStore } from '@/stores'

const employees = ref([
  {
    username: 'John Doe',
    email: 'alexis@epitech.eu',
    role: 'Admin',
    manager: 'Jane Doe',
  },
  {
    username: 'Jane Doe',
    email: 'jane@epitdch.eu',
    role: 'Manager',
    manager: 'Mark Doe',
  }
])
</script>

<template>
  <DataTable
    :data="employees"
    :columns="employeesColumns"
    :show-toolbar="true"
    :search="{
      label: 'Search employees...',
      field: 'username'
    }"
    :on-create="() => console.log('Create employee')"
  />
</template>
