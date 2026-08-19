-- Todo Dashboard (Supabase) schema
-- Table names are lowercase; column names match the FIELD_MAP in index.html.
create table if not exists public.works (
  id text primary key,
  name text not null default '',
  url text not null default '',
  date_key text not null default '',
  repeat text not null default 'none',
  urgent text not null default '',
  url_overrides jsonb not null default '{}'::jsonb
);
create table if not exists public.checks (
  check_key text primary key,
  state smallint not null default 0
);
create table if not exists public.settings (
  id text primary key,
  name text not null default '',
  value text not null default ''
);

-- POC: permissive RLS (same trust level as the old embedded Airtable PAT).
-- For production, replace with proper auth + policies.
alter table public.works enable row level security;
alter table public.checks enable row level security;
alter table public.settings enable row level security;

drop policy if exists "poc full access" on public.works;
drop policy if exists "poc full access" on public.checks;
drop policy if exists "poc full access" on public.settings;

create policy "poc full access" on public.works for all using (true) with check (true);
create policy "poc full access" on public.checks for all using (true) with check (true);
create policy "poc full access" on public.settings for all using (true) with check (true);
