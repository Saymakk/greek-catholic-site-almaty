import { PasswordChangeForm } from "./password-form";

export default function AdminAccountPage() {
  return (
    <div>
      <h1 className="font-display text-2xl text-parish-text">Пароль</h1>
      <p className="mt-2 max-w-md text-sm text-parish-muted">
        Смените пароль для входа в админку. Используйте надёжную комбинацию символов.
      </p>
      <PasswordChangeForm />
    </div>
  );
}
