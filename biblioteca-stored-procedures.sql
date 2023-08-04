DELIMITER //
CREATE PROCEDURE OrderByParameterInTable(IN tableName VARCHAR(15), IN columnName VARCHAR(15), IN sortOrder VARCHAR(4))
BEGIN
	SET @parameter = CONCAT("SELECT * FROM ", tableName, " ORDER BY ", columnName, IF(sortOrder="desc", " DESC", " ASC"));
   
   PREPARE runSQL FROM @parameter;
   EXECUTE runSQL;
   DEALLOCATE PREPARE runSQL;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddBook(IN isbn INT, IN title VARCHAR(100), IN author_id INT, IN category_id INT, IN publication_date DATE)
BEGIN 
    INSERT INTO book (isbn, title, author_id, category_id, publication_date)
    VALUES (isbn, title, author_id, category_id, publication_date);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE PayFine(IN user_id INT)
BEGIN 
    UPDATE fine f
    INNER JOIN loan l ON f.loan_id = l.loan_id 
    SET f.paid = 1 
    where l.user_id = user_id; 
END //
DELIMITER ;