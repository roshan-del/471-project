CREATE DEFINER=`root`@`localhost` PROCEDURE `get_admin_info`(IN _id varchar(30))
BEGIN
SELECT id, password FROM account WHERE id IN (SELECT admin.id FROM admin WHERE _id = admin.id);
END