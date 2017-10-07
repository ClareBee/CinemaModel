DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE films;
DROP TABLE time_slots;
DROP TABLE customers;

CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT4,
  CHECK (funds > 0)
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255),
  rating VARCHAR(255),
  price INT4
);

CREATE TABLE time_slots(
  id SERIAL4 PRIMARY KEY,
  time_of_day VARCHAR(255),
  hour TIME,
  day_of_week VARCHAR(255)
);

CREATE TABLE screenings(
  id SERIAL4 PRIMARY KEY,
  time_slot_id INT4 REFERENCES time_slots(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  capacity INT4,
  CHECK (capacity > 0)
);

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE
);
