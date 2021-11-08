CREATE DEFINER=`root`@`localhost` PROCEDURE `read_all_cars`()
BEGIN
SELECT * FROM car;
END