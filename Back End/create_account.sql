CREATE DEFINER=`root`@`localhost` PROCEDURE `create_account`(
    IN `_name` varchar(30),
    IN `_password` varchar(50),
    IN `_email` varchar(50),
    IN `_doc` varchar(20),
    IN `_address` varchar(255),
    IN `_cert` varchar(255),
    IN `_shop` varchar(255)
)
BEGIN

INSERT INTO `account`
VALUES(_name, _password, _email, _doc);

IF (_address is NOT NULL) THEN

INSERT INTO `mechanic` VALUES (_name, _address);

END IF;

IF (_cert != 'NULL' AND _shop != 'NULL')

THEN INSERT INTO `professional` VALUES (_name, _cert, _shop);

END IF;

IF (_cert LIKE 'NULL' AND _shop LIKE 'NULL')

THEN INSERT INTO `amateur`(id) VALUES (_name);

END IF;

END