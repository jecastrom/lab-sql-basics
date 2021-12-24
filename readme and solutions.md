![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Lab | SQL basics (selection and aggregation)     
Go to:
- <a href="#Query-1">Query 1</a>
- <a href="#Query-2">Query 2</a>
- <a href="#Query-3">Query 3</a>
- <a href="#Query-4">Query 4</a>
- <a href="#Query-5">Query 5</a>
- <a href="#Query-6">Query 6</a>
- <a href="#Query-7">Query 7</a>
- <a href="#Query-8">Query 8</a>
- <a href="#Query-9">Query 9</a>
- <a href="#Query-10">Query 10</a>
- <a href="#Query-11">Query 11</a>
- <a href="#Query-12">Query 12</a>
- <a href="#Query-15">Query 15</a>
- <a href="#Query-16">Query 16</a>
- <a href="#Query-17">Query 17</a>
- <a href="#Query-18">Query 18</a>
- <a href="#Query-20">Query 20</a>
- <a href="#Query-21">Query 21</a>

## Introduction

In this lab, you will be using the `files_for_lab/mysql_dump.sql` database. Load it to Sequel Pro, and there you will find a `bank` database which we will use for the following exercise.

Here, we will practice selecting and projecting data. You can finish all questions with only those clauses:

- `SELECT`
- `SELECT DISTINCT`
- `FROM`
- `WHERE`
- `ORDER BY`
- `LIMIT`

You can save your solutions in a file `solutions.sql`.

## Instructions

Assume that any `_id` columns are incremental, meaning that higher ids always occur after lower ids. For example, a client with a higher `client_id` joined the bank after a client with a lower `client_id`.

### Query 1

Get the `id` values of the first 5 clients from `district_id` with a value equals to 1.

Expected result:

```shell
2
3
22
23
28

```
#### Answer:
```sql
SELECT
    client_id
FROM
    client
WHERE
    district_id = 1
LIMIT
    5;
```
![image](https://user-images.githubusercontent.com/63274055/147350639-c8430797-5c4c-48e1-81ff-729b80c32018.png)
<a href="#Lab-|-SQL-basics-(selection-and-aggregation)">Back to Top</a>



### Query 2

In the `client` table, get an `id` value of the last client where the `district_id` equals to 72.

Expected result:

```shell
13576
```
### Answer:
```sql
SELECT
    max(client_id)
FROM
    client
WHERE
    district_id = 72;
```
![image](https://user-images.githubusercontent.com/63274055/147351629-c494dbe3-83d0-4eeb-89b6-79fe44622ed9.png)



### Query 3

Get the 3 lowest amounts in the `loan` table.

Expected result:

```shell
4980
5148
7656
```
#### Answer
```sql
SELECT
    amount
FROM
    loan
ORDER BY
    amount ASC
LIMIT
    3;
```
#### Answer:
```sql
SELECT
    DISTINCT(STATUS)
FROM
    loan
ORDER BY
    STATUS ASC;
```


### Query 4

What are the possible values for `status`, ordered alphabetically in ascending order in the `loan` table?

Expected result:

```shell
A
B
C
D
```
#### Answer:
```sql
SELECT
    DISTINCT(STATUS)
FROM
    loan
ORDER BY
    STATUS ASC;
```


### Query 5

What is the `loan_id` of the highest payment received in the `loan` table?

Expected result:

```shell
6312
```
#### Answer:

I believe there is a mistake in the expected answer. The `loan_id` 6312 corresponds to the lowest payment

if run this query:
```sql
SELECT
    loan_id,
    payments
FROM
    loan
ORDER BY
    payments ASC;
```
![image](https://user-images.githubusercontent.com/63274055/147358693-f964e6bd-bc4e-4700-83b5-4b136bec08b7.png)

we can see that the lowest payment of 304 corresponds with the `loan_id` 6312.        
If we run the same query in DESC order:      
```sql
SELECT
    loan_id,
    payments
FROM
    loan
ORDER BY
    payments DESC;
```
![image](https://user-images.githubusercontent.com/63274055/147358732-3fba9730-ff4d-4120-a955-571ce334fcf5.png)

The highest payment of 9910 corresponds to the `loan_id` 6415.     

So my answer query would be:
```sql
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
```
![image](https://user-images.githubusercontent.com/63274055/147358889-bdcd876c-6ac0-408b-98b3-02ca2d37267e.png)




### Query 6

What is the loan `amount` of the lowest 5 `account_id`s in the `loan` table? Show the `account_id` and the corresponding `amount`

Expected result:

```shell
#id     amount
2	    80952
19	    30276
25	    30276
37	    318480
38	    110736
```
#### Answer:

```sql
SELECT
    account_id,
    amount
FROM
    loan
ORDER BY
    account_id ASC
LIMIT
    5;
```

### Query 7

What are the `account_id`s with the lowest loan `amount` that have a loan `duration` of 60 in the `loan` table?

Expected result:

```shell
10954
938
10711
1766
10799
```
#### Answer:
```sql
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
```

### Query 8

What are the unique values of `k_symbol` in the `order` table?

Note: There shouldn't be a table name `order`, since `order` is reserved from the `ORDER BY` clause. You have to use backticks to escape the `order` table name.

Expected result:

```shell
LEASING
POJISTNE
SIPO
UVER
```
#### Answer:
```sql
SELECT
    DISTINCT k_symbol
FROM
    `order`
ORDER BY
    k_symbol ASC;
```


### Query 9

In the `order` table, what are the `order_id`s of the client with the `account_id` 34?

Expected result:

```shell
29445
29446
29447
```
#### Answer:
```sql
SELECT
    order_id
FROM
    `order`
WHERE
    account_id = 34
```

### Query 10

In the `order` table, which `account_id`s were responsible for orders between `order_id` 29540 and `order_id` 29560 (inclusive)?

Expected result:

```shell
88
90
96
97
```
#### Answer:
```sql
SELECT
    DISTINCT(account_id)
FROM
    `order`
WHERE
    order_id BETWEEN 29540
    AND 29560;
```

### Query 11

In the `order` table, what are the individual amounts that were sent to (`account_to`) id 30067122?

Expected result:

```shell
5123
```
#### Answer:
```sql
SELECT
    amount
FROM
    `order`
WHERE
    account_to = 30067122;
```

### Query 12

In the `trans` table, show the `trans_id`, `date`, `type` and `amount` of the 10 first transactions from `account_id` 793 in chronological order, from newest to oldest.

Expected result:

```shell
3556468	981231	PRIJEM	78.6
233254	981216	VYDAJ	600
233104	981212	VYDAJ	1212
233248	981211	VYDAJ	851
233176	981207	VYDAJ	204
3556467	981130	PRIJEM	75.1
233395	981130	VYDAJ	14.6
233103	981112	VYDAJ	1212
233247	981111	VYDAJ	851
233175	981107	VYDAJ	204
```
#### Answer:
```sql
SELECT
    trans_id,
    date,
    TYPE,
    amount
FROM
    trans
WHERE
    account_id =(793)
ORDER BY
    date DESC
LIMIT
    10;
```
![image](https://user-images.githubusercontent.com/63274055/147369288-a87a6a3d-b655-469e-8681-131918e1e3bb.png)



### Query 13

In the `client` table, of all districts with a `district_id` lower than 10, how many clients are from each `district_id`? Show the results sorted by the `district_id` in ascending order.

Expected result:

```shell
1	663
2	46
3	63
4	50
5	71
6	53
7	45
8	69
9	60
```

### Query 14

In the `card` table, how many cards exist for each `type`? Rank the result starting with the most frequent `type`.

Expected result:

```shell
classic	659
junior	145
gold	88
```

### Query 15

Using the `loan` table, print the top 10 `account_id`s based on the sum of all of their loan amounts.

Expected result:

```shell
7542	590820
8926	566640
2335	541200
817	    538500
2936	504000
7049	495180
10451	482940
6950	475680
7966	473280
339	    468060
```

### Query 16

In the `loan` table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.

Expected result:

```
930906	1
930803	1
930728	1
930711	1
930705	1
```

### Query 17

In the `loan` table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.

Expected result:

```shell
971206	24	1
971206	36	1
971208	12	3
971209	12	1
971209	24	1
971210	12	1
971211	24	1
971211	48	1
971213	24	1
971220	36	1
971221	36	1
971224	60	1
971225	24	1
971225	60	1
```

### Query 18

In the `trans` table, for `account_id` 396, sum the amount of transactions for each type (`VYDAJ` = Outgoing, `PRIJEM` = Incoming). Your output should have the `account_id`, the `type` and the sum of amount, named as `total_amount`. Sort alphabetically by type.

Expected result:

```shell
396	PRIJEM	1028138.6999740601
396	VYDAJ	1485814.400024414
```

### Query 19

From the previous output, translate the values for `type` to English, rename the column to `transaction_type`, round `total_amount` down to an integer

Expected result:

```shell
396	INCOMING	1028138
396	OUTGOING	1485814
```

### Query 20

From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference.

Expected result:

```shell
396	1028138	1485814	-457676
```

### Query 21

Continuing with the previous example, rank the top 10 `account_id`s based on their difference.

Expected result:

```shell
9707	869527
3424	816372
3260	803055
2486	735219
1801	725382
4470	707243
3674	703531
9656	702786
2227	696564
6473	692580
```
