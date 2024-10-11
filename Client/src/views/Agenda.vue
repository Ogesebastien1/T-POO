<script setup lang="ts">
import { Card, CardContent } from '@/components/ui/card'
import { RangeCalendar } from '@/components/ui/range-calendar'
import { ref, type Ref } from 'vue'
import { getLocalTimeZone, today } from '@internationalized/date'
import { PopoverClose, type DateRange } from 'radix-vue'
import moment from 'moment'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Textarea } from '@/components/ui/textarea'
import { Table, TableBody, TableCell, TableRow } from '@/components/ui/table'
import Separator from '@/components/ui/separator/Separator.vue'
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover'
import { CircleAlert } from 'lucide-vue-next'
import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage
} from '@/components/ui/form'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { useForm } from 'vee-validate'
import Toaster from '@/components/ui/toast/Toaster.vue'
import { toast } from '@/components/ui/toast/index.js'

const claimSchema = toTypedSchema(
  z.object({
    reason: z.string().min(1)
  })
)

const form = useForm({
  validationSchema: claimSchema
})

const onSubmitClaim = form.handleSubmit(async (values) => {
  console.log(values)
  toast({
    title: `Claim submitted!`,
    duration: 5000
  })
  //   close popover
})

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
  },
  {
    start_time: '2024-10-17 08:00:00',
    end_time: '2024-10-17 20:00:00'
  },
  {
    start_time: '2024-10-17 08:00:00',
    end_time: '2024-10-17 20:00:00'
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
  },
  {
    start_time: '2024-10-17 08:00:00',
    end_time: '2024-10-17 20:00:00'
  },
  {
    start_time: '2024-10-17 08:00:00',
    end_time: '2024-10-17 20:00:00'
  }
]

const start = today(getLocalTimeZone())
const end = start.add({ days: 7 })

const value = ref({
  start,
  end
}) as Ref<DateRange>
</script>

<template>
  <Toaster />
  <div class="mx-auto grid w-full gap-2">
    <h1 class="-mt-4 text-2xl font-semibold mb-4">Agenda</h1>
  </div>
  <div class="flex gap-4 md:gap-6 flex-col md:flex-row">
    <div class="w-fit md:sticky top-5 self-start">
      <RangeCalendar v-model="value" class="rounded-md border" />
    </div>
    <Card class="w-full">
      <CardContent class="p-6">
        <h2 class="text-lg font-semibold">
          {{ moment(value.start).format('DD/MM/YYYY') }} -
          {{ moment(value.end).format('DD/MM/YYYY') }}
        </h2>
        <Separator class="my-4" />
        <p class="mt-4 text-sm text-muted-foreground" v-show="workingTimes.length === 0">
          No working times scheduled this period.
        </p>
        <Table>
          <TableBody>
            <TableRow v-for="time in workingTimes" :key="time.start_time">
              <TableCell>
                {{ moment(time.start_time).format('dddd, DD MMMM') }}
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
              <TableCell>
                <Popover>
                  <PopoverTrigger as-child>
                    <Button
                      variant="outline"
                      class="bg-red-500 hover:bg-red-600 hover:text-white text-white flex items-center gap-1 font-bold py-2 px-4 rounded-xl"
                    >
                      <CircleAlert class="w-4 h-4" /> Claim
                    </Button>
                  </PopoverTrigger>
                  <PopoverContent class="w-80">
                    <div class="flex flex-col gap-4 p-4">
                      <form class="w-full space-y-6" @submit="onSubmitClaim">
                        <FormField name="reason" v-slot="{ componentField }">
                          <FormItem class="flex flex-col gap-1 w-full">
                            <FormControl class="w-full">
                              <Textarea v-bind="componentField" />
                            </FormControl>
                            <FormDescription> The reason of your claim. </FormDescription>
                            <FormMessage />
                          </FormItem>
                        </FormField>
                        <div class="flex gap-4">
                          <PopoverClose class="w-full">
                            <Button class="w-full" type="submit">Claim</Button>
                          </PopoverClose>
                        </div>
                      </form>
                    </div>
                  </PopoverContent>
                </Popover>
              </TableCell>
            </TableRow>
          </TableBody>
        </Table>
      </CardContent>
    </Card>
  </div>
</template>
