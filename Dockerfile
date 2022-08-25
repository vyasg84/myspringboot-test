# First stage: complete build environment
FROM maven:3.6.3 AS builder
# add pom.xml and source code
COPY ./pom.xml pom.xml
COPY ./src src/
# package jar
RUN mvn clean package

# Second stage: minimal runtime environment
FROM openjdk:11
# copy jar from the first stage
COPY --from=builder target/helloworld-0.0.1.jar helloworld-0.0.1.jar

EXPOSE 8080

CMD ["java","-jar","helloworld-0.0.1.jar"]