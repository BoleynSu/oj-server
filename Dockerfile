FROM openjdk
RUN curl -L https://boleyn.su/pgp | gpg --import
RUN yum install wget unzip -y && yum clean all

ENV APPROOT=/boleyn.su/opt/boleyn.su/oj-server/
RUN mkdir -p $APPROOT
WORKDIR $APPROOT

ENV VERSION=1.0.2
RUN wget https://repo1.maven.org/maven2/su/boleyn/oj/oj-server/$VERSION/oj-server-$VERSION-jar-with-dependencies.jar{,.asc}
RUN gpg --verify oj-server-$VERSION-jar-with-dependencies.jar.asc
RUN wget https://repo1.maven.org/maven2/su/boleyn/oj/oj-server/$VERSION/oj-server-$VERSION.jar{,.asc}
RUN gpg --verify oj-server-$VERSION.jar.asc

RUN useradd -r oj-server
USER oj-server:oj-server
WORKDIR /tmp
VOLUME /data
EXPOSE 8080

ENV ADDRESS 0.0.0.0
ENV PORT 8080
ENV DB_HOST localhost
ENV DB_NAME online_judge
# ENV DB_USER
# ENV DB_PASSWD
ENV DATA /data

CMD /usr/bin/bash -c '\
    unzip $APPROOT/oj-server-$VERSION.jar; \
    java -jar $APPROOT/oj-server-$VERSION-jar-with-dependencies.jar'
