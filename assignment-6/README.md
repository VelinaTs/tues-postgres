# Assignment 6 – Weekly Timetable

**Decisions I made and why.** The data is in four simple tables (`classes`, `subjects`, `teachers`, `rooms`) and one `lessons` table that links them by FOREIGN KEY. The primary key of `lessons` is `(class_id, day, period)`, so a class can't have two lessons at the same time. Two UNIQUE constraints, `(teacher_id, day, period)` and `(room_id, day, period)`, stop a teacher or a room from being double-booked. The day (1–5) and period (1–7) are small integers with CHECK constraints instead of dates, because the timetable is the same every week. I deliberately don't store free periods; a query computes them with `generate_series`.

**Test:** `INSERT INTO lessons VALUES (1, 1, 1, 2, 2, 2);` (a second lesson for 11A, Monday, period 1) fails with:
`ERROR: duplicate key value violates unique constraint "lessons_pkey"`
