CREATE DEFINER=`root`@`localhost` PROCEDURE `get_guide`(IN `_title` varchar(255) )
BEGIN

SELECT * FROM guide 
WHERE title = _title;
SELECT * FROM step
WHERE title = _title;

END