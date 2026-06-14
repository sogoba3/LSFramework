// import { useAuth } from "react-oidc-context";
import { Button } from "@mui/material";
import { useNavigate } from "react-router-dom";

export default function LoginButton() {
  const navigate = useNavigate();
  // const auth = useAuth();

  return (
    <Button
      fullWidth
      variant="contained"
      size="large"
      sx={{ mt: 4 }}
      onClick={() => navigate("/home/signin")}
    >
      Se connecter / S'inscrire
    </Button>
  );
}