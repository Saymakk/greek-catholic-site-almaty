import { createServerClient } from "@supabase/ssr";
import { NextResponse, type NextRequest } from "next/server";

const INACTIVITY_MS = 30 * 60 * 1000;
const ACTIVITY_COOKIE = "parish_activity_at";

export async function updateSession(request: NextRequest) {
  let response = NextResponse.next({
    request,
  });

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return request.cookies.getAll();
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value }) =>
            request.cookies.set(name, value),
          );
          response = NextResponse.next({
            request,
          });
          cookiesToSet.forEach(({ name, value, options }) =>
            response.cookies.set(name, value, options),
          );
        },
      },
    },
  );

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (user) {
    const raw = request.cookies.get(ACTIVITY_COOKIE)?.value;
    const now = Date.now();
    if (raw) {
      const last = Number(raw);
      if (!Number.isNaN(last) && now - last > INACTIVITY_MS) {
        await supabase.auth.signOut();
        const url = request.nextUrl.clone();
        url.pathname = "/admin/login";
        url.search = "";
        const redirectRes = NextResponse.redirect(url);
        redirectRes.cookies.delete(ACTIVITY_COOKIE);
        response.cookies.getAll().forEach((c) => {
          redirectRes.cookies.set(c.name, c.value);
        });
        return redirectRes;
      }
    }
    response.cookies.set(ACTIVITY_COOKIE, String(now), {
      path: "/",
      httpOnly: true,
      sameSite: "lax",
      maxAge: 60 * 60 * 24,
    });
  } else {
    response.cookies.delete(ACTIVITY_COOKIE);
  }

  return response;
}
