# Football Ticket Booking System Database

## Project Overview

This project is a database design and SQL query implementation for a **Football Ticket Booking System**.

The system manages:

* Football fans purchasing match tickets
* Tournament match information
* Ticket booking records
* Payment tracking and ticket status management

This assignment demonstrates database design concepts, relational integrity, and SQL query writing using PostgreSQL.

---

## Database Tables

The system contains the following tables:

### 1. Users Table

Stores user information for both football fans and ticket managers.

**Fields:**

* `user_id`
* `full_name`
* `email`
* `role`
* `phone_number`

**Features:**

* Unique email validation
* Role restriction using `CHECK`
* Supports both **Football Fan** and **Ticket Manager**

---

### 2. Matches Table

Stores football match information.

**Fields:**

* `match_id`
* `fixture`
* `tournament_category`
* `base_ticket_price`
* `match_status`

**Features:**

* Non-negative ticket price validation
* Match status restriction using `CHECK`

---

### 3. Bookings Table

Stores ticket purchase records.

**Fields:**

* `booking_id`
* `user_id`
* `match_id`
* `seat_number`
* `payment_status`
* `total_cost`

**Features:**

* Foreign Key relationships
* Payment status validation
* Duplicate seat prevention for the same match

---

## Database Relationships

### One-to-Many Relationship

One user can have multiple bookings.

```text
Users (1) ------< Bookings (Many)
```

### Many-to-One Relationship

Many bookings can belong to one match.

```text
Bookings (Many) >------ (1) Matches
```

### Logical One-to-One Mapping

Each booking row represents one user booking one match for a specific seat.

---

## SQL Concepts Used

This project includes the following SQL concepts:

* `CREATE TABLE`
* `PRIMARY KEY`
* `FOREIGN KEY`
* `CHECK Constraint`
* `UNIQUE Constraint`
* `INSERT INTO`
* `INNER JOIN`
* `LEFT JOIN`
* `ILIKE`
* `COALESCE()`
* `Subquery`
* `AVG()`
* `ORDER BY`
* `LIMIT`
* `OFFSET`

---

## Implemented Queries

### Query 1

Retrieve all available **Champions League** matches.

### Query 2

Search users whose names start with **Tanvir** or contain **Haque** using case-insensitive matching.

### Query 3

Handle missing payment status using `COALESCE()`.

### Query 4

Retrieve booking details with user and match information using `INNER JOIN`.

### Query 5

Display all users including those without bookings using `LEFT JOIN`.

### Query 6

Find bookings where the total cost is greater than the average booking cost.

### Query 7

Retrieve the top expensive matches while skipping the highest-priced match using pagination.

---

## Project Files

```text
football-ticket-booking-system/
│
├── ticket_booking_query.sql
└── README.md
```

---

## ERD Link (Public):

The Entity Relationship Diagram (ERD) is submitted separately as required in the assignment.

ERD Link: https://drawsql.app/teams/tuku/diagrams/football-ticket-booking-system

---

## Interview Video Link (Public):

The Theory Questions (Viva Practice) interview video link is submitted separately as required in the assignment instructions.

Answer of Question 1 video Link: https://drive.google.com/file/d/1b4dwFee7aTdM9s3iyguZcvkKDfVVywng/view
Answer of Question 4 video Link: https://drive.google.com/file/d/1QuUZ1wzsDKToOXFE9af-7b2k2qIRT07W/view

---

## ✔ Author

### Md Jahirul Islam Tuku
Student, Programming Hero, Level-2, Batch-7
