import { apiClient } from "../../commonApiConfig/apiClient";

// Get Users Endpoints
const createUserEndpoint = "/auth-user/signup/"
const loginUserEndpoint = "/auth-user/login/"
// const getTenantLogoEndpoint = "/tenant/get-logo/"

export default function useAuthUserApi(){
    
    /**
   * Create a user with that will be synced to cognito
   */
    async function loginUser(userLoginData: FormData) {
        try {
            // Append subdomain
            const host = window.location.hostname; // e.g. "golden.localhost"
            const subdomain = host.split('.')[0];   // "golden"
            userLoginData.append("TenantSubdomain", subdomain);

            // In dev mode (like localhost), you might not have a subdomain
            // let subdomain = "";
            // if (parts.length > 2) {
            //     // e.g. golden.lafiyasira.com → "golden"
            //     subdomain = parts[0];
            // } else if (parts.length === 2 && parts[0] !== "localhost") {
            //     // e.g. golden.localhost → "golden"
            //     subdomain = parts[0];
            // }

            // // Append subdomain if available
            // if (subdomain) {
            //     userLoginData.append("Subdomain", subdomain);
            // }
            
            const response = await apiClient.post(`${loginUserEndpoint}`, userLoginData, {
                headers: {
                "Content-Type": "multipart/form-data", // Axios handles the boundary automatically
                },
            });

            return response.data;
            
        } catch (err: any) {
            console.error("User login failed:", err.response?.data || err.message);
            throw err;
        }

    }

    /**
   * Create a user with that will be synced to cognito
   */
    async function createUser(userRegistrationData: FormData) {
        try {
            // Append subdomain
            const host = window.location.hostname; // e.g. "golden.localhost"
            const subdomain = host.split('.')[0];   // "golden"
            userRegistrationData.append("Subdomain", subdomain);

            const response = await apiClient.post(`${createUserEndpoint}`, userRegistrationData, {
                headers: {
                "Content-Type": "multipart/form-data", // Axios handles the boundary automatically
                },
            });

            return response.data;
            
        } catch (err: any) {
            console.error("User signup failed:", err.response?.data || err.message);
            throw err;
        }

    }


    return { createUser, loginUser };
}