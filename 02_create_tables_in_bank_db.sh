#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username admin --dbname bank_db <<-EOSQL
	CREATE TABLE IF NOT EXISTS customers
	(
    		customer_id serial,
    		login       VARCHAR(50) NOT NULL,
    		password    VARCHAR(256) NOT NULL,
    		first_name  VARCHAR(50) NOT NULL,
    		last_name   VARCHAR(50) NOT NULL,
                patronymic  VARCHAR(50) NOT NULL,
    		PRIMARY KEY (customer_id)
	);
	CREATE TABLE IF NOT EXISTS cards
	(
		card_id	       serial,
		fk_customer_id INTEGER NOT NULL,
		amount         BIGINT NOT NULL,
		PRIMARY KEY    (card_id),
		FOREIGN KEY    (customer_id) REFERENCES customers(customer_id)
	)
EOSQL
