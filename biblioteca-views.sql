CREATE VIEW numberOfBooksPerAuthor AS
SELECT author.author_name, COUNT(book.isbn) as number_of_books
FROM author
JOIN book ON author.author_id = book.author_id
GROUP BY author_name;

CREATE VIEW booksAndCategories AS
SELECT c.category_name, b.title 
FROM category c
JOIN book b ON c.category_id = b.category_id;

CREATE VIEW borrowedBooks AS
SELECT b.title, lb.user_name, l.loan_date 
FROM book b
JOIN loan l ON b.isbn = l.isbn
JOIN library_user lb ON l.user_id = lb.user_id
WHERE l.status = "not returned";

CREATE VIEW unpaidFines AS
SELECT f.fine_amount, f.issued_date, lu.user_name, lu.user_id  FROM fine f
JOIN loan l ON l.loan_id = f.loan_id
JOIN library_user lu ON lu.user_id = l.user_id
WHERE f.paid = 0;

CREATE VIEW numberOfLoans AS
SELECT lu.user_name,  count(lu.user_name) as number_of_loans
FROM library_user lu
JOIN loan l ON l.user_id = lu.user_id
GROUP BY lu.user_name;

