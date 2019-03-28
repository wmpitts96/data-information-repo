USE exercises;

SELECT *
FROM exercises.outside1;

# 1. How many of the expenditures in the table are in support of a candidate, and how many were in opposition to a candidate? How much money in total was in support of a candidate and how much money in total was in opposition? Write a single query that gives you all four answers.

SELECT sup_opp, COUNT(*) as expenditures, SUM(expend_amt) as total_expense
FROM exercises.outside1
WHERE sup_opp IS NOT NULL
GROUP BY sup_opp WITH ROLLUP;

# 40,108 expenditures, totaling $313,383,967.09 were in support of a candidate. 29,983 expenditures, totaling $146,584,013.92 were in opposition to a candidate.

# 2. What candidate had the most money spent against them? What candidate had the most money spent supporting them? Ignore null values.

SELECT cand_name, SUM(expend_amt) as total_spent
FROM exercises.outside1
WHERE sup_opp = "oppose"
GROUP BY cand_name 
ORDER BY total_spent desc;

SELECT cand_name, SUM(expend_amt) as total_spent
FROM exercises.outside1
WHERE sup_opp = "support"
GROUP BY cand_name 
ORDER BY total_spent desc;

# Donald Trump had the most money spent against him, $206,585,465.82.  He also had the most money spent in support, with $98,871,957.

# 3.

SELECT year(date) as expend_year, month(date) as expend_month, SUM(expend_amt) as total_spent
FROM exercises.outside1
GROUP BY expend_year, expend_month
ORDER BY total_spent desc;

# The most money was spent during October 2016, the last full month before the election - $158,306,430.31.

# 4.
 
SELECT sup_opp, SUM(expend_amt) as total_spent
FROM exercises.outside1
WHERE year(date) = 2016 AND month(date) = 10 AND sup_opp IS NOT NULL
GROUP BY sup_opp WITH ROLLUP;

# In October 2016, $117,704,223.95 were spent in opposition of a candidate, while $40,592,597.36 were spent in support.alter

#5 

SELECT IF((district_state = "00" OR district_state = "US" OR district_state = "DC"), "national", district_state) as natorstate, SUM(expend_amt) as total_spent
FROM exercises.outside1
WHERE cand_name LIKE "%Hillary%" AND sup_opp = "oppose"AND district_state IS NOT NULL
GROUP BY natorstate
ORDER BY total_spent desc;

# Kentucky spent more money than any other jurisdiction against Hillary, $791,151.36.