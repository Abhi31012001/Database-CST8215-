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