import {
  getNewsPage,
  getLiturgicalForDatePage,
  getLiturgicalForDateCount,
  getLiturgicalRange,
  getScriptureBooksPage,
  getExternalLiturgicalWidgetSettings,
  resolveExternalLiturgicalWidgetSrcs,
  liturgicalGridRangeForSiteNow,
  todayStr,
} from "@/lib/data";
import type { Metadata } from "next";
import { getLang } from "@/lib/i18n-server";
import { getSiteUrl } from "@/lib/site-url";
import { NewsSection } from "@/components/NewsSection";
import { TodayWithCalendar } from "@/components/TodayWithCalendar";
import { ScriptureSection } from "@/components/ScriptureSection";
import { t } from "@/lib/ui-strings";
import { format } from "date-fns";

export async function generateMetadata(): Promise<Metadata> {
  const base = getSiteUrl();
  return {
    alternates: { canonical: "/" },
    openGraph: { url: base },
  };
}

export default async function HomePage() {
  const lang = await getLang();
  const today = todayStr();
  const { gridStart, gridEnd } = liturgicalGridRangeForSiteNow();

  const [newsRes, todayPage, todayCount, initialEvents, booksRes, widgetSettings] =
    await Promise.all([
      getNewsPage(lang, 1, 200),
      getLiturgicalForDatePage(today, lang, 1, 10),
      getLiturgicalForDateCount(today),
      getLiturgicalRange(
        format(gridStart, "yyyy-MM-dd"),
        format(gridEnd, "yyyy-MM-dd"),
        lang,
      ),
      getScriptureBooksPage(lang, 1, 200),
      getExternalLiturgicalWidgetSettings(),
    ]);
  const externalWidgetSrcs = resolveExternalLiturgicalWidgetSrcs(widgetSettings);
  const news = newsRes.items;
  const books = booksRes.items;

  return (
    <div className="w-full py-8 pb-[max(2rem,env(safe-area-inset-bottom))] ps-[max(1rem,env(safe-area-inset-left))] pe-[max(1rem,env(safe-area-inset-right))] sm:px-6 sm:py-12 lg:px-10 xl:px-14 2xl:px-20">
      <div className="grid grid-cols-1 gap-y-10 sm:gap-y-12 lg:grid-cols-[20%_50%_20%] lg:gap-x-[5%] lg:gap-y-0 lg:items-start">
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
            variant="sidebar"
          />
          {externalWidgetSrcs.length > 0 ? (
            <div className="flex w-full flex-col items-center gap-2">
              {externalWidgetSrcs.map((src) => (
                <div
                  key={src}
                  className="mx-auto h-[240px] w-full max-w-[min(300px,calc(100vw-2rem))] shrink-0 overflow-hidden"
                >
                  <iframe
                    width={300}
                    height={240}
                    title={t(lang, "externalLiturgicalWidgetIframeTitle")}
                    src={src}
                    className="mx-auto block h-[240px] w-full max-w-[300px] border-0"
                    loading="lazy"
                    scrolling="no"
                  />
                </div>
              ))}
            </div>
          ) : null}
        </aside>
      </div>
    </div>
  );
}
