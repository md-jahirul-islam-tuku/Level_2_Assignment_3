-- =====================================================
-- drop table if they already exist to prevent conflicts
-- =====================================================
DROP TABLE IF EXISTS Bookings;

DROP TABLE IF EXISTS Matches;

DROP TABLE IF EXISTS Users;

-- ===============
-- create database
-- ===============
CREATE DATABASE football_ticket_booking_system;

-- ==================
-- create users table
-- ==================
CREATE TABLE
    users (
        user_id serial PRIMARY KEY,
        full_name varchar(100) NOT NULL,
        email varchar(100) UNIQUE NOT NULL,
        role varchar(20) NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
        phone_number varchar(20)
    );

-- ====================
-- create matches table
-- ====================
CREATE TABLE
    matches (
        match_id serial PRIMARY KEY,
        fixture varchar(150) NOT NULL,
        tournament_category varchar(50) NOT NULL,
        base_ticket_price decimal(8, 2) NOT NULL CHECK (base_ticket_price > 0),
        match_status varchar(20) NOT NULL CHECK (
            match_status IN (
                'Available',
                'Selling Fast',
                'Sold Out',
                'Postponed'
            )
        )
    );

-- =====================
-- create bookings table
-- =====================
CREATE TABLE
    bookings (
        booking_id serial PRIMARY KEY,
        user_id int NOT NULL REFERENCES users (user_id),
        match_id int NOT NULL REFERENCES matches (match_id),
        seat_number varchar(20),
        payment_status varchar(20) CHECK (
            payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
        ),
        total_cost decimal(8, 2) NOT NULL CHECK (total_cost > 0)
    );

-- ===================================
-- insert sample data into users table
-- ===================================
INSERT INTO
    users (full_name, email, role, phone_number)
VALUES
    (
        'Tanvir Rahman',
        'tanvir@mail.com',
        'Football Fan',
        '+8801711111111'
    ),
    (
        'Asif Haque',
        'asif@mail.com',
        'Football Fan',
        '+8801722222222'
    ),
    (
        'Sajjad Rahman',
        'sajjad@mail.com',
        'Ticket Manager',
        '+8801733333333'
    ),
    (
        'Jannat Ara',
        'jannat@mail.com',
        'Football Fan',
        NULL
    );

-- =====================================
-- insert sample data into matches table
-- =====================================
INSERT INTO
    matches (
        match_id,
        fixture,
        tournament_category,
        base_ticket_price,
        match_status
    )
VALUES
    (
        101,
        'Real Madrid vs Barcelona',
        'Champions League',
        150,
        'Available'
    ),
    (
        102,
        'Man City vs Liverpool',
        'Premier League',
        120,
        'Selling Fast'
    ),
    (
        103,
        'Bayern Munich vs PSG',
        'Champions League',
        130,
        'Available'
    ),
    (
        104,
        'AC Milan vs Inter Milan',
        'Serie A',
        90,
        'Sold Out'
    ),
    (
        105,
        'Juventus vs Roma',
        'Serie A',
        80,
        'Available'
    );

-- ======================================
-- insert sample data into bookings table
-- ======================================
INSERT INTO
    bookings (
        booking_id,
        user_id,
        match_id,
        seat_number,
        payment_status,
        total_cost
    )
VALUES
    (501, 1, 101, 'A-12', 'Confirmed', 150),
    (502, 1, 102, 'B-04', 'Confirmed', 120),
    (503, 2, 101, 'A-13', 'Confirmed', 150),
    (504, 2, 101, NULL, NULL, 150),
    (505, 3, 102, 'C-20', 'Pending', 120);

-- =========
-- Query 1:
-- =========
SELECT
    match_id,
    fixture,
    base_ticket_price
FROM
    matches
WHERE
    tournament_category = 'Champions League'
    AND match_status = 'Available';

-- =========
-- Query 2:
-- =========
SELECT
    user_id,
    full_name,
    email
FROM
    users
WHERE
    full_name ILIKE 'Tanvir%'
    OR full_name ILIKE '%Haque%';

-- =========
-- Query 3:
-- =========
SELECT
    booking_id,
    user_id,
    match_id,
    coalesce(payment_status, 'Action Required') AS systematic_status
FROM
    bookings
WHERE
    payment_status IS NULL;

-- =========
-- Query 4:
-- =========
SELECT
    booking_id,
    full_name,
    fixture,
    total_cost
FROM
    bookings b
    INNER JOIN users u ON b.user_id = u.user_id
    INNER JOIN matches m ON b.match_id = m.match_id;

-- =========
-- Query 5:
-- =========
SELECT
    u.user_id,
    full_name,
    booking_id
FROM
    users u
    LEFT JOIN bookings b ON u.user_id = b.user_id;

-- =========
-- Query 6:
-- =========
SELECT
    booking_id,
    match_id,
    total_cost
FROM
    bookings
WHERE
    total_cost > (
        SELECT
            avg(total_cost)
        FROM
            bookings
    );

-- =========
-- Query 7:
-- =========
SELECT
    match_id,
    fixture,
    base_ticket_price
FROM
    matches
ORDER BY
    base_ticket_price DESC
LIMIT
    2
OFFSET
    1;