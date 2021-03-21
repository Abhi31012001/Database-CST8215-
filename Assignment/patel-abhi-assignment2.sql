DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE users (
id BIGSERIAL NOT NULL PRIMARY KEY,
first_name VARCHAR(30) ,
last_name VARCHAR(50),
email VARCHAR(150),
password VARCHAR(40)
);

INSERT INTO users(id,first_name,last_name,email,password) 	VALUES (1,'Abhi','Patel',
'abhipatel31012001@gmail.com','abhiabhi');
INSERT INTO users(id,first_name,last_name,email,password) 	VALUES (2,'Harsh','mohamad',
'harshpatel26072005@gmail.com','harshharsh');
INSERT INTO users(id,first_name,last_name,email,password) 	VALUES (3,'Heny','sinda',
'henypatel18021996@gmail.com','henyheny');
INSERT INTO users(id,first_name,last_name,email,password) 	VALUES (4,'griva','varma',
'grivaPatel@gmail.yahoo','ggrivagriva');
INSERT INTO users(id,first_name,last_name,email,password) 	VALUES (5,'Jeel','Patel',
'jellpatel04092002@gmail.com','jeeljeel');


CREATE TABLE reasons (
id BIGSERIAL NOT NULL PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

INSERT INTO reasons (id,name) VALUES (1,'information of product');
INSERT INTO reasons (id,name) VALUES (2,'problem related');
INSERT INTO reasons (id,name) VALUES (3,'related to product');
INSERT INTO reasons (id,name) VALUES (4,'information of product');
INSERT INTO reasons (id,name) VALUES (5,'price details of different product');


CREATE TABLE provinces (
id BIGSERIAL NOT NULL PRIMARY KEY,
name VARCHAR(30)
);

INSERT INTO provinces(id,name) VALUES (1,'Ontario');
INSERT INTO provinces(id,name) VALUES (2,'Manitoba');
INSERT INTO provinces(id,name) VALUES (3,'British Columbia');



CREATE TABLE customers (
id BIGSERIAL NOT NULL PRIMARY KEY,
first_name VARCHAR(30) NOT NULL ,
last_name VARCHAR(50) NOT NULL ,
email VARCHAR(150) NOT NULL ,
address VARCHAR(50),
address2 VARCHAR(50),
city VARCHAR(30),
province_id int references provinces(id),
postal_code VARCHAR(7),
phone_number VARCHAR(14) NOT NULL  
);
INSERT INTO customers (id,first_name,last_name,email,address,address2,city,province_id,postal_code,phone_number) 
 VALUES (1,'Granci','Bhatt','grancipatel211@gmail.com','1348 Meadowland DR','ottawa','ontario',2,'K2E7E8',1234567890);
 
 
INSERT INTO customers (id,first_name,last_name,email,address,address2,city,province_id,postal_code,phone_number)  
 VALUES (2,'Prachi','Patel','PrachiPatel456@gmail.com','185 Sceneca tower','ottawa','ontario',3,'K9E0C8',9876543210);
 
INSERT INTO customers  (id,first_name,last_name,email,address,address2,city,province_id,postal_code,phone_number)  
 VALUES (3,'Girishbhai','Patel','GirishbhaiPatel118@gmail.com','360 March rd ','ottawa','ontario',1,'M6F8R2',8234567987);
INSERT INTO customers  (id,first_name,last_name,email,address,address2,city,province_id,postal_code,phone_number)  
 VALUES (4,'Vimraben','Trivadi','VimrabenPatel23456@gmail.com','460 March rd ','ottawa','ontario',3,'K5B3Z9',6789876543);
INSERT INTO customers  (id,first_name,last_name,email,address,address2,city,province_id,postal_code,phone_number)  
 VALUES (5,'Mangardas','Patel','MangardasPatel797@gmail.com','536 Centanial drive','ottawa','toronto',1,'K2E7E8',4163456590);



CREATE TABLE customer_calls (
id BIGSERIAL NOT NULL PRIMARY KEY,
call_timestamp TIMESTAMP,
call_length SMALLINT,
user_id bigint references users(id),
customer_id bigint references customers(id),
reason_id int references reasons(id),
description_of_call TEXT
);

INSERT INTO customer_calls (id,call_timestamp,call_length,user_id,customer_id,reason_id,description_of_call)
 VALUES (1,'2005-01-14 08:23:55',35,1,2,4,'about product');
INSERT INTO customer_calls (id,call_timestamp,call_length,user_id,customer_id,reason_id,description_of_call)
 VALUES (2,'2018-11-21 12:55:60',91,2,2,5,'for price related');
INSERT INTO customer_calls (id,call_timestamp,call_length,user_id,customer_id,reason_id,description_of_call)
 VALUES (3,'2019-07-05 11:23:38',52,2,1,3,'about customer');
INSERT INTO customer_calls (id,call_timestamp,call_length,user_id,customer_id,reason_id,description_of_call)
 VALUES (4,'2014-02-04 06:35:32',21,3,1,2,'problem');
INSERT INTO customer_calls (id,call_timestamp,call_length,user_id,customer_id,reason_id,description_of_call)
 VALUES (5,'2010-11-11 03:28:09',17,3,3,1,'emergency');
 



CREATE TABLE customer_call_notes (
id BIGSERIAL NOT NULL PRIMARY KEY,
customer_call_id bigint references customer_calls(id),
note_timestamp TIMESTAMP,
notes TEXT
);
INSERT INTO customer_call_notes (id,customer_call_id,note_timestamp,notes) VALUES (1,4,'2019-01-03 11:25:43','discusion of product');
INSERT INTO customer_call_notes (id,customer_call_id,note_timestamp,notes) VALUES (2,2,'2018-08-15 04:53:13','discusion of problem');
INSERT INTO customer_call_notes (id,customer_call_id,note_timestamp,notes) VALUES (3,4,'2017-03-11 09:35:56','feedback of product');
INSERT INTO customer_call_notes (id,customer_call_id,note_timestamp,notes) VALUES (4,1,'2016-03-18 04:59:31','discusion of product');
INSERT INTO customer_call_notes (id,customer_call_id,note_timestamp,notes) VALUES (5,2,'2018-09-19 01:39:06','review of servies');
INSERT INTO customer_call_notes (id,customer_call_id,note_timestamp,notes) VALUES (6,3,'2018-09-19 06:01:06','related to product');
INSERT INTO customer_call_notes (id,customer_call_id,note_timestamp,notes) VALUES (7,5,'2018-09-19 11:39:09','product complain');


SELECT phone_number
FROM customers 
	
SELECT *
FROM customer_calls
where customer_id=3;

SELECT *
FROM customer_calls 
where user_id=1

SELECT customer_calls.id as call_id,
	users.first_name as users_first_name,
	users.last_name as users_last_name,
	customers.first_name as customers_first_name,
	customers.last_name as customers_last_name,
	customers.phone_number as customers_phone_number,
	reasons.name as reasons,
	count(customer_call_notes.id) as customer_call_notes
	from customer_calls
	inner join users on customer_calls.user_id=users.id
	inner join customers on customer_calls.customer_id=customers.id
	inner join reasons on customer_calls.reason_id=reasons.id
	inner join customer_call_notes on customer_call_notes.customer_call_id=customer_calls.id
	group by customer_calls.id ,
	users.first_name ,
	users.last_name,
	customers.first_name ,
	customers.last_name,
	customers.phone_number,
	reasons.name,
	customer_call_notes.id


select avg(customer_call_counts)
from (select count(*) as customer_call_counts from customer_calls group by customer_calls.customer_id)as sub_customer_calls




