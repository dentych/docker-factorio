FROM alpine

RUN apk --update --no-cache add ca-certificates openssl
RUN update-ca-certificates
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/unreleased/glibc-bin-2.23-r3.apk
RUN apk add glibc-2.23-r3.apk
RUN apk add glibc-bin-2.23-r3.apk
RUN mkdir /opt
RUN wget https://www.factorio.com/get-download/0.14.21/headless/linux64 -O factorio.tar.gz
RUN tar -xvzf factorio.tar.gz -C /opt

WORKDIR /opt/factorio
CMD /opt/factorio/bin/x64/factorio --start-server main
