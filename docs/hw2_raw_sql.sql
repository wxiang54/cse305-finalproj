
/************* ITEM STOCK *************/
CREATE TABLE item_stock ( 
	stock_id INT AUTO_INCREMENT,
	name VARCHAR(50),
	vendor VARCHAR(50) NOT NULL,
	price DECIMAL(19,4),
	quantity INT,
	description VARCHAR(100),
	item_image_file VARCHAR(50),
	PRIMARY KEY (stock_id)
);

insert into item_stock values(0, 'pear', 'whole foods', 5.50, 5, 'this is a nice fruit from some country i do not know of.','pear.png');
insert into item_stock values(0, 'potato', 'whole foods', 15.50, 3, 'this is a very nice rooty vegetable thing.','potato.png');


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

insert into item values(0,1,false);
insert into item values(0,2,false);

/************* CUSTOMER *************/
CREATE TABLE customer (
	customer_id INT AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	password VARCHAR(100) NOT NULL,
	address VARCHAR(50),
	email VARCHAR(255),
	salt VARCHAR(10),
	PRIMARY KEY (customer_id)
);

insert into customer values(0, 'Petunia', 'Evergreen', 'poggurs', '69 Street', 'poobrain@gmail.com', NULL);
insert into customer values(0, 'Will', 'Liam', 'dansgame', '14 Street', 'ayaya@gmail.com', NULL);
update customer set salt=SUBSTRING(MD5(RAND()), -10);
update customer set password=sha1(concat(password,salt));

/**PAYMENT**/
CREATE TABLE card_information (
	card_number VARCHAR(19),
	payment_date DATE, 
	card_exp_month CHAR(2),
	card_exp_year CHAR(2),
	PRIMARY KEY (card_number)
)

/************* ORDER *************/
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
	
insert into card_information values('101', '1000-01-01', '02', '99');
insert into card_information values('131', '1003-01-01', '02', '96');
insert into ordr values(0, NULL, 1, 10, '101', 'credit');
insert into ordr values(0, NULL, 2, 15, '131', 'debit');
insert into shipment values(0, 1, 'regular', '1000-01-01', '4523-09-11', 'yes', 'Huntersway');
insert into shipment values(0, 2, 'worst order ever', '1000-01-01', '9523-09-11', 'ups', 'Hunterjiaway');

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
	ON UPDATE CASCADE,
	primary key (customer_id, stock_id)
);

insert into review values('2', 'garbage product would not buy again', 1, 1);
insert into review values('5', 'omg honey booboo what a steal!!!!!!!', 2, 1);


/************* SHOPPING CART *************/
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
	primary key(customer_id, stock_id)
);

insert into shopping_cart values(14, '2011-11-11', 1, 1);
insert into shopping_cart values(17, '2011-09-21', 2, 1);

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

insert into order_contents values(1,3);
insert into order_contents values(1,2);

/************* CATEGORY **************/
CREATE TABLE category (
	category_name VARCHAR(30),
	PRIMARY KEY (category_name)
);

insert into category values('fruit');
insert into category values('games');

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
	ON UPDATE CASCADE,
	primary key(category_name, stock_id)
);

insert into stock_category values(1, 'fruit');
insert into stock_category values(2, 'fruit');