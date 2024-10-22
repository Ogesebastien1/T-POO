<script setup lang="ts">
import { ClockArrowUp, Loader2, CalendarCheck2, Clock, ClockArrowDown } from 'lucide-vue-next'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { ref, onMounted, watch, computed } from 'vue'
import { Table, TableBody, TableCell, TableRow } from '@/components/ui/table'
import Separator from '@/components/ui/separator/Separator.vue'
import moment from 'moment'
import { toast } from '@/components/ui/toast'
import { useAuthStore, useClockManagerStore } from '@/stores'
import { Skeleton } from '@/components/ui/skeleton'
import type { RefSymbol } from '@vue/reactivity'

const authStore = useAuthStore()
const clockManagerStore = useClockManagerStore()

const clockedButton = ref(false)
const loading = ref(false)
const loadingLastClock = ref(false)
const hasWorkingTime = ref(true)

const lastClock = computed(() => {
  return clockManagerStore.clocks.length > 0 ? clockManagerStore.clocks[clockManagerStore.clocks.length - 1] : null;
});

const updateClockedInStatus = () => {
  console.log(lastClock.value);
  if (lastClock.value) {
    clockedButton.value = lastClock.value.status === 'clock_in';
  }
  console.log("Clocked in status updated:", clockedButton.value);
}

onMounted(async () => {
  loadingLastClock.value = true
  await clockManagerStore.getAllClocks();
  updateClockedInStatus();
  loadingLastClock.value = false
})

watch(() => clockManagerStore.clocks, () => {
  updateClockedInStatus();
});

const workingTimes = [
  {
    start_time: '2024-10-18 08:00:00',
    end_time: '2024-10-18 20:00:00'
  },
  {
    start_time: '2024-10-21 10:00:00',
    end_time: '2024-10-21 15:00:00'
  },
  {
    start_time: '2024-10-22 09:30:00',
    end_time: '2024-10-22 18:00:00'
  },
  {
    start_time: '2024-10-23 06:00:00',
    end_time: '2024-10-23 22:00:00'
  },
  {
    start_time: '2024-10-24 08:00:00',
    end_time: '2024-10-24 20:00:00'
  }
]

const handleClockedIn = async () => {
  loading.value = true
  await clockManagerStore.clock();
  clockedButton.value = !clockedButton.value
  loading.value = false
  toast({
    title: `You have successfully ${clockedButton.value ? 'clocked in' : 'clocked out'}`,
    description: `You are now ${clockedButton.value ? 'in' : 'out'} of a work session`,
    duration: 5000
  })
}
</script>

<template>
  <div class="grid grid-cols-1 lg:grid-cols-2 gap-4 md:gap-6">
    <Card class="relative">
      <CardHeader>
        <CardTitle class="text-sm font-medium"> Hello, {{ authStore.user?.username }} ! </CardTitle>
        <CardDescription>
          <div class="text-xs text-muted-foreground" v-show="!authStore.hasAnyRole">
            {{
              hasWorkingTime
                ? clockedButton
                  ? 'You are currently in a work session'
                  : 'What are you waiting for? Start working!'
                : null
            }}
          </div>
          <div class="text-xs text-muted-foreground" v-show="authStore.hasAnyRole">
            How are you big boss? 🚀
          </div>
        </CardDescription>
      </CardHeader>
      <CardContent class="text-muted-foreground">
        <div v-show="!authStore.hasAnyRole">
          {{
            !hasWorkingTime
              ? "I'm sorry but you don't have any working time today. If you think this is an error, please contact your manager."
              : null
          }}
          <div class="block sm:absolute -mt-4 right-4 top-4" v-if="hasWorkingTime">
            <Skeleton v-if="loadingLastClock" class="w-[123px] my-4 p-5 mx-auto">
              <Button class="max-w-xs my-4 p-5 mx-auto" disabled>
                <div class="flex items-center">
                  <ClockArrowUp class="w-4 h-4 mr-2" /> Clock in
                </div>
              </Button>
            </Skeleton>
            <Button
              v-else-if="!clockedButton"
              @click="handleClockedIn"
              :disabled="loading"
              class="max-w-xs my-4 p-5 mx-auto"
            >
                <div v-if="loading" class="flex items-center">
                  <Loader2 class="w-4 h-4 mr-2 animate-spin" /> Clocking in...
                </div>
                <div v-else class="flex items-center">
                  <ClockArrowUp class="w-4 h-4 mr-2" /> Clock in
                </div>
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
        </div>
      </CardContent>
    </Card>
    <div class="grid gap-4 grid-cols-1 md:gap-6 sm:grid-cols-2">
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
          <li class="flex flex-row items-start" v-for="clock in clockManagerStore.clocks" :key="clock.id">
            <div class="-mt-1 w-8 h-8 rounded-full flex items-center justify-center">
              <ClockArrowDown class="w-4 h-4 text-primary" v-show="clock.status === 'clock_in'" />
              <ClockArrowUp class="w-4 h-4 text-primary" v-show="clock.status === 'clock_out'" />
            </div>
            <div class="flex flex-col">
              <p class="text-sm font-medium text-primary">{{ clock.status === 'clock_in' ? 'Clock in' : 'Clock out' }}</p>
              <p class="text-xs text-muted-foreground">{{ moment(clock.time).format('LLLL') }}</p>
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
              <TableCell class="text-muted-foreground hidden md:block">
                {{ moment(time.end_time).diff(moment(time.start_time), 'hours') + ' hours' }}
              </TableCell>
            </TableRow>
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  </div>
</template>