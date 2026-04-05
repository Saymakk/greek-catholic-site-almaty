import { getLang } from "@/lib/i18n-server";
import { adminAccountCopy } from "@/lib/admin-layout-i18n";
import { AccountPasswordClient } from "./account-password-client";

export default async function AdminAccountPage() {
  const lang = await getLang();
  const copy = adminAccountCopy(lang);
  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">{copy.pageTitle}</h1>
      <p className="mt-2 max-w-md text-sm text-parish-muted">{copy.intro}</p>
      <AccountPasswordClient copy={copy} />
    </div>
  );
}
