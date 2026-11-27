-- Run once in Supabase: SQL Editor -> New query -> paste -> Run.
-- Safe to re-run. Does NOT change or delete anything in the "progress" table.
-- Before every change of a progress row, the old version is copied into "progress_history".
-- The site (anon key) can neither read nor change the history; only you in the Supabase dashboard can.

create table if not exists public.progress_history (
  id bigserial primary key,
  who text not null,
  done jsonb not null,
  saved_at timestamptz not null default now()
);

alter table public.progress_history enable row level security;
revoke all on public.progress_history from anon, authenticated;

create or replace function public.progress_keep_history()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if old.done is distinct from new.done then
    insert into public.progress_history (who, done) values (old.who, old.done);
  end if;
  return new;
end;
$$;

drop trigger if exists progress_keep_history on public.progress;
create trigger progress_keep_history
  before update on public.progress
  for each row execute function public.progress_keep_history();

-- How to restore (run by hand only when needed):
--   1) find the version:  select id, who, saved_at, done from progress_history where who = 'anton' order by saved_at desc limit 20;
--   2) put it back:       update progress set done = (select done from progress_history where id = <ID>) where who = 'anton';
