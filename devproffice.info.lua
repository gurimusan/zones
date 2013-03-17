ttl = 3600
ipaddr = "133.242.159.93"

a(_a, ipaddr, ttl)
cname("*", _a, ttl)

a(concat("mail", _a), ipaddr, ttl)
a(concat("mailhost", _a), ipaddr, ttl)
a(concat("lists", _a), ipaddr, ttl)

mx(_a, concat("mailhost", _a), 10, ttl)
mx(concat("lists", _a), concat("mailhost", _a), 10, ttl)
txt(_a, "v=spf1 a mx ptr ip4:" .. ipaddr .. " ptr:mailhost." .. _a .. " mx:mailhost." .. _a .. " mx:" .. _a .. " -all", ttl)
txt(concat("lists", _a), "v=spf1 a mx ptr ip4:" .. ipaddr .. " ptr:mailhost." .. _a .. " mx:mailhost." .. _a .. " mx:" .. _a .. " -all", ttl)
