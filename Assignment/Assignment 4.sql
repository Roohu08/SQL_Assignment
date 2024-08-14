CREATE DATABASE Assignment_4;
USE Assignment_4;
CREATE TABLE Movies (
  Code INTEGER PRIMARY KEY,
  Title VARCHAR(255) NOT NULL,
  Rating VARCHAR(255) 
);

CREATE TABLE MovieTheaters (
  Code INTEGER PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Movie INTEGER,  
    FOREIGN KEY (Movie) REFERENCES Movies(Code)
) ENGINE=INNODB;

INSERT INTO Movies(Code,Title,Rating) 
VALUES
(1,'Citizen Kane','PG'),
(2,'Singin'' in the Rain','G'),
(3,'The Wizard of Oz','G'),
(4,'The Quiet Man',NULL),
(5,'North by Northwest',NULL),
(6,'The Last Tango in Paris','NC-17'),
(7,'Some Like it Hot','PG-13'),
(8,'A Night at the Opera',NULL);

INSERT INTO MovieTheaters(Code,Name,Movie) 
VALUES
(1,'Odeon',5),
(2,'Imperial',1),
(3,'Majestic',NULL),
(4,'Royale',6),
(5,'Paraiso',3),
(6,'Nickelodeon',NULL);

-- 4.1 Select the title of all movies.
select Title from Movies;

-- 4.2 Show all the distinct ratings in the database.
select distinct Rating from Movies;

-- 4.3  Show all unrated movies.
select * from Movies 
where Rating is null;

-- 4.4 Select all movie theaters that are not currently showing a movie.
select * from MovieTheaters
where Movie is null;

-- 4.5 Select all data from all movie theaters 
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
    select * from MovieTheaters
    join Movies on Movies.Code = MovieTheaters.Movie;
    
-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
select * from MovieTheaters right join Movies 
on Movies.Code = MovieTheaters.Movie;

-- 4.7 Show the titles of movies not currently being shown in any theaters.
select Movies.Title from MovieTheaters right join Movies
on Movies.Code = MovieTheaters.Movie
where MovieTheaters.Movie is null;

-- 4.8 Add the unrated movie "One, Two, Three".
insert into Movies (Code, title, rating) values (9, "one", null);
insert into Movies (Code, title, rating) values (10, "two", null);
insert into Movies (Code, title, rating) values (11, "three", null);

-- 4.9 Set the rating of all unrated movies to "G".
set sql_safe_updates = 0;
update Movies set rating = "G" where rating is null;

-- 4.10 Remove movie theaters projecting movies rated "NC-17".
delete from Movietheaters
where movie in (select code from movies where rating = "NC-17");

