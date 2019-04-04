USE fars;

SELECT * FROM fars.accident;

SELECT *
FROM fars.accident a
JOIN fars.lkp_state b ON a.STATE = b.code;

SELECT *
FROM fars.accident a
JOIN fars.lkp_state b ON a.STATE = b.code
JOIN fars.lkp_harmevent c ON a.HARM_EV = c.code;

CREATE TEMPORARY TABLE accident_100
SELECT * FROM fars.accident
LIMIT 100;

SELECT *
FROM accident_100;

CREATE TEMPORARY TABLE common_harm_events
SELECT b.event_desc, b.code, count(*) as num_rec
FROM fars.accident a
JOIN fars.lkp_harmevent b ON a.HARM_EV = b.code
GROUP BY b.event_desc
HAVING num_rec > 100
ORDER BY num_rec desc;

SELECT *
FROM common_harm_events;

SELECT *
FROM fars.accident a
JOIN common_harm_events b ON a.HARM_EV = b.code;