// src/auth/AuthContext.tsx
import { createContext, useContext, useState, useEffect, type ReactNode } from "react";

interface AuthContextProps {
  isAuthenticated: boolean;
  isLoading: boolean;
  accessToken: string | null;
  login: (token: string) => void;
  logout: () => void;
}

const AuthContext = createContext<AuthContextProps | undefined>(undefined);

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [isLoading, setIsLoading] = useState(true); // start in loading state
  const [accessToken, setAccessToken] = useState<string | null>(null);

  // Simulate checking auth state from backend/localStorage
  useEffect(() => {
  const checkAuth = async () => {
    setIsLoading(true);
    try {
      const token = localStorage.getItem("accessToken");
      setIsAuthenticated(!!token);
    } catch (err) {
      setIsAuthenticated(false);
    } finally {
      // small artificial delay for smoother UX
      setTimeout(() => setIsLoading(false), 500);
    }
  };

  checkAuth();
}, []);
console.log("AuthContext loading:", isLoading);

  const login = (token: string) => {
    try {
      setIsLoading(true);
      setAccessToken(token);
      setIsAuthenticated(true);
    localStorage.setItem("accessToken", token);
    } catch (error) {
      console.error("Login failed", error);
      setIsAuthenticated(false);
    } finally {
      setIsLoading(false); // hide loader
    }
  };

  const logout = () => {
    try {
      setIsLoading(true);
      setAccessToken(null);
      setIsAuthenticated(false);
      localStorage.removeItem("accessToken");
      localStorage.removeItem("idToken");
      localStorage.removeItem("refreshToken");
    } finally {
      setIsLoading(false); // hide loader
    }
    
  };

  return (
    <AuthContext.Provider
      value={{ isAuthenticated, isLoading, accessToken, login, logout }}
    >
      {children}
    </AuthContext.Provider>
  );
};

export const useAuthContext = () => {
  const context = useContext(AuthContext);
  if (!context) throw new Error("useAuthContext must be used inside AuthProvider");
  return context;
};
