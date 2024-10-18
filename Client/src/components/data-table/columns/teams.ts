import type { ColumnDef } from '@tanstack/vue-table'
import { h } from 'vue'

import { DataTableColumnHeader, DataTableRowActions } from '@/components/data-table'
import { teamSchema, type Team } from '@/components/data-table/schemas'

interface ColumnProps {
  onDelete: (row: any) => void
}

export const teamsColumns = (props: ColumnProps): ColumnDef<Team>[] => {
  const { onDelete } = props;

  return [
    {
      accessorKey: 'name',
      header: ({ column }) => h(DataTableColumnHeader, { column, title: 'Name' }),
      cell: ({ row }) => {
        return h('div', { class: 'flex space-x-2' }, [
          h('span', { class: 'max-w-[500px] truncate' }, row.getValue('name')),
        ])
      },
    },
    {
      id: 'actions',
      cell: ({ row }) => h(DataTableRowActions, {
        schema: teamSchema,
        row,
        onDelete,
      }),
    }
  ]
}
