-- Question 1: The timetable of class 11A for Monday (day 1), period by period.
-- Returns one row per lesson: period, subject, teacher, room, ordered by period.
-- Change '11A' or the day number (1 = Monday ... 5 = Friday) to see another class or day.
SELECT l.period,
       s.name   AS subject,
       t.name   AS teacher,
       r.number AS room
FROM lessons l
JOIN classes  c ON c.id = l.class_id
JOIN subjects s ON s.id = l.subject_id
JOIN teachers t ON t.id = l.teacher_id
JOIN rooms    r ON r.id = l.room_id
WHERE c.name = '11A'
  AND l.day = 1
ORDER BY l.period;
 
 
-- Question 2: When is room 204 taken during the week, and when is it free?
-- Returns all 35 slots (5 days x 7 periods): day, period and the class in the room.
-- class is NULL when the room is free.
-- The room filter is in ON, not WHERE, so free slots are kept by the LEFT JOIN.
SELECT d.day,
       p.period,
       c.name AS class
FROM generate_series(1, 5) AS d(day)
CROSS JOIN generate_series(1, 7) AS p(period)
LEFT JOIN lessons l
       ON l.day = d.day
      AND l.period = p.period
      AND l.room_id = (SELECT id FROM rooms WHERE number = '204')
LEFT JOIN classes c ON c.id = l.class_id
ORDER BY d.day, p.period;