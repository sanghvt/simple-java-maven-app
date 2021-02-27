FROM maven:3.6-openjdk-11

COPY ./ /home/app/

WORKDIR /home/app

RUN mvn package

EXPOSE 8087

ENTRYPOINT java -jar ./target/*.jar
