CREATE DEFINER=`root`@`localhost` PROCEDURE `get_makes`()
BEGIN
SELECT DISTINCT make FROM car;
END