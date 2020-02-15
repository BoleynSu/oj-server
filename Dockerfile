FROM openjdk:latest
RUN curl -L boleyn.su/pgp | gpg --import
RUN yum install wget unzip -y && yum clean all

ENV APPROOT=/boleyn.su/opt/boleyn.su/oj-server/
RUN mkdir -p $APPROOT
WORKDIR $APPROOT

ENV VERSION=1.0.0
RUN wget https://repo1.maven.org/maven2/su/boleyn/oj/oj-server/$VERSION/oj-server-$VERSION-jar-with-dependencies.jar{,.asc}
RUN gpg --verify oj-server-$VERSION-jar-with-dependencies.jar.asc
RUN wget https://repo1.maven.org/maven2/su/boleyn/oj/oj-server/$VERSION/oj-server-$VERSION.jar{,.asc}
RUN gpg --verify oj-server-$VERSION.jar.asc

RUN useradd -r oj-server
USER oj-server:oj-server
WORKDIR /tmp
VOLUME /data
EXPOSE 8080

CMD /usr/bin/bash -c '\
    CONFIG_ENV="ADDRESS PORT DB_HOST DB_NAME DB_USER DB_PASSWD DATA"; \
    CONFIG=""; \
    if [[ ! -v ADDRESS ]]; then ADDRESS=0.0.0.0; fi; \
    if [[ ! -v PORT ]]; then PORT=8080; fi; \
    if [[ ! -v DATA ]]; then DATA=/data; fi; \
    for config in $CONFIG_ENV; do if [[ -v $config ]]; then CONFIG="$CONFIG -D$config=${!config}"; fi; done; \
    unzip $APPROOT/oj-server-$VERSION.jar; \
    java $CONFIG -jar $APPROOT/oj-server-$VERSION-jar-with-dependencies.jar'
