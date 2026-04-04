"use client";

/** Убирает теги для превью и поиска */
export function stripTagsForPreview(s: string) {
  return s.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim();
}

/** Считаем HTML, если есть похожий на тег фрагмент */
export function isProbablyHtml(s: string) {
  const t = s.trim();
  if (!t) return false;
  return /<[a-z][a-z0-9]*\b[^>]*>/i.test(t);
}

function PlainTextAsBlocks({ text }: { text: string }) {
  const blocks = text.split(/\n\s*\n/);
  return (
    <div className="space-y-2">
      {blocks.map((block, i) => (
        <p key={i} className="m-0 whitespace-pre-wrap">
          {block}
        </p>
      ))}
    </div>
  );
}

export function RichOrPlain({
  content,
  className,
}: {
  content: string;
  className?: string;
}) {
  if (isProbablyHtml(content)) {
    return (
      <div
        className={className}
        dangerouslySetInnerHTML={{ __html: content }}
      />
    );
  }
  return (
    <div className={className}>
      <PlainTextAsBlocks text={content} />
    </div>
  );
}
