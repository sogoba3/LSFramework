import { useState } from "react";
import { TextField, Button, Box, Typography, Link, Grid, FormControl, InputLabel, Select, MenuItem, Checkbox, FormControlLabel, type SelectChangeEvent, Alert} from "@mui/material";
import AuthLayout from "./AuthLayout";
import useAuthUserApi from "../api/useAuthUserApi";

interface UserRegistrationForm {
    TenantCode: string;
    Username: string;
    FirstName: string;
    LastName: string;
    PhoneNumber: string;
    Email: string | null
    Gender: string;
    Password: string;
    ConfirmPassword: string;
  
}

export default function SignupPage() {
    const { createUser } = useAuthUserApi();
    const [userRegistrationForm, setUserRegistrationForm] = useState<UserRegistrationForm>({
        TenantCode: "",
        Username: "",
        FirstName: "",
        LastName: "",
        PhoneNumber: "+223",
        Email: "",
        Gender: "",
        Password: "",
        ConfirmPassword: "",
    });

    const [result, setResult] = useState<any>(null);
    const [error, setError] = useState<string | null>(null);

    const handleUserRegistrationFormChange = (e: React.ChangeEvent<HTMLInputElement |           HTMLTextAreaElement>) => {
        setUserRegistrationForm({ ...userRegistrationForm, [e.target.name]: e.target.value });
    };
    const handleGenderChange = (event: SelectChangeEvent) => {
            setUserRegistrationForm({ ...userRegistrationForm, Gender: event.target.value});
        };

    const handleUserSignup = async (e: React.FormEvent) => {
        e.preventDefault();
        setError(null);
        setResult(null);
        // 👉 Call your marketing API endpoint: POST /api/tenants/signup
        // Include tenant info, admin name, etc.
        try {
            const userRegistrationData = new FormData();
            userRegistrationData.append("TenantCode", userRegistrationForm.TenantCode);
            userRegistrationData.append("UserName", userRegistrationForm.Username);
            userRegistrationData.append("FirstName", userRegistrationForm.FirstName);
            userRegistrationData.append("LastName", userRegistrationForm.LastName);
            userRegistrationData.append("PhoneNumber", userRegistrationForm.PhoneNumber);
            userRegistrationData.append("Email", userRegistrationForm.Email || "");
            userRegistrationData.append("Gender", userRegistrationForm.Gender);
            userRegistrationData.append("Password", userRegistrationForm.Password);
            userRegistrationData.append("ConfirmPassword", userRegistrationForm.ConfirmPassword);

            const data = await createUser(userRegistrationData);
            setResult(data);
            
            // Redirect to login page. Dashboard
            //window.location.href = "/lafiyaSira";
        } catch (err: any) {
            setError(err.message || "Échec de la création de l'utilisateur");
        }
    };

  return (
    <>
        <AuthLayout />
        <Box sx={{
            display: "flex",
            flexDirection: "column",
            alignItems: "center",
            justifyContent: "center",
            minHeight: "15vh",
            maxHeight: "8vh",
        }}
        >
            {/* bgcolor={"grey"} */}
            <Grid size={8}  sx={{maxWidth: '70%', borderRadius: 10, boxShadow: 20}}>
                <Typography variant="h5" gutterBottom align="center" pt={2}>
                    Créez votre compte
                    </Typography>
                    <Typography variant="body2" color="text.secondary" gutterBottom align="center">
                    Inscrivez-vous pour accéder à votre portail personnalisé.
                </Typography>

                {error && <Alert severity="error">{error}</Alert>}
                {result && (
                <Alert severity="success">
                    🎉 Votre compte a été créé avec succès! <br />
                    Portail: <strong>Connectez-vous à votre compte en utilisant le lien suivant<Link
                    href={`http://${result.tenantSubdomain}.lafiyasira.com`}
                    target="_blank"
                    rel="noopener noreferrer"
                    >
                    {result.tenantSubdomain}.lafiyasira.com
                    </Link>
                    </strong> <br /> 
                    {/* <link>{result.tenantSubdomain}.lafiyasira.com</link>< */}
                </Alert>
                )}

                <Box component="form" onSubmit={handleUserSignup} mt={4} p={4} width="100%">
                    <Grid container spacing={2}>
                        <Grid size={4}>
                        <TextField
                            required
                            fullWidth
                            label="Code de la clinique"
                            name="TenantCode"
                            value={userRegistrationForm.TenantCode}
                            onChange={handleUserRegistrationFormChange}
                        />
                        </Grid>

                        <Grid size={4}>
                        <TextField
                            required
                            fullWidth
                            label="Nom d'utilisateur"
                            name="Username"
                            value={userRegistrationForm.Username}
                            onChange={handleUserRegistrationFormChange}
                        />
                        </Grid>

                        <Grid size={4} >
                        <TextField
                            required
                            fullWidth
                            label="Prénom"
                            name="FirstName"
                            value={userRegistrationForm.FirstName}
                            onChange={handleUserRegistrationFormChange}
                        />
                        </Grid>

                        <Grid size={4}>
                        <TextField
                            required
                            fullWidth
                            label="Nom de famille"
                            name="LastName"
                            value={userRegistrationForm.LastName}
                            onChange={handleUserRegistrationFormChange}
                        />
                        </Grid>

                        <Grid size={4}>
                        <TextField
                            required
                            fullWidth
                            label="Numéro de téléphone"
                            name="PhoneNumber"
                            value={userRegistrationForm.PhoneNumber}
                            onChange={handleUserRegistrationFormChange}
                        />
                        </Grid>

                        <Grid size={4}>
                        <TextField
                            fullWidth
                            type="email"
                            label="E-mail"
                            name="Email"
                            value={userRegistrationForm.Email}
                            onChange={handleUserRegistrationFormChange}
                        />
                        </Grid>

                        <Grid size={4}>
                        <FormControl fullWidth>
                            <InputLabel id="gender-select-label">Genre</InputLabel>
                            <Select
                            labelId="gender-select-label"
                            value={userRegistrationForm.Gender}
                            label="Genre"
                            onChange={handleGenderChange}
                            >
                            <MenuItem value={10}>Mâle</MenuItem>
                            <MenuItem value={20}>Femelle</MenuItem>
                            <MenuItem value={30}>Autre</MenuItem>
                            </Select>
                        </FormControl>
                        </Grid>

                        <Grid size={4}>
                        <TextField
                            required
                            fullWidth
                            label="Mot de passe"
                            name="Password"
                            value={userRegistrationForm.Password}
                            onChange={handleUserRegistrationFormChange}
                        />
                        </Grid>

                        <Grid size={4}>
                        <TextField
                            required
                            fullWidth
                            label="Confirmez le mot de passe"
                            name="ConfirmPassword"
                            value={userRegistrationForm.ConfirmPassword}
                            onChange={handleUserRegistrationFormChange}
                        />
                        </Grid>

                        <Grid size={4}>
                        <FormControlLabel control={<Checkbox />} label="Afficher le mot de passe" />
                        </Grid>

                        <Grid size={12} textAlign="center">
                        <Typography variant="body2">
                            Vous avez déjà un compte ?{' '}
                            <Link href="/home/signin" underline="hover">
                            Connectez-vous
                            </Link>
                        </Typography>
                        </Grid>
                    </Grid>

                <Button type="submit" fullWidth variant="contained" sx={{ mt: 3, py: 1.5 }}>
                    S'inscrire
                </Button>
                </Box>
            </Grid>
        </Box>
    </>
    
  );
}