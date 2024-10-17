<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { employeesColumns } from '@/components/data-table/columns'
import { employeeSchema } from '@/components/data-table/schemas/employees.js';
import { ref } from 'vue'

const employees = ref([
  {
    username: 'John Doe',
    email: 'alexis@epitech.eu',
    role: 'Admin',
    manager: 'Jane Doe'
  },
  {
    username: 'Jane Doe',
    email: 'jane@epitdch.eu',
    role: 'Manager',
    manager: 'Mark Doe'
  }
])

const onCreate = () => {
  console.log('Create employee')
}

const onUpdate = (employee: any) => {
  console.log('Update employee', employee)
}

const onDelete = (employee: any) => {
  console.log('Delete employee', employee)
}
</script>

<template>
  <DataTable
    toolbar
    :schema="employeeSchema"
    :data="employees"
    :columns="employeesColumns({ onUpdate, onDelete })"
    :search="{
      label: 'Search employees...',
      field: 'username'
    }"
    :on-create="onCreate"
  />
</template>
