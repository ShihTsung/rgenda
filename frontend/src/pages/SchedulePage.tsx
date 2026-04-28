import FullCalendar from '@fullcalendar/react'
import dayGridPlugin from '@fullcalendar/daygrid'
import type { EventContentArg, EventClickArg } from '@fullcalendar/core'
import { useRef, useState } from 'react'
import { Button } from '@/components/ui/button'
import { Sheet, SheetContent, SheetHeader, SheetTitle } from '@/components/ui/sheet'
import { useResults, useStaff } from '@/api/schedule'

const SHIFT_BG: Record<number, string> = {
  0: '#bae6fd',
  1: '#fde68a',
  2: '#ddd6fe',
  3: '#a7f3d0',
  4: '#fef08a',
  5: '#99f6e4',
  6: '#fecdd3',
  7: '#e2e8f0',
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
const SHIFT_TYPE_LABEL: Record<number, string> = {
  0: '白班', 1: '小夜', 2: '大夜', 3: '公假',
  4: 'Oncall', 5: '有薪假', 6: '無薪假', 7: '行政',
}

interface EventProps {
  name: string; code: string; shiftType: number
  station: string; userName: string; date: string
}

function EventContent({ info }: { info: EventContentArg }) {
  const { code, name } = info.event.extendedProps as EventProps
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
  const [selected, setSelected] = useState<EventProps | null>(null)

  const { data: results = [] } = useResults(year, month)
  const { data: staff = [] } = useStaff()

  const staffMap = Object.fromEntries(staff.map(u => [u.id, u]))

  const events = results.map(r => {
    const user = staffMap[r.user]
    return {
      id: String(r.id),
      title: user?.full_name || user?.username || String(r.user),
      date: r.date,
      backgroundColor: SHIFT_BG[r.shift_type] ?? '#f1f5f9',
      textColor: SHIFT_TEXT[r.shift_type] ?? '#64748b',
      borderColor: 'transparent',
      extendedProps: {
        code: r.shift.code,
        name: r.shift.name,
        shiftType: r.shift_type,
        station: r.station?.name ?? '',
        userName: user?.full_name || user?.username || String(r.user),
        date: r.date,
      } satisfies EventProps,
    }
  })

  const handleEventClick = (arg: EventClickArg) => {
    setSelected(arg.event.extendedProps as EventProps)
  }

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
        <span className="text-base font-semibold">{year} 年 {month} 月</span>
      </div>

      <FullCalendar
        ref={calendarRef}
        plugins={[dayGridPlugin]}
        initialView="dayGridMonth"
        locale="zh-tw"
        headerToolbar={false}
        events={events}
        eventContent={(info) => <EventContent info={info} />}
        eventClick={handleEventClick}
        dayMaxEvents={6}
        height="auto"
        firstDay={0}
      />

      <Sheet open={!!selected} onOpenChange={open => !open && setSelected(null)}>
        <SheetContent side="right" className="w-72">
          {selected && (
            <>
              <SheetHeader>
                <SheetTitle>{selected.userName}</SheetTitle>
              </SheetHeader>
              <div className="mt-4 space-y-3 text-sm">
                <Row label="日期" value={selected.date} />
                <Row label="班別" value={selected.name} />
                <Row label="類型" value={SHIFT_TYPE_LABEL[selected.shiftType] ?? '-'} />
                <Row label="工作站" value={selected.station || '-'} />
                <div className="pt-2">
                  <span
                    className="inline-block px-2 py-0.5 rounded text-xs font-medium"
                    style={{
                      backgroundColor: SHIFT_BG[selected.shiftType] ?? '#f1f5f9',
                      color: SHIFT_TEXT[selected.shiftType] ?? '#64748b',
                    }}
                  >
                    {SHIFT_TYPE_LABEL[selected.shiftType]}
                  </span>
                </div>
              </div>
            </>
          )}
        </SheetContent>
      </Sheet>
    </div>
  )
}

function Row({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex justify-between">
      <span className="text-muted-foreground">{label}</span>
      <span className="font-medium">{value}</span>
    </div>
  )
}
