import path from 'path'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [react(), tailwindcss()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost',
        changeOrigin: true,
      },
      '/en': { target: 'http://localhost', changeOrigin: true },
      '/zh-hant': { target: 'http://localhost', changeOrigin: true },
    },
  },
})
