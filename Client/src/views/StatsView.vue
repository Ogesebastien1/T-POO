<script setup lang="ts">
import Card from '@/components/ui/card/Card.vue'
import CardContent from '@/components/ui/card/CardContent.vue'
import CardHeader from '@/components/ui/card/CardHeader.vue'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { AreaChart } from '@/components'
import { BarChart } from '@/components'

</script>

<template>
   <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
    <!-- First tab -->
    <card class="w-full justify-center">
      <CardContent class="w-full mt-20">
        <BarChart/>
      </CardContent>
    </card>

    <!-- Second tab -->
    <card class="w-full flex items-center justify-center">
      <CardContent class="w-full">
        <AreaChart/>
      </CardContent>
    </card>
  </div>
</template>
