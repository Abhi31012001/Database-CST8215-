/*CREATE TABLE order_logs (
id BIGSERIAL NOT NULL PRIMARY KEY,
log_date timestamp default now(),
log_note text,
order_id int8 references orders(id)
);

CREATE TABLE order_statuses (
id BIGSERIAL NOT NULL PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

ALTER TABLE customers  
ADD COLUMN phone_number VARCHAR(14)
;
ALTER TABLE customers add
opt_out BOOLEAN
;
ALTER TABLE orders 
ADD order_statuses_id int8 references order_statuses(id)
;
*/
INSERT INTO order_statuses (name) values ('New');
INSERT INTO order_statuses (name) values ('Processing');
INSERT INTO order_statuses (name) values ('Shipped');
INSERT INTO order_statuses (name) values ('Invoiced');
INSERT INTO order_statuses (name) values ('Paid');
create table email_log_types(
	id serial primary key,
	name varchar(50) not null
);

create table customer_email_log(
id bigserial primary key,
log_date timestamp default now(),
log_note text,
email_log_type_id int references email_log_types(id),
customer_id int references customers(id)
);

alter table versions add column active bool default true;
alter table product_versions add column active bool default true;
alter table product_types add column active bool default true;

INSERT INTO email_log_types (name) values ('Subscribe');
INSERT INTO email_log_types (name) values ('Unsubscribe');
INSERT INTO email_log_types (name) values ('Campaign Mailer');

update customers SET opt_out='false';

update orders set order_statuses_id=1;

