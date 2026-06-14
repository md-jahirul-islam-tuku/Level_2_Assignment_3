CREATE DATABASE football_ticket_booking_system;

CREATE TABLE
    users (
        user_id serial PRIMARY KEY,
        full_name varchar(100) NOT NULL,
        email varchar(100) UNIQUE NOT NULL,
        role varchar(20) NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
        phone_number varchar(20)
    );

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

SELECT
    match_id,
    fixture,
    base_ticket_price
FROM
    matches
WHERE
    tournament_category = 'Champions League'
    AND match_status = 'Available';