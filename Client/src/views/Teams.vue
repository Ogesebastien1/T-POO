<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { teamsColumns } from '@/components/data-table/columns'
import { ref } from 'vue'

const teams = ref([])
</script>

<template>
  <DataTable :show-toolbar="true" :data="teams" :columns="teamsColumns" />
</template>
