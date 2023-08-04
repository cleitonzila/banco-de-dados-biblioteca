DELIMITER $$
CREATE FUNCTION totalUserFine(userID INT) RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE totalFine FLOAT;
    SELECT COALESCE(SUM(fine_amount), 0) INTO totalFine
    FROM fine f
    JOIN loan l ON l.loan_id = f.loan_id
	WHERE l.user_id = userID AND f.paid = 0;
	RETURN totalFine;
END
$$


DELIMITER $$
CREATE FUNCTION totalUserBooksHolding(userId INT) RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE totalBooks INT;
    SELECT COUNT(*) INTO totalBooks 
    FROM loan l
	WHERE l.user_id = userID AND l.status = 'not returned';
	RETURN totalBooks;
END
$$