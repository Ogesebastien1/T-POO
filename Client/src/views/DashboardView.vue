<script setup lang="ts">
import { ClockArrowUp, Loader2, CalendarCheck2, Clock, ClockArrowDown } from 'lucide-vue-next'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { ref } from 'vue'
import { Table, TableBody, TableCell, TableRow } from '@/components/ui/table'
import Separator from '@/components/ui/separator/Separator.vue'
import moment from 'moment'
import Toaster from '@/components/ui/toast/Toaster.vue'
import { toast } from '@/components/ui/toast/index.js'

const clockedIn = ref(false)
const loading = ref(false)
const hasWorkingTime = ref(true)

const activities = [
  {
    type: 'Clock in',
    time: 'Today, 08:00 AM'
  },
  {
    type: 'Clock out',
    time: 'Today, 12:00 PM'
  },
  {
    type: 'Clock in',
    time: 'Today, 13:00 PM'
  },
  {
    type: 'Clock out',
    time: 'Today, 17:00 PM'
  },
  {
    type: 'Clock in',
    time: 'Today, 18:00 PM'
  }
]

const workingTimes = [
  {
    start_time: '2024-10-10 08:00:00',
    end_time: '2024-10-10 20:00:00'
  },
  {
    start_time: '2024-10-11 10:00:00',
    end_time: '2024-10-11 15:00:00'
  },
  {
    start_time: '2024-10-12 09:30:00',
    end_time: '2024-10-12 18:00:00'
  },
  {
    start_time: '2024-10-13 06:00:00',
    end_time: '2024-10-13 22:00:00'
  },
  {
    start_time: '2024-10-14 08:00:00',
    end_time: '2024-10-14 20:00:00'
  },
  {
    start_time: '2024-10-15 08:00:00',
    end_time: '2024-10-15 20:00:00'
  },
  {
    start_time: '2024-10-16 08:00:00',
    end_time: '2024-10-16 20:00:00'
  },
  {
    start_time: '2024-10-17 08:00:00',
    end_time: '2024-10-17 20:00:00'
  }
]

const handleClockedIn = () => {
  loading.value = true
  setTimeout(() => {
    clockedIn.value = !clockedIn.value
    loading.value = false
    toast({
      title: `You have successfully ${clockedIn.value ? 'clocked in' : 'clocked out'}`,
      description: `You are now ${clockedIn.value ? 'in' : 'out'} of a work session`,
      duration: 5000
    })
  }, 1250)
}
</script>

<template>
  <Toaster />
  <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 md:gap-6">
    <Card class="relative">
      <div class="flex flex-col items-center sm:absolute right-4 top-0" v-if="hasWorkingTime">
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
            hasWorkingTime
              ? clockedIn
                ? 'You are currently in a work session'
                : 'What are you waiting for? Start working!'
              : "I'm sorry but you don't have any working time today. If you think this is an error, please contact your manager."
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

  <div class="mt-2 grid grid-cols-1 sm:grid-cols-2 gap-4 md:gap-6">
    <Card>
      <CardHeader>
        <CardTitle class="text-sm font-medium"> Recent activities </CardTitle>
      </CardHeader>
      <CardContent>
        <Separator class="-mt-2 mb-4" />
        <ul class="space-y-4">
          <li class="flex flex-row items-start" v-for="activity in activities" :key="activity.type">
            <div class="-mt-1 w-8 h-8 rounded-full flex items-center justify-center">
              <ClockArrowDown class="w-4 h-4 text-primary" v-show="activity.type === 'Clock in'" />
              <ClockArrowUp class="w-4 h-4 text-primary" v-show="activity.type === 'Clock out'" />
            </div>
            <div class="flex flex-col">
              <p class="text-sm font-medium text-primary">{{ activity.type }}</p>
              <p class="text-xs text-muted-foreground">{{ activity.time }}</p>
            </div>
          </li>
        </ul>
      </CardContent>
    </Card>
    <Card>
      <CardHeader>
        <CardTitle class="text-sm font-medium"> Your next working times </CardTitle>
      </CardHeader>
      <CardContent>
        <Separator class="-mt-2 mb-4" />
        <Table>
          <TableBody>
            <TableRow v-for="time in workingTimes.slice(0, 5)" :key="time.start_time">
              <TableCell>
                {{ moment(time.start_time).format('dddd') }}
              </TableCell>
              <TableCell class="text-muted-foreground">
                {{
                  moment(time.start_time).format('HH:mm') +
                  ' - ' +
                  moment(time.end_time).format('HH:mm')
                }}
              </TableCell>
              <TableCell class="text-muted-foreground">
                {{ moment(time.end_time).diff(moment(time.start_time), 'hours') + ' hours' }}
              </TableCell>
            </TableRow>
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  </div>
</template>
