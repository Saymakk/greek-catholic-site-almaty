import { redirect } from "next/navigation";

export default async function AdminCalendarEditRedirectPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  redirect(`/admin/calendar?id=${encodeURIComponent(id)}`);
}
