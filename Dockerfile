FROM alpine

RUN apk --update --no-cache add ca-certificates openssl \
	&& update-ca-certificates \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk \
	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/unreleased/glibc-bin-2.23-r3.apk \
	&& apk add glibc-2.23-r3.apk \
	&& apk add glibc-bin-2.23-r3.apk \
	&& mkdir /opt \
	&& wget https://www.factorio.com/get-download/0.14.21/headless/linux64 -O factorio.tar.gz \
	&& tar -xvzf factorio.tar.gz -C /opt \
	&& rm factorio.tar.gz \
	&& apk del ca-certificates openssl \
	&& apk clean all

WORKDIR /opt/factorio
CMD /opt/factorio/bin/x64/factorio --start-server savegame
