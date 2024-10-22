export { teamsColumns } from './teams'
export { employeesColumns } from './employees'

export type CustomDataTableColumnAction = {
    label: string
    to: (row: any) => { name: string, params: any }
    icon: any
}