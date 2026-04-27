import { NavLink, Outlet } from 'react-router-dom'
import { useAuthStore } from '@/store/auth'
import { logout } from '@/api/auth'
import { useNavigate } from 'react-router-dom'
import { Button } from '@/components/ui/button'
import { Separator } from '@/components/ui/separator'

const newNavItems = [
  { to: '/schedule', label: '班表' },
  { to: '/dashboard', label: '總覽' },
]

const legacyNavItems = [
  { href: '/zh-hant/', label: '首頁' },
  { href: '/zh-hant/results/', label: '排班結果' },
  { href: '/zh-hant/results/pre_results', label: '預排班' },
  { href: '/zh-hant/shifts/list', label: '班別' },
  { href: '/zh-hant/stations/list', label: '工作站' },
  { href: '/zh-hant/demands/list', label: '需求' },
  { href: '/zh-hant/reserves/reserve', label: '預約' },
  { href: '/zh-hant/dates/date_management', label: '行事曆' },
  { href: '/zh-hant/departments/list', label: '部門' },
]

export default function AppLayout() {
  const { user, logout: clearAuth } = useAuthStore()
  const navigate = useNavigate()

  const handleLogout = async () => {
    try { await logout() } catch { /* ignore */ }
    clearAuth()
    navigate('/login')
  }

  return (
    <div className="min-h-screen flex flex-col">
      <header className="border-b bg-background sticky top-0 z-20 shadow-sm">
        <div className="flex items-center h-12 px-4 gap-3 overflow-x-auto">
          <span className="font-semibold text-primary shrink-0">Rgenda</span>

          <Separator orientation="vertical" className="h-5" />

          {/* 新版頁面 */}
          <nav className="flex gap-1 shrink-0">
            {newNavItems.map(({ to, label }) => (
              <NavLink
                key={to}
                to={to}
                className={({ isActive }) =>
                  `px-3 py-1.5 rounded text-sm transition-colors whitespace-nowrap ${
                    isActive
                      ? 'bg-primary text-primary-foreground'
                      : 'text-muted-foreground hover:text-foreground hover:bg-muted'
                  }`
                }
              >
                {label}
              </NavLink>
            ))}
          </nav>

          <Separator orientation="vertical" className="h-5" />

          {/* 舊版連結 */}
          <a
            href="/zh-hant/accounts/login/"
            target="_blank"
            rel="noopener noreferrer"
            className="px-2 py-1 rounded text-xs bg-amber-100 text-amber-800 hover:bg-amber-200 transition-colors shrink-0 whitespace-nowrap"
          >
            舊版登入
          </a>
          <nav className="flex gap-1">
            {legacyNavItems.map(({ href, label }) => (
              <a
                key={href}
                href={href}
                target="_blank"
                rel="noopener noreferrer"
                className="px-3 py-1.5 rounded text-sm text-muted-foreground hover:text-foreground hover:bg-muted transition-colors whitespace-nowrap"
              >
                {label}
              </a>
            ))}
          </nav>

          <div className="ml-auto flex items-center gap-2 shrink-0">
            <span className="text-sm text-muted-foreground hidden sm:block">{user?.username}</span>
            <Button variant="ghost" size="sm" onClick={handleLogout}>登出</Button>
          </div>
        </div>
      </header>

      <main className="flex-1">
        <Outlet />
      </main>
    </div>
  )
}
