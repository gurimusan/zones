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
txt(concat("_dmarc", _a), "v=DMARC1; p=none", ttl)

-- Brevo ドメイン認証（2026-07-08 取得, branded subdomain 方式）。
-- ブランドサブドメイン send.gurimusan.info の CNAME が DKIM 署名・リターンパスを担う。
cname(concat("send", _a), "send-gurimusan-info.brand.brevosend.com.", ttl)
-- ドメイン所有確認コード（apex TXT。上の SPF TXT とは別レコードなので共存可）。
txt(_a, "brevo-code:9b7872a8ad0c0c7164059a338959a9ee", ttl)
