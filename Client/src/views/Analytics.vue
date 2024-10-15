<script setup lang="ts">
import Card from '@/components/ui/card/Card.vue'
import CardContent from '@/components/ui/card/CardContent.vue'
import { AreaChart, BarChart } from '@/components/charts'
import DateRangePicker from '@/components/ui/date-range-picker/DateRangePicker.vue'
</script>

<template>
  <DateRangePicker />

  <!-- First tab -->
  <div class="grid grid-cols-1 lg:grid-cols-2 gap-4">
    <card class="w-full justify-center">
      <CardContent class="w-full mt-20">
        <BarChart />
      </CardContent>
    </card>
    <card class="w-full justify-center">
      <CardContent class="w-full mt-20">
        <BarChart />
      </CardContent>
    </card>
  </div>

  <!-- Second tab -->
  <card class="w-full flex items-center justify-center">
    <CardContent class="w-full">
      <AreaChart />
    </CardContent>
  </card>
</template>
