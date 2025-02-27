FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/your-app.jar /app/your-app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app/your-app.jar"]

