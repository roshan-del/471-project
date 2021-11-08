CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_account`(IN _id varchar(30))
BEGIN  
DELETE FROM account  
WHERE  id = _id;
END