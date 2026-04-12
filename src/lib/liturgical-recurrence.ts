import { addDays, addMonths, addWeeks, format, parseISO } from "date-fns";

export type LiturgicalRecurrenceFreq = "daily" | "weekly" | "monthly";

/** Даты включая первую; не более `max` штук. */
export function expandLiturgicalRecurrence(
  startDateIso: string,
  freq: LiturgicalRecurrenceFreq,
  totalCount: number,
  max = 100,
): string[] {
  const n = Math.min(Math.max(Math.floor(Number(totalCount)), 1), max);
  const start = parseISO(startDateIso);
  const out: string[] = [];
  for (let i = 0; i < n; i++) {
    const d =
      freq === "daily" ? addDays(start, i) : freq === "weekly" ? addWeeks(start, i) : addMonths(start, i);
    out.push(format(d, "yyyy-MM-dd"));
  }
  return out;
}
