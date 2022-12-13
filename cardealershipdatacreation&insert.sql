CREATE TABLE SalesStaff(
  staff_id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100)
);

CREATE TABLE customer (
  customer_id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100)
 );

CREATE TABLE car (
  serial_num SERIAL PRIMARY KEY,
  make VARCHAR(100),
  model VARCHAR(100),
  color VARCHAR(100),
  year_ INTEGER
);

CREATE TABLE Mechanic (
  mechanic_id SERIAL PRIMARY KEY,
  serial_num INTEGER NOT NULL,
  customer_id INTEGER NOT NULL,
  FOREIGN KEY(serial_num) REFERENCES car(serial_num),
  FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE parts (
  part_id SERIAL PRIMARY KEY,
  mechanic_id INTEGER NOT NULL,
  serial_num INTEGER NOT NULL,
  customer_id INTEGER NOT NULL,
  FOREIGN KEY(mechanic_id) REFERENCES Mechanic(mechanic_id),
  FOREIGN KEY(serial_num) REFERENCES car(serial_num),
  FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
 );


CREATE TABLE invoice (
  invoice_id SERIAL PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  payment_date DATE DEFAULT CURRENT_DATE,
  total_amout NUMERIC(10,2),
  part_id INTEGER NOT NULL,
  staff_id INTEGER NOT NULL,
  serial_num INTEGER NOT NULL,
  FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
  FOREIGN KEY(part_id) REFERENCES parts(part_id),
  FOREIGN KEY(staff_id) REFERENCES SalesStaff(staff_id),
  FOREIGN KEY(serial_num) REFERENCES car(serial_num)
);




CREATE OR REPLACE FUNCTION add_customer(
	_customer_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR
)
RETURNS void
AS $MAIN$
	BEGIN
		INSERT INTO customer(customer_id, first_name, last_name)
		VALUES(_customer_id, _first_name, _last_name);
	END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_customer(1, 'Happy', 'Today')
SELECT add_customer(2, 'Jamie', 'ohlala')
SELECT *
FROM customer;


CREATE OR REPLACE FUNCTION add_staff(
	_staff_id INTEGER,
	_first_name VARCHAR,
	_last_name VARCHAR
)
RETURNS void
AS $MAIN$
	BEGIN
		INSERT INTO SalesStaff(staff_id, first_name, last_name)
		VALUES(_staff_id, _first_name, _last_name);
	END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_staff(0003, 'Monday', 'Che')
SELECT add_staff(0004, 'Tuesday', 'Liu')
SELECT *
FROM salesstaff




CREATE OR REPLACE FUNCTION add_car(
	_serial_num INTEGER,
	_make VARCHAR,
	_model VARCHAR,
	_color VARCHAR,
	_year_ INTEGER
)
RETURNS void
AS $MAIN$
	BEGIN
		INSERT INTO car(serial_num, make, model, color, year_)
		VALUES(_serial_num, _make, _model, _color, _year_);
	END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_car(10, 'Subaru', 'Impreza', 'red', 2023)
SELECT add_car(13, 'Honda', 'Accord', 'red', 2022)
SELECT *
FROM car



CREATE OR REPLACE FUNCTION add_mechanic(
	_mechanic_id INTEGER,
	_serial_num INTEGER,
	_customer_id INTEGER
)
RETURNS void
AS $MAIN$
	BEGIN
		INSERT INTO mechanic(mechanic_id, serial_num, customer_id)
		VALUES(_mechanic_id, _serial_num, _customer_id);
	END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_mechanic(77, 10, 1) 
SELECT add_mechanic(88, 13, 2)
SELECT *
FROM mechanic



CREATE OR REPLACE FUNCTION add_part(
	_part_id INTEGER,
	_mechanic_id INTEGER,
	_serial_num INTEGER,
	_customer_id INTEGER
)
RETURNS void
AS $MAIN$
	BEGIN
		INSERT INTO parts(part_id, mechanic_id, serial_num, customer_id)
		VALUES(_part_id, _mechanic_id, _serial_num, _customer_id);
	END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_part(200, 77, 10, 1)
SELECT add_part(202, 88, 13, 2)
SELECT *
FROM parts

CREATE OR REPLACE FUNCTION add_invoice(
	_invoice_id INTEGER,
	_customer_id INTEGER,
	_payment_date DATE,
	_total_amount NUMERIC(6,2),
	_part_id INTEGER,
	_staff_id INTEGER,
	_serial_num INTEGER
)
RETURNS void
AS $MAIN$
	BEGIN
		INSERT INTO invoice(invoice_id, customer_id, payment_date, total_amout, part_id, staff_id, serial_num)
		VALUES(_invoice_id, _customer_id,_payment_date, _total_amount, _part_id, _staff_id, _serial_num);
	END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_invoice(30, 1, CURRENT_DATE, 7890.00, 200, 0003, 10)
SELECT add_invoice(32, 2, CURRENT_DATE, 670.00, 202, 0004, 13)
SELECT *
FROM invoice
