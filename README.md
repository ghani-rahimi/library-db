# library-db

Group assignment for Database Design and Development at Western Sydney Uni (2022). Three of us designed the database for a
small public library: members, books and copies, loans, holds and fines.

What's here:

- `sql/01_schema.sql` tables, keys and constraints (we normalised to 3NF and the report explains the steps)
- `sql/02_seed.sql` a bit of sample data so the queries return something
- `sql/03_queries.sql` the queries the brief asked for, plus a view for overdue loans
- `sql/04_triggers.sql` a trigger that stops a member borrowing if they owe more than $10

PostgreSQL 14. To try it:

    createdb library
    for f in sql/*.sql; do psql library -f "$f"; done

The ER diagram was in the report (not in this repo).
