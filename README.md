# node-static
Static compiled node inside container

Filesystem:
```
├─ etc
│  ├─ passwd
│  └─ ssl
│     └─ certs
├─ node
└─ usr
   └─ share
      └─ zoneinfo
```

Create a Release with tag: vx.x.x (v20.18.0) to use it as tag for nodejs repo


## Usage (Nextjs)

```Dockerfile
FROM node:20.18.0-alpine AS builder

...

FROM ghcr.io/arca-consult/node-static:v20.18.0 AS runner

COPY --from=builder /app/.next/standalone /app/
COPY --from=builder /app/.next/static /app/.next/static
COPY --from=builder /app/public /app/public

ENV PORT=3000
ENV HOSTNAME='0.0.0.0'
CMD ["/app/server.js"]
```