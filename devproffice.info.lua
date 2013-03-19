ttl = 3600
ipaddr = "133.242.159.93"

a(_a, ipaddr, ttl)
cname("*", _a, ttl)

a(concat("mail", _a), ipaddr, ttl)
mx(_a, concat("mail", _a), 10, ttl)
