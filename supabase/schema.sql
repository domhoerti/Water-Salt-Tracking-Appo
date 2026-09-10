-- Wasser & Salz – Datenbankschema für Supabase
-- Einfügen unter: Supabase → SQL Editor → New query → einfügen → Run
--
-- Legt zwei Tabellen an und schaltet Row Level Security ein. RLS ist der
-- eigentliche Schutz: Jede Zeile gehört einer Benutzerkennung, und die
-- Datenbank gibt nur Zeilen heraus, deren user_id zur angemeldeten Person
-- passt. Der öffentliche anon-Key im App-Code kann daran nichts ändern.

create table if not exists public.tracker_days (
  user_id    uuid        not null references auth.users(id) on delete cascade,
  date       date        not null,
  salt_g     numeric,
  entries    jsonb       not null default '[]'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, date)
);

create table if not exists public.tracker_settings (
  user_id    uuid        primary key references auth.users(id) on delete cascade,
  config     jsonb       not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.tracker_days     enable row level security;
alter table public.tracker_settings enable row level security;

drop policy if exists "eigene Tage"          on public.tracker_days;
drop policy if exists "eigene Einstellungen" on public.tracker_settings;

create policy "eigene Tage" on public.tracker_days
  for all
  using      (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "eigene Einstellungen" on public.tracker_settings
  for all
  using      (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Kontrolle: beide Tabellen müssen rowsecurity = true zeigen.
select tablename, rowsecurity
from pg_tables
where schemaname = 'public' and tablename in ('tracker_days','tracker_settings');
