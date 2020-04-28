#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username admin --dbname bank_db <<-EOSQL
CREATE TABLE IF NOT EXISTS users
(
    id         SERIAL,
    login      VARCHAR(50) NOT NULL,
    password   BYTEA       NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    patronymic VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (login)
);

CREATE TABLE IF NOT EXISTS cards
(
    id         SERIAL,
    fk_user_id INTEGER NOT NULL,
    amount     BIGINT  NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (fk_user_id) REFERENCES users ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS authorization_token
(
    id              UUID      NOT NULL,
    fk_user_id      INTEGER   NOT NULL,
    time_created    TIMESTAMP NOT NULL,
    time_expiration TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (fk_user_id) REFERENCES users ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS transfers
(
    id              UUID      NOT NULL,
    amount          BIGINT    NOT NULL,
    fk_card_to_id   INTEGER   NOT NULL,
    fk_card_from_id INTEGER   NOT NULL,
    executed        BOOLEAN   NOT NULL,
    time_created    TIMESTAMP NOT NULL,
    time_expiration TIMESTAMP NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (fk_card_to_id) REFERENCES cards ON DELETE CASCADE,
    FOREIGN KEY (fk_card_from_id) REFERENCES cards ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS transactions
(
    id              SERIAL,
    amount          BIGINT    NOT NULL,
    time_executed   TIMESTAMP NOT NULL,
    fk_card_from_id INTEGER,
    fk_card_to_id   INTEGER,
    PRIMARY KEY (id),
    FOREIGN KEY (fk_card_from_id) REFERENCES cards ON DELETE SET NULL,
    FOREIGN KEY (fk_card_to_id) REFERENCES cards ON DELETE SET NULL
);
EOSQL
