# AI-Based Virtual Mock Interview Platform

A full-stack, data-driven web application developed as a final-year academic project to automate technical interview evaluations using Spring Boot, Flask, MySQL, and Natural Language Processing (NLP).

##  Project Team & Contributions
* **Ekra Imad** (Lead - Database Integrity, Backend Data Workflows, & Documentation)
* *[Collaborator Name 1]* (Frontend & UI Development)
* *[Collaborator Name 2]* (Spring Boot & Flask NLP Service Integration)

---

##  Project Overview
This platform automates technical interview preparation by comparing user responses against ideal answers using **TF-IDF Vectorization and Cosine Similarity** algorithms. 

While the system evaluates responses via NLP, my primary focus on this project centered on **relational database architecture, data integrity verification, API data flow, and structured workflow documentation** to ensure seamless operational tracking and zero data loss across interview sessions.

---

##  System Navigation & Workflow Guide
To maintain clear process standards and tracking across user lifecycles, the end-to-end data flow operates through structured navigation points:

1. **Authentication & Session Initiation:** User logs in (`POST /api/auth/login`), creating an active interview session logged in MySQL.
2. **Role & Question Retrieval:** The system fetches role-based question banks (`GET /api/roles`) with strict parameter filtering.
3. **Response Processing & Evaluation:** User submits an answer (`POST /api/interview/answer`). Spring Boot routes the payload to the Flask NLP microservice.
4. **Data Storage & Audit Logging:** TF-IDF similarity scores and feedback metadata are securely committed to the database, ensuring complete historical tracking (`GET /api/history/{userId}`).

---

##  Database Architecture & Data Integrity
The application relies on a fully normalized MySQL relational database designed to guarantee strict data consistency and reliable audit trails:

* **Core Tables:** `users`, `roles`, `questions`, `interview_sessions`, and `answer_evaluations`.
* **Constraint Management:** Implemented Primary Keys (PK) and Foreign Keys (FK) to maintain strict cross-table relational mapping.
* **Data Verification:** Managed dataset integrity checks to prevent orphaned evaluation records and handle missing response edge cases cleanly.

---

##  Investigation, Troubleshooting & Workflow Documentation
During development, systematic troubleshooting and documentation protocols were applied to handle runtime discrepancies:

* **API Payload Validation:** Investigated data mismatch issues between the Spring Boot backend and Flask NLP service by tracing JSON payload structures and HTTP status codes.
* **Query Performance & Error Tracking:** Analyzed database execution logs for session-fetching queries to eliminate latency bottlenecks.
* **Process Documentation:** Authored comprehensive documentation covering system navigation maps, database schema definitions, and API integration steps to ensure smooth team collaboration and project maintenance.

---

##  Technology Stack

* **Frontend:** HTML5, CSS3, Bootstrap 5, Vanilla JavaScript (ES6)
* **Backend:** Java 17, Spring Boot, Spring MVC, Spring Data JPA, Hibernate, Maven
* **NLP Microservice:** Python, Flask, Scikit-learn, TF-IDF Vectorizer, Cosine Similarity
* **Database & Tools:** MySQL, Postman, Git/GitHub, Documentation

---

##  Project Structure
``` text
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

## Core API Endpoints
* **Authentication:** POST /api/auth/register, POST /api/auth/login
* **Roles & Setup:** GET /api/roles, POST /api/interview/start
* **Evaluation Pipeline:** POST /api/interview/answer
* **History & Reporting:** GET /api/result/{sessionId}, GET /api/history/{userId}

---

## How to Run the Project
**1. Start MySQL -** Create the database and import the SQL schema files located in the database folder.

**2. Start the Flask NLP Service**
Bash
cd flask-backend
python app.py
(Service runs on http://localhost:5000)

**3. Start the Spring Boot Backend**
Bash
cd spring-backend
mvn spring-boot:run
(Backend runs on http://localhost:8080)

**4. Start the Frontend**
Open the frontend folder using VS Code and launch via Live Server (http://127.0.0.1:5500).

---

** Future Improvements**
* Voice-based interview support & Speech-to-text integration
* AI-generated dynamic question banks
* Facial expression analysis
* Cloud deployment and advanced performance analytics dashboard
