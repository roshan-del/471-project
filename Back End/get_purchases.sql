CREATE DEFINER=`root`@`localhost` PROCEDURE `get_purchases`(IN `_id` varchar(30))
BEGIN
SELECT part_id, retailer_name, date, transaction_no
FROM purchases 
WHERE account_id = _id;
END