# portugues-brasil

48-week Brazilian Portuguese plan (20 min/day) for Anton and Yanina, aimed at life in Brazil and the CELPE-Bras exam. Static site, two profiles without passwords, shared progress.

## Stack and structure
- `index.html` — the whole site (plan data, UI, logic), plain HTML/CSS/JS, no build.
  Views by URL hash: start screen (Антон / Янина / Вместе), `#anton` / `#yanina` personal plan, `#vmeste` games
  (Дуэль, Объясни слово, Сценка) on words from weeks either person has started.
- `config.js` — Supabase URL and anon public key (public by design).
- `supabase.sql` — table `progress` (one row per person: `who`, `done` jsonb) with RLS for the anon key.
- Hosting: GitHub Pages from `main`, repo `baclandy/portugues-brasil`.

## Commands
- Run locally: `python3 -m http.server 8000` then open http://localhost:8000
- Deploy: push to `main` — GitHub Pages updates in ~1 minute.
- Check JS syntax: extract the `<script>` block and run `node --check`.

## Rules
- Only Brazilian Portuguese content (not European).
- No passwords or accounts: profile is just a choice of Anton / Yanina.
- Only the anon public key goes into `config.js`; never the service_role key.
- Database changes go through `supabase.sql` and are shown to the user before running.
