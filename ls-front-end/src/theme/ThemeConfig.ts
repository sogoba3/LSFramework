// theme.ts
import { createTheme, type ThemeOptions } from '@mui/material/styles';

const commonTypography: ThemeOptions['typography'] = {
  fontFamily: '"Inter", "Roboto", "Helvetica", "Arial", sans-serif',
  h1: { fontWeight: 700, fontSize: '2.5rem' },
  h2: { fontWeight: 600, fontSize: '2rem' },
  h3: { fontWeight: 600, fontSize: '1.75rem' },
  body1: { fontSize: '1rem' },
  body2: { fontSize: '0.875rem' },
  button: { textTransform: 'none', fontWeight: 600 },
};

const commonSettings: ThemeOptions = {
  typography: commonTypography,
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          borderRadius: '12px',
          padding: '10px 20px',
        },
      },
    },
    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: '16px',
          boxShadow: '0 2px 10px rgba(0,0,0,0.05)',
        },
      },
    },
  },
};

export const lightTheme = createTheme({
  ...commonSettings,
  palette: {
    mode: 'light',
    primary: {
      main: '#0E8EA8', // Teal Blue
      contrastText: '#FFFFFF',
    },
    secondary: {
      main: '#36B37E', // Green
      contrastText: '#FFFFFF',
    },
    warning: {
      main: '#F9A826', // Amber
      contrastText: '#1E293B',
    },
    error: {
      main: '#D93025',
      contrastText: '#FFFFFF',
    },
    success: {
      main: '#2E7D32',
      contrastText: '#FFFFFF',
    },
    background: {
      default: '#F4F6F8', // Gray background (portal)
      paper: '#FFFFFF',   // Cards/surfaces
    },
    text: {
      primary: '#1E293B',   // Charcoal Gray
      secondary: '#64748B', // Muted labels
    },
  },
  typography: {
    ...commonTypography,
    h1: { ...commonTypography.h1, color: '#0F4C81' }, // Deep Blue headings
    h2: { ...commonTypography.h2, color: '#0F4C81' },
    h3: { ...commonTypography.h3, color: '#0E8EA8' },
    body1: { ...commonTypography.body1, color: '#1E293B' },
    body2: { ...commonTypography.body2, color: '#64748B' },
  },
});

export const darkTheme = createTheme({
  ...commonSettings,
  palette: {
    mode: 'dark',
    primary: {
      main: '#0E8EA8', // Still teal
      contrastText: '#FFFFFF',
    },
    secondary: {
      main: '#36B37E',
      contrastText: '#FFFFFF',
    },
    warning: {
      main: '#F9A826',
      contrastText: '#0F172A',
    },
    error: {
      main: '#EF5350',
      contrastText: '#FFFFFF',
    },
    success: {
      main: '#4CAF50',
      contrastText: '#FFFFFF',
    },
    background: {
      default: '#0F172A', // Dark navy-gray
      paper: '#1E293B',   // Card/dash backgrounds
    },
    text: {
      primary: '#F8FAFC', // Soft white
      secondary: '#CBD5E1', // Light gray-blue
    },
  },
  typography: {
    ...commonTypography,
    h1: { ...commonTypography.h1, color: '#E2E8F0' },
    h2: { ...commonTypography.h2, color: '#E2E8F0' },
    h3: { ...commonTypography.h3, color: '#0E8EA8' },
    body1: { ...commonTypography.body1, color: '#F8FAFC' },
    body2: { ...commonTypography.body2, color: '#CBD5E1' },
  },
});
