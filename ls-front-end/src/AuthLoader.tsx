// AuthLoader.tsx
import { Backdrop, CircularProgress } from "@mui/material";
import { useAuthContext } from "./auth/hooks/AuthContext";

export default function AuthLoader() {
  // const auth = useAuth();
  const { isLoading } = useAuthContext();

  // Show loader when any async auth event is happening
  if (isLoading) {
    return (
      <Backdrop open sx={{ color: "#fff", zIndex: (theme) => theme.zIndex.drawer + 1 }}>
        <CircularProgress color="inherit" />
      </Backdrop>
    );
  }

  return null;
}
