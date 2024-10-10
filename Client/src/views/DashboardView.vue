<script setup lang="ts">
import { ClockArrowUp, Loader2, CalendarCheck2, ClockArrowDown, Clock } from 'lucide-vue-next'
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle
} from '@/components/ui/card'
import { Button } from '@/components/ui/button'
import { h, ref } from 'vue'
import type {
  ColumnFiltersState,
  ExpandedState,
  SortingState,
  VisibilityState
} from '@tanstack/vue-table'
import {
  FlexRender,
  createColumnHelper,
  getCoreRowModel,
  getExpandedRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  useVueTable
} from '@tanstack/vue-table'
import { ArrowUpDown, ChevronDown } from 'lucide-vue-next'
import { Checkbox } from '@/components/ui/checkbox'
import {
  DropdownMenu,
  DropdownMenuCheckboxItem,
  DropdownMenuContent,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu'
import { Input } from '@/components/ui/input'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow
} from '@/components/ui/table'
import { cn } from '@/lib/utils'

const clockedIn = ref(false)
const loading = ref(false)

const handleClockedIn = () => {
  loading.value = true
  setTimeout(() => {
    clockedIn.value = !clockedIn.value
    loading.value = false
  }, 3500)
}
</script>

<template>
  <div class="grid grid-cols-2 gap-4 md:gap-8">
    <Card>
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
    <div class="grid gap-4 md:grid-cols-1 md:gap-8 lg:grid-cols-2">
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

  <div>
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
    <Button v-else @click="handleClockedIn" :disabled="loading" class="max-w-xs my-4 p-5 mx-auto">
      <div v-if="loading" class="flex items-center">
        <Loader2 class="w-4 h-4 mr-2 animate-spin" /> Clocking out...
      </div>
      <div v-else class="flex items-center"><ClockArrowUp class="w-4 h-4 mr-2" /> Clock out</div>
    </Button>
  </div>

</template>
