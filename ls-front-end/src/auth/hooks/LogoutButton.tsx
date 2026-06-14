import { Button, CircularProgress } from "@mui/material";
import { useState } from "react";
import { useAuthContext } from "./AuthContext";
import { useNavigate } from "react-router-dom";

export default function LogoutButton() {
  // const auth = useAuth();
  const navigate = useNavigate();
  const { isAuthenticated, logout } = useAuthContext(); 
  const [loading, setLoading] = useState(false);

  if (!isAuthenticated) return null;

  const handleLogout = async () => {
    try {

      setLoading(true);
      // Clear local session (tokens cached in oidc-client)
      logout();

      // Build Cognito logout URL
      // const clientId = "5tisfu6e2rhtaam5auuompbpk2";
      // const logoutUri = "http://localhost:5173/home";
      // const cognitoDomain = "https://us-east-2pgv1qdwvk.auth.us-east-2.amazoncognito.com";

      // // Redirect to Cognito hosted logout
      // window.location.href = `${cognitoDomain}/logout?client_id=${clientId}&logout_uri=${encodeURIComponent(logoutUri)}`;

      // Redirect to login page. Dashboard
      navigate("/home");
    } catch (err) {
      console.error("Logout failed", err);
    }
  };

  return (
    <Button variant="outlined" onClick={handleLogout} disabled={loading}
      startIcon={loading ? <CircularProgress size={18} /> : null}>
      Déconnexion
    </Button>
  );
}
