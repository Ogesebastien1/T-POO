import { type ClassValue, clsx } from 'clsx'
import { twMerge } from 'tailwind-merge'
import type { Updater } from '@tanstack/vue-table'
import type { Ref } from 'vue'

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function valueUpdater<T extends Updater<any>>(updaterOrValue: T, ref: Ref) {
  ref.value = typeof updaterOrValue === 'function' ? updaterOrValue(ref.value) : updaterOrValue
}

export function makeToastFromResponseErrors(errors: Record<string, string[]>): string {
  const ucfirst = (str: string) => str.charAt(0).toUpperCase() + str.slice(1)
  return Object.entries(errors)
    .map(([key, value]) => `${ucfirst(key)} ${value.join(', ')}`)
    .join(' - ')
}
