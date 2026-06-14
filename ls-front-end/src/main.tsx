import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.tsx'
import { ThemeModeProvider } from './theme/ThemeContext.tsx'
import { AuthProvider } from './auth/hooks/AuthContext.tsx'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <ThemeModeProvider>
      {/* {...oidcConfig} */}
      <AuthProvider >
        <App />
      </AuthProvider>
    </ThemeModeProvider>
  </StrictMode>
)
