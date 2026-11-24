# database/

| File / folder | What it is | When to run it |
|---|---|---|
| `hygears.sql` | The full schema: tables, triggers, views and starter lookups. **Drops and recreates `hygears_db`.** | First, on a fresh setup |
| `seeds/sample-data.sql` | Sample people, items, requests and attendance for testing and screenshots | After `hygears.sql` |
| `queries/report-queries.sql` | The sample queries for the paper's Results section | Any time, to show results |
| `tests/schema-tests.sql` | Checks that every business rule is enforced (some lines are SUPPOSED to fail) | On a throwaway copy, after `hygears.sql` |
| `migrations/` | Changes to an existing database, one numbered file per change | When the schema changes after people already have data |

## Import order (phpMyAdmin or MySQL Workbench)
1. `hygears.sql`
2. `seeds/sample-data.sql`
3. (WebDev) `database/web-portal.sql` from the hygears-web-portal repo

## Changing the schema
- Small group, early stage: edit `hygears.sql` directly and say so in the commit message, so everyone re-imports.
- Once people keep real data: don't edit old files. Add `migrations/002_short_name.sql` with the `ALTER TABLE` statements, and update `hygears.sql` in the same commit so a fresh install still matches.
