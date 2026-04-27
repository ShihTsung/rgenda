import FullCalendar from '@fullcalendar/react'
import dayGridPlugin from '@fullcalendar/daygrid'
import type { EventContentArg } from '@fullcalendar/core'
import { useRef, useState } from 'react'
import { Button } from '@/components/ui/button'
import { useResults, useStaff } from '@/api/schedule'

const SHIFT_BG: Record<number, string> = {
  0: '#bae6fd', // 白班 sky-200
  1: '#fde68a', // 小夜 amber-200
  2: '#ddd6fe', // 大夜 violet-200
  3: '#a7f3d0', // 公假 emerald-200
  4: '#fef08a', // oncall yellow-200
  5: '#99f6e4', // 有薪假 teal-200
  6: '#fecdd3', // 無薪假 rose-200
  7: '#e2e8f0', // 行政 slate-200
}
const SHIFT_TEXT: Record<number, string> = {
  0: '#0369a1',
  1: '#92400e',
  2: '#5b21b6',
  3: '#065f46',
  4: '#713f12',
  5: '#134e4a',
  6: '#9f1239',
  7: '#475569',
}

function EventContent({ info }: { info: EventContentArg }) {
  const { name, code } = info.event.extendedProps as { name: string; code: string }
  return (
    <div className="flex items-center gap-1 px-1 py-0.5 w-full overflow-hidden">
      <span
        className="inline-flex items-center justify-center rounded text-[10px] font-bold shrink-0 w-5 h-4"
        style={{
          backgroundColor: info.event.backgroundColor,
          color: info.event.textColor,
          border: `1px solid ${info.event.textColor}33`,
        }}
      >
        {code || name.slice(0, 1)}
      </span>
      <span className="text-[11px] truncate text-foreground leading-none">
        {info.event.title}
      </span>
    </div>
  )
}

export default function SchedulePage() {
  const now = new Date()
  const [year, setYear] = useState(now.getFullYear())
  const [month, setMonth] = useState(now.getMonth() + 1)
  const calendarRef = useRef<FullCalendar>(null)

  const { data: results = [] } = useResults(year, month)
  const { data: staff = [] } = useStaff()

  const staffMap = Object.fromEntries(staff.map(u => [u.id, u]))

  const events = results.map(r => ({
    id: String(r.id),
    title: staffMap[r.user]?.full_name || staffMap[r.user]?.username || String(r.user),
    date: r.date,
    backgroundColor: SHIFT_BG[r.shift_type] ?? '#f1f5f9',
    textColor: SHIFT_TEXT[r.shift_type] ?? '#64748b',
    borderColor: 'transparent',
    extendedProps: {
      code: r.shift.code,
      name: r.shift.name,
      shiftType: r.shift_type,
      station: r.station?.name,
    },
  }))

  const prevMonth = () => {
    calendarRef.current?.getApi().prev()
    if (month === 1) { setYear(y => y - 1); setMonth(12) }
    else setMonth(m => m - 1)
  }
  const nextMonth = () => {
    calendarRef.current?.getApi().next()
    if (month === 12) { setYear(y => y + 1); setMonth(1) }
    else setMonth(m => m + 1)
  }
  const toToday = () => {
    calendarRef.current?.getApi().today()
    setYear(now.getFullYear())
    setMonth(now.getMonth() + 1)
  }

  return (
    <div className="p-4">
      <div className="flex items-center gap-2 mb-4">
        <Button variant="outline" size="sm" onClick={toToday}>今天</Button>
        <Button variant="outline" size="sm" onClick={prevMonth}>‹</Button>
        <Button variant="outline" size="sm" onClick={nextMonth}>›</Button>
        <span className="text-base font-semibold">
          {year} 年 {month} 月
        </span>
      </div>

      <FullCalendar
        ref={calendarRef}
        plugins={[dayGridPlugin]}
        initialView="dayGridMonth"
        locale="zh-tw"
        headerToolbar={false}
        events={events}
        eventContent={(info) => <EventContent info={info} />}
        dayMaxEvents={6}
        height="auto"
        firstDay={0}
      />
    </div>
  )
}
