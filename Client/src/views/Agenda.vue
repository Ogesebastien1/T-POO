<script setup lang="ts">
import Toaster from '@/components/ui/toast/Toaster.vue'
import DateRangePicker from '@/components/ui/date-range-picker/DateRangePicker.vue'
import { DataTable } from '@/components/data-table'
import { employeesColumns } from '@/components/data-table/columns'
</script>

<template>
  <Toaster />
  <DateRangePicker />
  <DataTable :data="[]" :columns="employeesColumns" />
</template>
