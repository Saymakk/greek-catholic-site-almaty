/** Карта прихода (Google Maps embed). */
export function ParishMapEmbed({
  src,
  title,
  className,
}: {
  src: string;
  title: string;
  /** По умолчанию отступ сверху; передайте "mt-0" чтобы убрать. */
  className?: string;
}) {
  return (
    <div
      className={[
        "w-full overflow-hidden rounded-xl border border-parish-border bg-parish-surface shadow-sm",
        className ?? "mt-2",
      ].join(" ")}
    >
      <iframe
        src={src}
        title={title}
        width={600}
        height={450}
        className="h-[min(28rem,70vh)] w-full border-0"
        allowFullScreen
        loading="lazy"
        referrerPolicy="no-referrer-when-downgrade"
      />
    </div>
  );
}
