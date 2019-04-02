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

#What kind of collision has killed the most pickup truck occupants?

SELECT l.collision_desc as collision, SUM(v.deaths) as total_deaths
FROM fars.vehicle v JOIN fars.lkp_mann_coll l on v.man_coll = l.code
WHERE v.body_typ = (10 OR 31 OR 32 OR 33 OR 39 OR 67) AND v.man_coll != 0
GROUP BY collision
ORDER BY total_deaths desc;

# Most who die in pickup trucks in collisions die when their truck collides at an angle.