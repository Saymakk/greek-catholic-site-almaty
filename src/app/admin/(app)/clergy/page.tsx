import { requireStaffCanViewObjects } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { getClergyForAdmin } from "@/lib/data";
import { AdminClergyClient } from "./AdminClergyClient";

export default async function AdminClergyPage() {
  await requireStaffCanViewObjects();
  const lang = await getLang();
  const rows = await getClergyForAdmin();

  return <AdminClergyClient lang={lang} rows={rows} />;
}
