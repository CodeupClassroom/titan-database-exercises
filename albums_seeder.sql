use codeup_test_db;

DROP TABLE persons;

TRUNCATE albums;

# original method
INSERT INTO albums(artist, name, release_date, genre, sales)
VALUES
 ('Michael Jackson', 'Thriller', '1982', 'Pop, Rock, R&B', 66),
 ('AC/DC', 'Back in Black', '1980', 'Hard rock', 50),
 ('Pink Floyd', 'The Dark Side of the Moon', '1973', 'Progressive rock', 45),
 ('Meat Loaf', 'Bat Out of Hell', '1977', 'Hard rock, Progressive rock', 43),
 ('Whitney Houston / Various artists', 'The Bodyguard', '1992', 'R&B, Soul, Pop, Soundtrack', 42),
 ('Eagles', 'Their Greatest Hits (1971–1975)', '1976', 'Rock, Soft rock, Folk rock', 42),
 ('Bee Gees / Various artists', 'Saturday Night Fever', '1977', 'Disco', 40),
 ('Fleetwood Mac', 'Rumours', '1977', 'Soft rock', 40),
 ('Various artists', 'Grease: The Original Soundtrack from the Motion Picture', '1978', 'Soundtrack', 38),
 ('Led Zeppelin', 'Led Zeppelin IV', '1971', 'Hard rock, Heavy metal, Folk', 37),
 ('Michael Jackson', 'Bad', '1987', 'Pop, Funk, Rock', 35),
 ('Alanis Morissette', 'Jagged Little Pill', '1995', 'Alternative rock', 33),
 ('Shania Twain', 'Come On Over', '1997', 'Country, Pop', 33),
 ('Celine Dion', 'Falling into You', '1996', 'Pop, Soft rock', 32),
 ('The Beatles', 'Sgt. Pepper''s Lonely Hearts Club Band', '1967', 'Rock', 32),
 ('Eagles', 'Hotel California', '1976', 'Rock, Soft rock, Folk rock', 32),
 ('Various artists', 'Dirty Dancing', '1987', 'Pop, Rock, R&B', 32),
 ('Adele', '21', '2011', 'Pop, Soul', 31),
 ('Celine Dion', 'Let''s Talk About Love', '1997', 'Pop, Soft rock', 31),
 ('The Beatles', '1', '2000', 'Rock', 31),
 ('Michael Jackson', 'Dangerous', '1991', 'Rock, Funk, Pop', 30),
 ('Madonna', 'The Immaculate Collection', '1990', 'Pop, Dance', 30),
 ('The Beatles', 'Abbey Road', '1969', 'Rock', 30),
 ('Bruce Springsteen', 'Born in the U.S.A.', '1984', 'Rock', 30),
 ('Dire Straits', 'Brothers in Arms', '1985', 'Rock, Pop', 30),
 ('James Horner', 'Titanic: Music from the Motion Picture', '1997', 'Soundtrack', 30),
 ('Metallica', 'Metallica', '1991', 'Thrash metal, Heavy metal', 30),
 ('Nirvana', 'Nevermind', '1991', 'Grunge, Alternative rock', 30),
 ('Pink Floyd', 'The Wall', '1979', 'Progressive rock', 30),
 ('Santana', 'Supernatural', '1999', 'Rock', 30),
 ('Guns N'' Roses', 'Appetite for Destruction', '1987', 'Hard rock', 30);


