Nginx setup
---

To use nginx instead of Caddy, follow these steps.

Add `ca.crt`, `jellyfin.home.crt` and `jellyfin.home.key` to `volumes/nginx/config/keys`.

Update `volumes/nginx/config/keys/site-confs/default.conf` and `volumes/nginx/config/keys/ssl.conf` with your domain and cert names (if different from above).
