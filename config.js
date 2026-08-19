// ═══════════════════════════════════════════════════════════════
// Todo Dashboard (Supabase 版) — 設定檔
// ═══════════════════════════════════════════════════════════════
// 1. 去 https://supabase.com/dashboard 開一個免費 project（2 分鐘）
// 2. 開完之後: Project Settings → API → 複製:
//    - Project URL  (例如 https://abcd1234.supabase.co)
//    - anon public key (eyJhbGciOi... 長長一串)
// 3. 貼落下面兩個變數，存檔即可
//
// 注意: anon key 係公開嘅（放喺前端），安全性靠 database
//       Row Level Security policy 控制 — schema.sql 已包含 POC 用嘅 policy。
// ═══════════════════════════════════════════════════════════════

var CONFIG_SUPABASE_URL = 'https://YOUR-PROJECT-REF.supabase.co';
var CONFIG_SUPABASE_ANON_KEY = 'YOUR-ANON-KEY';
