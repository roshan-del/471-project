CREATE DEFINER=`root`@`localhost` PROCEDURE `get_retailers`()
BEGIN
SELECT * FROM retailer;
END