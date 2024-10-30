FROM alpine:3@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d AS node_builder
WORKDIR /node

ENV NODE_VERSION=v20.x

RUN apk add git python3 gcc g++ linux-headers make ninja

RUN git clone --branch $NODE_VERSION --depth=1 --recursive --shallow-submodules https://github.com/nodejs/node

RUN cd node \
  && ./configure --fully-static --enable-static --ninja --node-builtin-modules-path "$(pwd)" --without-npm \
  && make

FROM scratch AS runner

COPY --from=node_builder /node/node/node /node

ENTRYPOINT ["/node"]