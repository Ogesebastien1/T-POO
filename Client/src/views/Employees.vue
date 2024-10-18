<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { employeesColumns } from '@/components/data-table/columns'
import { employeeSchema } from '@/components/data-table/schemas'
import { toast } from '@/components/ui/toast'
import { useUsersStore } from '@/stores'
import { ref, watch } from 'vue'

const usersStore = useUsersStore()

const users = ref(usersStore.users)

watch(usersStore.users, () => {
  users.value = [...usersStore.users]
})

const managers = ref(['John Doe', 'Jane Doe'])

const onCreate = (employee: any) => {
  usersStore.create(employee)
  users.value = [...usersStore.users]

  toast({
    title: 'Employee created',
    description: 'The employee has been created successfully',
    duration: 3500
  })
}

const onUpdate = (employee: any, data: any) => {
  usersStore.update(employee.original.id, data)
  users.value = [...usersStore.users]

  toast({
    title: 'Employee updated',
    description: 'The employee has been updated successfully',
    duration: 3500
  })
}

const onDelete = (row: any) => {
  usersStore.delete(row.original.id)
  users.value = [...usersStore.users]

  toast({
    title: 'Employee deleted',
    description: 'The employee has been deleted successfully',
    duration: 3500
  })
}
</script>

<template>
  <DataTable
    toolbar
    :key="users.length"
    :schema="employeeSchema(managers)"
    :data="users"
    :columns="employeesColumns({ onUpdate, onDelete, managers })"
    :search="{
      label: 'Search employees...',
      field: 'username'
    }"
    :on-create="onCreate"
  />
</template>
