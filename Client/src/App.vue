<script setup lang="ts">
import { Sidebar } from '@/components'
import { RouterView } from 'vue-router'
import { useAuthStore } from '@/stores'
import Toaster from './components/ui/toast/Toaster.vue'

const authStore = useAuthStore()
</script>

<template>
  <main class="w-full lg:grid lg:min-h-[600px] h-screen" v-if="!authStore.isLoggedIn">
    <RouterView />
  </main>

  <div class="flex min-h-screen w-full flex-col bg-muted/40" v-if="authStore.isLoggedIn">
    <Sidebar />

    <main class="flex flex-col sm:mt-0 mt-6 sm:gap-4 sm:py-4 ml-6 sm:ml-20 mr-6 mb-6">
      <RouterView />
    </main>
  </div>

  <Toaster />
</template>
