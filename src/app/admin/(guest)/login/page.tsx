import { Suspense } from "react";
import { AdminLoginForm } from "./login-form";

export default function AdminLoginPage() {
  return (
    <Suspense
      fallback={
        <div className="w-full max-w-sm rounded-2xl border border-parish-border bg-parish-surface p-8 text-center text-parish-muted">
          …
        </div>
      }
    >
      <AdminLoginForm />
    </Suspense>
  );
}
