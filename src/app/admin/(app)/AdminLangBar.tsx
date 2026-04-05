import { LangSwitcher } from "@/components/LangSwitcher";
import { adminInterfaceLanguageLabel } from "@/lib/admin-layout-i18n";
import type { Lang } from "@/lib/i18n";

export function AdminLangBar({ current }: { current: Lang }) {
  return (
    <div className="flex flex-col gap-1 border-b border-parish-border pb-4">
      <span className="text-xs font-medium text-parish-muted">
        {adminInterfaceLanguageLabel(current)}
      </span>
      <LangSwitcher current={current} srOnlyLabel={adminInterfaceLanguageLabel(current)} />
    </div>
  );
}
