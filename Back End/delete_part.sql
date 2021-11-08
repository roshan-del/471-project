CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_part`(IN `_part_id` int(2),
                                IN `_name` varchar(50) )
BEGIN
DELETE FROM car_part 
WHERE id = _part_id AND name = _name;
END