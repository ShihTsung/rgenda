import { useQuery } from '@tanstack/react-query'
import client from './client'

export interface ShiftInfo {
  id: number
  name: string
  code: string
  shift_type: number
  work_hours: number
}

export interface StationInfo {
  id: number
  name: string
}

export interface ResultItem {
  id: number
  user: number
  date: string
  shift: ShiftInfo
  station: StationInfo
  shift_type: number
}

export interface StaffUser {
  id: number
  username: string
  full_name: string
}

const SHIFT_TYPE_COLOR: Record<number, string> = {
  0: 'bg-sky-100 text-sky-800',       // 白班
  1: 'bg-amber-100 text-amber-800',   // 小夜
  2: 'bg-violet-100 text-violet-800', // 大夜
  3: 'bg-emerald-100 text-emerald-800', // 公假
  4: 'bg-yellow-100 text-yellow-800', // oncall
  5: 'bg-teal-100 text-teal-800',     // 有薪假
  6: 'bg-rose-100 text-rose-800',     // 無薪假
  7: 'bg-slate-100 text-slate-600',   // 行政
}

export const shiftColor = (shiftType: number) =>
  SHIFT_TYPE_COLOR[shiftType] ?? 'bg-gray-100 text-gray-500'

function pad(n: number) { return String(n).padStart(2, '0') }

export function useResults(year: number, month: number) {
  const start = `${year}-${pad(month)}-01`
  const lastDay = new Date(year, month, 0).getDate()
  const end = `${year}-${pad(month)}-${pad(lastDay)}`
  return useQuery({
    queryKey: ['results', year, month],
    queryFn: () =>
      client.get<ResultItem[]>('/results/', { params: { start, end } })
        .then(r => r.data),
  })
}

export function useStaff() {
  return useQuery({
    queryKey: ['users'],
    queryFn: () =>
      client.get<StaffUser[]>('/users/').then(r => r.data),
    staleTime: 1000 * 60 * 5,
  })
}

export function buildResultMap(results: ResultItem[]) {
  const map: Record<number, Record<number, ResultItem>> = {}
  for (const r of results) {
    const day = parseInt(r.date.slice(8, 10), 10)
    if (!map[r.user]) map[r.user] = {}
    map[r.user][day] = r
  }
  return map
}
