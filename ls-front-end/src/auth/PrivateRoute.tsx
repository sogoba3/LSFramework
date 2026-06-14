import React from "react";
import { Navigate, Outlet } from "react-router-dom";
import { useAuthContext } from "./hooks/AuthContext";

const PrivateRoute: React.FC = () => {
  // const auth = useAuth();
  const { isAuthenticated, isLoading } = useAuthContext();

  // Don’t redirect yet — wait until the auth state is known
  if (isLoading) return <div>Loading...</div>;
  // If user is not authenticated, redirect to homepage
  if (!isAuthenticated) {
    return <Navigate to="/home/signin" />;
  }

  // If authenticated, render child routes
  return <Outlet />;
};

export default PrivateRoute;
