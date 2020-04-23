#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username admin --dbname bank_db <<-EOSQL
CREATE TABLE IF NOT EXISTS users
(
    id         SERIAL,
    login      VARCHAR(50)  NOT NULL,
    password   VARCHAR(255) NOT NULL,
    first_name VARCHAR(50)  NOT NULL,
    last_name  VARCHAR(50)  NOT NULL,
    patronymic VARCHAR(50)  NOT NULL,
    uuid       VARCHAR(36),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS cards
(
    id         SERIAL,
    fk_user_id INTEGER NOT NULL,
    amount     BIGINT  NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (fk_user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS authorization_token
(
    id              SERIAL,
    fk_user_id      INTEGER   NOT NULL,
    token           varchar(36),
    time_created    timestamp not null,
    time_expiration timestamp not null,
    PRIMARY KEY (id),
    FOREIGN KEY (fk_user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS transfers
(
    id              SERIAL,
    amount          BIGINT    NOT NULL,
    fk_card_to_id   INTEGER   NOT NULL,
    fk_card_from_id INTEGER   NOT NULL,
    token           VARCHAR(36),
    executed        BOOLEAN   NOT NULL,
    time_created    TIMESTAMP NOT NULL,
    time_expiration TIMESTAMP NOT NULL,
    time_executed   TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (fk_card_to_id) REFERENCES cards (id) ON DELETE CASCADE,
    FOREIGN KEY (fk_card_from_id) REFERENCES cards (id) ON DELETE CASCADE
);
EOSQL
