CREATE DEFINER=`root`@`localhost` PROCEDURE `get_categories`()
BEGIN
SELECT * FROM category;
END