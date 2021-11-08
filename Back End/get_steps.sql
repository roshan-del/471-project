CREATE DEFINER=`root`@`localhost` PROCEDURE `get_steps`(IN _title varchar(255))
BEGIN

SELECT * FROM step
WHERE guide = _title
ORDER BY number ASC;
END