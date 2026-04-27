import { requireStaff } from "@/lib/admin";
import { getLang } from "@/lib/i18n-server";
import { getKazakhstanParishesForAdmin } from "@/lib/data";
import { AdminParishesClient } from "./AdminParishesClient";

export default async function AdminParishesPage() {
  await requireStaff();
  const lang = await getLang();
  const rows = await getKazakhstanParishesForAdmin();

  return <AdminParishesClient lang={lang} rows={rows} />;
}
