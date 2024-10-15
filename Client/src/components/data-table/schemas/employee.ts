import { z } from 'zod'

// We're keeping a simple non-relational schema here.
// IRL, you will have a schema for your data models.
export const employeeSchema = z.object({
  id: z.string(),
  name: z.string(),
})

export type Employee = z.infer<typeof employeeSchema>
