-- Behaviour tests for hygears.sql. Each "EXPECT ERROR" line should fail; everything else should pass.
USE hygears_db;

INSERT INTO person (student_id, first_name, last_name, contact_number) VALUES
 ('2024-00001-MN-0','Ana','Cruz','09170000001'),
 ('2024-00002-MN-0','Ben','Reyes','09170000002'),
 (NULL,'Visitor','Guest','09170000003');
INSERT INTO member (person_id, role_id, email, joined_on) VALUES (1, 2, 'ana@x.com', '2026-08-01');   -- officer
INSERT INTO member (person_id, role_id, email, joined_on) VALUES (2, 1, 'ben@x.com', '2026-08-01');   -- member
SELECT 'T1 visitor without student id cannot be member (EXPECT ERROR next)' AS test;
INSERT INTO member (person_id, role_id, joined_on) VALUES (3, 1, '2026-08-01');

INSERT INTO item (category_id, name, item_type, quantity_total, reorder_level) VALUES
 (4,'Digital multimeter','tool',3,NULL),
 (6,'Solder wire 0.8mm','consumable',10,4);

-- attendance
INSERT INTO attendance (person_id, purpose_id, time_in) VALUES (3, 6, '2026-11-23 09:00:00');
SELECT 'T2 time_out before time_in (EXPECT ERROR next)' AS test;
UPDATE attendance SET time_out='2026-11-23 08:00:00' WHERE attendance_id=1;
UPDATE attendance SET time_out='2026-11-23 10:00:00' WHERE attendance_id=1;

-- requests
INSERT INTO item_request (requested_by) VALUES (2);                          -- pending, ok
INSERT INTO request_line (request_id, item_id, quantity, due_date) VALUES (1, 1, 2, '2026-11-20');
INSERT INTO request_line (request_id, item_id, quantity) VALUES (1, 2, 3);
SELECT 'T3 consumable with due date (EXPECT ERROR next)' AS test;
INSERT INTO item_request (requested_by) VALUES (2);
INSERT INTO request_line (request_id, item_id, quantity, due_date) VALUES (2, 2, 1, '2026-12-01');
SELECT 'T4 approved without decider (EXPECT ERROR next)' AS test;
UPDATE item_request SET status='approved' WHERE request_id=1;
SELECT 'T5 plain member cannot approve (EXPECT ERROR next)' AS test;
UPDATE item_request SET status='approved', decided_by=2, decided_at=NOW() WHERE request_id=2;
SELECT 'T6 officer approves request 1 (should pass)' AS test;
UPDATE item_request SET status='approved', decided_by=1, decided_at=NOW() WHERE request_id=1;
SELECT 'T7 stock after approval: multimeter 3-2=1, solder 10-3=7' AS test;
SELECT name, quantity_available FROM v_item_stock;
SELECT 'T8 overdue loan shows in v_open_loans' AS test;
SELECT item_name, quantity, due_date, is_overdue FROM v_open_loans;
INSERT INTO restock (item_id, quantity, restocked_on) VALUES (2, 5, CURDATE());
SELECT 'T9 low stock view (solder 12 > reorder 4, so empty)' AS test;
SELECT * FROM v_low_stock;
SELECT 'T10 return the tool, stock back to 3' AS test;
UPDATE request_line SET returned_at=NOW() WHERE line_id=1;
SELECT name, quantity_available FROM v_item_stock WHERE item_id=1;
SELECT 'T11 officer approving own request (EXPECT ERROR next)' AS test;
INSERT INTO item_request (requested_by) VALUES (1);
UPDATE item_request SET status='approved', decided_by=1, decided_at=NOW() WHERE request_id=3;
SELECT 'T12 over-borrowing: request 5 multimeters when 3 exist (does it stop it?)' AS test;
INSERT INTO item_request (requested_by) VALUES (2);
INSERT INTO request_line (request_id, item_id, quantity, due_date) VALUES (4, 1, 5, '2026-12-01');
UPDATE item_request SET status='approved', decided_by=1, decided_at=NOW() WHERE request_id=4;
SELECT name, quantity_available FROM v_item_stock WHERE item_id=1;
