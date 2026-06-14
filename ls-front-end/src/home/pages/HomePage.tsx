// HomePage.tsx
import { Box, Button, Paper, Grid, Typography } from "@mui/material";
import { useNavigate } from "react-router-dom";
import { useEffect } from "react";
import LoginButton from "../../auth/hooks/LoginButton";
import logo from "../../assets/lafiya_sira_logo.png";
import welcomeImg from "../../assets/welcome_page.png";
import { useAuthContext } from "../../auth/hooks/AuthContext";

export default function HomePage() {
  const navigate = useNavigate();
  // const auth = useAuth();
  const { isAuthenticated } = useAuthContext(); 

  useEffect(() => {
    if (isAuthenticated) {
      navigate("/lafiyaSira", { replace: true });
    }
  }, [isAuthenticated, navigate]);

  return (
    <>
      <Box
        sx={{
          height: "100vh", // full page
          width: "100vw",
          display: "flex",
          flexDirection: "column",
          alignItems: "center",
          // justifyContent: "center",
          justifyContent: "space-between",
          p: 2,
          boxSizing: "border-box",
        }}
      >
        {/* Top row: Logo + centered text */}
        <Box
          sx={{
            width: "100%",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            position: "relative", // for absolute logo positioning
            //mb: 0,
          }}
        >
          {/* Logo */}
          <Box
            component="img"
            src={logo}
            alt="Logo"
            sx={{
              position: "absolute",
              left: 210,
              height: 150,
              width: "auto",
            }}
          />
            {/* Centered text */}
            <Typography variant="h4" textAlign="center">
              Bienvenue ! Votre Santé, Notre Priorité.
              <Typography sx={{ fontStyle: 'italic' }}>
                Ika Kɛnɛya, An ka lafiya!
              </Typography>
            </Typography>
        </Box>

        {/* Big Grid */}
        <Grid
          container
          sx={{
            width: "80%",
            height: "40%", // big grid takes 40% of page height
            mb: 2,
          }}
        >
          <Grid
            size={12}
            sx={{
              //bgcolor: "primary.main",
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
              color: "white",
              borderRadius: 2,
            }}
          >
            {/* <Typography variant="h5">Big Grid</Typography> */}
            <Box
              component="img"
              src={welcomeImg}
              alt="Logo"
              sx={{
                position: "absolute",
                height: 310,
                width: "auto",
              }}
            />
          </Grid>
        </Grid>
        {/* Two smaller grids */}
        <Grid container spacing={2} sx={{ width: "60%", height: "30%" }}>
          <Grid
            size={6}
            sx={{
              //bgcolor: "secondary.main",
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
              color: "white",
              borderRadius: 2,
            }}
          >
            {/* <Typography>Small Grid 1</Typography> */}
            <Paper elevation={4} sx={{ p: 4, borderRadius: 3, textAlign: "center" }}>
              <Typography variant="h5" gutterBottom>
                Patient / Personnel existant
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Connectez-vous pour accéder à vos dossiers, rendez-vous et outils cliniques.
              </Typography>
              <LoginButton />
            </Paper>
          </Grid>

          <Grid
            size={6}
            sx={{
              //bgcolor: "secondary.main",
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
              color: "white",
              borderRadius: 2,
            }}
          >
            {/* <Typography>Small Grid 2</Typography> */}
            <Paper elevation={4} sx={{ p: 4, borderRadius: 3, textAlign: "center" }}>
              <Typography variant="h5" gutterBottom>
                Nouveau Patient
              </Typography>
              <Typography variant="body2" color="text.secondary" gutterBottom>
                Prenez rendez-vous rapidement sans créer de compte.
              </Typography>
              <Button
                fullWidth
                variant="outlined"
                size="large"
                sx={{ mt: 4 }}
                onClick={() => navigate("/home/appointments")}
              >
                Planifier un rendez-vous
              </Button>
            </Paper>
          </Grid>
        </Grid>

        {/* Footer */}
        <Box sx={{ mt: 2, textAlign: "center" }}>
          <Box sx={{ display: "flex", justifyContent: "center", alignItems: "center", gap: 1 }}>
            <Box component="img" src={logo} alt="LafiyaSira" sx={{ height: 16 }} />
            <Typography variant="caption" color="text.secondary">
              Powered by LafiyaSira
            </Typography>
          </Box>
        </Box>

      </Box>
    </>
  );
}
