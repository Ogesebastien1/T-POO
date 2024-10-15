<script setup lang="ts">
import { Button } from '@/components/ui/button'
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle
} from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { useAuthStore } from '@/stores'

const authStore = useAuthStore()
</script>

<template>
  <div class="mx-auto grid w-full items-start gap-6">
    <div class="grid gap-6">
      <Card>
        <CardHeader>
          <CardTitle>Profile Information</CardTitle>
          <CardDescription class="max-w-lg"> Update your account's profile information. </CardDescription>
        </CardHeader>
        <CardContent class="max-w-lg">
          <form class="flex flex-col gap-4">
            <Input type="username" placeholder="Username" :default-value="authStore.user?.username" />
          </form>
        </CardContent>
        <CardFooter class="border-t px-6 py-4">
          <Button class="min-w-[100px]">Save</Button>
        </CardFooter>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Update Password</CardTitle>
          <CardDescription class="max-w-lg"> Ensure your account is using a long, random password to stay secure. </CardDescription>
        </CardHeader>
        <CardContent class="max-w-lg">
          <form class="flex flex-col gap-4">
            <Input type="password" placeholder="Current Password" />
            <Input type="password" placeholder="New Password" />
            <Input type="password" placeholder="Confirm New Password" />
          </form>
        </CardContent>
        <CardFooter class="border-t px-6 py-4">
          <Button class="min-w-[100px]">Save</Button>
        </CardFooter>
      </Card>
      <Card>
        <CardHeader>
          <CardTitle>Delete your account</CardTitle>
          <CardDescription class="max-w-lg">
            Once you delete your account, all of its resources and data will be permanently deleted. Before deleting your account, please download any data or information that you wish to retain.
          </CardDescription>
        </CardHeader>
        <CardContent class="max-w-lg">
          <Button variant="destructive" class="min-w-[100px]">Delete Account</Button>
        </CardContent>
      </Card>
    </div>
  </div>
</template>
