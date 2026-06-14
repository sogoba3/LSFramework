import { Alert, Box, Button, FormControl, Grid, InputLabel, MenuItem, Paper, Select, styled, TextField, Typography, type SelectChangeEvent } from "@mui/material";
import { useState } from "react";
import FileUploadIcon from '@mui/icons-material/FileUpload';
// import FileDownloadIcon from '@mui/icons-material/FileDownload';
import useTenantApi from "../../tenantManagement/api/useTenantApi";

const VisuallyHiddenInput = styled('input')({
  clip: 'rect(0 0 0 0)',
  clipPath: 'inset(50%)',
  height: 1,
  overflow: 'hidden',
  position: 'absolute',
  bottom: 0,
  left: 0,
  whiteSpace: 'nowrap',
  width: 10,
});

interface TenantRegistrationForm {
  tenantName: string;
  adminUsername: string;
  adminPassword: string;
  adminFirstName: string;
  adminLastName: string;
  adminEmail: string | null;
  adminPhoneNumber: string;
  adminGender: string;
}

export default function RegistrationPage(){

    const { createTenant } = useTenantApi();
    const [file, setFile] = useState<File | null>(null);
    const [registrationForm, setRegistrationForm] = useState<TenantRegistrationForm>({
        tenantName: "",
        adminUsername: "",
        adminPassword: "",
        adminFirstName: "",
        adminLastName: "",
        adminEmail: "",
        adminPhoneNumber: "+223",
        adminGender: "",
    });
    const handleRegistrationFormChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
        setRegistrationForm({ ...registrationForm, [e.target.name]: e.target.value });
    };
    const handleGenderChange = (event: SelectChangeEvent) => {
        setRegistrationForm({ ...registrationForm, adminGender: event.target.value});
    };

    const [result, setResult] = useState<any>(null);
    const [error, setError] = useState<string | null>(null);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError(null);
        setResult(null);

        try {
            const tenantRegistrationData = new FormData();
            tenantRegistrationData.append("TenantName", registrationForm.tenantName);
            tenantRegistrationData.append("AdminFirstName", registrationForm.adminFirstName);
            tenantRegistrationData.append("AdminUsername", registrationForm.adminUsername);
            tenantRegistrationData.append("AdminPassword", registrationForm.adminPassword);
            tenantRegistrationData.append("AdminLastName", registrationForm.adminLastName);
            tenantRegistrationData.append("AdminEmail", registrationForm.adminEmail || "");
            tenantRegistrationData.append("AdminPhoneNumber", registrationForm.adminPhoneNumber);
            tenantRegistrationData.append("AdminGender", registrationForm.adminGender);

            if (file) tenantRegistrationData.append("LogoFile", file); // ← file upload

            const data = await createTenant(tenantRegistrationData);
            setResult(data);

        } catch (err: any) {
            setError(err.message || "Échec de l'inscription");
        }
    };


    return(
        <>
            <Box display="flex"
                justifyContent="center"
                alignItems="center"
                minHeight="70vh"   // full viewport height
                pt={15}
            >
                <Paper  sx={{ p: 4, borderRadius: 3, boxShadow: 3, maxWidth: '60%', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', mx: 'auto', minHeight: 300,}}>
                    <Typography variant="h5" gutterBottom alignItems={"center"}>
                    {/* Clinic Admin Signup  */}
                    Registrer votre Clinique / Hopital
                    </Typography>
                    <Typography variant="body2" color="text.secondary" gutterBottom>
                    Inscrivez votre clinique / hôpital pour obtenir un portail dédié.
                    </Typography>

                    {error && <Alert severity="error">{error}</Alert>}
                    {result && (
                    <Alert severity="success">
                        🎉 Votre compte a été créé avec succès! <br />
                        Portail: <strong>{result.tenantSubdomain}.lafiyasira.com</strong> <br />
                        {/* Nom d'utilisateur: {" "} <br />
                        Temporary Password:{" "} */}
                        {/* <strong>{result.adminUsername}</strong> */}
                        {/* <strong>{result.adminTemporaryPassword}</strong> */}
                    </Alert>
                    )}

                    <Box component="form" onSubmit={handleSubmit} mt={2}>
                        <Grid container spacing={2} sx={{justifyContent: 'center', alignItems: 'center'}}>
                            <Grid>
                                <TextField
                                    required
                                    fullWidth
                                    label="Nom de la Clinique / Hôpital"
                                    name="tenantName"
                                    value={registrationForm.tenantName}
                                    onChange={handleRegistrationFormChange}
                                />
                            </Grid>

                            <Grid>
                                <TextField
                                    required
                                    fullWidth
                                    label="Nom d'utilisateur"
                                    name="adminUsername"
                                    value={registrationForm.adminUsername}
                                    onChange={handleRegistrationFormChange}
                                />
                            </Grid>

                            <Grid>
                                <TextField
                                    required
                                    fullWidth
                                    label="Mot de passe"
                                    name="adminPassword"
                                    value={registrationForm.adminPassword}
                                    onChange={handleRegistrationFormChange}
                                />
                            </Grid>

                            <Grid>
                                <TextField
                                    required
                                    fullWidth
                                    label="Prénom"
                                    name="adminFirstName"
                                    value={registrationForm.adminFirstName}
                                    onChange={handleRegistrationFormChange}
                                />
                            </Grid>

                            <Grid>
                                <TextField
                                    required
                                    fullWidth
                                    label="Nom de famille"
                                    name="adminLastName"
                                    value={registrationForm.adminLastName}
                                    onChange={handleRegistrationFormChange}
                                />
                            </Grid>

                            <Grid>
                                <TextField
                                    fullWidth
                                    type="email"
                                    label="E-mail"
                                    name="adminEmail"
                                    value={registrationForm.adminEmail}
                                    onChange={handleRegistrationFormChange}
                                />
                            </Grid>

                            <Grid>
                                <TextField
                                    required
                                    fullWidth
                                    label="Numéro de téléphone"
                                    name="adminPhoneNumber"
                                    value={registrationForm.adminPhoneNumber}
                                    onChange={handleRegistrationFormChange}
                                />
                            </Grid>

                            <Grid sx={{ minWidth: 120 }}>
                                {/* <TextField
                                    fullWidth
                                    label="Genre"
                                    name="adminGender"
                                    value={registrationForm.adminGender}
                                    onChange={handleChange}
                                /> */}
                                <FormControl fullWidth>
                                    <InputLabel id="demo-simple-select-label">Genre</InputLabel>
                                    <Select
                                    labelId="demo-simple-select-label"
                                    id="demo-simple-select"
                                    value={registrationForm.adminGender}
                                    label="Genre"
                                    onChange={handleGenderChange}
                                    >
                                    <MenuItem value={10}>Mâle</MenuItem>
                                    <MenuItem value={20}>Femelle</MenuItem>
                                    <MenuItem value={30}>Autre</MenuItem>
                                    </Select>
                                </FormControl>
                            </Grid>
                            <Grid>
                                <Button
                                    color="primary"
                                    component="label"
                                    role={undefined}
                                    variant="contained"
                                    tabIndex={-1}
                                    startIcon={<FileUploadIcon />}
                                    >
                                    Télécharger votre logo
                                    <VisuallyHiddenInput
                                        type="file"
                                        accept=".png, .jpg, .jpeg, .svg, image/png, image/jpeg, image/svg+xml"
                                        // console.log(event.target.files)
                                        onChange={(event) => {
                                            const files = event.target.files;
                                            if (files && files.length > 0) {
                                                setFile(files[0]);
                                            }}
                                        }
                                    />
                                </Button>
                                {file && (
                                    <Typography variant="body2" sx={{ mt: 1 }}>
                                    Fichier sélectionné: {file.name}
                                    </Typography>
                                )}
                            </Grid>
                        </Grid>

                        <Button
                            type="submit"
                            fullWidth
                            variant="contained"
                            sx={{ mt: 3, py: 1.5 }}
                        >
                            S'inscrire
                        </Button>
                    </Box>
                </Paper>
            </Box>

        </>
    )
}