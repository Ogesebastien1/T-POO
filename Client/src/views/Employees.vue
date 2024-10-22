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

const onCreate = async (employee: any): Promise<void> => {
  const created = await usersStore.create(employee)

  if (created) {
    users.value = [...usersStore.users]

    toast({
      title: 'Employee created',
      description: 'The employee has been created successfully',
      duration: 3500
    })
  } else {
    toast({
      variant: 'destructive',
      title: 'Team creation failed',
      description: 'The team could not be created',
      duration: 3500
    })
  }
}

const onUpdate = async (employee: any, data: any): Promise<void> => {
  const updated = await usersStore.update(employee.original.id, data)

  // if (updated.ok) {
  users.value = [...usersStore.users]
  toast({
    title: 'Employee updated',
    description: 'The employee has been updated successfully',
    duration: 3500
  })
  // } else {
  //   toast({
  //     variant: 'destructive',
  //     title: 'Employee update failed',
  //     description: 'The employee could not be updated',
  //     duration: 3500
  //   })

  // }
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
