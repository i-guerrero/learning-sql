/* JOINS */

/* Questions */

/* Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.*/
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
WHERE a.name = 'Walmart';

/* Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name. */
SELECT r.name region_name, s.name sales_rep_name, a.name account_name
FROM sales_reps s
JOIN region r
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name;

/* Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero. */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id

/* Last Check for JOINS  with LEFT & RIGHT */

/* Questions */
/* 1. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name. */
SELECT r.name region, s.name rep, a.name account
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name;


/* 2. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name. */
SELECT r.name region, s.name rep, a.name account
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND (s.name LIKE 's%' OR s.name LIKE 'S%')
ORDER BY a.name;

/* 3. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name. */
SELECT r.name region, s.name rep, a.name account
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND (s.name LIKE '%K%' AND s.name NOT LIKE 'K%')
ORDER BY a.name;

/* Alternate Solution */
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;


/* 4. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01). */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o 
ON a.id = o.account_id
WHERE o.standard_qty > 100;


/* 5. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o 
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty >50
ORDER BY o.total_amt_usd/(o.total + 0.01);

/* Alternate Solution */

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;


/* 6. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01). */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o 
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty >50
ORDER BY o.total_amt_usd/(o.total + 0.01) DESC;

/* 7. What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values. */
SELECT DISTINCT a.name account, w.channel
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
WHERE a.id = 1001

/* 8. Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd. */
SELECT o.occurred_at, a.name account, o.total, o.total_amt_usd
FROM orders o 
JOIN accounts a
ON a.id = o.account_id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY o.occurred_at DESC;




/* SQL Aggregations */

/* Aggregation Questions */
/* Use the SQL environment below to find the solution for each of the following questions. If you get stuck or want to check your answers, you can find the answers at the top of the next concept. */

/* Find the total amount of poster_qty paper ordered in the orders table. */
SELECT SUM(poster_qty) AS total_poster_sales
FROM orders

/* Find the total amount of standard_qty paper ordered in the orders table. */
SELECT SUM(standard_qty)
FROM orders

/* Find the total dollar amount of sales using the total_amt_usd in the orders table. */
SELECT SUM(total_amt_usd)
FROM orders

/* Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table. */
SELECT SUM(standard_amt_usd) standard_sum, SUM(gloss_amt_usd) gloss_sum
FROM orders

/* Solution */
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

/* Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator. */
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders


/* Questions: MIN, MAX, & AVERAGE */

/* Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept. */

/* When was the earliest order ever placed? You only need to return the date. */
SELECT MIN(occurred_at)
FROM orders

/* Try performing the same query as in question 1 without using an aggregation function. */
SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

/* When did the most recent (latest) web_event occur? */
SELECT MAX(occurred_at)
FROM web_events

/* Try to perform the result of the previous query without using an aggregation function. */
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

/* Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount. */
SELECT 
    AVG(standard_amt_usd) avg_standard_amt_usd,
    AVG(poster_amt_usd) avg_poster_amt_usd,
    AVG(gloss_amt_usd) avg_gloss_amt_usd,
    AVG(standard_qty) avg_standard_qty, 
    AVG(poster_qty) avg_poster_qty, 
    AVG(gloss_qty) avg_gloss_qty
FROM orders


/* Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders? */
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;


/* SQL Aggregations */

/* GROUP BY Note */
/* Now that you have been introduced to JOINs, GROUP BY, and aggregate functions, the real power of SQL starts to come to life. Try some of the below to put your skills to the test! */

/* Questions: GROUP BY */
/* Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept. */

/* One part that can be difficult to recognize is when it might be easiest to use an aggregate or one of the other SQL functionalities. Try some of the below to see if you can differentiate to find the easiest solution. */

/* 1. Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order. */
SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY o.occurred_at
LIMIT 1;

/* 2. Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name. */
SELECT a.name, SUM(o.total_amt_usd)
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name


/* 3. Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name. */

/* 4. Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used. */

/* 5. Who was the primary contact associated with the earliest web_event? */

/* 6. What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest. */

/* 7. Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps. */