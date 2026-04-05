import { LangSwitcher } from "@/components/LangSwitcher";
import { adminInterfaceLanguageLabel } from "@/lib/admin-layout-i18n";
import type { Lang } from "@/lib/i18n";

export function AdminLangBar({
  current,
  plain,
}: {
  current: Lang;
  /** Без разделителя — для экрана входа и узких блоков */
  plain?: boolean;
}) {
  return (
    <div
      className={
        plain
          ? "flex flex-col gap-1"
          : "flex flex-col gap-1 border-b border-parish-border pb-4"
      }
    >
      <span className="text-xs font-medium text-parish-muted">
        {adminInterfaceLanguageLabel(current)}
      </span>
      <LangSwitcher current={current} srOnlyLabel={adminInterfaceLanguageLabel(current)} />
    </div>
  );
}
