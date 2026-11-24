# IMRaD paper: where each part comes from

The paper follows the PUP thesis format (Arial 11, double spaced, 1.5 in left margin). The draft is in the group's Google Drive.

| Paper section | Source in this repo |
|---|---|
| Methods, Database Design | `../erd/hygears-erd.drawio`, `../business-rules.docx` |
| Results, Business Rules | `../business-rules.docx`, enforced by the triggers and CHECKs in `database/hygears.sql` |
| Results, ERD | Export the drawio as PNG for Figure 1 |
| Results, Data Dictionary | Each table in `database/hygears.sql` (columns, types, keys, comments) |
| Results, Sample Queries | `database/queries/report-queries.sql` with their output |
| Discussion | Which rules the DB enforces vs. which the app must check (e.g. approving more than the stock) |
| Appendices | Full `database/hygears.sql`, photos of the old logbooks |
