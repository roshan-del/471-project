CREATE DEFINER=`root`@`localhost` PROCEDURE `get_years`(IN `_make` varchar(50), IN `_model` varchar(50))
BEGIN
SELECT DISTINCT c.year FROM car AS c
WHERE c.make = _make AND c.model = _model;
END