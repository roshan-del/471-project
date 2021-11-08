CREATE DEFINER=`root`@`localhost` PROCEDURE `get_car_issues`(IN `_make` varchar(50), 
                                IN `_model` varchar(50),
                                IN `_year` int(4))
BEGIN

SELECT issue_name, description FROM issue 
WHERE issue_name IN
(SELECT name FROM has 
WHERE make = _make AND model = _model AND year = _year);
END