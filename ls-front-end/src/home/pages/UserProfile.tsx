// Avatar Button FormControl InputLabel Link MenuItem Select
import {Box, Checkbox, FormControlLabel, Grid, TextField, Typography } from "@mui/material";
import ContactPhoneRoundedIcon from '@mui/icons-material/ContactPhoneRounded';
import AccountCircleRoundedIcon from '@mui/icons-material/AccountCircleRounded';
import LocalHospitalRoundedIcon from '@mui/icons-material/LocalHospitalRounded';
import EnhancedEncryptionRoundedIcon from '@mui/icons-material/EnhancedEncryptionRounded';

export default function UserProfile() {

  return (
    <>
      <Box sx={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        pt: "5vh",
        }}
      >
          <Typography variant="h5" gutterBottom align="center">
                  Profil Utilisateur
          </Typography>
          {/* bgcolor={"grey"} */}
          <Grid size={8} sx={{ width:"90%", alignItems: "center", mb: 3 , borderRadius: 5, boxShadow: 20}}>
            
              <Box display="flex" alignItems="center" gap={2} mb={2}>
                <Box
                  sx={{width: 40,height: 40,borderRadius: "50%",backgroundColor: "primary.main",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                  }}
                >
                  <AccountCircleRoundedIcon sx={{ color: "#fff", width: 30, height: 30 }} />
                </Box>
                <Typography variant="h5" >
                  Résumé du profil
                </Typography>
              </Box>
              
              <Box component="form"  mt={0} p={2} width="100%">
                  <Grid container spacing={2}>
                      <Grid size={4}>
                      <TextField
                          disabled
                          fullWidth
                          label="Nom d'utilisateur"
                          name="Username"
                          //value={userRegistrationForm.Username}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4} >
                      <TextField
                          disabled
                          fullWidth
                          label="Prénom"
                          name="FirstName"
                          //value={userRegistrationForm.FirstName}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <TextField
                          disabled
                          fullWidth
                          label="Nom de famille"
                          name="LastName"
                          //value={userRegistrationForm.LastName}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <TextField
                          disabled
                          fullWidth
                          label="Numéro de téléphone"
                          name="PhoneNumber"
                          //value={userRegistrationForm.PhoneNumber}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <TextField
                          disabled
                          fullWidth
                          type="email"
                          label="E-mail"
                          name="Email"
                          //value={userRegistrationForm.Email}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <TextField
                          fullWidth
                          label="Genre"
                          name="Gender"
                          disabled
                          //value={userRegistrationForm.Email}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <TextField
                          disabled
                          fullWidth
                          label="Mot de passe"
                          name="Password"
                          //value={userRegistrationForm.Password}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <TextField
                          disabled
                          fullWidth
                          label="Confirmez le mot de passe"
                          name="ConfirmPassword"
                          //value={userRegistrationForm.ConfirmPassword}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <FormControlLabel control={<Checkbox />} label="Afficher le mot de passe" />
                      </Grid>

                  </Grid>
              </Box>
          </Grid>

          <Grid size={8} sx={{ width:"90%", alignItems: "center", mb: 3 , borderRadius: 5, boxShadow: 20}}>
            
              <Box display="flex" alignItems="center" gap={2} mb={2}>
                {/* <ContactPhoneRoundedIcon color="primary" sx={{width:"40px", height:"40px"}}/> */}
                <Box
                  sx={{width: 40,height: 40,borderRadius: "50%",backgroundColor: "primary.main",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                  }}
                >
                  <ContactPhoneRoundedIcon sx={{ color: "#fff", width: 30, height: 30 }} />
                </Box>
                <Typography variant="h5" >
                  Coordonnées
                </Typography>
              </Box>

              <Box component="form"  mt={0} p={2} width="100%">
                  <Grid container spacing={2}>
                      <Grid size={4}>
                      <TextField
                          fullWidth
                          label="Nom d'utilisateur"
                          name="Username"
                          //value={userRegistrationForm.Username}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4} >
                      <TextField
                          fullWidth
                          label="Prénom"
                          name="FirstName"
                          //value={userRegistrationForm.FirstName}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <FormControlLabel control={<Checkbox />} label="Afficher le mot de passe" />
                      </Grid>

                  </Grid>
              </Box>

          </Grid>

          <Grid size={8} sx={{ width:"90%", alignItems: "center", mb: 3 , borderRadius: 5, boxShadow: 20}}>
            
              <Box display="flex" alignItems="center" gap={2} mb={2}>
                <Box
                  sx={{width: 40,height: 40,borderRadius: "50%",backgroundColor: "primary.main",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                  }}
                >
                  <LocalHospitalRoundedIcon sx={{ color: "#fff", width: 30, height: 30 }} />
                </Box>
                <Typography variant="h5" >
                  Informations sur la Clinique/Hôpital
                </Typography>
              </Box>

              <Box component="form"  mt={0} p={2} width="100%">
                  <Grid container spacing={2}>
                      <Grid size={4}>
                      <TextField
                          fullWidth
                          label="Nom d'utilisateur"
                          name="Username"
                          //value={userRegistrationForm.Username}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4} >
                      <TextField
                          fullWidth
                          label="Prénom"
                          name="FirstName"
                          //value={userRegistrationForm.FirstName}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <FormControlLabel control={<Checkbox />} label="Afficher le mot de passe" />
                      </Grid>

                  </Grid>
              </Box>

          </Grid>

          <Grid size={8} sx={{ width:"90%", alignItems: "center", mb: 3 , borderRadius: 5, boxShadow: 20}}>
            
              <Box display="flex" alignItems="center" gap={2} mb={2}>
                <Box
                  sx={{width: 40,height: 40,borderRadius: "50%",backgroundColor: "primary.main",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                  }}
                >
                  <EnhancedEncryptionRoundedIcon sx={{ color: "#fff", width: 30, height: 30 }} />
                </Box>
                <Typography variant="h5" >
                  Paramètres de Sécurité
                </Typography>
              </Box>

              <Box component="form"  mt={0} p={2} width="100%">
                  <Grid container spacing={2}>
                      <Grid size={4}>
                      <TextField
                          fullWidth
                          label="Nom d'utilisateur"
                          name="Username"
                          //value={userRegistrationForm.Username}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4} >
                      <TextField
                          fullWidth
                          label="Prénom"
                          name="FirstName"
                          //value={userRegistrationForm.FirstName}
                          //onChange={handleUserRegistrationFormChange}
                      />
                      </Grid>

                      <Grid size={4}>
                      <FormControlLabel control={<Checkbox />} label="Afficher le mot de passe" />
                      </Grid>

                  </Grid>
              </Box>

          </Grid>
          
      </Box>

      {/* <Box sx={{ display: "flex", alignItems: "center", mb: 3 , borderRadius: 10, boxShadow: 20}}>
        <Avatar
          sx={{ width: 80, height: 80, mr: 2 }}
        />
        <Box>
          <Typography variant="h5">User Sumary</Typography>
          <Typography variant="body2" color="text.secondary">
            admin — cscom
          </Typography>
          
        </Box>
      </Box> */}
        {/* <Box sx={{
            display: "flex",
            flexDirection: "column",
            justifyContent: "center",
            alignItems: "center",
            p: '3vh',
        }}>
          <Grid size={8}  sx={{maxWidth: '80%', borderRadius: 10, boxShadow: 20,}}>
            <Typography variant="h5" gutterBottom align="center" pt={2}>
                Profil Utilisateur
              </Typography>
            <Grid container spacing={2} mt={4} p={4} width="100%" justifyContent={"center"}>

              <Grid size={8}>
                <Typography>Nom d'utilisateur</Typography>
                <TextField fullWidth>

                </TextField>
              </Grid>

              <Grid size={8}>
                <Typography>Mot de passe</Typography>
                <TextField fullWidth>

                </TextField>
              </Grid>

              <Grid size={8}>
                <Typography>Prénom</Typography>
                <TextField fullWidth>

                </TextField>
              </Grid>

              <Grid size={8}>
                <Typography>Nom de famille</Typography>
                <TextField fullWidth>

                </TextField>
              </Grid>

              <Grid size={8}>
                <Typography>Numéro de téléphone</Typography>
                <TextField fullWidth>

                </TextField>
              </Grid>

              <Grid size={8}>
                <Typography>E-mail</Typography>
                <TextField fullWidth>

                </TextField>
              </Grid>

              <Grid size={8}>
                <Typography>Genre</Typography>
                <TextField fullWidth disabled>

                </TextField>
              </Grid>

            </Grid>
          </Grid>
          
        </Box> */}
    </>
  );
}
