CREATE DEFINER=`root`@`localhost` PROCEDURE `get_acc_info`(IN _id varchar(30))
BEGIN
SELECT * FROM account NATURAL JOIN mechanic WHERE account.id = _id;
END