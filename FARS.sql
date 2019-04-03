USE fars;

# Which make and model (barring motorcycles) was most dangerous in terms of number of fatalities of model year 2013?

SELECT l.make_desc, v.model, v.mak_mod, SUM(v.deaths) as deaths
from fars.vehicle v JOIN fars.lkp_make l on v.make = l.code 
WHERE v.mod_year = 2013
GROUP BY v.model
ORDER BY deaths desc;

# Toyota Corolla with five deaths

# Which car had the most fatalities by collision since 2002? 

SELECT SUM(a.fatals) as total_deaths, v.mak_mod
FROM fars.vehicle v JOIN fars.accident a on v.st_case_year = a.st_case_year
WHERE v.man_coll != 0 AND v.man_coll != 98 AND v.man_coll != 99 AND a.year>= 2002
GROUP BY v.mak_mod
ORDER BY total_deaths desc;

SELECT v.make, l.make_desc
from fars.vehicle v JOIN fars.lkp_make l on v.make = l.code
WHERE v.make = 37;

# Honda Accord - 127 deaths

# What kind of collision has killed the most pickup truck occupants?

SELECT l.collision_desc as collision, SUM(v.deaths) as total_deaths
FROM fars.vehicle v JOIN fars.lkp_mann_coll l on v.man_coll = l.code
WHERE v.body_typ = (10 OR 31 OR 32 OR 33 OR 39 OR 67) AND v.man_coll != 0
GROUP BY collision
ORDER BY total_deaths desc;

# Most who die in pickup trucks in collisions die when their truck collides at an angle.

# From 1990 onwards, which make of car is most prone to causing fatalities by Ford Pinto-style explosions or fires?

SELECT v.make, COUNT(*) as explosions
FROM fars.vehicle v JOIN fars.accident a on v.st_case_year = a.st_case_year
WHERE v.m_harm = 2 AND a.year >= 1990
GROUP BY v.make
ORDER BY explosions desc;

SELECT v.make, l.make_desc
from fars.vehicle v JOIN fars.lkp_make l on v.make = l.code
WHERE v.make = 12;

# Ford has had more occupants die in explosions than any other manufacturer since 1990 - three.

# https://www.usatoday.com/story/news/nation/2013/05/07/car-crashes-cell-phones-distracted-driving/2142157/

/*We've mentioned in class how often data from government sources will have holes that need to be patched, either due to bad reporting, bad updating, or different reporting standards for different jurisdictions. This is a prime example of what can happen. It's unlikely that such studies will ever record all of the data perfectly, as cellphone use in driving is not something that people will be willing to admit up-front. Unfortunately, everyone from news organizations to everyday people use these statistics as a crutch and a tool to make decisions, so whenever it happens in a study such as this, the costs can by massive.*/

# https://www.denverpost.com/2017/08/25/colorado-marijuana-traffic-fatalities/

/*This article highlights the danger of focusing on a small sample size. While the agencies releasing this information are quick to warn people that not enough time has passed to determine whether there is a correlation between marijuana legalization and motor accidents, some aren't buying it. We like to think that data, charts, graphs, and numbers presented correctly and efficiently are a definitive answer in every situation, but sometimes that's not enough. People will believe what they want to believe, and nothing can convince them otherwise.*/