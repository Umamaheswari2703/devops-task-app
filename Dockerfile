FROM eclipse-temurin:17-jre

WORKDIR /app

COPY target/devops-task-app-1.0.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
