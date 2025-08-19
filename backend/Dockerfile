# ---- Build stage (needs JDK 21) ----
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app

# Copy Gradle wrapper & build files first for caching
COPY gradlew gradlew.bat settings.gradle* build.gradle* gradle/ ./
# Windows checkouts sometimes have CRLF; fix & make executable
RUN sed -i 's/\r$//' gradlew && chmod +x gradlew

# Then copy sources
COPY src ./src

# Build the Spring Boot fat jar (skip tests, no daemon)
RUN ./gradlew --no-daemon bootJar -x test

# Rename the single jar to a stable name to avoid COPY wildcards
RUN JAR="$(ls build/libs/*-*.jar | head -n1)" \
 && echo "Using jar: $JAR" \
 && cp "$JAR" /app/app.jar

# ---- Runtime stage (JRE is fine) ----
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=builder /app/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
