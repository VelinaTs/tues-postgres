--
-- PostgreSQL database dump (database: timetable)
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE TABLE public.classes (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name text NOT NULL UNIQUE
);

CREATE TABLE public.subjects (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name text NOT NULL UNIQUE
);

CREATE TABLE public.teachers (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE public.rooms (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    number text NOT NULL UNIQUE
);

CREATE TABLE public.lessons (
    class_id integer NOT NULL REFERENCES public.classes(id),
    day smallint NOT NULL CHECK (day BETWEEN 1 AND 5),
    period smallint NOT NULL CHECK (period BETWEEN 1 AND 7),
    subject_id integer NOT NULL REFERENCES public.subjects(id),
    teacher_id integer NOT NULL REFERENCES public.teachers(id),
    room_id integer NOT NULL REFERENCES public.rooms(id),
    PRIMARY KEY (class_id, day, period),
    UNIQUE (teacher_id, day, period),
    UNIQUE (room_id, day, period)
);

INSERT INTO public.classes (name) VALUES ('11A'), ('11B');
INSERT INTO public.subjects (name) VALUES ('Math'), ('English'), ('Databases'), ('Physics');
INSERT INTO public.teachers (name) VALUES ('Ivanova'), ('Petrov'), ('Georgieva');
INSERT INTO public.rooms (number) VALUES ('204'), ('105'), ('310');

-- day: 1 = Monday ... 5 = Friday
INSERT INTO public.lessons (class_id, day, period, subject_id, teacher_id, room_id) VALUES
    (1, 1, 1, 1, 1, 1),
    (1, 1, 2, 2, 2, 2),
    (1, 1, 3, 3, 3, 1),
    (1, 1, 4, 4, 1, 3),
    (2, 1, 1, 2, 2, 2),
    (2, 1, 2, 1, 1, 1),
    (2, 1, 3, 4, 1, 3),
    (1, 2, 1, 3, 3, 1),
    (2, 2, 1, 1, 1, 2),
    (2, 3, 2, 3, 3, 1),
    (1, 3, 2, 2, 2, 2);

--
-- PostgreSQL database dump complete
--
