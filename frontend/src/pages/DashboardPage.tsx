import { useState } from 'react'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { useDashboard } from '@/api/dashboard'

interface StatCardProps {
  title: string
  value: number | string
  unit?: string
  highlight?: boolean
}

function StatCard({ title, value, unit = 'hr', highlight }: StatCardProps) {
  return (
    <Card className={highlight ? 'border-primary' : ''}>
      <CardHeader className="pb-1 pt-3 px-4">
        <CardTitle className="text-xs text-muted-foreground font-normal">{title}</CardTitle>
      </CardHeader>
      <CardContent className="px-4 pb-3">
        <span className={`text-2xl font-bold ${highlight ? 'text-primary' : ''}`}>
          {value}
        </span>
        <span className="text-xs text-muted-foreground ml-1">{unit}</span>
      </CardContent>
    </Card>
  )
}

export default function DashboardPage() {
  const now = new Date()
  const [year, setYear] = useState(now.getFullYear())
  const [month, setMonth] = useState(now.getMonth() + 1)

  const { data, isLoading, isError } = useDashboard(year, month)

  const prevMonth = () => {
    if (month === 1) { setYear(y => y - 1); setMonth(12) }
    else setMonth(m => m - 1)
  }
  const nextMonth = () => {
    if (month === 12) { setYear(y => y + 1); setMonth(1) }
    else setMonth(m => m + 1)
  }
  const toToday = () => {
    setYear(now.getFullYear())
    setMonth(now.getMonth() + 1)
  }

  return (
    <div className="p-6 max-w-4xl mx-auto">
      <div className="flex items-center gap-2 mb-6">
        <Button variant="outline" size="sm" onClick={toToday}>本月</Button>
        <Button variant="outline" size="sm" onClick={prevMonth}>‹</Button>
        <Button variant="outline" size="sm" onClick={nextMonth}>›</Button>
        <h2 className="text-lg font-semibold">{year} 年 {month} 月 總覽</h2>
      </div>

      {isLoading && <p className="text-muted-foreground">載入中...</p>}
      {isError && <p className="text-destructive">載入失敗，請確認是否已登入。</p>}

      {data && (
        <div className="space-y-6">
          {/* 工時統計 */}
          <div>
            <h3 className="text-sm font-medium text-muted-foreground mb-3">工時統計（人均）</h3>
            <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
              <StatCard title="平均工時" value={data.avg_workhours} highlight />
              <StatCard title="應上工時" value={data.legal_workhours} />
              <StatCard title="差額" value={data.diff} unit="hr"
                highlight={Math.abs(data.diff) > 5} />
              <StatCard title="加班" value={data.avg_overtime} />
              <StatCard title="減班" value={data.avg_minustime} />
              <StatCard title="Oncall" value={data.avg_oncall} />
              <StatCard title="公假" value={data.official_rest} />
              <StatCard title="人員數" value={data.user_count} unit="人" />
            </div>
          </div>

          {/* 人員類型 */}
          <div>
            <h3 className="text-sm font-medium text-muted-foreground mb-3">人員類型</h3>
            <div className="grid grid-cols-2 sm:grid-cols-3 gap-3">
              {Object.entries(data.staff_types).map(([label, count]) => (
                count > 0 && (
                  <Card key={label}>
                    <CardContent className="flex items-center justify-between px-4 py-3">
                      <span className="text-sm">{label}</span>
                      <span className="text-xl font-bold">{count}</span>
                    </CardContent>
                  </Card>
                )
              ))}
            </div>
          </div>

          {/* 差額說明 */}
          <p className="text-xs text-muted-foreground">
            差額 = （工時 + 加班 - 減班 + Oncall − 應上工時）/ 人數
          </p>
        </div>
      )}
    </div>
  )
}
