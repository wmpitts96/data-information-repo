/* MySQL Assignment 1
Connect to JOURDATA in MySQL Workbench, Then open this file in MySQL Workbench. Rename it Firstname-Lastname-10-homework.sql. Work in this file to answer the questions.
Underneath each question below, create a new comment with the correct answer.  Underneath the answer -- NOT in a comment -- put the SQL query you used to derive the answer.
Use the table md_gov_race in the exercises database.  This is a single-table database of all campaign contributions to Republican Larry Hogan and Democrat Ben Jealous in the 2018 Maryland governor's race from January 2014 through June 2018, just before the primary election in June.
The data was downloaded from here https://campaignfinancemd.us/Public/ViewReceipts and cleaned.
Use the following documentation:
* unique_id: each record has a unique number to identify it. This is the table's "primary key". Each record represents one contribution.
* receiving_committee: each candidate has a "committee" set up to receive contributions.
* filing_period: the political cycles are broken up into different "periods", demarked by the time when candidates must report contributions to the state.
* contribution_date: the date on which a particular contribution was made.
* contributor_name, contributor_address, zip_code, state: details about the person who made the contribution.
* contributor_type: includes individuals, businesses, party committees and other types.
* contribution_type: includes credit cards, checks, loans, and more.
* contribution_amount: in dollars.
* employer_name: self-reported name of contributor's employer.  A lot of these values are blank.
* employer_occupation: self-reported occupation of contributor.  A lot of these values are blank.
*/

/* To submit: Rename the file firstname-lastname-SQL-Assignment-01.sql and upload to ELMS here: https://umd.instructure.com/courses/1259604/assignments/4811986 */

# 1. How many records are in the table?
# There are 55,327 records.
SELECT * FROM exercises.md_gov_race;

# 2. What is the dollar amount of the largest dollar contribution from any source?  Who was it from, and who did it go to? What does the contribution type mean (link to a page or file on elections.maryland.gov where you find support for your answer)?
# Larry Hogan received the largest contribution, $68,133 from the Republican State Central Committee Of Maryland. This was a "coordinated in-kind" transaction, a contribution from the party committee coordinated with the campaign, which is legal as long as the party committee reports everything correctly. (https://elections.maryland.gov/laws_and_regs/documents/33.14.01.pdf)
SELECT *
FROM exercises.md_gov_race
ORDER BY contribution_amount desc;

# 3. What was the largest dollar contribution amount to Ben Jealous? Who made it, and what type of contribution was it?
# Ben Jealous' largest contribution was $50,000 out of his own pocket.
SELECT *
FROM exercises.md_gov_race
WHERE receiving_committee = "Jealous Ben Friends of"
ORDER BY contribution_amount desc;

# 4. Did Larry Hogan make any loans to his own campaign? Explain why you think this might be.
# Hogan did not make a single loan to his campaign, most likely because he coordinated with the Republican Party of Maryland to fund a successful campaign.
SELECT *
FROM exercises.md_gov_race
WHERE contribution_type = "Candidate Loan" AND receiving_committee = "Hogan Larry for Governor";

# 5. With the exception of a $9,004 contribution to Ben Jealous (which is possibly an error in the data), what is the dollar amount of the largest contribution from an individual donor.  Note: there are more than 200 individual contributions at this amount. For extra credit, do some quick Internet research and offer your best guess as to why this amount is the largest contribution.
# The largest individual contribution to Ben Jealous is $6,000, simply because that is the limit that Maryland sets for individual donors.
SELECT *
FROM exercises.md_gov_race
WHERE receiving_committee = "Jealous Ben Friends of"
ORDER BY contribution_amount desc;

# 6. How many contributions are from Maryland?  How many contributions are from outside of Maryland, including other U.S. states and terrorities, foreign countries or contributions with no state listed?
# 37,685 of the contributions came from the state of Maryland, while 17,524 came from elsewhere.
SELECT *
FROM exercises.md_gov_race
WHERE state <> "MD"
---
WHERE state = "MD"

# 7. How many contributions for Larry Hogan came from outside of Maryland, and how many came from Maryland?  How many contributions for Ben Jealous came from outside of Maryland and how many came from Maryland?  Write four queries in total, each of which should use LIKE and wildcards to find contributions to Jealous or Hogan.  Then, using Excel or a calculator, calculate the percentage of each candidate's contributions that came from out of state.
# 34,012 of Hogan's contributions came from Maryland, and 1,683 from elsewhere. 15,940 of Jealous' contributions came from outside the state and 3,673 came from within.
# Hogan: 4.45% out of state
# Jealous: 81.34% out of state
SELECT *
FROM exercises.md_gov_race
WHERE state <> "MD" AND receiving_committee LIKE "%Hogan%";
#Rinse and repeat for Jealous, and again for contributions in Maryland.

# 8 The actress Jada Pinkett Smith gave money to one of the candidates.  List the candidate she gave to, her address, how much she gave, what she listed as her employer and the date.  Then list some of the clues in the data that tell you that the person described in the database as "Jada Pinkett Smith" is actually the actress and not just some random person with the same name, and how you would verify your hunch with web research.
# Smith contributed $3000 to the Ben Jealous campaign on September 28th, 2017. Her employer at the time is listed as "Overbrook". It can be assumed that this is Jada Pinkett Smith herself because she gives her occupation as "Arts and Entertainment", and her address as "Century Park, Los Angeles, CA" - a glamorous section of the city.
SELECT *
FROM exercises.md_gov_race
WHERE contributor_name LIKE "Smith Jada%";

# 9. How many contributions were made to Larry Hogan in calendar year 2018?
# There were 7,584 contributions to Hogan in 2018.
SELECT *
FROM exercises.md_gov_race
WHERE year(contribution_date) = "2018" AND receiving_committee LIKE "%Hogan%";

# 10. How many contributions were made to Ben Jealous on March 1, 2018 or later? How many were made on exactly March 2, 2018?
# Jealous received 6,372 contributions on or after March 1st, and 35 specifically on the 2nd.
SELECT *
FROM exercises.md_gov_race
WHERE contribution_date > "2018-03-01" AND receiving_committee LIKE "%Jealous%";
---
WHERE contribution_date = "2018-03-02" AND receiving_committee LIKE "%Jealous%";

# 11.  How many total contributions have a null value for employer_occupation?  How many total contributions have a non-null value for employer contribution?  What percentage of total contributions have a null value (use Excel or a calculator)?  Write a sentence describing your level of confidence in using the information in this database to describe, in aggregate, the occupations of people contributing to the campaign.
# 32,995 listed their occupation as "NULL", for a percentage of 59.64%. Knowing this, I cannot confidently use the database to make statements on the types of people that contributed to each campaign, especially since most of the categories were overly vague. "Arts and Entertainment" could apply to someone who directs porn films.
SELECT *
FROM exercises.md_gov_race
WHERE employer_occupation IS NULL;

# 12. A University of Maryland professor gave Ben Jealous a total of $6,000 in 15 separate contributions between September 2017 and June 2018, between $50 and $1000.  What is the name of the professor? What department does he teach in (you may need to do some internet research to find this out)? Please list the date and contribution amount for each contribution, along with all queries used to arrive at this information.
# That professor was Norbert Hornstein of the Department of Linguistics.
2017-09-23	50
2017-11-04	100
2017-12-26	100
2018-02-04	100
2018-02-21	1000
2018-03-14	100
2018-04-06	100
2018-04-09	500
2018-04-13	600
2018-04-27	500
2018-05-06	250
2018-05-10	500
2018-05-21	500
2018-05-26	1000
2018-06-09	600
SELECT filing_period, contribution_date, contributor_name, contribution_amount, employer_name, employer_occupation
FROM exercises.md_gov_race
WHERE employer_name LIKE "University of Maryland%"
ORDER BY contributor_name asc;
---
SELECT *
FROM exercises.md_gov_race
WHERE contributor_name = "Hornstein Norbert"
ORDER BY contribution_date asc;

# 13. How many contributions came from 21012 or 21401? Write a single query to do this.
# 1,307 contributions came from those two ZIP codes.
SELECT *
FROM exercises.md_gov_race
WHERE zip_code = "21012" OR zip_code = "21401";

# 14. Write a query that will return a table with contributions from people who listed their employer name as being retired or retired at least part of the time? Do not include contributions from people who work at communities or homes for people who are retired. And do not use the employer occupation field in this query.  List the number of records in the table here.
# 6,772 of the contributors in the database list themselves as retired.
SELECT *
FROM exercises.md_gov_race
WHERE employer_name LIKE "%retired%";