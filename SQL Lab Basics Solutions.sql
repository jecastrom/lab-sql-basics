/*
 Instructions:      
 
 Assume that any _id columns are incremental, meaning that higher ids always occur
 after lower ids. For example, a client with a higher client_id joined the bank after 
 a client with a lower client_id.
 
 Query 1
 Get the id values of the first 5 clients from district_id with a value equals to 1.
 */
SELECT
    client_id
FROM
    client
WHERE
    district_id = 1
LIMIT
    5;
/*
 Query 2
 In the client table, get an id value of the last client where the district_id equals to 72.
 */
SELECT
    max(client_id)
FROM
    client
WHERE
    district_id = 72;
/*
 Query 3
 Get the 3 lowest amounts in the loan table.
 */
SELECT
    amount
FROM
    loan
ORDER BY
    amount ASC
LIMIT
    3;
/*
 Query 4
 What are the possible values for status, ordered alphabetically in ascending order in the loan table?
 */
SELECT
    DISTINCT(STATUS)
FROM
    loan
ORDER BY
    STATUS ASC;
/*
 Query 5
 What is the loan_id of the highest payment received in the loan table?
 */
SELECT
    loan_id
FROM
    loan
WHERE
    payments = (
        SELECT
            max(payments)
        FROM
            loan
    );
/*
 Query 6:
 
 What is the loan amount of the lowest 5 account_ids in the 
 loan table? Show the account_id and the corresponding amount
 */
SELECT
    account_id,
    amount
FROM
    loan
ORDER BY
    account_id ASC
LIMIT
    5;
/*
 Query 7
 What are the account_ids with the lowest loan amount 
 that have a loan duration of 60 in the loan table?
 */
SELECT
    account_id
FROM
    loan
WHERE
    duration = 60
ORDER BY
    amount ASC
LIMIT
    5;
/*
 Query 8
 What are the unique values of k_symbol in the order table?
 
 Note: There shouldn't be a table name order, since order is 
 reserved from the ORDER BY clause. You have to use backticks 
 to escape the order table name.
 */
SELECT
    DISTINCT k_symbol
FROM
    `order`
ORDER BY
    k_symbol ASC;
/*
 Query 9
 In the order table, what are the order_ids of the 
 client with the account_id 34?
 */
SELECT
    order_id
FROM
    `order`
WHERE
    account_id = 34