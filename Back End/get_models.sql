CREATE DEFINER=`root`@`localhost` PROCEDURE `get_models`(IN `_make` varchar(50))
BEGIN
SELECT DISTINCT c.model FROM car AS c
WHERE c.make = _make;
END