-- Sample data for testing and screenshots. Run AFTER hygears.sql.
-- All names and numbers are made up.
USE hygears_db;

INSERT INTO person (student_id, first_name, last_name, contact_number, affiliation) VALUES
  ('2023-00101-MN-0', 'Mika',  'Santos',   '09170000001', NULL),
  ('2023-00102-MN-0', 'Paolo', 'Reyes',    '09170000002', NULL),
  ('2024-00103-MN-0', 'Bea',   'Villanueva','09170000003', NULL),
  ('2022-00104-MN-0', 'Carlo', 'Mendoza',  '09170000004', NULL),
  (NULL,              'Jamie', 'Cruz',     '09170000005', 'Visiting school');

-- Mika and Bea are members, Paolo is an officer, Carlo is the president
INSERT INTO member (person_id, role_id, email, joined_on) VALUES
  (1, 1, 'mika.sample@example.com',  '2025-08-15'),
  (2, 2, 'paolo.sample@example.com', '2024-08-20'),
  (3, 1, 'bea.sample@example.com',   '2026-09-01'),
  (4, 3, 'carlo.sample@example.com', '2023-08-10');

INSERT INTO item (category_id, name, item_type, quantity_total, reorder_level) VALUES
  (4, 'Digital multimeter',      'tool',       3, NULL),
  (3, 'Soldering station',       'tool',       2, NULL),
  (2, 'Cordless drill',          'tool',       2, NULL),
  (1, 'Torque wrench',           'tool',       1, NULL),
  (6, 'Solder wire 0.8mm',       'consumable', 10, 4),
  (5, 'Cutting disc 4 in',       'consumable', 6,  3),
  (3, 'Heat-shrink tubing pack', 'consumable', 5,  2);

INSERT INTO restock (item_id, quantity, restocked_on, notes) VALUES
  (5, 5, '2026-11-10', 'Bought after workshop');

-- Attendance: Jamie (visitor) came for the workshop, Mika is still inside
INSERT INTO attendance (person_id, purpose_id, time_in, time_out) VALUES
  (5, 3, '2026-11-22 09:00:00', '2026-11-22 12:00:00'),
  (1, 2, NOW() - INTERVAL 2 HOUR, NULL);

-- Requests: one pending, one approved tool loan (overdue), one approved consumable
INSERT INTO item_request (requested_by, requested_at) VALUES (1, NOW() - INTERVAL 1 DAY);
INSERT INTO request_line (request_id, item_id, quantity, due_date) VALUES (1, 2, 1, CURDATE() + INTERVAL 3 DAY);

INSERT INTO item_request (requested_by, requested_at) VALUES (3, NOW() - INTERVAL 6 DAY);
INSERT INTO request_line (request_id, item_id, quantity, due_date) VALUES (2, 1, 2, CURDATE() - INTERVAL 2 DAY);
UPDATE item_request SET status = 'approved', decided_by = 2, decided_at = NOW() - INTERVAL 5 DAY WHERE request_id = 2;

INSERT INTO item_request (requested_by, requested_at) VALUES (1, NOW() - INTERVAL 3 DAY);
INSERT INTO request_line (request_id, item_id, quantity) VALUES (3, 5, 2);
UPDATE item_request SET status = 'approved', decided_by = 4, decided_at = NOW() - INTERVAL 3 DAY WHERE request_id = 3;
