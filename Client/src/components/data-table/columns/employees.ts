import type { ColumnDef } from '@tanstack/vue-table'
import { h } from 'vue'

import type { Employee } from '@/components/data-table/schemas'
import DataTableColumnHeader from '@/components/data-table/DataTableColumnHeader.vue'
import DataTableRowActions from '@/components/data-table/DataTableRowActions.vue'
import { Checkbox } from '@/components/ui/checkbox'

export const employeesColumns: ColumnDef<Employee>[] = [
  {
    accessorKey: 'username',
    header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Username' }),
    cell: ({ row }) => {
      return h('div', { class: 'flex space-x-2' }, [
        h('span', { class: 'max-w-[500px] truncate' }, row.getValue('username')),
      ])
    },
  },
  {
    accessorKey: 'email',
    header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Email' }),
    cell: ({ row }) => {
      return h('div', { class: 'flex space-x-2' }, [
        h('span', { class: 'max-w-[500px] truncate' }, row.getValue('email')),
      ])
    },
  },
  {
    accessorKey: 'manager',
    header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Manager' }),
    cell: ({ row }) => {
      return h('div', { class: 'flex space-x-2' }, [
        h('span', { class: 'max-w-[500px] truncate' }, row.getValue('manager')),
      ])
    },
  },
  {
    accessorKey: 'role',
    header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Permissions' }),
    cell: ({ row }) => {
      return h('div', { class: 'flex space-x-2' }, [
        h('span', { class: 'max-w-[500px] truncate' }, row.getValue('role')),
      ])
    },
  },
  {
    id: 'actions',
    cell: ({ row }) => h(DataTableRowActions, { row }),
  },
]
