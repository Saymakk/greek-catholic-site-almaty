import {
  getNewsPage,
  getLiturgicalForDatePage,
  getLiturgicalForDateCount,
  getLiturgicalRange,
  getScriptureBooksPage,
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

  const [newsRes, todayPage, todayCount, initialEvents, booksRes, telegram] = await Promise.all([
    getNewsPage(lang, 1, 200),
    getLiturgicalForDatePage(today, lang, 1, 10),
    getLiturgicalForDateCount(today),
    getLiturgicalRange(format(gridStart, "yyyy-MM-dd"), format(gridEnd, "yyyy-MM-dd"), lang),
    getScriptureBooksPage(lang, 1, 200),
    getTelegramMessages(25),
  ]);
  const news = newsRes.items;
  const books = booksRes.items;

  return (
    <div className="w-full px-4 py-12 sm:px-6 lg:px-10 xl:px-14 2xl:px-20">
      <div className="grid grid-cols-1 gap-y-14 lg:grid-cols-[20%_50%_20%] lg:gap-x-[5%] lg:gap-y-0 lg:items-start">
        <div className="min-w-0 scroll-mt-24 overflow-visible">
          <ScriptureSection lang={lang} books={books} variant="sidebar" />
        </div>
        <div className="min-w-0 scroll-mt-24">
          <NewsSection lang={lang} news={news} />
        </div>
        <aside className="min-w-0 space-y-10 scroll-mt-24">
          <TodayWithCalendar
            lang={lang}
            events={todayPage.events}
            todayDateStr={today}
            todayTotal={todayCount}
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
