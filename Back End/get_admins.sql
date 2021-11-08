CREATE DEFINER=`root`@`localhost` PROCEDURE `get_admins`()
BEGIN
SELECT id FROM admin;
END