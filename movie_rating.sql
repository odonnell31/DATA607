#create a schema 
drop schema if exists movies_rating;
create schema movies_rating;
use movies_rating; 

#create a movies table from my survey 
drop table if exists movies;
create table movies  (
movie_id integer primary key not null,
movie_name varchar(150) not null);

# populate the movies table with movie id and movie	name
insert into  movies (movie_id, movie_name)
values (1, 'Fight Club'),
       (2, 'Spy'),
	   (3, 'Blind Side'),
       (4, 'Spider Man'),
       (5, 'John Wick 2'),
       (6, 'Star Wars - The Last Jedi');

# create viewers table 
drop table if exists viewers ;
create table viewers ( person_id integer primary key,
                       person_name varchar(150) not null,
                       person_age integer  not null ,
                       person_gender varchar(150) not null );
insert into viewers (person_id ,person_name, person_age,person_gender)
values 
       (1,'Mel',38,'F'),                       
       (2,'Aykut',40,'M'),
       (3,'Pete',31,'F'),
       (4,'John',38,'M'),
       (5,'Gary',26,'M'),
       (6,'Tom',35,'M'),
       (7,'Mike',32,'M'),
       (8,'Eric',45,'M'),
       (9,'Jeff',29,'M'),
       (10,'Jeoma',30,'F');
       
#--create a reviewers table 
drop table if exists reviews;
create table reviews (
person_id integer references names(person_id), 
movie_id integer references movies(movie_id), 
rating integer check (rating between 1 and 5));  

#--populate the table with the results from my survey 

insert into reviews(person_id,movie_id,rating)
values
       # person_id 1
      (1,1,5),
      (1,2,3),
      (1,3,1),
      (1,4,2),
      (1,5,5),
      
      # person_id 2
      (2,1,4),
      (2,2,3),
      (2,3,4),
      (2,4,4),
      (2,5,5),
      
	 # person_id 3
	  (3,1,2),
      (3,2,2),
      (3,3,4),
      (3,4,4),
      (3,5,5),
      
	# person_id 4
      (4,1,2),
      (4,2,2),
      (4,3,4),
      (4,4,5),
      (4,5,5),
      
   # person_id 5
      (5,1,4),
      (5,2,3),
      (5,3,4),
      (5,4,4),
      (5,5,5),
   # person_id 6
      (6,1,4),
      (6,2,3),
      (6,3,4),
      (6,4,4),
      (6,5,5),
	# person_id 7
      (7,1,1),
      (7,2,2),
      (7,3,3),
      (7,4,5),
      (7,5,5),
   # person_id 8
      (8,1,2),
      (8,2,2),
      (8,3,3),
      (8,4,4),
      (8,5,4),
	# person_id 9
      (9,1,4),
      (9,2,4),
      (9,3,4),
      (9,4,6),
      (9,5,4),
	# person_id 10
      (10,1,2),
      (10,2,2),
      (10,3,3),
      (10,4,4),
      (10,5,4);

drop table if exists movie_ratings;
create table movie_ratings
select 
a.person_id, 
a.person_name, 
b.movie_name, 
c.rating  
from viewers a  
left join reviews c  
on (a.person_id=c.person_id)
left join movies b
on (b.movie_id=c.movie_id)
order by c.rating desc;

