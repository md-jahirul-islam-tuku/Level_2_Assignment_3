

CREATE DATABASE football_ticket_booking_system;

CREATE TABLE users (
  user_id serial PRIMARY KEY,
  full_name varchar(100) NOT NULL,
  email varchar(100) UNIQUE NOT NULL,
  role varchar(20) NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
  phone_number varchar(20)
);


CREATE TABLE matches (
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


CREATE TABLE bookings (
  booking_id serial PRIMARY KEY,
  user_id int NOT NULL REFERENCES users (user_id),
  match_id int NOT NULL REFERENCES matches (match_id),
  seat_number varchar(20),
  payment_status varchar(20) CHECK (
    payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  ),
  total_cost decimal(8, 2) NOT NULL CHECK (total_cost > 0)
);



