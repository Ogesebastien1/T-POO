<script setup lang="ts">
import { DataTable } from '@/components/data-table'
import { employeesColumns } from '@/components/data-table/columns'
import { ref } from 'vue'

const employees = ref([])
</script>

<template>
  <DataTable :data="employees" :columns="employeesColumns" />
</template>
