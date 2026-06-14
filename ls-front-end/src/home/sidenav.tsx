import { styled, useTheme, type Theme, type CSSObject } from '@mui/material/styles';
import Box from '@mui/material/Box';
import MuiDrawer from '@mui/material/Drawer';
import MuiAppBar, { type AppBarProps as MuiAppBarProps } from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import List from '@mui/material/List';
import CssBaseline from '@mui/material/CssBaseline';
import Typography from '@mui/material/Typography';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import ChevronLeftIcon from '@mui/icons-material/ChevronLeft';
import ChevronRightIcon from '@mui/icons-material/ChevronRight';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import { Link, Outlet, useNavigate } from 'react-router-dom';
import GridViewIcon from '@mui/icons-material/GridView';
import EventAvailableIcon from '@mui/icons-material/EventAvailable';
import logo from '../assets/lafiya_sira_logo.png';
import { useState } from 'react';
import PersonIcon from "@mui/icons-material/Person";
import LocalHospitalIcon from "@mui/icons-material/LocalHospital";
import AccountCircleIcon from "@mui/icons-material/AccountCircle";
import NotificationsIcon from "@mui/icons-material/Notifications";
import AccountBalanceIcon from "@mui/icons-material/AccountBalance";
import { AccountCircle } from '@mui/icons-material';
import { Menu, MenuItem, Tooltip } from '@mui/material';
import { useAuthContext } from '../auth/hooks/AuthContext';

const drawerWidth = 270;

const openedMixin = (theme: Theme): CSSObject => ({
  width: drawerWidth,
  transition: theme.transitions.create('width', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.enteringScreen,
  }),
  overflowX: 'hidden',
});

const closedMixin = (theme: Theme): CSSObject => ({
  transition: theme.transitions.create('width', {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  overflowX: 'hidden',
  width: `calc(${theme.spacing(7)} + 1px)`,
  [theme.breakpoints.up('sm')]: {
    width: `calc(${theme.spacing(8)} + 1px)`,
  },
});

const DrawerHeader = styled('div')(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'flex-end',
  padding: theme.spacing(0, 1),
  // necessary for content to be below app bar
  ...theme.mixins.toolbar,
}));

interface AppBarProps extends MuiAppBarProps {
  open?: boolean;
}

const AppBar = styled(MuiAppBar, {
  shouldForwardProp: (prop) => prop !== 'open',
})<AppBarProps>(({ theme }) => ({
  zIndex: theme.zIndex.drawer + 1,
  transition: theme.transitions.create(['width', 'margin'], {
    easing: theme.transitions.easing.sharp,
    duration: theme.transitions.duration.leavingScreen,
  }),
  variants: [
    {
      props: ({ open }) => open,
      style: {
        marginLeft: drawerWidth,
        width: `calc(100% - ${drawerWidth}px)`,
        transition: theme.transitions.create(['width', 'margin'], {
          easing: theme.transitions.easing.sharp,
          duration: theme.transitions.duration.enteringScreen,
        }),
      },
    },
  ],
}));

const Drawer = styled(MuiDrawer, { shouldForwardProp: (prop) => prop !== 'open' })(
  ({ theme }) => ({
    width: drawerWidth,
    flexShrink: 0,
    whiteSpace: 'nowrap',
    boxSizing: 'border-box',
    variants: [
      {
        props: ({ open }) => open,
        style: {
          ...openedMixin(theme),
          '& .MuiDrawer-paper': openedMixin(theme),
        },
      },
      {
        props: ({ open }) => !open,
        style: {
          ...closedMixin(theme),
          '& .MuiDrawer-paper': closedMixin(theme),
        },
      },
    ],
  }),
);

export default function Sidenav() {

  // const auth = useAuth();
  // const navigate = useNavigate();

  // const signOutRedirect = () => {
  //   const clientId = "5tisfu6e2rhtaam5auuompbpk2";
  //   const logoutUri = "http://localhost:5173";
  //   const cognitoDomain = "https://us-east-2pgv1qdwvk.auth.us-east-2.amazoncognito.com";
  //   window.location.href = `${cognitoDomain}/logout?client_id=${clientId}&logout_uri=${encodeURIComponent(logoutUri)}`;
  // };

  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const handleMenu = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };
  const handleClose = () => {
    setAnchorEl(null);
  };
  const navigate = useNavigate();
  const { isAuthenticated, logout } = useAuthContext(); 
  // const [loading, setLoading] = useState(false);
  if (!isAuthenticated) return null;
  const handleLogout = async () => {
    try {

      // setLoading(true);
      // Clear local session (tokens cached in oidc-client)
      logout();

      // Redirect to login page. Dashboard
      navigate("/home");
    } catch (err) {
      console.error("Logout failed", err);
    }
  };

  const theme = useTheme();
  const [open, setOpen] = useState(true);

  const handleDrawerOpen = () => {
    setOpen(true);
  };

  const handleDrawerClose = () => {
    setOpen(false);
  };
  

  return (
    <Box sx={{ display: 'flex' }}>
      <CssBaseline />
      <AppBar position="fixed" open={open}
        sx={{
            backgroundColor: 'white', // green color
            // color: '#fff', // white text/icons
        }}
      >
        <Toolbar>
          <IconButton
            color="inherit"
            aria-label="open drawer"
            onClick={handleDrawerOpen}
            edge="start"
            sx={[
              {
                marginRight: 5,
              },
              open && { display: 'none' },
            ]}
          >
            <MenuIcon sx={{color:"#35454f"}}/>
          </IconButton>
          {/* <AdbIcon sx={{ display: { xs: 'none', md: 'flex' }, mr: 1 }} /> */}
          <img src={logo} alt="Clinic Logo" style={{ height: "10rem", maxHeight: "64px", marginRight: 8 }} />
          <Typography variant="h6" noWrap component="div" sx={{ flexGrow: 1, color: "#0E8EA8" }}>
            Lafiya Sira Clinic
          </Typography>
              
              <IconButton
                size="large"
                aria-label="account of current user"
                aria-controls="menu-appbar"
                aria-haspopup="true"
                onClick={handleMenu}
                color="inherit"
              >
                <AccountCircle sx={{ color: "#0E8EA8"}}/>
              </IconButton>
              <Menu
                id="menu-appbar"
                anchorEl={anchorEl}
                anchorOrigin={{
                  vertical: 'bottom',
                  horizontal: 'left',
                }}
                keepMounted
                transformOrigin={{
                  vertical: 'top',
                  horizontal: 'left',
                }}
                open={Boolean(anchorEl)}
                onClose={handleClose}
              >
                <MenuItem sx={{alignItems:"center"}} component={Link}
                to="/lafiyaSira/profile">Profil</MenuItem>
                {/* <LogoutButton /> */}
                <MenuItem onClick={handleLogout}>Déconnexion</MenuItem>
              </Menu>
        </Toolbar>
      </AppBar>
      <Drawer variant="permanent" open={open}>
        <DrawerHeader>
          <IconButton onClick={handleDrawerClose}>
            {theme.direction === 'rtl' ? <ChevronRightIcon sx={{ color: "black" }}/> : <ChevronLeftIcon/>}
          </IconButton>
        </DrawerHeader>
        <Divider />
        <List>

          {/* Dashboard section */}
          <ListItem disablePadding sx={{ display: 'block' }}>
              <ListItemButton
                component={Link}
                to="/lafiyaSira"
                sx={[
                  {
                    minHeight: 48,
                    px: 2.5,
                  },
                  open
                    ? {
                        justifyContent: 'initial',
                      }
                    : {
                        justifyContent: 'center',
                      },
                ]}
              >
                <ListItemIcon
                  sx={[
                    {
                      minWidth: 0,
                      justifyContent: 'center',
                    },
                    open
                      ? {
                          mr: 3,
                        }
                      : {
                          mr: 'auto',
                        },
                  ]}
                >
                  {/* <InboxIcon /> */}
                  <GridViewIcon />
                </ListItemIcon>
                <ListItemText
                  primary="Tableau de Bord"
                  sx={[
                    open
                      ? {
                          opacity: 1,
                        }
                      : {
                          opacity: 0,
                        },
                  ]}
                />
              </ListItemButton>
            </ListItem>
            
            {/* Appointment section */}
            <ListItem disablePadding sx={{ display: 'block' }}>
              <Tooltip title="Rendez-vous" placement="right-start" slotProps={{tooltip: {sx:{padding: "14px 12px", color: "#35454f"}}}}>
                <ListItemButton
                component={Link}
                to="/lafiyaSira/appointmentManagement"
                sx={[
                  {
                    minHeight: 48,
                    px: 2.5,
                  },
                  open
                    ? {
                        justifyContent: 'initial',
                      }
                    : {
                        justifyContent: 'center',
                      },
                ]}
                >
                  <ListItemIcon
                    sx={[
                      {
                        minWidth: 0,
                        justifyContent: 'center',
                      },
                      open
                        ? {
                            mr: 3,
                          }
                        : {
                            mr: 'auto',
                          },
                    ]}
                  >
                    <EventAvailableIcon />
                  </ListItemIcon>
                  <ListItemText
                    primary="Rendez-vous"
                    sx={[
                      open
                        ? {
                            opacity: 1,
                          }
                        : {
                            opacity: 0,
                          },
                    ]}
                  />
                </ListItemButton>
              </Tooltip>

              
            </ListItem>

            {/* Billing section */}
            <ListItem disablePadding sx={{ display: 'block' }}>
              <ListItemButton
                component={Link}
                to="/lafiyaSira/billingManagement"
                sx={[
                  {
                    minHeight: 48,
                    px: 2.5,
                  },
                  open
                    ? {
                        justifyContent: 'initial',
                      }
                    : {
                        justifyContent: 'center',
                      },
                ]}
              >
                <ListItemIcon
                  sx={[
                    {
                      minWidth: 0,
                      justifyContent: 'center',
                    },
                    open
                      ? {
                          mr: 3,
                        }
                      : {
                          mr: 'auto',
                        },
                  ]}
                >
                  <AccountBalanceIcon />
                </ListItemIcon>
                <ListItemText
                  primary="Gestion de la facturation"
                  sx={[
                    open
                      ? {
                          opacity: 1,
                        }
                      : {
                          opacity: 0,
                        },
                  ]}
                />
              </ListItemButton>
            </ListItem>

            {/* Notification section */}
            <ListItem disablePadding sx={{ display: 'block' }}>
              <ListItemButton
                component={Link}
                to="/lafiyaSira/notificationManagement"
                sx={[
                  {
                    minHeight: 48,
                    px: 2.5,
                  },
                  open
                    ? {
                        justifyContent: 'initial',
                      }
                    : {
                        justifyContent: 'center',
                      },
                ]}
              >
                <ListItemIcon
                  sx={[
                    {
                      minWidth: 0,
                      justifyContent: 'center',
                    },
                    open
                      ? {
                          mr: 3,
                        }
                      : {
                          mr: 'auto',
                        },
                  ]}
                >
                  <NotificationsIcon />
                </ListItemIcon>
                <ListItemText
                  primary="Gestion des Notifications"
                  sx={[
                    open
                      ? {
                          opacity: 1,
                        }
                      : {
                          opacity: 0,
                        },
                  ]}
                />
              </ListItemButton>
            </ListItem>
            
            {/* Doctor section */}
            <ListItem disablePadding sx={{ display: 'block' }}>
              <ListItemButton
                component={Link}
                to="/lafiyaSira/doctorManagement"
                sx={[
                  {
                    minHeight: 48,
                    px: 2.5,
                  },
                  open
                    ? {
                        justifyContent: 'initial',
                      }
                    : {
                        justifyContent: 'center',
                      },
                ]}
              >
                <ListItemIcon
                  sx={[
                    {
                      minWidth: 0,
                      justifyContent: 'center',
                    },
                    open
                      ? {
                          mr: 3,
                        }
                      : {
                          mr: 'auto',
                        },
                  ]}
                >
                  <LocalHospitalIcon />
                </ListItemIcon>
                <ListItemText
                  primary="Gestion des Médecins"
                  sx={[
                    open
                      ? {
                          opacity: 1,
                        }
                      : {
                          opacity: 0,
                        },
                  ]}
                />
              </ListItemButton>
            </ListItem>

            {/* Patient section */}
            <ListItem disablePadding sx={{ display: 'block' }}>
              <ListItemButton
                component={Link}
                to="/lafiyaSira/patientManagement"
                sx={[
                  {
                    minHeight: 48,
                    px: 2.5,
                  },
                  open
                    ? {
                        justifyContent: 'initial',
                      }
                    : {
                        justifyContent: 'center',
                      },
                ]}
              >
                <ListItemIcon
                  sx={[
                    {
                      minWidth: 0,
                      justifyContent: 'center',
                    },
                    open
                      ? {
                          mr: 3,
                        }
                      : {
                          mr: 'auto',
                        },
                  ]}
                >
                  <PersonIcon />
                </ListItemIcon>
                <ListItemText
                  primary="Gestion des Patients"
                  sx={[
                    open
                      ? {
                          opacity: 1,
                        }
                      : {
                          opacity: 0,
                        },
                  ]}
                />
              </ListItemButton>
            </ListItem>

            {/* User section */}
            <ListItem disablePadding sx={{ display: 'block' }}>
              <ListItemButton
                component={Link}
                to="/lafiyaSira/userManagement"
                sx={[
                  {
                    minHeight: 48,
                    px: 2.5,
                  },
                  open
                    ? {
                        justifyContent: 'initial',
                      }
                    : {
                        justifyContent: 'center',
                      },
                ]}
              >
                <ListItemIcon
                  sx={[
                    {
                      minWidth: 0,
                      justifyContent: 'center',
                    },
                    open
                      ? {
                          mr: 3,
                        }
                      : {
                          mr: 'auto',
                        },
                  ]}
                >
                  <AccountCircleIcon />
                </ListItemIcon>
                <ListItemText
                  primary="Gestion des Utilisateurs"
                  sx={[
                    open
                      ? {
                          opacity: 1,
                        }
                      : {
                          opacity: 0,
                        },
                  ]}
                />
              </ListItemButton>
            </ListItem>

            {/* Users section */}

            {/*  */}
        </List>
      </Drawer>
      <Box component="main" sx={{ flexGrow: 1, overflow: 'hidden',}}>
        <DrawerHeader />
        <Outlet />
      </Box>
    </Box>
  );
}