<script setup lang="ts">
import { useColorMode } from '@vueuse/core'
import { Button } from '@/components/ui/button'
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card'
import { Input } from '@/components/ui/input'
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu'
import { Icon } from '@iconify/vue'

const mode = useColorMode()

</script>

<template>
    <main class="flex min-h-[calc(100vh_-_theme(spacing.16))] flex-1 flex-col gap-4 p-4 md:gap-8 md:p-10">
      <div class="mx-auto grid w-full max-w-6xl gap-2">
        <h1 class="text-5xl font-semibold ml-6 mb-5">
          Settings
        </h1>
      </div>
      <div class="mx-auto grid w-full max-w-6xl items-start gap-6 md:grid-cols-[180px_1fr] lg:grid-cols-[0px_1fr]">
        <nav class="grid gap-4 text-sm text-muted-foreground">

        </nav>
        <div class="grid gap-6">
          <Card>
            <CardHeader>
              <CardTitle>Profile</CardTitle>
              <CardDescription>
                Change your profile settings.
              </CardDescription>
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
              <CardDescription>
                Update your password.
              </CardDescription>
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

          <Card>
            <CardHeader>
              <CardTitle>Theme mode</CardTitle>
              <CardDescription>
                Change the theme mode.
              </CardDescription>
              <CardContent>
            <DropdownMenu>
              <DropdownMenuTrigger as-child>
                <Button variant="outline" class="mt-4">
                  <Icon icon="radix-icons:moon" class="h-[1.2rem] w-[1.2rem] rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0" />
                  <Icon icon="radix-icons:sun" class="absolute h-[1.2rem] w-[1.2rem] rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100" />
                  <span class="sr-only">Toggle theme</span>
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end">
                <DropdownMenuItem @click="mode = 'light'">
                  Light
                </DropdownMenuItem>
                <DropdownMenuItem @click="mode = 'dark'">
                  Dark
                </DropdownMenuItem>
                <DropdownMenuItem @click="mode = 'auto'">
                  System
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </CardContent>
            </CardHeader>

          </Card>
        </div>
      </div>
    </main>
</template>
