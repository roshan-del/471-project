CREATE DEFINER=`root`@`localhost` PROCEDURE `read_all_parts`(IN _make varchar(50), IN _model varchar(50), IN _year int(4))
BEGIN
SELECT * FROM car_part WHERE car_part.id IN 
	(SELECT f.part_id FROM fits AS f WHERE f.make = _make AND f.model = _model AND f.year = _year );
END