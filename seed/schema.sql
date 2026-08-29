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

-- ===== Security: RLS deny all (2026-08-18) =====
-- anon 權限全部 revoke：就算攞到 anon key 都讀唔到嘢。
-- service_role key 自動 bypass RLS（PostgreSQL 內建行為），所以 worker 代理照常讀寫。
-- 唯一存取途徑 = fificheck-access-gate worker（session cookie + allowlist）。
alter table public.works enable row level security;
alter table public.checks enable row level security;
alter table public.settings enable row level security;

drop policy if exists "poc full access" on public.works;
drop policy if exists "poc full access" on public.checks;
drop policy if exists "poc full access" on public.settings;

-- 唔再建立任何 anon policy → anon role 對三張表嘅存取 = deny by default。
-- (如需保留 service_role 專用 policy 可以加，但 service_role bypass RLS 唔需要)
