import { parseHttpImageUrl } from "./admin-image-url";

/** Длинные вставки (Instagram blockquote и т.д.) */
export const MAX_NEWS_COVER_FIELD_LEN = 131072;

/** Разрешённые внешние script только по src (вставки соцсетей). */
const ALLOWED_EMBED_SCRIPT_SRC: RegExp[] = [
  /^(https?:)?\/\/(www\.)?instagram\.com\/embed\.js\/?(\?.*)?$/i,
  /^https?:\/\/(www\.)?instagram\.com\/embed\.js\/?(\?.*)?$/i,
  /^https?:\/\/platform\.twitter\.com\/widgets\.js/i,
  /^https?:\/\/www\.tiktok\.com\/embed\.js/i,
];

function scriptSrcLooksAllowed(src: string): boolean {
  const t = src.trim().replace(/^\/\//, "https://");
  return ALLOWED_EMBED_SCRIPT_SRC.some((re) => re.test(src.trim()) || re.test(t));
}

function validateEmbedScripts(s: string, fieldLabel: string): void {
  const re = /<script\b([^>]*)>([\s\S]*?)<\/script\s*>/gi;
  let m: RegExpExecArray | null;
  while ((m = re.exec(s)) !== null) {
    const attrs = m[1] ?? "";
    const body = (m[2] ?? "").trim();
    if (body.replace(/\s/g, "") !== "") {
      throw new Error(`${fieldLabel}: script с кодом внутри не разрешён`);
    }
    const srcM = attrs.match(/\bsrc\s*=\s*(?:"([^"]*)"|'([^']*)'|([^\s>]+))/i);
    const src = (srcM?.[1] ?? srcM?.[2] ?? srcM?.[3] ?? "").trim();
    if (!src) {
      throw new Error(`${fieldLabel}: script без src не разрешён`);
    }
    if (!scriptSrcLooksAllowed(src)) {
      throw new Error(`${fieldLabel}: неподдерживаемый script вставки`);
    }
  }
}

/** Минимальное раскодирование, если вставили HTML как текст с &lt;iframe … */
function decodeMinimalHtmlEntities(t: string): string {
  return t
    .replace(/&lt;/gi, "<")
    .replace(/&gt;/gi, ">")
    .replace(/&quot;/gi, '"')
    .replace(/&#0*39;/g, "'")
    .replace(/&amp;/gi, "&");
}

/** Убирает артефакты вставки: переносы посреди URL, BOM, protocol-relative //… */
function normalizeUrlForNewsCover(raw: string): string {
  let t = raw.trim().replace(/^\uFEFF/, "");
  t = t.replace(/[\u200B-\u200D\uFEFF]/g, "");
  t = t.replace(/[\r\n\t]+/g, "");
  t = t.trim();
  t = t.replace(/^[\s"'«»„”’‘]+|[\s"'«»„”’‘]+$/gu, "");
  t = t.trim();
  if (/^\/\/[^/\s]+/i.test(t)) {
    return `https:${t}`;
  }
  return t;
}

/** Из строки вида «текст https://…» выделяет первый http(s) URL. */
function extractFirstHttpUrl(s: string): string | null {
  const m = s.match(/\bhttps?:\/\/[^\s<>"']+/i);
  return m ? m[0] : null;
}

function validateEmbedMarkup(s: string, fieldLabel: string): string {
  if (s.length > MAX_NEWS_COVER_FIELD_LEN) {
    throw new Error(`${fieldLabel}: слишком длинный фрагмент HTML`);
  }
  validateEmbedScripts(s, fieldLabel);
  return s;
}

/**
 * Обложка-вставка: iframe / video / embed / object, Instagram blockquote,
 * Twitter/TikTok и др. (не прямой URL картинки).
 */
export function isNewsCoverVideoEmbed(s: string | null | undefined): boolean {
  if (s == null) return false;
  const t = s.trim();
  if (!t) return false;
  if (/<\s*(iframe|video|embed|object)\b/i.test(t)) return true;
  if (/instagram-media|data-instgrm-permalink/i.test(t)) return true;
  if (/class\s*=\s*["'][^"']*twitter-tweet/i.test(t)) return true;
  if (/\btiktok-embed\b/i.test(t)) return true;
  return false;
}

/**
 * Пустая строка → null. HTML-вставка → сохраняем как есть (с ограничениями).
 * Иначе — обычный http(s) URL картинки или ссылки.
 */
export function parseNewsCoverUrlOrEmbed(raw: string, fieldLabel = "Обложка"): string | null {
  const s = raw.trim().replace(/^\uFEFF/, "");
  if (!s) return null;

  const decoded = decodeMinimalHtmlEntities(s);

  if (isNewsCoverVideoEmbed(decoded)) {
    return validateEmbedMarkup(decoded, fieldLabel);
  }

  const normalized = normalizeUrlForNewsCover(decoded);
  try {
    return parseHttpImageUrl(normalized, `${fieldLabel} (URL)`, MAX_NEWS_COVER_FIELD_LEN);
  } catch (urlErr) {
    const extracted = extractFirstHttpUrl(normalized);
    if (extracted && extracted !== normalized) {
      try {
        return parseHttpImageUrl(extracted, `${fieldLabel} (URL)`, MAX_NEWS_COVER_FIELD_LEN);
      } catch {
        /* fall through */
      }
    }
    if (isNewsCoverVideoEmbed(s)) {
      return validateEmbedMarkup(s, fieldLabel);
    }
    throw urlErr;
  }
}

/** Для DOM: скрипты из вставки не выполняются через innerHTML — вырезаем, подключаем сами. */
export function stripEmbedScriptsForDisplay(html: string): string {
  return html.replace(/<script\b[^>]*>[\s\S]*?<\/script\s*>/gi, "").trim();
}
