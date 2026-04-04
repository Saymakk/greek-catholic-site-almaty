/** Ошибка PostgREST, когда колонки ещё нет в БД (миграция не применена). */
export function isSchemaCacheMissingColumn(
  err: { message?: string } | null | undefined,
  column: string,
): boolean {
  const m = err?.message ?? "";
  return m.includes(column) && m.includes("schema cache");
}
