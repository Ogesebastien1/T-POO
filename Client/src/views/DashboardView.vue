<script setup lang="ts">
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from '@/components/ui/card'
</script>

<template>
    <div>
        <Card>
        <CardHeader>
            <CardTitle>Dashboard</CardTitle>
        </CardHeader>
        <CardContent>
            <CardDescription>
            Welcome to the dashboard
            </CardDescription>
        </CardContent>
        <CardFooter>
            <router-link to="/about">About</router-link>
        </CardFooter>
        </Card>
    </div>
</template>
