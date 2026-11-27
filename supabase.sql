-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.
-- One row per person; anyone with the site can read and update only these two rows.

create table if not exists public.progress (
  who text primary key check (who in ('anton', 'yanina')),
  done jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.progress enable row level security;

drop policy if exists "progress read" on public.progress;
drop policy if exists "progress insert" on public.progress;
drop policy if exists "progress update" on public.progress;

create policy "progress read" on public.progress for select to anon using (true);
create policy "progress insert" on public.progress for insert to anon with check (who in ('anton', 'yanina'));
create policy "progress update" on public.progress for update to anon using (true) with check (who in ('anton', 'yanina'));

grant select, insert, update on public.progress to anon;

insert into public.progress (who) values ('anton'), ('yanina') on conflict (who) do nothing;
