<script setup lang="ts">
import { Sidebar } from '@/components'
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div class="flex min-h-screen w-full flex-col bg-muted/40">
    <Sidebar />

    <main class="flex flex-col sm:gap-4 sm:py-4 sm:pl-16 pr-4">
      <RouterView />
    </main>
  </div>
</template>

