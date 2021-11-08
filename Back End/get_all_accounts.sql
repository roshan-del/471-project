CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_accounts`()
BEGIN
SELECT id, email FROM account;
END