import { IconButton, Tooltip } from '@mui/material';
import { LightMode, DarkMode } from '@mui/icons-material';
import { useThemeMode } from './ThemeContext';
import { motion } from 'framer-motion';

const ThemeToggle = () => {
  const { mode, toggleMode } = useThemeMode();

  return (
    <Tooltip title={mode === 'light' ? 'Switch to Dark Mode' : 'Switch to Light Mode'}>
      <motion.div
        whileTap={{ scale: 0.9 }}
        style={{
          position: 'fixed',
          bottom: 24,
          right: 24,
          zIndex: 1000,
        }}
      >
        <IconButton
          onClick={toggleMode}
          sx={{
            backgroundColor: 'background.paper',
            boxShadow: 3,
            borderRadius: '50%',
            width: 48,
            height: 48,
            '&:hover': {
              backgroundColor: 'action.hover',
            },
          }}
        >
          {mode === 'light' ? (
            <DarkMode color="primary" />
          ) : (
            <LightMode color="warning" />
          )}
        </IconButton>
      </motion.div>
    </Tooltip>
  );
};

export default ThemeToggle;
