ttl = 3600
ipaddr = "49.212.150.92"

a(_a, ipaddr, ttl)
cname("www", _a, ttl)

-- Redmine の公開先はこのサブドメインのみ（Web は redmine.gurimusan.info で提供）
a(concat("redmine", _a), ipaddr, ttl)

-- 廃止済みサービスの A / MX（hg・jenkins・joomla・barks・mail・mailhost・lists）は
-- 移行スコープ外のため削除。@gurimusan.info 宛の受信メールは廃止（MX なし）。

-- 送信は Brevo SMTP リレー経由（redmine@gurimusan.info）。旧メールサーバは廃止したため
-- apex SPF は Brevo のみ許可に整理（SPF は1ドメイン1本のみ有効）。
txt(_a, "v=spf1 include:spf.brevo.com -all", ttl)

-- DMARC。レポート送付先は受信可能な外部アドレス（@gurimusan.info は受信停止のため使わない）。
txt(concat("_dmarc", _a), "v=DMARC1; p=none; rua=mailto:matsushita-nagatoshi@scratch.jp", ttl)

-- DKIM / ドメイン認証: Brevo 管理画面「Senders, Domains & Dedicated IPs」→ 対象ドメイン →
-- Authenticate に表示される CNAME/TXT をそのまま追加する（値は要記入）。
--   例) cname(concat("brevo1._domainkey", _a), "<Brevoが示すターゲット>.", ttl)
--       cname(concat("brevo2._domainkey", _a), "<Brevoが示すターゲット>.", ttl)
--       txt(concat("<Brevoが示すコード>", _a), "<Brevoが示す値>", ttl)  -- ドメイン認証コード
