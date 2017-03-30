FROM alpine:3.4

ARG GLIBC_VERSION=2.23-r3

RUN \
   # Install build dependencies \
   apk --no-cache add \
               ca-certificates \
               openssl \
   \
   # Adding public keys to allow install of glibc \
   && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
   \
   # Downloading apk packages \
   && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
   && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
   \
   # Installing glibc \
   && apk --no-cache add \
                glibc-${GLIBC_VERSION}.apk \
                glibc-bin-${GLIBC_VERSION}.apk \
   \
   # Removing the downloaded packages \
   && rm -f glibc-${GLIBC_VERSION}.apk \
   && rm -f glibc-bin-${GLIBC_VERSION}.apk \
   \
   # Removing build dependencies
   && apk --no-cache del \
               ca-certificates \
               openssl

ENV FACTORIO_VERSION=0.14.21 \
    FACTORIO_SHA1=fc11c0d5b2671e0cf36db7907de6ff617525ede3

RUN \
   # Install build dependencies \
   apk --no-cache add \
               ca-certificates \
               openssl \
   \
   # Creating opt \
   && mkdir /opt \
   \
   # Install Factorio into opt \
   && wget -q -O /tmp/factorio.tar.gz https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 \
   && echo "${FACTORIO_SHA1}  /tmp/factorio.tar.gz" | sha1sum -c \
   && tar -xvz -C /opt -f /tmp/factorio.tar.gz \
   && rm /tmp/factorio.tar.gz \
   \
   # Remove build dependencies \
   && apk --no-cache del \
               ca-certificates \
               openssl

VOLUME ["/opt/factorio/saves", "/opt/factorio/mods"]

WORKDIR /opt/factorio/saves

EXPOSE "34197/udp"
EXPOSE "27015/tcp"

COPY server/entry.sh /bin/entry.sh

RUN chmod +x /bin/entry.sh

ENTRYPOINT ["/bin/entry.sh"]
