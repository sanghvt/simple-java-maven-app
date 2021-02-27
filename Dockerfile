FROM maven:3.6-openjdk-11

COPY ./ /home/app/

WORKDIR /home/app

RUN mvn package -Dmaven.test.skip=true

EXPOSE 8087

ENTRYPOINT java -jar ./target/*.jar
