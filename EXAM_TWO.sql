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

# 3. In what month of what year was the most money spent? How much was spent in that month? Use the date field, not expend_date.

SELECT year(date) as expend_year, month(date) as expend_month, SUM(expend_amt) as total_spent
FROM exercises.outside1
GROUP BY expend_year, expend_month
ORDER BY total_spent desc;

# The most money was spent during October 2016, the last full month before the election - $158,306,430.31.

# 4. In the month/year combo identified in question 3, how much was spent in support and how much was spent in opposition? Use the date field, not expend_date.
 
SELECT sup_opp, SUM(expend_amt) as total_spent
FROM exercises.outside1
WHERE year(date) = 2016 AND month(date) = 10 AND sup_opp IS NOT NULL
GROUP BY sup_opp WITH ROLLUP;

# In October 2016, $117,704,223.95 were spent in opposition of a candidate, while $40,592,597.36 were spent in support.alter

# 5. The district_state field shows the location where the spending was intended to influence voters. If the field is blank, or 00 or US or DC, then it is national-level spending. Other values pertain to specific states. Create a new column that combines the blank, 00, US and DC values into ‘national’ and leaves the rest of the state values unchanged, then shows the total spending opposed to Hillary Clinton. What individual state had the most money spent opposed to Clinton? How much was it?

SELECT IF((district_state = "00" OR district_state = "US" OR district_state = "DC"), "national", district_state) as natorstate, SUM(expend_amt) as total_spent
FROM exercises.outside1
WHERE cand_name LIKE "%Hillary%" AND sup_opp = "oppose"AND district_state IS NOT NULL
GROUP BY natorstate
ORDER BY total_spent desc;

# Kentucky spent more money than any other jurisdiction against Hillary, $791,151.36.

#6 - How many different values for purpose are listed in the table? If you wanted to draw conclusions about the purpose of the money outside groups are spending, why would that be challenging?

SELECT purpose
FROM exercises.outside1
GROUP BY purpose;

# There are 1,832 different values for "purpose" listed. However, it would be tricky to find out if this really was the number of purposes for spending, since some of these entries could mean the exact same thing. Others could be misspelled variants of other entries.

# 7. How much was total money was spent in support and in opposition by the committee with ‘Priorities’ in its name? Use a rollup query to show the support and oppose amount for that committee and overall total of spending for that committee. Below, List the name of the committee, the support and oppose amount and overall total for that committee.

SELECT spender_nam, sup_opp, SUM(expend_amt) as total_spent, cand_name
FROM exercises.outside1
WHERE spender_nam LIKE "%Priorities%"
GROUP BY sup_opp WITH ROLLUP;

# Priorities USA Action spent $123,146,391.61 in opposition of Donald Trump, and only $450,000 in support of Hillary Clinton - a total of $125,596,391.61 spent.

# 8. In spending for which the purpose included the name of a social network (for example, Facebook, YouTube, Snapchat, Instagram) or the word "social", which candidate had the most spent in support and which candidate had the most total expenditures spent in opposition? How much was it?

SELECT cand_name, sup_opp, SUM(expend_amt) as total_spent
FROM exercises.outside1
WHERE purpose LIKE "%Facebook%" OR purpose LIKE "%YouTube%" OR purpose LIKE "%Instagram%" OR purpose LIKE "%Snapchat%" OR purpose LIKE "%social%"
GROUP BY sup_opp, cand_name WITH ROLLUP
HAVING total_spent > 100000;

# Gary Johnson (?!) had the most spent in support related to social media (unless there was an error in the query) with $1,000,000. Hillary Clinton had the most spent against her on social media, $682,400.43.

# 9. EXTRA CREDIT. Create a new column to lump together all spending in favor of Trump or opposed to Clinton as “for Trump.” Lump together all spending in favor of Clinton or opposed to Trump as “for Clinton.” Categorize any other spending as “other.” List the total for the three groups. Which is greater, spending "for Clinton" or "for Trump?"

SELECT IF((cand_name LIKE "%Trump%" AND sup_opp = "support") OR (cand_name LIKE "%Clinton%" AND sup_opp = "oppose"), "for Trump", 
IF((cand_name LIKE "%Clinton%" AND sup_opp = "support") OR (cand_name LIKE "%Trump%" AND sup_opp = "oppose"), "for Clinton", "other")) as candidate, SUM(expend_amt) as total_spent
FROM exercises.outside1
GROUP BY candidate WITH ROLLUP;

# Spending was greater for Clinton - $250,312,813.06 to $204,245,220.63.

-- PART TWO --

SELECT *
FROM exercises.md_contrib;

# 1. Which candidate got a contribution from a donor who listed their occupation as a the owner of a food truck?

SELECT *
FROM exercises.md_contrib co JOIN exercises.md_cand ca on co.cmte_id = ca.cmte_id
WHERE co.occupation LIKE "%food truck%";

# The food truck owner is Nureya Monroe, and she gave to Hillary Clinton.

# 2. What city in Maryland contributed the most money to Donald Trump? How much?

SELECT co.city, SUM(co.amount) as total_spent
FROM exercises.md_contrib co JOIN exercises.md_cand ca on co.cmte_id = ca.cmte_id
WHERE ca.CAND_NAME LIKE "%Trump%"
GROUP BY co.city
ORDER BY total_spent desc;

# Bethesda spent the most money on Trump, $4,950.

# 3. How many contributions were given to Hillary Clinton by people who had the word attorney or lawyer included in their occupation? Don't include abbreviations of these words in the count of contributions.

SELECT *
FROM exercises.md_contrib co JOIN exercises.md_cand ca on co.cmte_id = ca.cmte_id
WHERE (co.occupation LIKE "%attorney%" or co.occupation LIKE "%lawyer%") AND cand_name LIKE "%clinton%";

# Hillary Clinton received approximately 536 contributions from Maryland attorneys.

# 4. Which candidate got the second most money from people who had the word attorney or lawyer included in their contribution. Don't include abbreviations of these words in the count. How much did they get?

SELECT ca.cand_name, COUNT(*) as number_contrib, SUM(co.amount) as total_spent
FROM exercises.md_contrib co JOIN exercises.md_cand ca on co.cmte_id = ca.cmte_id
WHERE co.occupation LIKE "%attorney%" or co.occupation LIKE "%lawyer%"
GROUP BY ca.cand_name
ORDER BY total_spent desc;

# Martin O'Malley received 199 contributions from Maryland attorneys, totaling $191,990.

# 5. How many donors gave a combined total of $20,000 or more to all of the Republican presidential candidates? Write a single query that returns a table with only those donors and no other donors.

SELECT co.NAME, co.CITY, co.STATE, SUM(co.amount) as total_spent
FROM exercises.md_contrib co JOIN exercises.md_cand ca on co.cmte_id = ca.cmte_id
WHERE ca.party = "REP"
GROUP BY co.NAME
HAVING total_spent >= 20000;

# Only two donors gave over $20,000 to the Republican candidates - Robert McWilliams and Aaron Poynton.

#6. Contributions for a negative amount represent refunds or "redesignations" of the contribution to another contributor (i.e. re-assigning the contribution to a spouse, so you can give more money). How many such contributions are in the data for Ted Cruz?

SELECT *
FROM exercises.md_contrib co JOIN exercises.md_cand ca on co.cmte_id = ca.cmte_id
WHERE co.amount < 0 AND ca.CAND_NAME LIKE "%Cruz%";

# There are 16 such "contributions" in the database.

# 7. Which two presidential candidates received the most money from contributors in Maryland? Write a single query that returns the total amount of money contributed for only those two candidates.

SELECT ca.CAND_NAME, SUM(co.amount) as total_spent
FROM exercises.md_contrib co JOIN exercises.md_cand ca on co.cmte_id = ca.cmte_id
WHERE co.STATE = "MD"
GROUP BY ca.CAND_NAME
ORDER BY total_spent desc
LIMIT 0, 2;

# The top two candidates in Maryland were Hillary Clinton ($3,678,903) and Martin O'Malley ($1,506,699).

#8. If you remove contributions of 0 or less, how many candidates have an average contribution amount less than Bernard Sanders?

SELECT ca.CAND_NAME, AVG(co.amount) as average_cont
FROM exercises.md_contrib co JOIN exercises.md_cand ca on co.cmte_id = ca.cmte_id
WHERE co.amount > 0
GROUP BY ca.CAND_NAME
ORDER BY average_cont desc;

# Only one candidate - Jill Stein - had a lower average contribution in Maryland than Bernie Sanders. Frankly, it's a miracle he got as far as he did at all.