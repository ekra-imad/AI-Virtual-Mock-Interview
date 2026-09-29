# AI-Based Virtual Mock Interview Platform

## Overview

The AI-Based Virtual Mock Interview Platform is a web application developed as a final-year academic project. The purpose of this project is to help students practice technical interviews by providing role-based interview questions and automatically evaluating their answers using Natural Language Processing (NLP).

Instead of manually checking every response, the system compares the user's answer with an ideal answer using the TF-IDF Vectorization and Cosine Similarity algorithm. Based on the similarity score, the system provides feedback that helps the user understand how well their answer matches the expected response.

The project follows a simple client-server architecture using Spring Boot for the backend, Flask for the NLP service, MySQL for data storage, and HTML, CSS, Bootstrap, and JavaScript for the frontend.

---

## Features

- User Registration and Login
- Role-based interview selection
- Multiple interview domains
  - Java Developer
  - Frontend Developer
  - Data Scientist
- Automatic answer evaluation using NLP
- Similarity score generation
- Feedback for every answer
- Interview result summary
- Interview history
- REST API based backend
- MySQL database integration

---

## Technology Stack

### Frontend
- HTML5
- CSS3
- Bootstrap 5
- Vanilla JavaScript (ES6)

### Backend
- Java 17
- Spring Boot
- Spring MVC
- Spring Data JPA
- Hibernate
- Maven

### NLP Service
- Python
- Flask
- Scikit-learn
- TF-IDF Vectorizer
- Cosine Similarity

### Database
- MySQL

---

## Project Structure

```
AI-Virtual-Mock-Interview
│
├── database
│   ├── schema.sql
│   └── question datasets
│
├── frontend
│   ├── assets
│   ├── css
│   ├── js
│   └── html pages
│
├── spring-backend
│
├── flask-backend
│
├── documentation
│
└── postman
```

---

## System Workflow

1. User registers or logs in.
2. User selects an interview role.
3. The backend creates an interview session.
4. Questions are fetched from the database.
5. The user submits an answer.
6. Spring Boot sends the answer and ideal answer to the Flask NLP service.
7. Flask calculates the similarity score using TF-IDF and Cosine Similarity.
8. The score and feedback are stored in MySQL.
9. After completing the interview, the user can view the overall result and interview history.

---

## Database Tables

The application uses the following tables:

- users
- roles
- questions
- interview_sessions
- answer_evaluations

---

## API Endpoints

### Authentication

- POST `/api/auth/register`
- POST `/api/auth/login`

### Roles

- GET `/api/roles`

### Interview

- POST `/api/interview/start`
- POST `/api/interview/answer`

### Results

- GET `/api/result/{sessionId}`
- GET `/api/history/{userId}`

---

## How to Run the Project

### 1. Start MySQL

Create the database and import the SQL files from the `database` folder.

---

### 2. Start the Flask NLP Service

```bash
cd flask-backend
python app.py


The Flask service will run on:

```
http://localhost:5000
```

---

### 3. Start the Spring Boot Backend

```bash
cd spring-backend
mvn spring-boot:run

The backend will run on:


http://localhost:8080


---

### 4. Start the Frontend

Open the `frontend` folder using VS Code and start it using Live Server.

The application will be available at:

http://127.0.0.1:5500

---

## Future Improvements

Some features that can be added in future versions include:

- Voice-based interview support
- Speech-to-text integration
- AI-generated interview questions
- Facial expression analysis
- JWT authentication
- Cloud deployment
- Performance analytics dashboard

