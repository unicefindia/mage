FROM openjdk:8-alpine3.7

RUN apk update && apk add redis
COPY target/mage-0.1.87-SNAPSHOT.jar /usr/src/mage-0.1.87-SNAPSHOT.jar
COPY config.yml /usr/src/config.yml
COPY docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh
WORKDIR /usr/src
EXPOSE 8026
EXPOSE 8028
ENTRYPOINT /entrypoint.sh
