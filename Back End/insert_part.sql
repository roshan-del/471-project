CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_part`(
    IN `_part_id` int(2),
    IN `_name` varchar(50),
    IN `_price` decimal(10),
    IN `_category` varchar(20),
    IN `_retailer` varchar(50),
    IN `_rating` int(2)
)
BEGIN 
INSERT INTO `car_part` VALUES( _part_id, _name, _price, _rating, _category, _retailer);
END