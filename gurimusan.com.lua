ttl = 3600
ipaddr = "49.212.150.92"

a(_a, ipaddr, ttl)
cname("www", _a, ttl)
cname("redmine", _a, ttl)
cname("hg", _a, ttl)

a(concat("mail", _a), ipaddr, ttl)
a(concat("mailhost", _a), ipaddr, ttl)
a(concat("lists", _a), ipaddr, ttl)

mx(_a, concat("mailhost", _a), 10, ttl)
mx(concat("lists", _a), concat("mailhost", _a), 10, ttl)
txt(_a, "v=spf1 a mx ptr ip4:" .. ipaddr .. " ptr:mailhost." .. _a .. " mx:mailhost." .. _a .. " mx:" .. _a .. " -all", ttl)
txt(concat("lists", _a), "v=spf1 a mx ptr ip4:" .. ipaddr .. " ptr:mailhost." .. _a .. " mx:mailhost." .. _a .. " mx:" .. _a .. " -all", ttl)
