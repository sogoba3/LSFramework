import { apiClient } from "../../commonApiConfig/apiClient";

// Get Users Endpoints
const createTenantEndpoint = "/tenant/admin-signup"
const getTenantLogoEndpoint = "/tenant/get-logo/"

export default function useTenantApi(){
    
    /**
   * Create a tenant with admin + optional logo file
   */
    async function createTenant(tenantRegistrationData: FormData) {
        try {
            const response = await apiClient.post(`${createTenantEndpoint}`, tenantRegistrationData, {
                headers: {
                "Content-Type": "multipart/form-data", // Axios handles the boundary automatically
                },
            });

            return response.data;
            
        } catch (err: any) {
            console.error("Tenant signup failed:", err.response?.data || err.message);
            throw err;
        }

    }

    // Fetch Tenant Logo
    async function getTenantLogo(tenantId: number): Promise<Blob> {
        try {
            const response = await apiClient.get(`${getTenantLogoEndpoint}${tenantId}`, {
            responseType: "blob", // important to get the file as a Blob
            });

            return response.data; // this is the Blob
        } catch (error) {
            console.error("Error fetching tenant logo:", error);
            throw error;
        }
    }


    return { createTenant, getTenantLogo };
}