<script setup lang="ts">
import { DataTable } from '@/components/data-table';
import { employeesColumns } from '@/components/data-table/columns';
import { ref } from 'vue';
import { useRoute } from 'vue-router';

const members = ref([])

const route = useRoute()
const { id } = route.params
</script>

<template>
  <DataTable :data="members" :columns="employeesColumns" />
</template>
