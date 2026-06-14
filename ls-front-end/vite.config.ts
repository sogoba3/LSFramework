import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: 'localhost', // you can change this to '0.0.0.0' to allow LAN access
    port: 4444,        // change this to another port like 3000
  },
})
