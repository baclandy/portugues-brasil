# portugues-brasil

48-week Brazilian Portuguese plan (20 min/day) for Anton and Yanina, aimed at life in Brazil and the CELPE-Bras exam. Static site, two profiles without passwords, shared progress.

## Stack and structure
- `index.html` — the whole site (plan data, UI, logic), plain HTML/CSS/JS, no build.
  Views by URL hash: start screen (Антон / Янина / Вместе), `#anton` / `#yanina` personal plan, `#vmeste` games
  (Дуэль, Объясни слово, Сценка) on words from weeks either person has started.
  `VIDEOS` (one checked YouTube id per week) and `PHRASES` (3 model phrases per week) — same order as `W`.
  `daySteps` gives concrete step-by-step instructions for each day. No Anki: daily on-site warm-up
  (8 words, current + older weeks; missed words come back more often, kept in localStorage `pt-miss`, not in the DB).
- `config.js` — Supabase URL and anon public key (public by design).
- `supabase.sql` — table `progress` (one row per person: `who`, `done` jsonb) with RLS for the anon key.
- `supabase-history.sql` — trigger copying the old row into `progress_history` before each update (restore steps inside).
- `.github/workflows/backup.yml` — daily read-only backup of `progress` into branch `backups` (`latest.json`, `daily/`).
- Saving is merge-safe: the site keeps unsent changes (`ops`), reads the server row, applies them, writes back.
- Hosting: GitHub Pages from `main`, repo `baclandy/portugues-brasil`.

## Commands
- Run locally: `python3 -m http.server 8000` then open http://localhost:8000
- Deploy: push to `main` — GitHub Pages updates in ~1 minute.
- Check JS syntax: extract the `<script>` block and run `node --check`.

## Rules
- Only Brazilian Portuguese content (not European) — including linked videos and channels.
- No passwords or accounts: profile is just a choice of Anton / Yanina.
- Only the anon public key goes into `config.js`; never the service_role key.
- Database changes go through `supabase.sql` and are shown to the user before running.

## Progress protection (never break)
- Real progress lives in Supabase `progress`. Never delete, truncate, drop or rewrite it; never change its columns.
- Progress keys are `w<week>d<day>` (week 1–48, day 1–6). Never reorder, insert or delete weeks/days in `W`/`DAYS`:
  edit texts in place, add new weeks only at the end.
- Never write the whole local list to the server; every save must read the server row first and apply only changes.
- Test new code only against a local mock server, never by clicking on the live site with real data.
- Don't remove `progress_history`, its trigger, or the backup workflow.
