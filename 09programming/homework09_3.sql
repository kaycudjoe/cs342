/*
Karen Cudjoe
CS 342
Homework 3
/*

/*
Implement the following SQL queries on the IMDBLarge, optimize them using physical database and SQL tuning.

For each query, include a short (one-paragraph) discussion that includes the following.

the alternate implementation forms you could have used and why you chose the one you did
the indexes your queries use (or don’t use) and why they help
the general SQL tuning heuristics you’ve deployed
Demonstrate what you’ve accomplished by reviewing the execution plans for each query.

For testing purposes, it can be helpful to run these queries on the smaller IMDB; this works provided that you relax the requirements a bit (e.g., directors with more than 2 rather than 200 movies, etc.).
*/

-- 3.
-- Get the most popular actors, where actors are designated as popular if their movies have an average rank greater than 8.5 with a movie count of at least 10 movies.
-- Try 1
select a.ID, a.firstName, a.lastName, avg(m.rank)
from Actor a, Role r, Movie m
WHERE a.id = r.actorId
AND r.movieId = m.id
GROUP BY a.ID, a.firstName, a.lastName
having avg(m.rank) > 8.5
and count(m.id) >= 10;
--Runtime: 2.6 seconds

-- Try 2
create index roleIndex on Role (movieId, actorId);

select a.ID, a.firstName, a.lastName, avg(m.rank)
from Actor a, Role r, Movie m
WHERE a.id = r.actorId
AND r.movieId = m.id
group by a.ID, a.firstName, a.lastName
having avg(m.rank) > 8.5
and count(1) >= 10;


-- Try 3
create index actorIndex on Actor (firstName, lastName, id);

select a.ID, a.firstName, a.lastName as actor, avg(m.rank)
from Actor a, Role r, Movie m
where a.id = r.actorId
and r.movieId = m.id
group by a.ID, a.firstName, a.lastName
having avg(m.rank) > 8.5
and count(*) >= 10;

drop index roleIndex;
drop index actorIndex;

/*
The roleIndex does not seem to have an effect on the execution time.
In try 3, adding the actorIndex in this case did not increase the optimization in any way
I can't think of any alternate queries that could be faster than the first.
*/
