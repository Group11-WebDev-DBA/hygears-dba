# Hygears HQ Database

The database and internal system for the **PUP Hygears** headquarters: it replaces the paper logbooks for entry and exit, attendance, inventory and equipment borrowing, so officers can see who's inside, what's out, and who approved it.

Database Administration project, Group 11, BSIT 3-2 (Sir Juancho D. Espineli).

- Screen prototypes: https://group11-webdev-dba.github.io/hygears-dba-prototypes/
- The public website (WebDev project) uses this same database: https://github.com/Group11-WebDev-DBA/hygears-web-portal

## Set up the database

1. Start **MySQL** in the XAMPP Control Panel (or use MySQL Workbench).
2. In phpMyAdmin (http://localhost/phpmyadmin) or Workbench, run, in this order:
   1. `database/hygears.sql`: creates `hygears_db` with all tables, triggers, views and lookups. **It drops the database first.**
   2. `database/seeds/sample-data.sql`: sample people, items, requests and attendance.
3. Try `database/queries/report-queries.sql` to see the views working.

`database/tests/schema-tests.sql` checks every business rule; some statements are supposed to fail. Run it only on a copy you don't mind resetting.

## Folder map

```
hygears-dba/
├── database/
│   ├── hygears.sql        Full schema (tables, triggers, views, lookups)
│   ├── seeds/             Sample data
│   ├── queries/           Report queries for the paper
│   ├── tests/             Business-rule tests
│   └── migrations/        Numbered changes once real data exists
├── app/                   The HQ system in PHP (kiosk, dashboard, requests...)
├── docs/                  ERD, business rules, paper notes
└── .github/               Pull request and issue templates
```

## What the database enforces

- Only members with a student ID can be members; visitors are people without a member row.
- Time out must be after time in.
- Consumables have no due date or return time.
- Only active members whose role can approve may decide requests, and never their own.
- Stock is calculated by views (`v_item_stock`, `v_low_stock`, `v_open_loans`), so it never drifts.

**Known gaps for the app to handle:** approving more than the available stock isn't blocked by the database, and nothing marks a request `completed` when all tools are returned.

## Team

Dapon, Ralph Eli G. · Fernandez, Rico Gajelloma (schema) · Galdones, Namron · Medina, Rhylle · Ramos, Shawn Angel S. · Villas, Hans

How we work together: see [CONTRIBUTING.md](CONTRIBUTING.md).
