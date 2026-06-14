import { createBrowserRouter } from "react-router-dom";
import PublicLayout from "../PublicLayout";
import TenantPublicLayout from "../TenantPublicLayout";
import RootLayout from "../RootLayout";
import PrivateRoute from "../auth/PrivateRoute";
import LoginPage from "../auth/pages/LoginPage";
import SignupPage from "../auth/pages/SignupPage";
import HomePage from "../home/pages/HomePage";
import DashboardPage from "../home/pages/DashboardPage";
import UserProfile from "../home/pages/UserProfile";
import AppointmentPage from "../appointmentManagement/pages/AppointmentPage";
import BillingPage from "../billingManagement/pages/BillingPage";
import DoctorPage from "../DoctorManagement/pages/DoctorPage";
import PatientPage from "../patientManagement/pages/PatientPage";
import UserPage from "../userManagement/pages/UserPage";
import NotificationPage from "../notificationManagement/pages/NotificationPage";
import ContactPage from "../LandingManagement/pages/ContactPage";
import FeaturesPage from "../LandingManagement/pages/FeaturesPage";
import PricingPage from "../LandingManagement/pages/PricingPage";
import AboutPage from "../LandingManagement/pages/AboutPage";
import RegistrationPage from "../LandingManagement/pages/RegistrationPage";
import LandingPage from "../LandingManagement/pages/LandingPage";
import LandingRootLayout from "../LandingManagement/pages/LandingRootLayout";


export const router = createBrowserRouter([
    {
        path: '/',
        element: <PublicLayout />,
        children: [
            { element: <LandingRootLayout />, 
                children: 
                [
                    { index: true, element: <LandingPage /> },
                    // {path: 'home', element: <HomePage />},
                    // {path: 'appointments', element: <AppointmentPage />},

                    // Marketing pages
                    { path: 'registration', element: <RegistrationPage /> },
                    { path: 'about', element: <AboutPage /> },
                    { path: 'pricing', element: <PricingPage /> },
                    { path: 'features', element: <FeaturesPage /> },
                    { path: 'contact', element: <ContactPage /> },
                ]  
            },
        ],
    },
    // Tenant public pages (subdomain only)
    {
        path: "/home",
        element: <TenantPublicLayout />,
        children: [
        { index: true, element: <HomePage /> },
        { path: "appointments", element: <AppointmentPage /> },
        { path: "signin", element: <LoginPage /> },
        { path: "signup", element: <SignupPage /> },
        ],
    },
    
    {
        path: "/lafiyaSira",
        element: <PrivateRoute />, // Protect all /lafiyaSira routes
        children: [
            { element: <RootLayout />, 
                children: 
                [
                    { index: true, element: <DashboardPage /> },
                    { path: "profile", element: <UserProfile /> },
                    { path: "appointmentManagement", element: <AppointmentPage /> },
                    { path: "doctorManagement", element: <DoctorPage /> },
                    { path: "patientManagement", element: <PatientPage /> },
                    // { path: "tenantManagement", element: <TenantPage /> },
                    { path: "userManagement", element: <UserPage /> },
                    { path: "notificationManagement", element: <NotificationPage /> },
                    { path: "billingManagement", element: <BillingPage /> },
                ]
            },
        ],
    },

    // {
    //     path: '/lafiyaSira',
    //     element: <RootLayout />,
    //     children: [
    //         {index: true, element: <DashboardPage />},
    //         {path: 'appointmentManagement', element: <AppointmentPage />}
    //     ],
    // },
]);