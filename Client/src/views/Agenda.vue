<script setup lang="ts">
import DateRangePicker from '@/components/ui/date-range-picker/DateRangePicker.vue'
import { DataTable } from '@/components/data-table'
import { employeesColumns } from '@/components/data-table/columns'
</script>

<template>
  <DateRangePicker />
  <DataTable :data="[]" :columns="employeesColumns" />
</template>
