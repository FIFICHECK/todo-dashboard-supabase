# Todo Dashboard — Supabase 版 (POC)

Fiona Team To-Do Dashboard 嘅 Supabase 版，由 Airtable 版本改裝（資料 layer 換成 supabase-js，UI 全部保留）。

- 原版 (Airtable): https://fificheck.github.io/todo-dashboard-v2/
- 新版 (Supabase): https://fificheck.github.io/todo-dashboard-supabase/

## 點解轉

| | Airtable Free | Supabase Free |
|---|---|---|
| Records 上限 | 1,000 / base (成日爆) | 500MB 總容量（呢個 dashboard 用 <1MB） |
| API requests | 每月 quota，燒爆就 429 | Unlimited |
| Auto-pause | — | 7 日冇 activity 會 pause（用 cron keep-alive 解決） |

## 檔案結構

```
todo-dashboard-supabase/
  index.html        # 成個 dashboard（UI + Supabase data layer）
  config.js         # ★ 要填: SUPABASE_URL + ANON_KEY
  seed/
    schema.sql      # 建表 + RLS policy（喺 Supabase SQL Editor 行一次）
    seed.sql        # 由 Airtable fallback export 抽出嘅 seed data (2026-08-19)
    works.json      # 36 works
    checks.json     # 868 checks
    settings.json   # 7 RMs + CheckArchive (1332 entries)
  assets/
```

## Setup 步驟（一次性）

1. 開 Supabase project（免費）→ Project Settings → API → 抄低 Project URL + anon key
2. 填落 `config.js`
3. Supabase Dashboard → SQL Editor → 貼 `seed/schema.sql` → Run
4. SQL Editor → 貼 `seed/seed.sql` → Run
5. Deploy（已經 auto-deploy，改完 push 就得）

## 技術筆記

- 用 supabase-js v2（CDN）+ anon key；RLS policy 係 POC 全開放（同舊版嵌 PAT 喺前端同一信任級別）
- `checks` 表用 `check_key` 做 primary key → 天然防止 cross-browser duplicate（Airtable 版要人手 lookup-before-POST）
- 所有寫入用 `upsert`（onConflict），多人同時 tick 唔會 409
- Archive 機制保留：舊 checks 照樣 merge 入 `settings` 表嘅 CheckArchive row（text column 冇 100K 限制，但保留 truncation 保險）
- Polling 保留 5 分鐘 + visibility change 即時 sync
- Offline fallback（localStorage cache + 內嵌 FALLBACK_*）保留

## Keep-alive cron（防止 7 日 inactivity pause）

```bash
# 每日 09:00 打一次，令 project 唔會 pause
curl -s "https://YOUR-PROJECT-REF.supabase.co/rest/v1/checks?select=check_key&limit=1" \
  -H "apikey: YOUR-ANON-KEY" -H "Authorization: Bearer YOUR-ANON-KEY"
```
