import {
  getNewsForLang,
  getLiturgicalForDate,
  getLiturgicalRange,
  getScriptureBooks,
  getTelegramMessages,
  todayStr,
} from "@/lib/data";
import { getLang } from "@/lib/i18n-server";
import { NewsSection } from "@/components/NewsSection";
import { TodayWithCalendar } from "@/components/TodayWithCalendar";
import { ScriptureSection } from "@/components/ScriptureSection";
import { TelegramSection } from "@/components/TelegramSection";
import {
  endOfMonth,
  endOfWeek,
  format,
  startOfMonth,
  startOfWeek,
} from "date-fns";

export default async function HomePage() {
  const lang = await getLang();
  const today = todayStr();
  const now = new Date();
  const gridStart = startOfWeek(startOfMonth(now), { weekStartsOn: 1 });
  const gridEnd = endOfWeek(endOfMonth(now), { weekStartsOn: 1 });

  const [news, todayEvents, initialEvents, books, telegram] = await Promise.all([
    getNewsForLang(lang),
    getLiturgicalForDate(today, lang),
    getLiturgicalRange(format(gridStart, "yyyy-MM-dd"), format(gridEnd, "yyyy-MM-dd"), lang),
    getScriptureBooks(lang),
    getTelegramMessages(25),
  ]);

  return (
    <div className="w-full px-4 py-12 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
      <div className="grid grid-cols-1 gap-y-14 lg:grid-cols-[20%_50%_20%] lg:gap-x-[5%] lg:gap-y-0 lg:items-start">
        <div id="scripture" className="min-w-0 scroll-mt-24 overflow-visible">
          <ScriptureSection lang={lang} books={books} variant="sidebar" />
        </div>
        <div className="min-w-0 scroll-mt-24">
          <NewsSection lang={lang} news={news} />
        </div>
        <aside className="min-w-0 space-y-10 scroll-mt-24">
          <TodayWithCalendar
            lang={lang}
            events={todayEvents}
            initialEvents={initialEvents}
            initialMonthIso={now.toISOString()}
            variant="sidebar"
          />
          <TelegramSection lang={lang} messages={telegram} variant="sidebar" />
        </aside>
      </div>
    </div>
  );
}
