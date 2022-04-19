USE codeup_teest_db;

#Write SELECT statements for:

#Albums released after 1991
Select 'Albums released after 1991' as caption, a.*  from albums a WHERE release_date > 1991;

#Albums with the genre 'disco'
Select 'Albums with the genre ''disco''' as caption, a.* from albums a where  genre = 'disco';

#Albums by 'Whitney Houston' (...or maybe an artist of your choice)
select 'Albums by ''Whitney Houston''' as caption, a.* from albums a where artist like '%Whitney Houston%';

-- delgit etes based on the above select statements
DELETE FROM albums a WHERE release_date > 1991;
delete from albums a where  genre = 'disco';
delete from albums a where artist like '%Whitney Houston%';

