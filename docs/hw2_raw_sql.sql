
/************* ITEM STOCK *************/
CREATE TABLE item_stock ( 
	stock_id INT AUTO_INCREMENT,
	name VARCHAR(50),
	price DECIMAL(19,4),
	quantity INT,
	PRIMARY KEY (stock_id)
);


/************* ITEM *************/
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


/************* CUSTOMER *************/
CREATE TABLE customer (
	customer_id INT AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	address VARCHAR(50),
	email VARCHAR(255),
	PRIMARY KEY (customer_id)
);


/************* ORDER *************/
CREATE TABLE ordr (
	ordr_id INT AUTO_INCREMENT,
	shipment_id INT,
customer_id INT NOT NULL,
	amount DECIMAL(19,4),
	card_number VARCHAR(19),
	payment_date DATE, 
	card_exp_month CHAR(2),
card_exp_year CHAR(2),
	payment_type ENUM('credit', 'paypal', 'debit'),
	PRIMARY KEY (ordr_id),
	FOREIGN KEY (customer_id)
		REFERENCES customer(customer_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


/************* SHIPMENT *************/
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

ALTER TABLE ordr
	ADD CONSTRAINT
	FOREIGN KEY (shipment_id)
	REFERENCES shipment(shipment_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE;


/************* REVIEW *************/
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
		ON UPDATE CASCADE
);


/************* SHOPPING CART *************/
CREATE TABLE shopping_cart (
	quantity INT,
	date_added DATE,
	stock_id INT,
	customer_id INT,
	FOREIGN KEY (stock_id)
		REFERENCES item_stock(stock_id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY (customer_id)
		REFERENCES customer(customer_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


/************* ORDER CONTENTS *************/
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

/************* CATEGORY *************/
CREATE TABLE category (
	category_name VARCHAR(30),
	PRIMARY KEY (category_name)
);


/************* ITEM STOCK CATEGORY *************/
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
		ON UPDATE CASCADE
);


/************* EMPLOYEE *************/
CREATE TABLE employee (
	employee_id INT AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	role VARCHAR(50),
	date_employed DATE,
	manager_id INT,
	PRIMARY KEY (employee_id),
	FOREIGN KEY (manager_id) 
		REFERENCES employee(employee_id)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);
