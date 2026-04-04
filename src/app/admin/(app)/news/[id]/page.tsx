import { redirect } from "next/navigation";

export default async function AdminNewsEditRedirectPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  redirect(`/admin/news?id=${encodeURIComponent(id)}`);
}
