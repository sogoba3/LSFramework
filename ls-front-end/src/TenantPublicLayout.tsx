import { Outlet } from "react-router-dom";

export default function TenantPublicLayout() {
  // Get hostname
  const hostname = window.location.hostname; // e.g., "localhost", "clinic.lafiyaSira.com"
  const subdomain = hostname.split(".")[0];

 // In dev, only allow subdomains like 'clinic.localhost'
  const isLocalDevSubdomain = hostname.endsWith("localhost") && subdomain !== "localhost";
  
  // Only allow tenant subdomains (ignore localhost, www, main domain)
  //|| hostname.includes("localhost")
  if ((!subdomain || subdomain === "www") && !isLocalDevSubdomain) {
    return <div>Tenant not found or invalid subdomain</div>;
  }

  // Tenant pages render here
  return <Outlet />;
}