<script setup lang="ts">
import Card from '@/components/ui/card/Card.vue'
import CardContent from '@/components/ui/card/CardContent.vue'
import CardHeader from '@/components/ui/card/CardHeader.vue'
import { AreaChart } from '@/components/ui/chart-area'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'

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
    <h1 class="-mt-4 text-2xl font-semibold mb-4">Statistics</h1>
  </div>
  <Tabs default-value="general" class="w-full">
    <TabsList class="grid w-full grid-cols-2 mb-4">
      <TabsTrigger value="general"> General </TabsTrigger>
      <TabsTrigger value="others"> Others </TabsTrigger>
    </TabsList>
    <TabsContent value="general">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-6">
        <Card>
          <CardContent>
            <AreaChart
              :data="data"
              :colors="['blue', 'pink', 'orange', 'red']"
              :categories="['name', 'value']"
              index="name"
            />
          </CardContent>
        </Card>
        <Card>
          <CardContent>
            <AreaChart
              :data="data"
              :colors="['blue', 'pink', 'orange', 'red']"
              :categories="['name', 'value']"
              index="name"
            />
          </CardContent>
        </Card>
        <Card>
          <CardContent>
            <AreaChart
              :data="data"
              :colors="['blue', 'pink', 'orange', 'red']"
              :categories="['name', 'value']"
              index="name"
            />
          </CardContent>
        </Card>
      </div>
    </TabsContent>
    <TabsContent value="others"> </TabsContent>
  </Tabs>
</template>
