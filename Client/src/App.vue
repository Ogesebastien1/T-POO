<script setup lang="ts">
import { Sidebar } from '@/components'
import { RouterView } from 'vue-router'
</script>

<template>
  <div class="flex min-h-screen w-full flex-col bg-muted/40">
    <Sidebar />

    <main class="flex flex-col sm:mt-0 mt-6 sm:gap-4 sm:py-4 ml-6 sm:ml-20 mr-6">
      <RouterView />
    </main>
  </div>
</template>
