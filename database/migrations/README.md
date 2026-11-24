# migrations/

Each file changes an existing database in place, in order:

```
001_initial.sql        (the schema as first committed; for now that's hygears.sql)
002_add_item_unit.sql  (example: ALTER TABLE item ADD COLUMN unit ...)
```

Rules:
- One change per file, named `NNN_what_it_does.sql`, lowercase.
- Never edit a migration someone has already run. Fix it with a new file.
- Update `../hygears.sql` in the same commit so a fresh install matches.
