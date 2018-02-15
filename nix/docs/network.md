network.md

------------------------------------------------------------------------------

For network:
Since guest netwrok seemed to (or it was really the protal) slow speed, it should only be enabled when guests are over.  There is ssh admin possible, so write a script that can enable on demand from phone, also set pw at that time.



reverse-proxy + caches
varnish
nginx
haproxy
squid

varnish can inspect requests to determine whether to cache.  

cache candidates:
regular browsing on an LRU
freqency + recency model

yarn/npm package requests?
need to see how these things handle cache updating.

should it only be used on immutable links?

nix packages

https://www.nginx.com/resources/glossary/reverse-proxy-server/

https://varnish-cache.org/docs/5.1/users-guide/vcl-example-manipulating-headers.html