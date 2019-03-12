# William Pitts - 12 March 2019

SET SQL_MODE='only_full_group_by';

SELECT *
FROM bard.accidents;

SELECT bardid, count(*) as count
FROM bard.accidents
GROUP BY bardid
ORDER BY count desc;

SELECT *
FROM bard.deaths;

SELECT * FROM bard.deaths
WHERE bardid = "MD-2016-0161";

SELECT * FROM bard.accidents
WHERE bardid = "MD-2016-0161";

SELECT *
FROM bard.accidents JOIN bard.deaths on bard.accidents.bardid = bard.deaths.bardid
WHERE bard.accidents.bardid = "MD-2016-0161";

SELECT *
FROM bard.accidents JOIN bard.deaths on bard.accidents.bardid = bard.deaths.bardid;

SELECT *
FROM bard.deaths d JOIN bard.accidents a on d.bardid = a.bardid;

SELECT d.bardid, d.CauseofDeath, d.DeceasedRole, a.Year
FROM bard.deaths d JOIN bard.accidents a on d.bardid = a.bardid
WHERE d.DeceasedAge < 18 AND a.YEAR = '2016';

SELECT a.year, d.CauseofDeath, COUNT(*) as count
FROM bard.deaths d JOIN bard.accidents a on d.bardid = a.bardid
GROUP BY a.year, d.CauseofDeath
ORDER BY a.year, d.CauseofDeath;

# By year, how many fatal accidents have occurred in clear visibility? Which was the worst year for this?

SELECT d.year, COUNT(*) as count
FROM bard.deaths d JOIN bard.accidents a on d.bardid = a.bardid
WHERE a.visibility = "Good"
GROUP BY d.year
ORDER BY count desc;

# The worst year for this count is 2005, with 51 accidents in good visibility.

# In 2016, which county in Maryland had the most fatalities?

SELECT a.County, COUNT(*) as count
FROM bard.deaths d JOIN bard.accidents a on d.bardid = a.bardid
WHERE a.state = "MD" AND d.Year = "2016"
GROUP BY a.County
ORDER BY count desc;

# Anne Arundel County had the most of all, with five.

# Of all drowning fatalities, what percentage were not wearing life jackets?

SELECT d.DeceasedPFDWorn, COUNT(*) as count
FROM bard.deaths d JOIN bard.accidents a on d.bardid = a.bardid
WHERE d.CauseofDeath = "Drowning"
GROUP BY d.DeceasedPFDWorn
ORDER BY count;

# 101 out of 120 were NOT wearing life jackets - 84.16%.