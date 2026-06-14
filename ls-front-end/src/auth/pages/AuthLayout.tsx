import { Box, Typography } from "@mui/material";
import logo from "../../assets/lafiya_sira_logo.png";

export default function AuthLayout() {
  return (
    <Box
      maxWidth="xs"
      sx={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        minHeight: "50vh",
      }}
    >
      <Box sx={{ textAlign: "center", mb: 25, }}>
        <img src={logo} alt="Clinique" style={{ width: "200px" }} />
        <Typography variant="h5" sx={{ mt: 2, color: "primary.main" }}>
          LafiyaSira Portail
        </Typography>
      </Box>
    </Box>
  );
}
