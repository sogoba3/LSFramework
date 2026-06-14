import React, { useState } from "react";
import { AppBar, Box, Toolbar, IconButton, Typography, Tabs, Tab, Button, Drawer, List, ListItem, ListItemButton, ListItemText, useTheme, Tooltip } from "@mui/material";
import MenuIcon from "@mui/icons-material/Menu";
import { Link } from "react-router-dom";
import { useThemeMode } from "../../theme/ThemeContext";
import { DarkMode, LightMode } from "@mui/icons-material";
import { motion } from "framer-motion";
import logo from '../../assets/lafiya_sira_logo.png';

const pages = ["Accueil", "Fonctionnalités", "À Propos", "Tarifs", "Contact"];

export default function LandingNav() {
  const [value, setValue] = useState(0);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const theme = useTheme();
  const { mode, toggleMode } = useThemeMode();

  const handleChange = (_event: React.SyntheticEvent, newValue: number) => {
    setValue(newValue);
  };

  return (
    <>
      <AppBar
        position="static"
        sx={{
          backgroundColor:
            mode === "light"
              ? theme.palette.primary.main
              : theme.palette.background.paper,
          boxShadow: "0 2px 10px rgba(0,0,0,0.1)",
          transition: "background-color 0.3s ease",
        }}
      >
        <Toolbar sx={{ display: "flex", justifyContent: "space-between" }}>
          {/* Logo */}
          <Typography
          >
            <Box
                component="img"
                src={logo}
                alt="Clinic Logo"
                sx={{
                height: { xs: 32, sm: 40, md: 48 }, // responsive logo size
                width: "auto",
                objectFit: "contain",
                }}
            />
          </Typography>

          {/* Desktop Tabs */}
          <Box
            sx={{
              flexGrow: 1,
              display: { xs: "none", md: "flex" },
              justifyContent: "center",
            }}
          >
            <Tabs
              value={value}
              onChange={handleChange}
              textColor="inherit"
              sx={{
                "& .MuiTabs-indicator": {
                  backgroundColor: theme.palette.primary.contrastText,
                  height: 3,
                  borderRadius: 3,
                },
              }}
            >
              {pages.map((page) => (
                <Tab
                  key={page}
                  label={page}
                  sx={{
                    color: theme.palette.primary.contrastText,
                    textTransform: "none",
                    fontWeight: 500,
                  }}
                />
              ))}
            </Tabs>
          </Box>

          {/* Desktop Right Actions */}
          <Box sx={{ display: { xs: "none", md: "flex" }, alignItems: "center", gap: 2 }}>
            <Button
              component={Link}
              to="/registration"
              variant="contained"
            >
              Registrer
            </Button>

            {/* 🌙 Theme Toggle Button */}
            <Tooltip title={mode === "light" ? "Dark Mode" : "Light Mode"}>
              <motion.div whileTap={{ scale: 0.9 }}>
                <IconButton
                  onClick={toggleMode}
                  sx={{
                    backgroundColor: theme.palette.background.paper,
                    color: theme.palette.text.primary,
                    borderRadius: "50%",
                    transition: "all 0.3s ease",
                    "&:hover": {
                      backgroundColor: theme.palette.action.hover,
                    },
                  }}
                >
                  {mode === "light" ? <DarkMode /> : <LightMode color="warning" />}
                </IconButton>
              </motion.div>
            </Tooltip>
          </Box>

          {/* Mobile Hamburger */}
          <Box sx={{ display: { xs: "flex", md: "none" } }}>
            <IconButton
              size="large"
              edge="end"
              color="inherit"
              onClick={() => setDrawerOpen(true)}
            >
              <MenuIcon />
            </IconButton>
          </Box>
        </Toolbar>
      </AppBar>

      {/* Mobile Drawer */}
      <Drawer anchor="right" open={drawerOpen} onClose={() => setDrawerOpen(false)}>
        <Box
          sx={{
            width: 250,
            backgroundColor: theme.palette.background.default,
            height: "100%",
          }}
          role="presentation"
        >
          <List>
            {pages.map((page) => (
              <ListItem key={page} disablePadding>
                <ListItemButton component={Link} to="/">
                  <ListItemText
                    primary={page}
                    primaryTypographyProps={{
                      color: theme.palette.text.primary,
                    }}
                  />
                </ListItemButton>
              </ListItem>
            ))}

            <ListItem sx={{ mt: 2 }}>
              <Button
                variant="contained"
                fullWidth
                sx={{
                  backgroundColor: theme.palette.primary.main,
                  color: theme.palette.primary.contrastText,
                  textTransform: "none",
                  borderRadius: "20px",
                  "&:hover": { backgroundColor: theme.palette.primary.dark },
                }}
              >
                Register
              </Button>
            </ListItem>
          </List>
        </Box>
      </Drawer>
    </>
  );
}
