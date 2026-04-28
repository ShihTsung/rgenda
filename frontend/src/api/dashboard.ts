import { useQuery } from '@tanstack/react-query'
import client from './client'

export interface DashboardStats {
  year: number
  month: number
  user_count: number
  avg_workhours: number
  avg_overtime: number
  avg_minustime: number
  avg_oncall: number
  legal_workhours: number
  diff: number
  official_rest: number
  staff_types: Record<string, number>
}

export function useDashboard(year: number, month: number) {
  return useQuery({
    queryKey: ['dashboard', year, month],
    queryFn: () =>
      client.get<DashboardStats>('/dashboard/', { params: { year, month } })
        .then(r => r.data),
  })
}
