CREATE DEFINER=`root`@`localhost` PROCEDURE `read_one_part`(IN `_part_id` int(2), IN `_part_name` varchar(50))
BEGIN
SELECT * FROM car_part 
WHERE id = _part_id AND name = _part_name;
END