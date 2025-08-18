# Personal Finance Tracker

![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
![Spring](https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white)
![React](https://img.shields.io/badge/react-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)
[![Vite](https://img.shields.io/badge/Vite-646CFF?style=for-the-badge&logo=Vite&logoColor=white)](#)
[![Postgres](https://img.shields.io/badge/postgresql-4169e1?style=for-the-badge&logo=postgresql&logoColor=white)](#)
[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2FSOLODILLYA%2Ffinance-tracker%2Fbadge%3Fref%3Dmain&style=for-the-badge)](https://actions-badge.atrox.dev/SOLODILLYA/finance-tracker/goto?ref=main)

---

## 📖 Overview

A **Personal Finance Tracker** built with **Spring Boot (backend)**, **React + Vite (frontend)**, and **PostgreSQL**.  
It supports authentication, transactions, analytics, budgets, and visual dashboards.  
The app runs locally via **Docker Compose** or manually with **Gradle + npm**.

---

## ⚙️ Tech Stack

- **Backend**: Java 21, Spring Boot 3, Gradle, Flyway, Spring Security (JWT)
- **Frontend**: React 18, Vite, TypeScript, TailwindCSS
- **Database**: PostgreSQL 15 + seed data via `seed.sql`
- **Infra**: Docker Compose, GitHub Actions (CI)
- **Quality**: Checkstyle, Spotless, ESLint, Prettier, Vitest, Testcontainers

---

## 📂 Repository Layout

```
finance-tracker/
  backend/     # Spring Boot backend (Gradle)
  frontend/    # React + Vite frontend
  infra/       # docker-compose.yml, seed.sql
  .github/     # GitHub Actions workflows
  README.md
```

---

## ✅ Prerequisites

- [Java 21+](https://adoptium.net)
- [Node.js 20+](https://nodejs.org) & npm
- [Docker & Docker Compose](https://docs.docker.com/get-docker/)
- Git

---

## 🚀 Quick Start (Docker)

Spin up full stack with one command:

```bash
cd infra
docker compose up --build
```

- Backend: [http://localhost:8080](http://localhost:8080)
- Frontend: [http://localhost:5173](http://localhost:5173)
- Database: `localhost:15432` (db=financetracker, user=postgres, pass=postgres)

Stop containers:

```bash
docker compose down
```

---

## 📡 Commands, Ports & URLs

| Service  | Port  | URL / Notes                                    |
| -------- | ----- | ---------------------------------------------- |
| Backend  | 8080  | http://localhost:8080 /api/...                 |
| Frontend | 5173  | http://localhost:5173                          |
| Postgres | 15432 | localhost:15432 (inside container → `db:5432`) |

---

## 🛠 Local Development

### Database via Compose (DB only)

```bash
cd infra
docker compose up db
```

---

### Backend

```bash
cd backend
./gradlew bootRun --args='--spring.profiles.active=postgres'
```

Runs at [http://localhost:8080](http://localhost:8080).  
Profiles:

- `postgres` → connects to Docker DB
- `test` → used in CI

---

### Frontend

```bash
cd frontend
npm install
npm run dev
```

Runs at [http://localhost:5173](http://localhost:5173).  
Configure API URL in `.env`:

```
VITE_API_URL=http://localhost:8080
```

---

## 🔑 Environment Variables (examples)

### Backend (`application-postgres.yml`)

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:15432/financetracker
    username: postgres
    password: postgres
  jpa:
    hibernate:
      ddl-auto: validate
  flyway:
    enabled: true
    locations: classpath:db/migration

server:
  port: 8080

frontend:
  origin: http://localhost:5173
```

### Frontend (`.env`)

```env
VITE_API_URL=http://localhost:8080
```

---

## 🗄 Database & Migrations

- **Migrations**: Flyway in `backend/src/main/resources/db/migration`
- **Seed data**: `infra/seed.sql` auto-loaded by Docker Compose

---

## 🧪 Testing & Quality

Backend:

```bash
cd backend
./gradlew test
./gradlew spotlessApply checkstyleMain
```

Frontend:

```bash
cd frontend
npm run lint
npm run format
npm run test
```

---

## 📦 Build & Deploy

Backend (Docker):

```bash
cd backend
./gradlew bootJar
docker build -t finance-backend .
```

Frontend (Docker):

```bash
cd frontend
npm run build
docker build -t finance-frontend .
```

---

## 🟢 CI Status

GitHub Actions workflow runs on each push:

- Backend build + tests
- Frontend lint + tests
- Docker images (on tag)  
  [![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2FSOLODILLYA%2Ffinance-tracker%2Fbadge%3Fref%3Dmain&style=for-the-badge)](https://actions-badge.atrox.dev/SOLODILLYA/finance-tracker/goto?ref=main)

---

## 🛠 Troubleshooting

- **Backend fails**: ensure DB is up at `localhost:15432`.
- **Frontend blank**: check `.env` → `VITE_API_URL`.
- **Migrations fail**: clean volume and restart:
  ```bash
  docker compose down -v
  docker compose up --build
  ```
