# Project Guidelines

* Use Gradle 8

## Backend sub-project guidelines

* Use Java 11 
* Use Spring Boot 3
* Use Slf4j 2.0 version for logging and logback 1.5 as a logging backend
* Write integration tests for spring applications using Spring Boot Test and mocking database access objects with Mockito
* If a sub-project has REST API use Spring webflux
* If a sub-project has REST API use Spring security which points auth-service as an oauth2 authentication authorization service to secure the endpoints
* If a sub-project sends or consumes asynchronous messages use Spring Messaging API implementation for SQS
* If a sub-project uploads files use Spring Cluoud to store the files on S3
* If a sub-project accesses a database, it should be Postgres, use JOOQ to do it and liquibase for database creation and migration