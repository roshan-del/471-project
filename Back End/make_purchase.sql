CREATE DEFINER=`root`@`localhost` PROCEDURE `make_purchase`(
	IN _part_id int(3),
    IN _retailer varchar(50),
    IN _id varchar(30),
    IN _date varchar(10)
)
BEGIN

INSERT INTO `purchases` (part_id, retailer_name,account_id,date)VALUES (_part_id,_retailer,_id, _date);

END