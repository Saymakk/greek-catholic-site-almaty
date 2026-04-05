import { SiteLoadingSpinner } from "@/components/SiteLoadingSpinner";

export default function LibraryLoading() {
  return (
    <div className="flex min-h-[50vh] w-full items-center justify-center px-4 py-20">
      <SiteLoadingSpinner />
    </div>
  );
}
