<script setup lang="ts">
import {
  Calendar,
  Home,
  UsersRound,
  LineChart,
  PanelLeft,
  Settings,
  Network
} from 'lucide-vue-next'
import { Sheet, SheetContent, SheetTrigger } from '@/components/ui/sheet'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu'
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from '@/components/ui/tooltip'
import { useColorMode } from '@vueuse/core'
import { Icon } from '@iconify/vue'
import { Button } from '@/components/ui/button'
import { Avatar, AvatarImage, AvatarFallback } from '@/components/ui/avatar'
import { ref } from 'vue'
import { Check, ChevronsUpDown } from 'lucide-vue-next'
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator
} from '@/components/ui/breadcrumb'
import { cn } from '@/lib/utils'
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList
} from '@/components/ui/command'
import { Popover, PopoverContent, PopoverTrigger } from '@/components/ui/popover'

const employees = [
  { value: 'Jean Martin', label: 'Jean Martin' },
  { value: 'John Doe', label: 'John Doe' },
  { value: 'Jane Doe', label: 'Jane Doe' },
  { value: 'John Smith', label: 'John Smith' },
  { value: 'Jane Smith', label: 'Jane Smith' }
]
import { useRoute } from 'vue-router'
import { useAuthStore } from '@/stores'

const route = useRoute()
const authStore = useAuthStore()

const open = ref(false)
const value = ref('')
const mode = useColorMode()
</script>

<template>
  <aside class="fixed inset-y-0 left-0 z-10 hidden w-14 flex-col border-r bg-background sm:flex">
    <nav class="flex flex-col items-center gap-4 px-2 sm:py-5">
      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger as-child>
            <a href="/">
              <Button
                variant="ghost"
                size="icon"
                :class="{
                  'rounded-lg text-muted-foreground transition-colors hover:text-foreground': true,
                  'bg-gray-100 text-foreground dark:bg-gray-800 dark:text-foreground':
                    route.fullPath === '/'
                }"
              >
                <Home class="h-5 w-5" />
                <span class="sr-only">Dashboard</span>
              </Button>
            </a>
          </TooltipTrigger>
          <TooltipContent side="right"> Dashboard </TooltipContent>
        </Tooltip>
      </TooltipProvider>

      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger as-child>
            <a href="/agenda">
              <Button
                variant="ghost"
                size="icon"
                :class="{
                  'rounded-lg text-muted-foreground transition-colors hover:text-foreground': true,
                  'bg-gray-100 text-foreground dark:bg-gray-800 dark:text-foreground':
                    route.fullPath.includes('/agenda')
                }"
              >
                <Calendar class="h-5 w-5" />
                <span class="sr-only">Agenda</span>
              </Button>
            </a>
          </TooltipTrigger>
          <TooltipContent side="right"> Agenda </TooltipContent>
        </Tooltip>
      </TooltipProvider>

      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger as-child>
            <a href="/analytics">
              <Button
                variant="ghost"
                size="icon"
                :class="{
                  'rounded-lg text-muted-foreground transition-colors hover:text-foreground': true,
                  'bg-gray-100 text-foreground dark:bg-gray-800 dark:text-foreground':
                    route.fullPath.includes('/analytics')
                }"
              >
                <LineChart class="h-5 w-5" />
                <span class="sr-only">Analytics</span>
              </Button>
            </a>
          </TooltipTrigger>
          <TooltipContent side="right"> Analytics </TooltipContent>
        </Tooltip>
      </TooltipProvider>

      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger as-child>
            <a href="/teams">
              <Button
                variant="ghost"
                size="icon"
                :class="{
                  'rounded-lg text-muted-foreground transition-colors hover:text-foreground': true,
                  'bg-gray-100 text-foreground dark:bg-gray-800 dark:text-foreground':
                    route.fullPath.includes('/teams')
                }"
              >
                <UsersRound class="h-5 w-5" />
                <span class="sr-only">Teams</span>
              </Button>
            </a>
          </TooltipTrigger>
          <TooltipContent side="right"> Teams </TooltipContent>
        </Tooltip>
      </TooltipProvider>

      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger as-child>
            <a href="/employees">
              <Button
                variant="ghost"
                size="icon"
                :class="{
                  'rounded-lg text-muted-foreground transition-colors hover:text-foreground': true,
                  'bg-gray-100 text-foreground dark:bg-gray-800 dark:text-foreground':
                    route.fullPath.includes('/employees')
                }"
              >
                <Network class="h-5 w-5" />
                <span class="sr-only">Employees</span>
              </Button>
            </a>
          </TooltipTrigger>
          <TooltipContent side="right"> Employees </TooltipContent>
        </Tooltip>
      </TooltipProvider>
    </nav>
    <nav class="mt-auto flex flex-col items-center gap-4 px-2 sm:py-5">
      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger as-child>
            <a href="/settings">
              <Button
                variant="ghost"
                size="icon"
                :class="{
                  'rounded-lg text-muted-foreground transition-colors hover:text-foreground': true,
                  'bg-gray-100 text-foreground dark:bg-gray-800 dark:text-foreground':
                    route.fullPath.includes('/settings')
                }"
              >
                <Settings class="h-5 w-5" />
                <span class="sr-only">Settings</span>
              </Button>
            </a>
          </TooltipTrigger>
          <TooltipContent side="right"> Settings </TooltipContent>
        </Tooltip>
      </TooltipProvider>
    </nav>
  </aside>
  <div class="flex flex-col sm:gap-4 sm:py-4 sm:pl-14">
    <header
      class="sticky top-0 z-30 flex h-14 items-center gap-4 border-b bg-background px-4 sm:static sm:h-auto sm:border-0 sm:bg-transparent sm:px-6"
    >
      <Sheet>
        <SheetTrigger as-child>
          <Button size="icon" variant="outline" class="sm:hidden">
            <PanelLeft class="h-5 w-5" />
            <span class="sr-only">Toggle Menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left" class="sm:max-w-xs">
          <nav class="grid gap-6 text-lg font-medium">
            <a
              href="/"
              class="flex items-center gap-4 px-2.5 text-muted-foreground hover:text-foreground"
            >
              <Home class="h-5 w-5" />
              Dashboard
            </a>
            <a
              href="/analytics"
              class="flex items-center gap-4 px-2.5 text-muted-foreground hover:text-foreground"
            >
              <LineChart class="h-5 w-5" />
              Analytics
            </a>
            <a
              href="/agenda"
              class="flex items-center gap-4 px-2.5 text-muted-foreground hover:text-foreground"
            >
              <Calendar class="h-5 w-5" />
              Agenda
            </a>
            <a
              href="/teams"
              class="flex items-center gap-4 px-2.5 text-muted-foreground hover:text-foreground"
            >
              <UsersRound class="h-5 w-5" />
              Teams
            </a>
            <a
              href="/settings"
              class="flex items-center gap-4 px-2.5 text-muted-foreground hover:text-foreground"
            >
              <Settings class="h-5 w-5" />
              Settings
            </a>
          </nav>
        </SheetContent>
      </Sheet>
      <Breadcrumb class="hidden md:flex">
        <BreadcrumbList>
          <BreadcrumbItem v-if="route.fullPath === '/'">
            <BreadcrumbPage>Dashboard</BreadcrumbPage>
          </BreadcrumbItem>
          <BreadcrumbItem
            v-else
            v-for="(segment, index) in route.fullPath.split('/').filter(Boolean)"
            :key="index"
          >
            <BreadcrumbLink
              as-child
              v-if="index < route.fullPath.split('/').filter(Boolean).length - 1"
            >
              <a
                :href="`/${route.fullPath
                  .split('/')
                  .slice(1, index + 2)
                  .join('/')}`"
                >{{ segment.charAt(0).toUpperCase() + segment.slice(1) }}</a
              >
            </BreadcrumbLink>
            <BreadcrumbPage v-else>{{
              segment.charAt(0).toUpperCase() + segment.slice(1)
            }}</BreadcrumbPage>
            <BreadcrumbSeparator
              v-if="index < route.fullPath.split('/').filter(Boolean).length - 1"
            />
          </BreadcrumbItem>
        </BreadcrumbList>
      </Breadcrumb>
      <div class="relative flex items-center gap-4 ml-auto">
        <div
          class="hidden sm:block"
          v-show="authStore?.isLogged && (authStore?.user?.is_admin || authStore?.user?.is_manager)"
        >
          <Popover v-model:open="open">
            <PopoverTrigger as-child>
              <Button
                variant="outline"
                role="combobox"
                :aria-expanded="open"
                class="w-[200px] justify-between"
              >
                {{
                  value
                    ? employees.find((employee) => employee.value === value)?.label
                    : 'Choose employee...'
                }}
                <ChevronsUpDown class="ml-2 h-4 w-4 shrink-0 opacity-50" />
              </Button>
            </PopoverTrigger>
            <PopoverContent class="w-[200px] p-0">
              <Command>
                <CommandInput class="h-9" placeholder="Search employee..." />
                <CommandEmpty> No employees found </CommandEmpty>
                <CommandList>
                  <CommandGroup>
                    <CommandItem
                      v-for="framework in employees"
                      :key="framework.value"
                      :value="framework.value"
                      @select="
                        (ev) => {
                          if (typeof ev.detail.value === 'string') {
                            value = ev.detail.value
                          }
                          open = false
                        }
                      "
                    >
                      {{ framework.label }}
                      <Check
                        :class="
                          cn(
                            'ml-auto h-4 w-4',
                            value === framework.value ? 'opacity-100' : 'opacity-0'
                          )
                        "
                      />
                    </CommandItem>
                  </CommandGroup>
                </CommandList>
              </Command>
            </PopoverContent>
          </Popover>
        </div>
        <DropdownMenu>
          <DropdownMenuTrigger as-child>
            <Button variant="secondary" size="icon" class="rounded-full h-[2.5rem] w-[2.5rem]">
              <Avatar class="h-[2.5rem] w-[2.5rem]">
                <AvatarImage src="https://avatar.iran.liara.run/public" alt="@radix-vue" />
                <AvatarFallback>CN</AvatarFallback>
              </Avatar>
              <span class="sr-only">Toggle user menu</span>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuLabel>My Account</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem>
              <a href="/settings">Settings</a>
            </DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem
              @click="
                () => {
                  authStore.fakeLogout()
                }
              "
              >Logout</DropdownMenuItem
            >
          </DropdownMenuContent>
        </DropdownMenu>
        <DropdownMenu>
          <DropdownMenuTrigger as-child>
            <Button variant="outline" class="rounded-full p-0 h-[2.5rem] w-[2.5rem]">
              <Icon
                icon="radix-icons:moon"
                class="h-[1.2rem] w-[1.2rem] rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0"
              />
              <Icon
                icon="radix-icons:sun"
                class="absolute h-[1.2rem] w-[1.2rem] rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100"
              />
              <span class="sr-only">Toggle theme</span>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuItem @click="mode = 'light'"> Light </DropdownMenuItem>
            <DropdownMenuItem @click="mode = 'dark'"> Dark </DropdownMenuItem>
            <DropdownMenuItem @click="mode = 'auto'"> System </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
    </header>
  </div>
</template>
