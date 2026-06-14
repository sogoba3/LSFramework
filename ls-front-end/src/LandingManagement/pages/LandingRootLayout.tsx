import { Outlet } from "react-router-dom";
import LandingNav from "./LandingNav";

export default function LandingRootLayout(){
    return(
        <>
            <LandingNav />
            <Outlet />
        </>
    )
}