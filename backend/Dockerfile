# ---- Build stage (Gradle + JDK 21) ----
FROM gradle:8.10.2-jdk21 AS build
WORKDIR /workspace

COPY --chown=gradle:gradle settings.gradle* build.gradle* gradle.properties* ./
COPY --chown=gradle:gradle gradle/ ./gradle/
COPY --chown=gradle:gradle src ./src

RUN --mount=type=cache,target=/home/gradle/.gradle \
    gradle --no-daemon clean bootJar -x test

RUN set -eux; ls -lah build/libs; \
    JAR="$(find build/libs -maxdepth 1 -type f -name '*.jar' ! -name '*-plain.jar' | head -n1)"; \
    test -n "$JAR"; \
    cp "$JAR" /workspace/app.jar

# ---- Runtime ----
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /workspace/app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
