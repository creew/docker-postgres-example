#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username admin --dbname service_db <<-EOSQL
	CREATE TABLE IF NOT EXISTS users
	(
    		user_id     serial,
    		login       VARCHAR(50) NOT NULL,
    		password    VARCHAR(256) NOT NULL,
    		email       VARCHAR(100) NOT NULL,
    		first_name  VARCHAR(50),
    		last_name   VARCHAR(50),
    		PRIMARY KEY (user_id)
	);
	INSERT INTO users(login, password, email) VALUES('user1', '123', 'email@gmail.com');
	INSERT INTO users(login, password, email) VALUES('user2', '456', 'email@yandex.ru');
	INSERT INTO users(login, password, email) VALUES('user3', '789', 'email@mail.ru');
	INSERT INTO users(login, password, email) VALUES('user4', 'qwe', 'email@yahoo.com');
	INSERT INTO users(login, password, email) VALUES('user5', 'rty', 'email@rambler.ru');
EOSQL
