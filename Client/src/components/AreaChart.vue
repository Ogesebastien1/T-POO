<script setup lang="ts">
import { AreaChart } from '@/components/ui/chart-area'

const data = [
  {
    name: 'Jan',
    value: 100
  },
  {
    name: 'Feb',
    value: 200
  },
  {
    name: 'Mar',
    value: 150
  },
  {
    name: 'Apr',
    value: 300
  }
]
</script>

<template>
    <div class="mx-auto grid w-full gap-2">
      <h1 class="text-2xl font-semibold mb-3 mt-5 ml-5">Statistics</h1>
      <AreaChart
        :data="data"
        :colors="['blue', 'pink', 'orange', 'red']"
        :categories="['name', 'value']"
        index="name"
      />
    </div>
  </template>