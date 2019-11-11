
{} = comment, not part of syntax





BASICS
=========================================================
show Databases to use
-->SHOW DATABASES;

Create Database
--> CREATE <database_name>;

Use Database
--> USE <database_name>;

Delete Database
--> DROP <database_name>

Show which Database is used
--> SELECT database();

Show the name of the Tables the used Database
--> SHOW TABLES;

Create Table in used database_name with argument like length of String. NOT NULL means it cant be NULL.
--> CREATE TABLE <table_name> (<name_column_1> <Datatype(arg)> NOT NULL {optional} DEFAULT arg {arg=datatype}), <name_column_2> <Datatype>, PRIMARY KEY (<name_column_1>){<set name_column_1 as the primary Key});

Show Table in used database_name
--> SHOW COLUMNS FROM <table_name>;
--> DESC tablename;

Delete Table
--> DROP TABLE <table_name>;

Insert Data into a Table (Bulk Insert)
--> INSERT INTO <table_name> (<name_column_1>, <name_column_2>) VALUES ('VALUE1', 'VALUE2'), ('VALUE1', 'VALUE2'), ...;

Retrieve Data
--> Select * 

If a Warning exists after Operation, show Warning
 SHOW WARNINGS;



IF NO NULL is specified and a Value is missing in an insert statement, a Warning is given and e.g. for Strings NULL is replaced with an empty String
IF a default Value is specified, a missing Value is replaced with the default value. The Default Default is NULL



Define a table with a PRIMARY KEY constraint and AUTO_INCREMENT leads to automatically incrementing primary keys:
--> CREATE TABLE <table_name> (
    <name_column_1> INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    PRIMARY KEY (<name_column_1>)
);


EXAMPLE WITH everything
CREATE TABLE employees (
    id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    age INT NOT NULL,
    current_status VARCHAR(255) NOT NULL DEFAULT 'employed',
    PRIMARY KEY(id)
);

===========================================================
CRUD
===========================================================

READ
SELECT - FROM - WHERE

ALIAS 
relabel the column name from cat_id to id for the returned data (important for JOINS)
--> SELECT name AS 'cat name', breed AS 'kitty breed' FROM cats;

UPDATE
-->UPDATE cats SET breed='shorthair' WHERE breed'Tabby'

DELETE
delete the hole entry
--> DELETE FROM cats Where name='EGG'
Delete everything
--> DELETE FROM cats

CREATE 
-->INSERT INTO cats (age, name, breed) VALUES (12, 'dumbledoore', shorthair);


================================================================
String Functions
==========================================================0======

select and Concat a part of a string from a db with some other string value (stringfunctions--> see documentation from mysql)
--> SELECT CONCAT
    (
        SUBSTRING(title, 1, 10),
        '...'
    ) AS 'short title'
FROM books;


 Select Replace










CREATE TABLE shirtstable(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(255) NOT NULL,
    color VARCHAR(20) NOT NULL,
    shirt_size VARCHAR(1) NOT NULL,
   last_worn INT DEFAULT 0 NOT NULL
);

Insert Into shirtstable (article, color, shirt_size, last_worn) VALUES 
('t-shirt', 'white', 'S', 10),
('t-shirt', 'green', 'S', 200),
('polo shirt', 'purple', 'M', 50);


SELECT article, color FROM shirtstable;

UPDATE shirtstable SET shirt_size='L' WHERE article='polo shirt';

UPDATE shirtstable SET shirt_size='XS', color='off white' WHERE color='white';

DELETE FROM shirtstable where last_worn>=200;

DELETE FROM shirtstable;

DROP TABLE shirtstable;

--=============String Functions================
--Replace every e with an 3 of the substring of the first 10 letters of title-column
SELECT
    SUBSTRING(REPLACE(title, 'e', '3'), 1, 10)
FROM books;


--Reverse 
--Show all author names reversed
Select 
    Reverse (author_name)
FROM books;

-- CHAR-Length
SELECT 
    author_name CHAR_LENGTH (author_name) 
AS 'length' FROM books;

SELECT 
    CONCAT(author_fname, ' ', 'is', ' ' CHAR_LENGTH(author_fname), ' ', 'characters', ' ', 'long')
FROM books;

-- lower(), upper>()
SELECT UPPER('Hello World');
 -- "HELLO WORLD"
SELECT LOWER('Hello World');
 -- 'hello world'
SELECT UPPER(title) FROM books;

--====================
Select Reverse (upper('Why does my cat loog at me with such hatred'));


--I-like-cats

SELECT REPLACE (title, ' ', '->') from books;

SELECT author_lname as 'forwards', Reverse(author_lname) AS 'backwards' from books;

SELECT CONCAT (title, ' was released in ', released_year) AS blurb from books

SELECT Count(*) from books;
--gibt summe aller bücher wieder, hinter count(*) kein leerzeichen!!! ansonsten, function not found

-- DISTINCT
SELECT DISTINCT author_lname from books;
--Gibt jeden Namen nur einmal an, wenn ein author mehrere Bücher veröffentlicht hat

SELECT DISTINCT author_lname, author_fname from books;
-- returns distinct full-name combination





--========================
--Order by
SELECT  author_lname from books ORDER BY author_lname;
-- returns column in an ascending order 

--==============================
---Order by extended
SELECT  author_lname from books ORDER BY author_lname DESC;
-- returns column in an Descending order

SELECT  author_lname, author_fname from books ORDER BY 2;
-- returns columns orderd by the second (2) Argument (author_lname, author:fname)

SELECT  author_lname, author_fname from books ORDER BY author_fname, author_lname;
-- returns columns orderd first by author_fname then by author author_lname

--======================================0
--limit
SELECT  title, released_year FROM books ORDER BY released_year DESC LIMIT 2;
-- returns the top 2 of descending ordered books by year

SELECT title, released_year FROM books  ORDER BY released_year DESC LIMIT 10,1;
--returns the first 1o ordered by year books

--======================================


SELECT title, author_fname FROM books WHERE author_fname LIKE '%da%';
 -- in the authors name there are letters da
SELECT title, author_fname FROM books WHERE author_fname LIKE 'da%';
-- all author who start with da (% means 'something') '%da' would mean it ends with da

 
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '____';
--selects elements where the value has exactly 4 digits
 
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '__';
--selects elements where the value has exactly 2 digits


(235)234-0987 LIKE '(___)___-____'
 --in order to match a certain Format, _ means a wildcard digit
 
SELECT title FROM books WHERE title LIKE '%\%%'
--if u looking for % as one of the digits use \, since it would otherwise mean "look for anything"
 
SELECT title FROM books WHERE title LIKE '%\_%'
-- same with this

--==================================
--aggegate function
--==================================
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
--group by in verbingung mit count(*) gibt die anzahl der elemente je released_year aus. 

SELECT COUNT(DISTINCT author_lname) FROM books;
-- anzahl einzigartiger authoren