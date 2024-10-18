<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { teamsColumns } from '@/components/data-table/columns'
import { teamSchema } from '@/components/data-table/schemas'
import { toast } from '@/components/ui/toast'
import { useTeamsStore } from '@/stores'
import { ref, watch } from 'vue'

const teamsStore = useTeamsStore()

const teams = ref(teamsStore.teams)

watch(teamsStore.teams, () => {
  teams.value = [...teamsStore.teams]
})

const onDelete = (row: any) => {
  teamsStore.delete(row.original.id)
  teams.value = [...teamsStore.teams]

  toast({
    title: 'Team deleted',
    description: 'The team has been deleted successfully',
    duration: 3500
  })
}

const onCreate = (team: any) => {
  teamsStore.create(team)
  teams.value = [...teamsStore.teams]

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
    :key="teams.length"
    :schema="teamSchema"
    :data="teams"
    :columns="teamsColumns({ onDelete })"
    :search="{
      label: 'Search teams...',
      field: 'name'
    }"
    :on-create="onCreate"
  />
</template>
