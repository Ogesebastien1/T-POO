<script setup lang="ts">
import Card from '@/components/ui/card/Card.vue'
import CardContent from '@/components/ui/card/CardContent.vue'
import CardHeader from '@/components/ui/card/CardHeader.vue'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { AreaChart } from '@/components'


</script>

<template>
  <card class="w-1/2">
    <CardContent>
      <AreaChart class="w-full" />
    </CardContent>
  </card>
</template>
