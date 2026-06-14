import { Outlet } from "react-router-dom";

export default function PublicLayout() {
  return (
    <>
      <div style={{ display: "center" }}>
        <main style={{ padding: 0, margin: 0 }}>
          <Outlet />
        </main>
      </div>
    </>
  );
}