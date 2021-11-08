CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_car`(IN `_make` varchar(50), 
                                IN `_model` varchar(50),
                                IN `_year` int(4))
BEGIN
DELETE FROM car
WHERE make = _make AND model = _model AND year = _year;
END