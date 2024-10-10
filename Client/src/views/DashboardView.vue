<script setup lang="ts">
import { ClockArrowUp, Loader2, CalendarCheck2, Clock } from 'lucide-vue-next'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { ref } from 'vue'
import { Table, TableBody, TableCell, TableRow } from '@/components/ui/table'

const clockedIn = ref(false)
const loading = ref(false)

const handleClockedIn = () => {
  loading.value = true
  setTimeout(() => {
    clockedIn.value = !clockedIn.value
    loading.value = false
  }, 1250)
}
</script>

<template>
  <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 md:gap-6">
    <Card class="relative">
      <div class="flex flex-col items-center sm:absolute right-4 top-0">
        <Button
          v-if="!clockedIn"
          @click="handleClockedIn"
          :disabled="loading"
          class="max-w-xs my-4 p-5 mx-auto"
        >
          <div v-if="loading" class="flex items-center">
            <Loader2 class="w-4 h-4 mr-2 animate-spin" /> Clocking in...
          </div>
          <div v-else class="flex items-center"><ClockArrowUp class="w-4 h-4 mr-2" /> Clock in</div>
        </Button>
        <Button
          v-else
          @click="handleClockedIn"
          :disabled="loading"
          class="max-w-xs my-4 p-5 mx-auto"
        >
          <div v-if="loading" class="flex items-center">
            <Loader2 class="w-4 h-4 mr-2 animate-spin" /> Clocking out...
          </div>
          <div v-else class="flex items-center">
            <ClockArrowUp class="w-4 h-4 mr-2" /> Clock out
          </div>
        </Button>
      </div>
      <CardHeader>
        <CardTitle class="text-sm font-medium"> Hello, Chris ! </CardTitle>
      </CardHeader>
      <CardContent>
        <CardDescription class="text-muted-foreground">
          {{
            clockedIn
              ? 'You are currently in a work session'
              : 'What are you waiting for? Start working!'
          }}
        </CardDescription>
      </CardContent>
    </Card>
    <div class="grid gap-4 md:grid-cols-1 md:gap-6 lg:grid-cols-2">
      <Card>
        <CardHeader class="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle class="text-sm font-medium"> Hours worked this week </CardTitle>
          <Clock class="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div class="text-2xl font-bold">35</div>
          <p class="text-xs text-muted-foreground">+26% from last week</p>
        </CardContent>
      </Card>
      <Card>
        <CardHeader class="flex flex-row items-center justify-between space-y-0 pb-2">
          <CardTitle class="text-sm font-medium"> Points this month </CardTitle>
          <CalendarCheck2 class="h-4 w-4 text-muted-foreground" />
        </CardHeader>
        <CardContent>
          <div class="text-2xl font-bold">235</div>
          <p class="text-xs text-muted-foreground">-30% from last month</p>
        </CardContent>
      </Card>
    </div>
  </div>

  <div class="mt-2">
    <Card>
      <CardHeader>
        <CardTitle class="text-sm font-medium"> Recent activities </CardTitle>
      </CardHeader>
      <CardContent>
        <Table>
          <TableBody>
            <TableRow>
              <TableCell>Worked on project</TableCell>
              <TableCell>
                <span class="text-muted-foreground">2 hours ago</span>
              </TableCell>
              <TableCell>10</TableCell>
            </TableRow>
            <TableRow>
              <TableCell>Worked on project</TableCell>
              <TableCell>
                <span class="text-muted-foreground">2 hours ago</span>
              </TableCell>
              <TableCell>10</TableCell>
            </TableRow>
            <TableRow>
              <TableCell>Worked on project</TableCell>
              <TableCell>
                <span class="text-muted-foreground">2 hours ago</span>
              </TableCell>
              <TableCell>10</TableCell>
            </TableRow>
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  </div>
</template>
