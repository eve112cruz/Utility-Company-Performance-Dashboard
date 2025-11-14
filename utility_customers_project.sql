CREATE TABLE clean_utility_table
LIKE utility_customers_dirty;

SELECT *
FROM clean_utility_table;

INSERT clean_utility_table
SELECT *
FROM utility_customers_dirty;

SELECT *
FROM clean_utility_table;

SELECT *,
ROW_NUMBER () OVER(
PARTITION BY `customer_id`, `name`, `phone`, `address`, `city`, `state`, `zip`, `email`, `account_open_date`, `last_payment_date`,
`monthly_usage_kwh`, `monthly_bill`, `service_type`, `status`, `company`, `ip_address`, `browser`, `language`) AS row_num
FROM clean_utility_table;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER(
PARTITION BY `customer_id`, `name`, `phone`, `address`, `city`, `state`, `zip`, `email`, `account_open_date`, `last_payment_date`,
`monthly_usage_kwh`, `monthly_bill`, `service_type`, `status`, `company`, `ip_address`, `browser`, `language`) AS row_num
FROM clean_utility_table
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM clean_utility_table;

SELECT *
FROM utility_customers_dirty
LIMIT 20;

SELECT DISTINCT monthly_bill
FROM utility_customers_dirty
ORDER BY monthly_bill;

SELECT 
    monthly_bill,
    TRIM(
        REPLACE(
            REPLACE(monthly_bill, '$', ''),
        'USD', '')
    ) AS cleaned_test
FROM utility_customers_dirty
LIMIT 20;

ALTER TABLE clean_utility_table
ADD COLUMN monthly_bill_clean DECIMAL(10,2);

UPDATE clean_utility_table
SET monthly_bill_clean = CAST(
    REPLACE(
        REPLACE(
            TRIM(monthly_bill),
        '$', ''),
    'USD', '') AS DECIMAL(10,2)
);

SELECT monthly_bill, monthly_bill_clean
FROM clean_utility_table
LIMIT 20;

SELECT *
FROM clean_utility_table;

ALTER TABLE clean_utility_table
ADD COLUMN phone_clean VARCHAR(20);


SELECT 
    phone AS original,
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(TRIM(phone), '.', ''), '-', ''
            ), ' ', ''
        ), '+1', ''
    ) AS numbers_only
FROM clean_utility_table
LIMIT 20;


UPDATE clean_utility_table
SET phone_clean = CONCAT(
    SUBSTRING(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(phone, '.', ''), '-', ''
                ), ' ', ''
            ), '+1', ''
        ), 1, 3
    ), '-',
    SUBSTRING(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(phone, '.', ''), '-', ''
                ), ' ', ''
            ), '+1', ''
        ), 4, 3
    ), '-',
    SUBSTRING(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(phone, '.', ''), '-', ''
                ), ' ', ''
            ), '+1', ''
        ), 7, 4
    )
);


SELECT phone AS original, phone_clean
FROM clean_utility_table
LIMIT 20;

SELECT name, address
FROM clean_utility_table
Limit 20;

ALTER TABLE clean_utility_table
ADD COLUMN name_clean VARCHAR(100);

UPDATE clean_utility_table
SET name_clean = TRIM(LOWER(name));


SELECT name, name_clean
FROM clean_utility_table
LIMIT 20;

SELECT address
FROM clean_utility_table
LIMIT 20;

ALTER TABLE clean_utility_table
ADD COLUMN address_clean VARCHAR(255);

UPDATE clean_utility_table
SET address_clean = TRIM(LOWER(address));

SELECT address, address_clean
FROM clean_utility_table
LIMIT 15;

SELECT DISTINCT language
FROM clean_utility_table
ORDER BY language;

ALTER TABLE clean_utility_table
ADD COLUMN language_clean VARCHAR(10);

UPDATE clean_utility_table
SET language_clean = TRIM(LOWER(language));

UPDATE clean_utility_table
SET language_clean = CASE
    WHEN language_clean = 'en' THEN 'en-us'
    WHEN language_clean = 'es' THEN 'es-es'
    WHEN language_clean = 'fr' THEN 'fr-fr'
    ELSE language_clean
END;

UPDATE clean_utility_table
SET language_clean = CONCAT(
    SUBSTRING(language_clean, 1, 2),
    '-',
    UPPER(SUBSTRING(language_clean, 4, 2))
);


SELECT DISTINCT language_clean
FROM clean_utility_table
ORDER BY language_clean;

SELECT DISTINCT browser
FROM clean_utility_table
ORDER BY browser;

SELECT browser
FROM clean_utility_table
WHERE browser LIKE ' %' OR browser LIKE '% ';

SELECT DISTINCT company
FROM clean_utility_table
ORDER BY company;

SELECT *
FROM clean_utility_table
WHERE company IS NULL 
   OR TRIM(company) = '';

UPDATE clean_utility_table
SET company = 'Unknown'
WHERE company IS NULL 
   OR TRIM(company) = '';

ALTER TABLE clean_utility_table
ADD COLUMN company_clean VARCHAR(100);

UPDATE clean_utility_table
SET company_clean = TRIM(LOWER(company));

SELECT company, company_clean
FROM clean_utility_table
LIMIT 15;

SELECT 
    account_open_date, 
    last_payment_date
FROM clean_utility_table
LIMIT 10;

ALTER TABLE clean_utility_table
ADD COLUMN account_open_date_clean DATE,
ADD COLUMN last_payment_date_clean DATE;

UPDATE clean_utility_table
SET account_open_date_clean = STR_TO_DATE(account_open_date, '%M %d, %Y')
WHERE account_open_date LIKE '%,%';

UPDATE clean_utility_table
SET account_open_date_clean = STR_TO_DATE(account_open_date, '%m/%d/%Y')
WHERE account_open_date LIKE '%/%';

UPDATE clean_utility_table
SET account_open_date_clean = STR_TO_DATE(account_open_date, '%d-%b-%Y')
WHERE account_open_date LIKE '%-%' AND account_open_date REGEXP '[A-Za-z]';

UPDATE clean_utility_table
SET account_open_date_clean = account_open_date
WHERE account_open_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

SELECT account_open_date, account_open_date_clean
FROM clean_utility_table
LIMIT 15;

UPDATE clean_utility_table
SET last_payment_date_clean = STR_TO_DATE(last_payment_date, '%M %d, %Y')
WHERE last_payment_date LIKE '%,%';

UPDATE clean_utility_table
SET last_payment_date_clean = STR_TO_DATE(last_payment_date, '%m/%d/%Y')
WHERE last_payment_date LIKE '%/%';

UPDATE clean_utility_table
SET last_payment_date_clean = STR_TO_DATE(last_payment_date, '%d-%b-%Y')
WHERE last_payment_date LIKE '%-%' AND last_payment_date REGEXP '[A-Za-z]';

UPDATE clean_utility_table
SET last_payment_date_clean = last_payment_date
WHERE last_payment_date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

SELECT last_payment_date, last_payment_date_clean
FROM clean_utility_table
LIMIT 15;

SELECT *
FROM clean_utility_table;

SELECT DISTINCT status, service_type, state
FROM clean_utility_table;

SELECT zip, monthly_usage_kwh
FROM clean_utility_table
LIMIT 15;

UPDATE clean_utility_table
SET state = UPPER(TRIM(state));

SELECT zip, LEFT(zip, 5) AS new_zip
FROM clean_utility_table
LIMIT 20;

UPDATE clean_utility_table
SET zip = LEFT(zip, 5);

UPDATE clean_utility_table
SET zip = 'Unknown'
WHERE zip IS NULL OR zip = '';

SELECT *
FROM clean_utility_table
WHERE monthly_usage_kwh IS NULL
   OR monthly_usage_kwh = ''
   OR monthly_usage_kwh = 0
   OR monthly_usage_kwh > 10000;

ALTER TABLE clean_utility_table
DROP COLUMN name,
DROP COLUMN address,
DROP COLUMN company,
DROP COLUMN language,
DROP COLUMN browser,
DROP COLUMN account_open_date,
DROP COLUMN last_payment_date;

ALTER TABLE clean_utility_table
CHANGE COLUMN name_clean name VARCHAR(100),
CHANGE COLUMN address_clean address VARCHAR(255),
CHANGE COLUMN company_clean company VARCHAR(100),
CHANGE COLUMN language_clean language VARCHAR(10),
CHANGE COLUMN account_open_date_clean account_open_date DATE,
CHANGE COLUMN last_payment_date_clean last_payment_date DATE;

ALTER TABLE clean_utility_table
ADD COLUMN browser TEXT;

UPDATE clean_utility_table c
JOIN utility_customers_dirty o
ON c.customer_id = o.customer_id
SET c.browser = o.browser;

SELECT customer_id, browser
FROM clean_utility_table
LIMIT 15;


UPDATE clean_utility_table
SET browser = LOWER(TRIM(browser));

SELECT DISTINCT browser
FROM clean_utility_table;


UPDATE clean_utility_table
SET browser = LOWER(TRIM(browser));


ALTER TABLE clean_utility_table
DROP COLUMN phone;

ALTER TABLE clean_utility_table
CHANGE COLUMN phone_clean phone VARCHAR(20);

SELECT *
FROM clean_utility_table;
