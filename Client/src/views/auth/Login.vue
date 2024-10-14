<script setup lang="ts">
import { FormControl, FormField, FormItem, FormLabel } from '@/components/ui/form'
import { toTypedSchema } from '@vee-validate/zod'
import * as z from 'zod'
import { useForm } from 'vee-validate'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { useAuthStore } from '@/stores'
import { RouterLink } from 'vue-router'

const authStore = useAuthStore()

const registerSchema = toTypedSchema(
  z.object({
    email: z.string().email().min(1),
    password: z.string().min(1)
  })
)

const form = useForm({
  validationSchema: registerSchema
})

const onSubmitLogin = form.handleSubmit(async (values) => {
  authStore.fakeLogin(values.email)
})
</script>

<template>
  <div class="flex items-center justify-center py-12">
    <div class="mx-auto grid w-[350px] gap-6">
      <div class="grid gap-2 text-center">
        <h1 class="text-3xl font-bold">Login</h1>
        <p class="text-balance text-muted-foreground">Enter your details below to login</p>
      </div>
      <form class="w-full space-y-6" @submit="onSubmitLogin">
        <FormField name="email" v-slot="{ componentField }">
          <FormItem class="flex flex-col gap-1 w-full">
            <FormLabel>Email</FormLabel>
            <FormControl class="w-full">
              <Input placeholder="hello@world.fr" v-bind="componentField" />
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
        <Button type="submit" class="w-full"> Login </Button>
      </form>
      <div class="mt-4 text-center text-sm">
        Don't have an account?
        <RouterLink to="/register" class="underline"> Sign up </RouterLink>
      </div>
    </div>
  </div>
</template>
