USE lesson_4;

/*
1. Создайте таблицу users_old, аналогичную таблице users. 
Создайте процедуру, с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно).
*/

CREATE TABLE users_old LIKE users;

DELIMITER //

CREATE PROCEDURE move_user(IN user_id INT, OUT  tran_result varchar(100))
BEGIN
	
	DECLARE `_rollback` BIT DEFAULT b'0';
	DECLARE code varchar(100);
	DECLARE error_string varchar(100); 
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
  BEGIN
     SET _rollback = b'1';
     GET stacked DIAGNOSTICS CONDITION 1
    code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
  END;
    
    START TRANSACTION;
    INSERT INTO users_old SELECT * FROM users WHERE id = user_id;
    DELETE FROM users WHERE id = user_id;
    
    IF _rollback THEN
    SET tran_result = CONCAT('УПС. Ошибка: ', code, ' Текст ошибки: ', error_string);
    ROLLBACK;
  ELSE
    SET tran_result = 'O K';
    COMMIT;
  END IF;

END//
DELIMITER ;


/*
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
С 6:00 до 12:00 - "Доброе утро", 
с 12:00 до 18:00 - "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", 
с 00:00 до 6:00 — "Доброй ночи".
*/


DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello ()
RETURNS TINYTEXT READS SQL DATA
BEGIN
	DECLARE answer TINYTEXT;
	CASE
		WHEN CURTIME() > "18" THEN SET answer = "Добрый вечер";
		WHEN CURTIME() > "12" THEN SET answer = "Добрый день";
		WHEN CURTIME() > "6" THEN SET answer = "Доброе утро";
		WHEN CURTIME() > "0" THEN SET answer = "Доброй ночи";
	END CASE;
RETURN answer;
END 
//
DELIMITER ;

SELECT hello ();
