import { requireSuperadmin } from "@/lib/admin";
import { CreateUserForm } from "./create-user-form";

export default async function AdminUsersPage() {
  await requireSuperadmin();

  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">Пользователи</h1>
      <p className="mt-2 text-sm text-parish-muted">Здесь создаются администраторы</p>
      <CreateUserForm />
    </div>
  );
}
