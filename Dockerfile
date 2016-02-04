FROM java:8
COPY mage-0.1.70-SNAPSHOT.jar /usr/src/mage-0.1.70-SNAPSHOT.jar
COPY config.yml /usr/src/config.yml
WORKDIR /usr/src
CMD ["java", "-jar", "mage-0.1.70-SNAPSHOT.jar", "server", "config.yml"]
