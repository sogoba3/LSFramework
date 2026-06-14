import { Box, Grid, Paper, Typography } from "@mui/material";
// import { green } from "@mui/material/colors";
// import { useAuth } from "react-oidc-context";
import PeopleIcon from '@mui/icons-material/People';
import MedicationIcon from '@mui/icons-material/Medication';
import ScheduleIcon from '@mui/icons-material/Schedule';
import ScienceIcon from '@mui/icons-material/Science';

export default function DashboardPage(){
    //const auth = useAuth();
    return(
        <>
        <Box component="main" sx={{ flexGrow: 1, p: 3 }}>
                <Grid container spacing={1} sx={{
            width: "100%",
            // big grid takes 40% of page height
            mb: 2,
          }}>
                    <Grid size={3} height={'30vh'} 
                        sx={{
                        //bgcolor: "primary.main",
                        display: "flex",
                        justifyContent: "center",
                        alignItems: "center",
                        color: "white",
                        borderRadius: 2,
                        }}
                    >
                        <Paper elevation={4} sx={{ p: 4, borderRadius: 3, width:'100vh', height:'30vh' }}
                        >
                            <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'flex-start' }}>
                                <PeopleIcon fontSize="large" sx={{ color: "#0E8EA8"}}/>
                            </Box>
                            <Typography variant="h5" gutterBottom>
                                Nombre Total de Patients
                                <Typography variant="body2">Utilisateurs enregistrés actifs</Typography>
                            </Typography>
                        </Paper>
                    </Grid>
                    <Grid size={3} height={'30vh'}
                        sx={{
                        //bgcolor: "primary.main",
                        display: "flex",
                        justifyContent: "center",
                        alignItems: "center",
                        color: "white",
                        borderRadius: 2,
                        }}
                    >
                        <Paper elevation={4} sx={{ p: 4, borderRadius: 3, width:'100vh', height:'30vh' }}
                        >
                            <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'flex-start' }}>
                                <MedicationIcon fontSize="large" sx={{ color: "#0E8EA8"}}/>
                            </Box>
                            <Typography variant="h5" gutterBottom>
                                Médecins Actifs
                                <Typography variant="body2">Personnel médical disponible</Typography>
                            </Typography>
                        </Paper>
                    </Grid>
                    <Grid size={3} height={'30vh'}
                        sx={{
                        //bgcolor: "primary.main",
                        display: "flex",
                        justifyContent: "center",
                        alignItems: "center",
                        color: "white",
                        borderRadius: 2,
                        }}
                    >
                        <Paper elevation={4} sx={{ p: 4, borderRadius: 3, width:'100vh', height:'30vh' }}
                        >
                            <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'flex-start' }}>
                                <ScheduleIcon fontSize="large" sx={{ color: "#0E8EA8"}}/>
                            </Box>
                            <Typography variant="h5" gutterBottom>
                                Rendez-vous D'aujourd'hui
                                <Typography variant="body2">Consultations prévues</Typography>
                            </Typography>
                        </Paper>
                    </Grid>
                    <Grid size={3} height={'30vh'}
                        sx={{
                        //bgcolor: "primary.main",
                        display: "flex",
                        justifyContent: "center",
                        alignItems: "center",
                        color: "white",
                        borderRadius: 2,
                        }}
                    >
                        <Paper elevation={4} sx={{ p: 4, borderRadius: 3, width:'100vh', height:'30vh' }}
                        >
                            <Box sx={{ display: 'flex', alignItems: 'center', justifyContent: 'flex-start' }}>
                                <ScienceIcon fontSize="large" sx={{ color: "#0E8EA8"}}/>
                            </Box>
                            <Typography variant="h5" gutterBottom>
                                Résultats de laboratoire en attente
                                <Typography variant="body2">En attente d'examen</Typography>
                            </Typography>
                        </Paper>
                    </Grid>
                    <Grid size={6} height={'56vh'}
                        sx={{
                        //bgcolor: "primary.main",
                        display: "flex",
                        justifyContent: "center",
                        alignItems: "center",
                        color: "white",
                        borderRadius: 2,
                        }}
                    >
                        <Paper elevation={4} sx={{ p: 4, borderRadius: 3, textAlign: "center", width:'100vh', height:'56vh' }}
                        >
                            <Typography variant="h5" gutterBottom>
                                Rendez-vous Récentes
                            </Typography>
                        </Paper>
                    </Grid>
                    <Grid container spacing={1} size={6}>
                        <Grid size={12} height={'30vh'}
                            sx={{
                            //bgcolor: "primary.main",
                            display: "flex",
                            justifyContent: "center",
                            alignItems: "center",
                            color: "white",
                            borderRadius: 2,
                            }}
                        >
                            <Paper elevation={4} sx={{ p: 4, borderRadius: 3, textAlign: "center", width:'100vh', height:'30vh' }}
                            >
                                <Typography variant="h5" gutterBottom>
                                    Actions Rapides
                                </Typography>
                            </Paper>
                        </Grid>
                        <Grid size={12} height={'25vh'}
                            sx={{
                            //bgcolor: "primary.main",
                            display: "flex",
                            justifyContent: "center",
                            alignItems: "center",
                            color: "white",
                            borderRadius: 2,
                            }}
                        >
                            <Paper elevation={4} sx={{ p: 4, borderRadius: 3, textAlign: "center", width:'100vh', height:'25vh' }}
                            >
                                <Typography variant="h5" gutterBottom>
                                    Analyse des données des patients
                                </Typography>
                            </Paper>
                        </Grid>
                    </Grid>
                    
                </Grid>
            </Box>
        </>
    )
}