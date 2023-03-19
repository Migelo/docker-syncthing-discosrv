FROM golang:alpine AS builder
LABEL maintainer="Miha Cernetic <cernetic.miha@gmail.com>"

ENV PKGVER 1.23.2

# Busybox wget needs TLS support, curl is less painful to get working
RUN apk add --no-cache ca-certificates curl && \
    mkdir /go || true && \
    cd /go && \
    mkdir -p src/github.com/syncthing && \
    export SRCDIR=$PWD && \
    cd src/github.com/syncthing && \
    curl -L https://github.com/syncthing/syncthing/releases/download/v$PKGVER/syncthing-source-v${PKGVER}.tar.gz | tar xzf - && \
    cd syncthing && \
    export GOPATH="$SRCDIR" GOROOT_FINAL="/usr/bin" && \
    go run build.go -no-upgrade -version v${PKGVER} build stdiscosrv

#Building thin container
FROM alpine

RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/syncthing/syncthing/stdiscosrv /usr/bin/stdiscosrv

# Run unprivileged out of /stdiscosrv
RUN mkdir /stdiscosrv && chown nobody:nobody /stdiscosrv
VOLUME /stdiscosrv
USER nobody
WORKDIR /stdiscosrv

EXPOSE 8443 19200

ENTRYPOINT ["/usr/bin/stdiscosrv"]
CMD [""]
