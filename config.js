// ═══════════════════════════════════════════════════════════════
// Todo Dashboard (Supabase 版) — 設定檔
// ═══════════════════════════════════════════════════════════════
// 安全架構（2026-08-18 起）：
//   browser → fificheck-access-gate worker（session cookie + allowlist 檢查）
//              ↓ worker 用 service role key（secret，永不出而家 public repo）
//            Supabase（anon 權限已 revoke — RLS deny all）
// 呢個檔案唔再需要任何 key — public repo 零敏感資料。
// ═══════════════════════════════════════════════════════════════

var CONFIG_SB_WORKER = 'https://fificheck-access-gate.fificheck.workers.dev';
var CONFIG_SB_SITE = 'todo-supabase';
