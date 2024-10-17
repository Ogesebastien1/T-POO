<script setup lang="ts">
import type { ColumnDef, Table } from '@tanstack/vue-table'
import { computed, h, ref } from 'vue'
import { vAutoAnimate } from '@formkit/auto-animate/vue'
import DataTableViewOptions from './DataTableViewOptions.vue'
import { X as Cross2Icon, Plus } from 'lucide-vue-next'
import { Button } from '@/components/ui/button'
import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage
} from '@/components/ui/form'
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetDescription,
  SheetFooter,
  SheetHeader,
  SheetTitle,
  SheetTrigger
} from '@/components/ui/sheet'
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectTrigger,
  SelectValue
} from '@/components/ui/select'
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover'
import { Check, ChevronsUpDown } from 'lucide-vue-next'
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList
} from '@/components/ui/command'
import { cn, ucfirst } from '@/lib/utils'

import { Input } from '@/components/ui/input'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { useForm } from 'vee-validate'
import { getTaleColumns } from '@/components/data-table/lib/utils'
import AutoForm from '../ui/auto-form/AutoForm.vue'

interface DataTableToolbarProps<TData> {
  columns: ColumnDef<TData, any>[]
  table: Table<TData>
  search?: {
    label?: string
    field?: string
  }
  onCreate?: () => void
  schema: z.ZodObject<any>
}

const props = defineProps<DataTableToolbarProps<any>>()

const { columns, table, search, onCreate, schema } = props

const { handleSubmit } = useForm({
  validationSchema: toTypedSchema(schema)
})

const isFiltered = computed(() => table.getState().columnFilters.length > 0)

const searchField = computed(() => search?.field ?? 'name')

const managers = [
  { value: 'Jean Martin', label: 'Jean Martin' },
  { value: 'John Doe', label: 'John Doe' },
  { value: 'Jane Doe', label: 'Jane Doe' },
  { value: 'John Smith', label: 'John Smith' },
  { value: 'Jane Smith', label: 'Jane Smith' }
]

const open = ref(false)
const value = ref('')

const roles = [
  { label: 'Admin', value: 'admin' },
  { label: 'Manager', value: 'manager' },
  { label: 'User', value: 'user' }
]

const fields = getTaleColumns(table)
</script>

<template>
  <div class="flex items-center justify-between">
    <div class="flex flex-1 items-center justify-between space-x-2">
      <div class="flex items-center space-x-2">
        <Input
          :placeholder="search?.label ?? 'Search...'"
          :model-value="(table.getColumn(searchField)?.getFilterValue() as string) ?? ''"
          class="h-8 p-2 w-[150px] lg:w-[250px]"
          @input="table.getColumn(searchField)?.setFilterValue($event.target.value)"
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
        <Sheet>
          <SheetTrigger as-child>
            <Button variant="outline" size="sm" class="ml-auto flex h-8" @click="onCreate">
              <Plus class="mr-2 h-4 w-4" />
              Create
            </Button>
          </SheetTrigger>
          <SheetContent>
            <SheetHeader>
              <SheetTitle>Create employee</SheetTitle>
              <SheetDescription>
                Fill out the form below to create a new employee.
              </SheetDescription>
            </SheetHeader>
            <div>
              <AutoForm
                class="grid gap-4 py-4"
                v-auto-animate
                :schema="schema"
                :field-config="{
                  username: {
                    label: 'Username Test Label',
                    inputProps: {
                      placeholder: 'Username'
                    }
                  }
                }"
              />
            </div>
            <SheetFooter>
              <SheetClose as-child>
                <Button type="submit"> Create </Button>
              </SheetClose>
            </SheetFooter>
          </SheetContent>
        </Sheet>
        <DataTableViewOptions :table="table" />
      </div>
    </div>
  </div>
</template>
