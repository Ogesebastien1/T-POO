import { z } from 'zod'

export enum Role {
  Admin = 'Admin',
  Manager = 'Manager',
  Employee = 'Employee',
}

export const employeeSchema = (managers: any = []) => z.object({
  username: z.string().min(3).max(30),
  email: z.string().email().min(1),
  password: z.string().min(8).max(30),
  role: z.nativeEnum(Role).default(Role.Employee),
  manager: z.enum(managers)
})

const schema = employeeSchema()

export type Employee = z.infer<typeof schema>
