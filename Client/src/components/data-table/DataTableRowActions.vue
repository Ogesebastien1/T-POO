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
import { AutoForm } from '@/components/ui/auto-form'

import { Input } from '@/components/ui/input'
import * as z from 'zod'
import { useForm } from 'vee-validate'
import { ref } from 'vue'
import { toTypedSchema } from '@vee-validate/zod'
import { getAutoFormFieldConfig, getOriginal, getRowFields } from '@/components/data-table/lib/utils'

interface DataTableRowActionsProps<TData> {
  row: Row<TData>
  onUpdate: (row: Row<TData>) => void
  onDelete: (row: Row<TData>) => void
  schema: z.ZodObject<any>
}

const props = defineProps<DataTableRowActionsProps<any>>()

const { row, onUpdate, onDelete, schema } = props

const { handleSubmit } = useForm({
  validationSchema: toTypedSchema(schema)
})

const managers = []

const open = ref(false)
const value = ref('')

getAutoFormFieldConfig(row, schema)
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
            <SheetTitle>Edit employee</SheetTitle>
            <SheetDescription>
              Fill in the form below to edit the employee details.
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
              @submit="onUpdate(row)"
            />
          </div>
          <SheetFooter>
            <SheetClose as-child>
              <Button type="submit" class="w-full mt-3" @click="onUpdate(row)"> Save </Button>
            </SheetClose>
          </SheetFooter>
        </SheetContent>
      </Sheet>
      <DropdownMenuSeparator />
      <AlertDialog>
        <AlertDialogTrigger as-child>
          <Button
            variant="ghost"
            class="w-full flex justify-between p-3 font-normal text-destructive"
          >
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
            <AlertDialogAction
              class="bg-destructive hover:opacity-90 hover:bg-destructive-dark"
              @click="onDelete(props.row)"
            >
              Continue
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </DropdownMenuContent>
  </DropdownMenu>
</template>
