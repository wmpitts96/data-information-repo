#William Pitts
#March 5, 2018

USE exercises;

SELECT SUM(contribution_amount) as Contribution_Total
FROM exercises.md_gov_race;

SELECT SUM(contribution_amount) as Contribution_Total, AVG(contribution_amount) as Average_Contribution, MIN(contribution_amount) as Smallest_Contribution, MAX(contribution_amount) as Largest_Contribution, COUNT(*) as Number_Contributions
FROM exercises.md_gov_race;

SELECT *
FROM exercises.md_gov_race
ORDER BY contribution_date desc;

---

#Which ZIP code recordest the highest number of contributions?
SELECT zip_code, SUM(contribution_amount) as Contribution_Total, AVG(contribution_amount) as Average_Contribution, MAX(contribution_amount) as Largest_Contribution, COUNT(*) as Number_Contributions
FROM exercises.md_gov_race
GROUP BY zip_code
ORDER BY Contribution_Total desc;

# Answer: 21401

#What percentage of contributors donated during the "2018 Gubernatorial Pre-Primary 2" filing period?


# What was the difference between Hogan's average contribution and Jealous' average contribution?


# How many donated in cash?

