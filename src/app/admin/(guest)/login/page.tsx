import { Suspense } from "react";
import { getLang } from "@/lib/i18n-server";
import { adminLoginCopy } from "@/lib/admin-layout-i18n";
import { AdminLoginForm } from "./login-form";

export default async function AdminLoginPage() {
  const lang = await getLang();
  const copy = adminLoginCopy(lang);

  return (
    <Suspense
      fallback={
        <div className="w-full max-w-sm rounded-2xl border border-parish-border bg-parish-surface p-8 text-center text-parish-muted">
          {copy.fallback}
        </div>
      }
    >
      <AdminLoginForm copy={copy} />
    </Suspense>
  );
}
