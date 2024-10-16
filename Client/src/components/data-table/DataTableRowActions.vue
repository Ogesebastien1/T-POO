<script setup lang="ts">
import type { Row, Table } from '@tanstack/vue-table'
import { EllipsisVertical, Trash2Icon, Edit2Icon } from 'lucide-vue-next'
import { Button } from '@/components/ui/button'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu'
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
  AlertDialogTrigger
} from '@/components/ui/alert-dialog'
import { vAutoAnimate } from '@formkit/auto-animate/vue'
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
import { Plus, Check, ChevronsUpDown } from 'lucide-vue-next'
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
import { computed, ref } from 'vue'

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

interface DataTableRowActionsProps<TData> {
  row: Row<TData>
}

const props = defineProps<DataTableRowActionsProps<any>>()

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
  <DropdownMenu>
    <DropdownMenuTrigger as-child>
      <Button variant="ghost" class="flex h-8 w-8 p-0 data-[state=open]:bg-muted">
        <EllipsisVertical class="h-4 w-4" />
        <span class="sr-only">Open menu</span>
      </Button>
    </DropdownMenuTrigger>
    <DropdownMenuContent align="end" class="w-[160px]">
      <Sheet>
        <SheetTrigger as-child>
          <Button variant="ghost" class="w-full flex justify-between font-normal p-3">
            Edit
            <Edit2Icon class="h-4 w-4" />
          </Button>
        </SheetTrigger>
        <SheetContent>
          <SheetHeader>
            <SheetTitle>Create employee</SheetTitle>
            <SheetDescription> Fill out the form below to create a new employee. </SheetDescription>
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
      <DropdownMenuSeparator />
      <AlertDialog>
        <AlertDialogTrigger as-child>
          <Button variant="ghost" class="w-full flex justify-between p-3 font-normal text-destructive">
            Delete
            <Trash2Icon class="h-4 w-4" />
          </Button>
        </AlertDialogTrigger>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Are you absolutely sure?</AlertDialogTitle>
            <AlertDialogDescription>
              This action cannot be undone. This will permanently delete your account and remove
              your data from our servers.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <AlertDialogAction>Continue</AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </DropdownMenuContent>
  </DropdownMenu>
</template>
