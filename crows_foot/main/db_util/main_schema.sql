/* START */
CREATE TABLE item_stock (
	stock_id INT AUTO_INCREMENT,
	name VARCHAR(50),
	vendor VARCHAR(50) NOT NULL,
	price DECIMAL(19,4),
	quantity INT,
	description TEXT,
	item_image_file VARCHAR(50),
	PRIMARY KEY (stock_id)
);
/* END */

/* START */
CREATE TABLE item (
	item_id INT AUTO_INCREMENT,
	stock_id INT NOT NULL,
	was_bought BOOL,
	PRIMARY KEY (item_id),
	FOREIGN KEY (stock_id)
	REFERENCES item_stock(stock_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);
/* END */

/* START */
CREATE TABLE customer (
	customer_id INT AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	password VARCHAR(100) NOT NULL,
	address VARCHAR(100),
	email VARCHAR(255) UNIQUE,
	salt VARCHAR(10),
	PRIMARY KEY (customer_id)
);
/* END */

/* START */
CREATE TABLE card_information (
	card_number VARCHAR(19),
	payment_date DATE,
	card_exp_month CHAR(2),
	card_exp_year CHAR(2),
	PRIMARY KEY (card_number)
)
/* END */

/* START */
CREATE TABLE ordr (
	ordr_id INT AUTO_INCREMENT,
	shipment_id INT,
	customer_id INT NOT NULL,
	amount DECIMAL(19,4),
	card_number VARCHAR(19),
	payment_type ENUM('credit', 'paypal', 'debit'),
	PRIMARY KEY (ordr_id),
	FOREIGN KEY (customer_id)
	REFERENCES customer(customer_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
/* END */

/* START */
CREATE TABLE shipment (
	shipment_id INT AUTO_INCREMENT,
	ordr_id INT NOT NULL,
	priority CHAR(20),
	date_shipped DATE,
	date_received DATE,
	carrier VARCHAR(20),
	shipment_address VARCHAR(100),
	PRIMARY KEY (shipment_id),
	FOREIGN KEY (ordr_id)
	REFERENCES ordr(ordr_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);
/* END */

/* START */
ALTER TABLE ordr
	ADD CONSTRAINT ordr_shipment
	FOREIGN KEY (shipment_id)
	REFERENCES shipment(shipment_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE;
/* END */

/* START */
CREATE TABLE review (
	rating ENUM('1', '2', '3', '4', '5'),
	review_text TEXT,
	stock_id INT,
	customer_id INT,
	FOREIGN KEY (stock_id)
	REFERENCES item_stock(stock_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (customer_id)
	REFERENCES customer(customer_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	PRIMARY KEY (customer_id, stock_id)
);
/* END */

/* START */
CREATE TABLE shopping_cart (
	quantity INT,
	date_added DATE,
	stock_id INT,
	customer_id INT,
	FOREIGN KEY (stock_id)
	REFERENCES item_stock(stock_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (customer_id)
	REFERENCES customer(customer_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	PRIMARY KEY (customer_id, stock_id)
);
/* END */

/* START */
CREATE TABLE order_contents (
	ordr_id INT,
	item_id INT,
	FOREIGN KEY (ordr_id)
	REFERENCES ordr(ordr_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	PRIMARY KEY (item_id),
	FOREIGN KEY (item_id)
	REFERENCES item(item_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);
/* END */

/* START */
CREATE TABLE category (
	category_name VARCHAR(30),
    display_name VARCHAR(30),
	PRIMARY KEY (category_name)
);
/* END */

/* START */
CREATE TABLE stock_category (
	stock_id INT,
	category_name VARCHAR(30),
	FOREIGN KEY (stock_id)
	REFERENCES item_stock(stock_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (category_name)
	REFERENCES category(category_name)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	primary key(category_name, stock_id)
);
/* END */
