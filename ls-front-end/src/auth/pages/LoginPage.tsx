import { useState } from "react";
import { TextField, Button, Box, Typography, Link, Grid } from "@mui/material";
// import { useAuth } from "react-oidc-context";
import AuthLayout from "./AuthLayout";
import useAuthUserApi from "../api/useAuthUserApi";
import { useNavigate } from "react-router-dom";
import { useAuthContext } from "../hooks/AuthContext";

interface UserLoginForm {
  Username: string;
  Password: string;
}

export default function LoginPage() {
  // const auth = useAuth();
  const navigate = useNavigate();
  const { loginUser } = useAuthUserApi();
  const { login } = useAuthContext();
  const [userLoginForm, setUserLoginForm] = useState<UserLoginForm>({
    Username: "",
    Password: "",
  });
  //  const [error, setError] = useState<string | null>(null);
  //  const [result, setResult] = useState<any>(null);

  const handleUserLoginFormChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
        setUserLoginForm({ ...userLoginForm, [e.target.name]: e.target.value });
  };

  // const handleChange = (e: React.ChangeEvent<HTMLInputElement>) =>
  //   setForm({ ...form, [e.target.name]: e.target.value });

  const handleUserLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    // setError(null);
    // setResult(null);

    try {
          const userLoginData = new FormData();
          userLoginData.append("Username", userLoginForm.Username);
          userLoginData.append("Password", userLoginForm.Password);

          const data = await loginUser(userLoginData);

          // Save session securely (localStorage or sessionStorage)
          localStorage.setItem("accessToken", data.accessToken);
          localStorage.setItem("idToken", data.idToken);
          localStorage.setItem("refreshToken", data.refreshToken);

          // setResult(data);
        
          // ✅ mark user as authenticated
          login(data.accessToken);
            
          // Redirect to login page. Dashboard
          navigate("/lafiyaSira");
      } catch (err: any) {
            // setError(err.message || "Échec de la création de l'utilisateur");
      }
    // Redirect to Cognito OIDC login
    // auth.signinRedirect();
  };

  return (
    <>
      <AuthLayout />
      <Box sx={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        minHeight: "10vh",
        maxHeight: "8vh"
      }}>
        <Grid size={8}  sx={{maxWidth: '35%', borderRadius: 10, boxShadow: 20, p: 2}}>
          <Box component="form" onSubmit={handleUserLogin} sx={{ textAlign: "center",}}>
            <Typography variant="h6" gutterBottom>
              Se connecter à votre compte
            </Typography>

            <TextField
              label="Nom d'utilisateur"
              name="Username"
              type="text"
              fullWidth
              margin="normal"
              onChange={handleUserLoginFormChange}
            />
            <TextField
              label="Mot de passe"
              name="Password"
              type="password"
              fullWidth
              margin="normal"
              onChange={handleUserLoginFormChange}
            />

            <Button
              fullWidth
              variant="contained"
              size="large"
              sx={{ mt: 3 }}
              type="submit"
            >
              Se connecter
            </Button>

            <Box sx={{ textAlign: "center", mt: 2 }}>
              <Typography variant="body2">
                Vous n'avez pas encore de compte ?{" "}
                <Link href="/home/signup" underline="hover">
                  Créer un compte
                </Link>
              </Typography>
            </Box>
          </Box>
        </Grid>
        
      </Box>
    </>
  );
}
