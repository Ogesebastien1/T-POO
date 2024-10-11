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
</script>

<template>
  <div class="mx-auto grid w-full gap-2">
    <h1 class="-mt-4 text-2xl font-semibold mb-4">Settings</h1>
  </div>
  <div class="mx-auto grid w-full items-start gap-6">
    <div class="grid gap-6">
      <Card>
        <CardHeader>
          <CardTitle>Profile</CardTitle>
          <CardDescription> Change your profile settings. </CardDescription>
        </CardHeader>
        <CardContent>
          <form class="flex flex-col gap-4">
            <Input type="username" placeholder="Username" />
          </form>
        </CardContent>
        <CardFooter class="border-t px-6 py-4">
          <Button>Save</Button>
        </CardFooter>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Change password</CardTitle>
          <CardDescription> Update your password. </CardDescription>
        </CardHeader>
        <CardContent>
          <form class="flex flex-col gap-4">
            <Input type="password" placeholder="Current Password" />
            <Input type="password" placeholder="New Password" />
            <Input type="password" placeholder="Confirm New Password" />
          </form>
        </CardContent>
        <CardFooter class="border-t px-6 py-4">
          <Button>Save</Button>
        </CardFooter>
      </Card>
    </div>
  </div>
</template>
