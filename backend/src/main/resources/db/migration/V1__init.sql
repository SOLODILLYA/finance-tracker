-- V1__init.sql

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    date DATE NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    category TEXT NOT NULL,
    type TEXT CHECK (type IN ('INCOME', 'EXPENSE')),
    note TEXT,
    created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE budgets (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    month CHAR(7) NOT NULL,   -- format YYYY-MM
    category TEXT NOT NULL,
    limit_amount NUMERIC(12,2) NOT NULL
);

-- Indexes for performance
CREATE INDEX idx_transactions_user_date
    ON transactions(user_id, date);

CREATE INDEX idx_transactions_user_category
    ON transactions(user_id, category);
