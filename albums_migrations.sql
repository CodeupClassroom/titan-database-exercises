USE codeup_teest_db;

-- removes a table only if it exists
DROP TABLE IF EXISTS albums;
CREATE TABLE IF NOT EXISTS albums (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    artist CHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    release_date INT,
    sales FLOAT,
    genre CHAR(200),
    PRIMARY KEY (id)
);


INSERT INTO albums (artist, name, release_date, sales, genre)
VALUES ('Bon Jovi','Some album',1994, 1235332453, 'classic rock, pop');

INSERT INTO albums (artist, name, release_date, sales, genre)
VALUES ('Christina Aguilera','Some other album',1999, 10000000, 'classic pop');

INSERT INTO albums (artist, name, release_date, sales, genre)
VALUES ('Metallica','black album',1990, 1444244, 'classic rock, rock');

INSERT INTO albums (artist, name, release_date, sales, genre)
VALUES ('Eminem','new album',2004, 255453432, 'rap, pop');

INSERT INTO albums (artist, name, release_date, sales, genre)
VALUES ('Styx','old album',1976, 333144223, 'classic rock, pop');

INSERT INTO albums (artist, name, release_date, sales, genre)
VALUES  ('Styx','old album',1976, 333144223, 'classic rock, pop'),
        ('Eagles','old album',1977, 23452345, 'classic rock, pop'),
        ('Jonnie Cash','old album',1950, 2222344, 'classic country, pop'),
        ('The Beach Boys','old album',1965, 222224544, 'classic pop'),
        ('Death Cab for Cutie','old album',2010, 233453433, 'indie rock, emo');


SELECT 'albums' as prefix , a.* FROM albums a WHERE release_date > 1995;

SELECT artist FROM albums WHERE sales between 10000000 and 15000000;

UPDATE albums SET release_date = 1991
WHERE artist = 'Metallica' ;

/*DELETE FROM albums WHERE release_date > 1995;
DELETE FROM albums;*/
-- same as DELETE FROM without any where, but faster
TRUNCATE albums;


DESC albums;

SHOW CREATE TABLE albums;
