import { RouterProvider } from "react-router-dom"
import AuthLoader from "./AuthLoader"
import ThemeToggle from "./theme/ThemeToggle"
import { router } from "./routes-manager/LafiyaSiraRouters"

function App() {

  return (
    <>
      {/* Global Auth Loader */}
    <AuthLoader />
    <RouterProvider router={router}></RouterProvider>

    <ThemeToggle /> {/* toggle button */}
    </>
  )
}

export default App
