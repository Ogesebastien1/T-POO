<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { teamsColumns } from '@/components/data-table/columns'
import { teamSchema } from '@/components/data-table/schemas'
import { toast } from '@/components/ui/toast'
import { useTeamsStore } from '@/stores'
import { ref, watch } from 'vue'

const teamsStore = useTeamsStore()

const members = ref([])

watch(teamsStore.teams, () => {
  members.value = [...[]]
})

const onDelete = (row: any) => {
  teamsStore.delete(row.original.id)
  // members.value = [...[]]

  toast({
    title: 'Team deleted',
    description: 'The team has been deleted successfully',
    duration: 3500
  })
}

const onCreate = (team: any) => {
  // teamsStore.create(team)
  members.value = [...[]]

  toast({
    title: 'Team created',
    description: 'The team has been created successfully',
    duration: 3500
  })
}
</script>

<template>
  <DataTable
    toolbar
    :key="members.length"
    :schema="teamSchema"
    :data="members"
    :columns="teamsColumns({ onDelete })"
    :search="{
      label: 'Search members...',
      field: 'username'
    }"
  />
</template>
