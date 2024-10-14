<script setup lang="ts">
import {
  FormControl,
  FormField,
  FormItem,
  FormLabel,
} from '@/components/ui/form'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { useForm } from 'vee-validate'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { toast } from '@/components/ui/toast'
import { RouterLink } from 'vue-router'

const registerSchema = toTypedSchema(
  z.object({
    email: z.string().email(),
    username: z.string().min(3),
    password: z.string().min(6)
  })
)

const form = useForm({
  validationSchema: registerSchema
})

const onSubmitRegister = form.handleSubmit(async (values) => {
  toast({
    title: `Registering user ${values.username}...`,
    description: JSON.stringify(values),
    duration: 5000
  })
})
</script>

<template>
  <div class="flex items-center justify-center py-12">
    <div class="mx-auto grid w-[350px] gap-6">
      <div class="grid gap-2 text-center">
        <h1 class="text-3xl font-bold">Register</h1>
        <p class="text-balance text-muted-foreground">
          Enter your details below to create an account
        </p>
      </div>
      <form class="w-full space-y-6" @submit="onSubmitRegister">
        <FormField name="email" v-slot="{ componentField }">
          <FormItem class="flex flex-col gap-1 w-full">
            <FormLabel>Email</FormLabel>
            <FormControl class="w-full">
              <Input placeholder="hello@world.fr" v-bind="componentField" />
            </FormControl>
          </FormItem>
        </FormField>
        <FormField name="username" v-slot="{ componentField }">
          <FormItem class="flex flex-col gap-1 w-full">
            <FormLabel>Username</FormLabel>
            <FormControl class="w-full">
              <Input v-bind="componentField" />
            </FormControl>
          </FormItem>
        </FormField>
        <FormField name="password" v-slot="{ componentField }">
          <FormItem class="flex flex-col gap-1 w-full">
            <FormLabel>Password</FormLabel>
            <FormControl class="w-full">
              <Input type="password" v-bind="componentField" />
            </FormControl>
          </FormItem>
        </FormField>
        <Button type="submit" class="w-full"> Register </Button>
      </form>
      <div class="mt-4 text-center text-sm">
        Already have an account?
        <RouterLink to="/login" class="underline"> Sign in </RouterLink>
      </div>
    </div>
  </div>
</template>
