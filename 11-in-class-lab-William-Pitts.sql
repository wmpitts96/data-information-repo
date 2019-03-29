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
SELECT filing_period, COUNT(*) as Contribution_Count
FROM exercises.md_gov_race
GROUP BY filing_period
ORDER BY Contribution_Count desc;

# Answer: 12.68%

# Who received more per contribution through either cash, check, or credit card - and by how much?
SELECT receiving_committee, AVG(contribution_amount) as Average_Contribution, SUM(contribution_amount) as Contribution_Total
FROM exercises.md_gov_race
WHERE contribution_type = "Check" OR "Cash" OR "Credit Card"
GROUP BY receiving_committee
ORDER BY Average_contribution desc;

# Jealous by $479.78

# How much more was the average contribution by groups than by individuals? What was the difference between the total? What does this tell you about the data?
SELECT contributor_type, AVG(contribution_amount) as Average_Contribution, SUM(contribution_amount) as Contribution_Total, COUNT(*) as Total_Contributions
FROM exercises.md_gov_race
GROUP BY contributor_type
ORDER BY Average_contribution desc;

# Businesses shelled out, on average, $1235.53 more per contribution for every corresponding individual contribution ($1442.42 to $206.89). However, individual contributions totaled $10,703,972, while business contributions came to only $4,330,156. This implies that the public took this election seriously and were willing to take any financial hit to help their candidate win.
