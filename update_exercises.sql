use codeup_teest_db;

# All albums in your table.
select * from albums;

#Make all the albums 10 times more popular (sales * 10)
UPDATE albums a -- a alias for the table
SET a.sales = (a.sales * 10);

select * from albums;

# All albums released before 1980
select * from albums
where release_date < 1980;

#Move all the albums before 1980 back to the 1800s.
UPDATE albums a
SET release_date = (release_date - 100)
WHERE release_date < 1980;

select * from albums a
WHERE release_date < 1980;




# All albums by Michael Jackson
select * from albums
where artist = 'Michael Jackson';


# Change 'Michael Jackson' to 'Peter Jackson'
UPDATE albums a
SET artist = 'Peter Jackson'
where artist = 'Michael Jackson';

select * from albums
where artist = 'Michael Jackson' OR artist = 'Peter Jackson';