FROM maven as build
RUN useradd builder
WORKDIR /build
RUN chown builder:builder /build
USER builder
COPY --chown=builder ./ ./

RUN mvn install -Dgpg.skip -f external/oj-core/pom.xml
RUN mvn package
RUN mkdir -p out
RUN mvn help:evaluate -q -Dexpression=project.version -DforceStdout > out/version
RUN mv target/oj-server-$(cat out/version)-jar-with-dependencies.jar out/oj-server.jar
RUN mv src/main/webapp out/webapp

FROM openjdk
COPY --from=build /build/out /oj-server

RUN useradd -m -d /run/oj-server -r oj-server
USER oj-server
VOLUME /data
EXPOSE 8080

ENV ADDRESS 0.0.0.0
ENV PORT 8080
ENV DB_HOST localhost
ENV DB_NAME online_judge
# ENV DB_USER
# ENV DB_PASSWD
ENV DATA /data
ENV WEBAPP /oj-server/webapp

WORKDIR /run/oj-server
CMD java -jar /oj-server/oj-server.jar
