DELIMITER //
CREATE TRIGGER before_loan_insert
BEFORE INSERT ON loan
FOR EACH ROW
BEGIN 
	DECLARE unpaid_fines INT;
    SELECT COUNT(*) INTO unpaid_fines
    FROM fine
    WHERE loan_id IN (SELECT loan_id FROM loan WHERE user_id = NEW.user_id) AND paid = 0;
    IF unpaid_fines > 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot loan book due to unpaid fines.';
	ELSE
		INSERT INTO loan_log(loan_id, session_user, action_type, session_date, session_time)
		VALUES (NEW.loan_id, CURRENT_USER(), "New loan",CURDATE(), CURTIME());
    END IF;    
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER after_fine_insert
AFTER INSERT ON fine
FOR EACH ROW
BEGIN 
	INSERT INTO fine_log(fine_id, session_user, action_type, session_date, session_time)
    VALUES (NEW.fine_id, CURRENT_USER(), "New Fine added" ,CURDATE(), CURTIME());
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER after_fine_update
AFTER UPDATE ON fine
FOR EACH ROW
BEGIN 
	INSERT INTO fine_log(fine_id, session_user, action_type, session_date, session_time)
    VALUES (NEW.fine_id, CURRENT_USER(), "Fine Paid" ,CURDATE(), CURTIME());
END //
DELIMITER ;
