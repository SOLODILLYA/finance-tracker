-- V2__seed.sql
-- Insert sample users
INSERT INTO users (email, password_hash, created_at) VALUES
('alice@example.com', '$2a$10$7uWh5L3pZjlm1Q2y7pFJeuQy3uVnM9mPj4KwKlOZCw8.ZaZ0T/hjG', now()), -- password: password123
('bob@example.com',   '$2a$10$7uWh5L3pZjlm1Q2y7pFJeuQy3uVnM9mPj4KwKlOZCw8.ZaZ0T/hjG', now()); -- password: password123

-- Insert sample transactions (some income, some expenses)
INSERT INTO transactions (user_id, date, amount, category, type, note, created_at) VALUES
(1, '2025-08-01', 3000.00, 'Salary', 'INCOME', 'Monthly salary', now()),
(1, '2025-08-02', 150.00, 'Groceries', 'EXPENSE', 'Supermarket shopping', now()),
(1, '2025-08-03', 60.00,  'Transport', 'EXPENSE', 'Monthly bus pass', now()),
(2, '2025-08-01', 2500.00, 'Salary', 'INCOME', 'Monthly salary', now()),
(2, '2025-08-04', 200.00,  'Dining', 'EXPENSE', 'Dinner with friends', now());

-- Insert sample budgets
INSERT INTO budgets (user_id, month, category, limit_amount) VALUES
(1, '2025-08', 'Groceries', 500.00),
(1, '2025-08', 'Transport', 100.00),
(2, '2025-08', 'Dining',    300.00);
