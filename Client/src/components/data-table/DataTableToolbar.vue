<script setup lang="ts">
import type { Table } from '@tanstack/vue-table'
import { computed } from 'vue'

import DataTableViewOptions from './DataTableViewOptions.vue'
import { X as Cross2Icon, Plus } from 'lucide-vue-next'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'

interface DataTableToolbarProps<TData> {
  table: Table<TData>
}

const props = defineProps<DataTableToolbarProps<any>>()

const isFiltered = computed(() => props.table.getState().columnFilters.length > 0)
</script>

<template>
  <div class="flex items-center justify-between">
    <div class="flex flex-1 items-center justify-between space-x-2">
      <div class="flex items-center space-x-2">
        <Input
          placeholder="Filter teams..."
          :model-value="(table.getColumn('name')?.getFilterValue() as string) ?? ''"
          class="h-8 p-2 w-[150px] lg:w-[250px]"
          @input="table.getColumn('name')?.setFilterValue($event.target.value)"
        />

        <Button
          v-if="isFiltered"
          variant="ghost"
          class="h-8 px-2 lg:px-3"
          @click="table.resetColumnFilters()"
        >
          Reset
          <Cross2Icon class="ml-2 h-4 w-4" />
        </Button>
      </div>
      <div class="flex items-center space-x-2">
        <Button variant="outline" size="sm" class="ml-auto flex h-8">
          <Plus class="mr-2 h-4 w-4" />
          Create
        </Button>
        <DataTableViewOptions :table="table" />
      </div>
    </div>
  </div>
</template>
