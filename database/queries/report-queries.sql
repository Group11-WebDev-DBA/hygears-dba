-- Sample queries for the paper (RESULTS > Sample Queries). Run after hygears.sql and seeds/sample-data.sql.
USE hygears_db;

-- 1. Current stock of every item
SELECT name, item_type, quantity_available FROM v_item_stock ORDER BY name;

-- 2. Tools that are out right now, and which are overdue
SELECT first_name, last_name, item_name, quantity, due_date, is_overdue FROM v_open_loans ORDER BY due_date;

-- 3. Consumables at or below their reorder level
SELECT name, quantity_available, reorder_level FROM v_low_stock;

-- 4. Who is in the HQ right now
SELECT p.first_name, p.last_name, pu.name AS purpose, a.time_in
FROM attendance a
JOIN person p   ON p.person_id = a.person_id
JOIN purpose pu ON pu.purpose_id = a.purpose_id
WHERE a.time_out IS NULL
ORDER BY a.time_in;

-- 5. Attendance per purpose (all time)
SELECT pu.name AS purpose, COUNT(*) AS visits
FROM attendance a JOIN purpose pu ON pu.purpose_id = a.purpose_id
GROUP BY pu.name ORDER BY visits DESC;

-- 6. Pending requests with what they ask for
SELECT q.request_id, p.first_name, p.last_name, i.name AS item, rl.quantity, q.requested_at
FROM item_request q
JOIN person p        ON p.person_id = q.requested_by
JOIN request_line rl ON rl.request_id = q.request_id
JOIN item i          ON i.item_id = rl.item_id
WHERE q.status = 'pending'
ORDER BY q.requested_at;
