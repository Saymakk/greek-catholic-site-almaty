"use client";

import { RichOrPlain } from "./RichOrPlain";

export function HistoryBody({ body }: { body: string }) {
  return (
    <RichOrPlain
      content={body}
      className="rich-html mt-8 max-w-none text-base font-medium leading-relaxed text-parish-text"
    />
  );
}
