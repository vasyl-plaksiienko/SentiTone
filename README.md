# SentiTone MVP. 10x course certification project

## Brief description
SentiTone is a cloud-based Sentiment Analysis Service that allows users to upload text data (news, reviews, comments) and automatically classify them by sentiment tone (or other categories like fakeness).
The MVP focuses on providing users with structured analytics and the ability to manage multiple isolated projects.

## Requirements
**The MVP must satisfy the following core requirements:**

| Category | Requirement | Description |
| -------- | ----------- | ----------- |
| User Management (Auth) | Authentication & Authorization | Registration, login, profile management. Ensuring data isolation between users. |
| Project Management (UI, CRUD) | Project Creation/Deletion | Users can create an isolated "Project" to group their data and select an ML model for Sentiment Analysis. |
| Data Ingestion | Text Upload | Capability to upload text data (e.g., CSV files, REST or streaming) via the interface. |
| ML Analysis | Sentiment Classification | Processing of uploaded text using the ML model and assigning a sentiment label. |
| Analytics (UI) | Results Visualization | Displaying key metrics (overall sentiment distribution, time-series dynamics) via charts. |
| Express Analysis (UI) | Instant Check | A simple public interface for pasting a single text snippet and receiving instant analysis. |

## Technical Stack
The MVP is built on a reliable microservices architecture, ensuring scalability and fault tolerance.

| Component | Technology | Description / Rationale |
| --------- | ---------- | ----------------------- |
| Backend (API/Business Logic) | Java 21+ (Spring Boot 3) | Stability, high performance, and a rich ecosystem for business logic and data processing. Using Spring Security for authentication (JWT). |
| Micro frontend (UI) | React.js | Component-based approach for building two independent yet stylistically consistent frontend applications (Dashboard and Express Analysis). |
| ML Layer | deeplearning4j or Python Keras | The ML model will be deployed as a separate microservice, allowing for flexible model changes without altering the core backend. |
| Persistence | PostgreSQL (on AWS EC2 or RDS) | Reliable, scalable, and feature-rich storage for project metadata, users, and analysis results. |
| Build Tool | Gradle | A unified tool for dependency management and building both Java projects and, where necessary, integrating the React application build processes. |
| Containerization | Docker | Standardizing the environment for all subprojects. |
| Deployment environment | AWS EKS | Ensuring high availability, automatic scaling, and efficient management of microservices. |
| Code & CI/CD | GitHub & GitHub Actions | GitHub for code repository, version control, and collaboration. GitHub Actions for automated build, test, and deployment (CI/CD) pipelines. |

## Subproject Breakdown
The architecture follows microservices principles with a focus on Separation of Concerns (SoC).
The MVP will be divided into the following independent, buildable modules (Gradle Modules):

### Backend Microservices (Java/Spring Boot)
**auth-service**
- authentication and authorization (JWT) via REST

**project-service**
- CRUD operations for Projects via REST

**project-worker**
- async operations related to data loading and processing

**lm-worker**
- async data analysis

### Micro Frontend Applications (React)
**dashboard-ui**:
- the complex compaund interface

**project-ui**
- project management interface

**analytics-ui**
- project analytics interface

**express-ui**
- simple sentiment ananlysis interface

