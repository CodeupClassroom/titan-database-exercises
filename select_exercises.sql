use codeup_teest_db;

#The name of all albums by Pink Floyd.
Select 'The name of all albums by Pink Floyd.' as caption, a.* from albums a WHERE artist = 'Pink Floyd';
--

#The year Sgt. Pepper's Lonely Hearts Club Band was released
Select 'Year SGT Peppers... band was released' as caption, release_date
from albums
where name = 'Sgt. Pepper''s Lonely Hearts Club Band';

#The genre for Nevermind
select 'genre for Nevermind' as caption, genre
from albums
where name = 'Nevermind';

#Which albums were released in the 1990s
select ' albums were released in the 1990s' as caption, a.*
from albums a
where release_date between 1990 and 1999;


#Which albums had less than 20 million certified sales
select 'less than 20 mil certified sales' as caption, name
from albums a
where sales < 20;

#All the albums with a genre of "Rock".
select 'rock albums' as caption, a.*
from albums a
where genre = 'Rock';


# Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
select 'rock albums' as caption, a.*
from albums a
where genre like '%Rock%';



