<script setup lang="ts">
import type { Table } from '@tanstack/vue-table'
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
import { cn } from '@/lib/utils'

import { Input } from '@/components/ui/input'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { useForm } from 'vee-validate'

const formSchema = toTypedSchema(
  z.object({
    username: z.string().min(3).max(30),
    email: z.string().email().min(1),
    password: z.string().min(8).max(30),
    role: z.string().optional(),
    manager: z.string().optional()
  })
)

const { handleSubmit } = useForm({
  validationSchema: formSchema
})

interface DataTableToolbarProps<TData> {
  table: Table<TData>
  search?: {
    label?: string
    field?: string
  }
  onCreate?: () => void
}

const props = defineProps<DataTableToolbarProps<any>>()

const isFiltered = computed(() => props.table.getState().columnFilters.length > 0)

const searchField = computed(() => props.search?.field ?? 'name')

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
</script>

<template>
  <div class="flex items-center justify-between">
    <div class="flex flex-1 items-center justify-between space-x-2">
      <div class="flex items-center space-x-2">
        <Input
          :placeholder="props.search?.label ?? 'Search...'"
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
            <Button variant="outline" size="sm" class="ml-auto flex h-8" @click="props.onCreate">
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
            <div class="grid gap-6 py-4">
              <FormField name="username" v-slot="{ componentField }">
                <FormItem class="flex flex-col gap-1 w-full" v-auto-animate>
                  <FormLabel>Username</FormLabel>
                  <FormControl class="w-full">
                    <Input v-bind="componentField" />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              </FormField>
              <FormField name="email" v-slot="{ componentField }">
                <FormItem class="flex flex-col gap-1 w-full" v-auto-animate>
                  <FormLabel>Email</FormLabel>
                  <FormControl class="w-full">
                    <Input v-bind="componentField" />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              </FormField>
              <FormField name="password" v-slot="{ componentField }">
                <FormItem class="flex flex-col gap-1 w-full" v-auto-animate>
                  <FormLabel>Password</FormLabel>
                  <FormControl class="w-full">
                    <Input v-bind="componentField" type="password" />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              </FormField>
              <FormField name="role" v-slot="{ componentField }">
                <FormItem class="flex flex-col gap-1 w-full" v-auto-animate>
                  <FormLabel>Role</FormLabel>
                  <FormControl class="w-full">
                    <Select v-bind="componentField">
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Select a role" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        <SelectGroup>
                          <SelectItem v-for="role in roles" :key="role.value" :value="role.value">
                            {{ role.label }}
                          </SelectItem>
                        </SelectGroup>
                      </SelectContent>
                    </Select>
                  </FormControl>
                  <FormMessage />
                </FormItem>
              </FormField>
              <FormField name="manager" v-slot="{ componentField }">
                <FormItem class="flex flex-col gap-1 w-full" v-auto-animate>
                  <FormLabel>Manager</FormLabel>
                  <Popover v-model:open="open">
                    <PopoverTrigger as-child>
                      <Button
                        variant="outline"
                        role="combobox"
                        :aria-expanded="open"
                        class="w-full justify-between"
                      >
                        {{
                          value
                            ? managers.find((manager) => manager.value === value)?.label
                            : 'Choose manager...'
                        }}
                        <ChevronsUpDown class="ml-2 h-4 w-4 shrink-0 opacity-50" />
                      </Button>
                    </PopoverTrigger>
                    <PopoverContent class="w-full p-0">
                      <Command>
                        <CommandInput class="h-9" placeholder="Search manager..." />
                        <CommandEmpty> No managers found </CommandEmpty>
                        <CommandList>
                          <CommandGroup>
                            <CommandItem
                              v-for="manager in managers"
                              :key="manager.value"
                              :value="manager.value"
                              @select="
                                (ev) => {
                                  if (typeof ev.detail.value === 'string') {
                                    value = ev.detail.value
                                  }
                                  open = false
                                }
                              "
                            >
                              {{ manager.label }}
                              <Check
                                :class="
                                  cn(
                                    'ml-auto h-4 w-4',
                                    value === manager.value ? 'opacity-100' : 'opacity-0'
                                  )
                                "
                              />
                            </CommandItem>
                          </CommandGroup>
                        </CommandList>
                      </Command>
                    </PopoverContent>
                  </Popover>
                </FormItem>
              </FormField>
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
