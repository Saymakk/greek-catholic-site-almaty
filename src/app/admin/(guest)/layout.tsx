export default function AdminGuestLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex min-h-screen items-center justify-center bg-parish-bg px-4">
      {children}
    </div>
  );
}
