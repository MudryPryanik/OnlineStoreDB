DROP DATABASE IF EXISTS internetshop;
CREATE DATABASE internetshop;
USE internetshop;

CREATE TABLE clients (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	firstname VARCHAR(100) NOT NULL,
	lastname VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	phone BIGINT UNSIGNED unique,
	
	INDEX clients_fn_ln(firstname, lastname)
);

CREATE TABLE orders (
	order_num INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	client_id INT UNSIGNED NOT NULL,
	dp_id INT UNSIGNED NOT NULL,
	order_date DATETIME DEFAULT NOW(),
	product_quantity INT NOT NULL,
	order_status VARCHAR(10),
	payment_status VARCHAR(10),
	
	INDEX orders_date(order_date)
);

create table products_in_order (
	prod_id INT UNSIGNED NOT NULL,
	order_num INT NOT NULL
);

CREATE TABLE products (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    vend_id INT UNSIGNED NOT NULL,
    pt_id INT UNSIGNED NOT NULL,
    storage_id INT UNSIGNED NOT NULL,
    prod_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    photo_link VARCHAR(10),
	description TEXT,
    prod_price DECIMAL(8,2) NOT null,
    
    INDEX product_price(prod_price)
);

create table payment (
	order_num INT NOT NULL,
	bank_card_number BIGINT NOT NULL,
	payment_status VARCHAR(10)
);

CREATE TABLE vendors (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    company VARCHAR(100),
    office_adress VARCHAR(100),
    city varchar(100),
    phone BIGINT,
    website VARCHAR(100)		
);

CREATE TABLE storages (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	adress VARCHAR(100),
	city VARCHAR(100)
);

create table order_delivery (
	order_num INT NOT NULL,
	delivery_method varchar(10),
	delivery_company varchar(10)
);

CREATE TABLE delivery_points (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	adress VARCHAR(100),
	city VARCHAR(100)
);

CREATE TABLE product_type (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100)
);


ALTER TABLE orders 
ADD CONSTRAINT FK_orders_clients 
FOREIGN KEY (client_id) REFERENCES clients(id);

ALTER TABLE products_in_order 
ADD CONSTRAINT FK_products_in_order_products
FOREIGN KEY (prod_id) REFERENCES products(id);

ALTER TABLE orders 
ADD CONSTRAINT FK_orders_delivery_points 
FOREIGN KEY (dp_id) REFERENCES delivery_points(id);

ALTER TABLE products 
ADD CONSTRAINT FK_products_storages 
FOREIGN KEY (storage_id) REFERENCES storages(id);

ALTER TABLE products 
ADD CONSTRAINT FK_products_vendors 
FOREIGN KEY (vend_id) REFERENCES vendors(id);

ALTER TABLE products 
ADD CONSTRAINT FK_products_product_categories 
FOREIGN KEY (pt_id) REFERENCES product_type(id);

ALTER TABLE payment
ADD CONSTRAINT fk_payment_orders
FOREIGN KEY (order_num) REFERENCES orders(order_num);

ALTER TABLE order_delivery
ADD CONSTRAINT fk_orders_delivery
FOREIGN KEY (order_num) REFERENCES orders(order_num);

ALTER TABLE products_in_order
ADD CONSTRAINT fk_products_in_order_orders
FOREIGN KEY (order_num) REFERENCES orders(order_num);
