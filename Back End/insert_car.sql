CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_car`( IN `_make` varchar(50), 
                                IN `_model` varchar(50),
                                IN `_year` int(4),
                                IN `_transmission` varchar(50),
                                IN `_drivetrain` varchar(50),
                                IN `_engine` varchar(50),
                                IN `_chassis` varchar(50))
BEGIN

INSERT INTO `car` VALUES(_make, _model, _year);

INSERT INTO `chassis_table` VALUES(_make, _model, _year, _chassis);

INSERT INTO `transmission_table` VALUES(_make, _model, _year, _transmission, _drivetrain);

INSERT INTO `engine_table` VALUES(_make, _model, _year, _engine);

END