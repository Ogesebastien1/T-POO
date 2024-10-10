<script setup lang="ts">
import {
  Home,
  LineChart,
  Package,
  PanelLeft,
  Settings,
  ShoppingCart,
  Package2,
  Users2
} from 'lucide-vue-next'

import { Sheet, SheetContent, SheetTrigger } from '@/components/ui/sheet'
import {
  Pagination,
  PaginationList,
  PaginationNext,
  PaginationPrev
} from '@/components/ui/pagination'
import { Progress } from '@/components/ui/progress'
import { Separator } from '@/components/ui/separator'
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow
} from '@/components/ui/table'
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs'
import { Checkbox } from '@/components/ui/checkbox'
import { Sidebar } from '@/components'
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger
} from '@/components/ui/dropdown-menu'
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from '@/components/ui/tooltip'
</script>

<template>
  <aside class="fixed inset-y-0 left-0 z-10 hidden w-14 flex-col border-r bg-background sm:flex">
    <nav class="flex flex-col items-center gap-4 px-2 sm:py-5">
      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger as-child>
            <a
              href="/"
              class="flex h-9 w-9 items-center justify-center rounded-lg text-muted-foreground transition-colors hover:text-foreground md:h-8 md:w-8"
            >
              <Home class="h-5 w-5" />
              <span class="sr-only">Dashboard</span>
            </a>
          </TooltipTrigger>
          <TooltipContent side="right"> Dashboard </TooltipContent>
        </Tooltip>
      </TooltipProvider>

      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger as-child>
            <a
              href="/stats"
              class="flex h-9 w-9 items-center justify-center rounded-lg text-muted-foreground transition-colors hover:text-foreground md:h-8 md:w-8"
            >
              <LineChart class="h-5 w-5" />
              <span class="sr-only">Analytics</span>
            </a>
          </TooltipTrigger>
          <TooltipContent side="right"> Analytics </TooltipContent>
        </Tooltip>
      </TooltipProvider>
    </nav>
    <nav class="mt-auto flex flex-col items-center gap-4 px-2 sm:py-5">
      <TooltipProvider>
        <Tooltip>
          <TooltipTrigger as-child>
            <a
              href="/settings"
              class="flex h-9 w-9 items-center justify-center rounded-lg text-muted-foreground transition-colors hover:text-foreground md:h-8 md:w-8"
            >
              <Settings class="h-5 w-5" />
              <span class="sr-only">Settings</span>
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
              href="/stats"
              class="flex items-center gap-4 px-2.5 text-muted-foreground hover:text-foreground"
            >
              <LineChart class="h-5 w-5" />
              Analytics
            </a>
          </nav>
        </SheetContent>
      </Sheet>
      <div class="relative ml-auto flex-1 md:grow-0">
        <DropdownMenu>
          <DropdownMenuTrigger as-child>
            <Button variant="secondary" size="icon" class="rounded-full">
              <Avatar>
                <AvatarImage src="https://github.com/radix-vue.png" alt="@radix-vue" />
                <AvatarFallback>CN</AvatarFallback>
              </Avatar>
              <span class="sr-only">Toggle user menu</span>
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent align="end">
            <DropdownMenuLabel>My Account</DropdownMenuLabel>
            <DropdownMenuSeparator />
            <DropdownMenuItem>Settings</DropdownMenuItem>
            <DropdownMenuSeparator />
            <DropdownMenuItem>Logout</DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </div>
    </header>
  </div>
</template>
