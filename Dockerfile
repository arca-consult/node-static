FROM alpine:latest AS node_builder
WORKDIR /node

ARG NODE_VERSION=unspecified

RUN apk add git python3 gcc g++ linux-headers make ninja

RUN git clone --branch $NODE_VERSION --depth=1 --recursive --shallow-submodules https://github.com/nodejs/node

RUN cd node \
  && ./configure \
    --fully-static --enable-static \
    --ninja --without-corepack --without-npm \
  && make

FROM scratch AS runner

COPY --from=node_builder /node/node/node /node

ENTRYPOINT ["/node", "--max-semi-space-size=128", "--max-old-space-size=1024"]