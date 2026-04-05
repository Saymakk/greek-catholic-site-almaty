import { SiteLoadingSpinner } from "@/components/SiteLoadingSpinner";

export default function PublicLoading() {
  return (
    <div className="flex min-h-[40vh] w-full items-center justify-center px-4 py-20">
      <SiteLoadingSpinner />
    </div>
  );
}
