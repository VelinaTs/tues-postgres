-- Question 1: timetable of class 11A for Monday (day 1).
-- Returns period, subject, teacher, room, ordered by period.
SELECT l.period, s.name AS subject, t.name AS teacher, r.number AS room
FROM lessons l
JOIN classes c  ON c.id = l.class_id
JOIN subjects s ON s.id = l.subject_id
JOIN teachers t ON t.id = l.teacher_id
JOIN rooms r    ON r.id = l.room_id
WHERE c.name = '11A' AND l.day = 1
ORDER BY l.period;

-- Question 2: the whole week for room 204 (5 days x 7 periods).
-- Returns day, period and the class using it; class is NULL when the room is free.
SELECT d.day, p.period, c.name AS class
FROM generate_series(1, 5) AS d(day)
CROSS JOIN generate_series(1, 7) AS p(period)
LEFT JOIN lessons l
       ON l.day = d.day AND l.period = p.period
      AND l.room_id = (SELECT id FROM rooms WHERE number = '204')
LEFT JOIN classes c ON c.id = l.class_id
ORDER BY d.day, p.period;
