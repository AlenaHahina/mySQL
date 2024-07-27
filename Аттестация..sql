-- 1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
USE lesson_1;

DELIMITER $$ -- //

CREATE FUNCTION format_seconds(seconds INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
  DECLARE days INT;
  DECLARE hours INT;
  DECLARE minutes INT;
  DECLARE remaining_seconds INT;

  SET days = FLOOR(seconds / (24 * 60 * 60));
  SET remaining_seconds = seconds % (24 * 60 * 60);
  SET hours = FLOOR(remaining_seconds / (60 * 60));
  SET remaining_seconds = remaining_seconds % (60 * 60);
  SET minutes = FLOOR(remaining_seconds / 60);
  SET remaining_seconds = remaining_seconds % 60;

  RETURN CONCAT(
    IF(days > 0, CONCAT(days, ' days '), ''),
    IF(hours > 0, CONCAT(hours, ' hours '), ''),
    IF(minutes > 0, CONCAT(minutes, ' minutes '), ''),
    IF(remaining_seconds > 0, CONCAT(remaining_seconds, ' seconds '), '')
  );
END $$ -- //

DELIMITER ;
SELECT format_seconds(123456);



-- 2. Выведите только чётные числа от 1 до 10.
-- Пример: 2,4,6,8,10
DROP PROCEDURE even_numbers;
DELIMITER //

CREATE PROCEDURE even_numbers(num INT)
BEGIN
  DECLARE i INT DEFAULT 1;
  DECLARE output VARCHAR(100) DEFAULT '';
  WHILE i <= 10 DO
    IF i % 2 = 0 THEN
      SET output = CONCAT(output, i, ', ');
    END IF;
    SET i = i + 1;
  END WHILE;
  SELECT SUBSTRING(output, 1, LENGTH(output) - 2);
END //

DELIMITER ;

CALL even_numbers(10);
