-- Init
CREATE DATABASE IF NOT EXISTS `Project`;
USE `Project`;

/* Table Creations*/

CREATE TABLE IF NOT EXISTS `retailer` (
    `name` varchar(50) NOT NULL,
    `phone_no` varchar(15) NOT NULL UNIQUE,
    `rating` int(2),
    `warehouse_location` varchar(255) NOT NULL,
    PRIMARY KEY (`name`)
);

CREATE TABLE IF NOT EXISTS `category`(
    `title` varchar(50) NOT NULL,
    `parent_title` varchar(50),
    PRIMARY KEY (`title`), 
    FOREIGN KEY (`parent_title`) REFERENCES `category` (`title`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `car_part` (
    `id` int(2) NOT NULL,
    `name` varchar(50) NOT NULL,
    `price` decimal(10) NOT NULL,
    `rating` int(3),
    `category` varchar(20) NOT NULL,
    `retailer` varchar(50) NOT NULL,
    PRIMARY KEY (`id`, `name`),
    FOREIGN KEY (`category`) REFERENCES `category` (`title`) ON DELETE CASCADE,
    FOREIGN KEY (`retailer`) REFERENCES `retailer` (`name`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `account` (
    `id` varchar(30) NOT NULL,
    `password` varchar(50) NOT NULL,
    `email` varchar(50) NOT NULL,
    `date_of_creation` varchar(20) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `admin` (
    `id` varchar(30) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id`) REFERENCES `account` (`id`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `mechanic` (
    `id` varchar(30) NOT NULL,
    `shipping_address` varchar(255) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id`) REFERENCES `account` (`id`)  ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `professional` (
    `id` varchar(30) NOT NULL,
    `certification` varchar(255) NOT NULL,
    `shop_name` varchar(255) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id`) REFERENCES `mechanic` (`id`)  ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `amateur` (
    `id` varchar(30) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`id`) REFERENCES `mechanic` (`id`)  ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS `issue`(
    `issue_name` varchar(50) NOT NULL,
    `description` varchar(255) NOT NULL,
    `commoness` int(2) NOT NULL,
    `severity` int(2) NOT NULL,
    `difficulty` int(2),
    `part_id` int(2),
    `part_name` varchar(50),
    PRIMARY KEY (`issue_name`),
    FOREIGN KEY (`part_id`,`part_name`) REFERENCES `car_part` (`id`,`name`)  ON DELETE SET NULL
   
);

CREATE TABLE IF NOT EXISTS `guide` (
    `avg_rate` decimal(30) NOT NULL,
    `title` varchar(255) NOT NULL,
    `article` varchar(255),
    `video` varchar(255),
    `pro_id` varchar(30) NOT NULL,
    `admin_id` varchar(30) NOT NULL,
    `issue_name` varchar(50) NOT NULL,
    PRIMARY KEY (`title`),
    FOREIGN KEY (`pro_id`) REFERENCES `professional` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`issue_name`) REFERENCES `issue` (`issue_name`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `step` (
    `title` varchar(50) NOT NULL,
    `number` int(2) NOT NULL,
    `description` varchar(255) NOT NULL,
    `guide` varchar(50) NOT NULL,
    PRIMARY KEY (`title`),
    FOREIGN KEY (`guide`) REFERENCES `guide` (`title`)  ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `car`(
    `make` varchar(50) NOT NULL,
    `model` varchar(50) NOT NULL,
    `year` int(4) NOT NULL,
    PRIMARY KEY (`make`,`model`,`year`)  
);

CREATE TABLE IF NOT EXISTS `chassis_table`(
    `make` varchar(50) NOT NULL,
    `model` varchar(50) NOT NULL,
    `year` int(4) NOT NULL,
    `chassis` varchar(50) NOT NULL,
    PRIMARY KEY(`make`,`model`,`year`,`chassis`),
    FOREIGN KEY (`make`,`model`,`year`) REFERENCES `car` (`make`,`model`,`year`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `transmission_table`(
    `make` varchar(50) NOT NULL,
    `model` varchar(50) NOT NULL,
    `year` int(4) NOT NULL,
    `transmission` varchar(50) NOT NULL, 
    `drivetrain` varchar(50) NOT NULL,
    PRIMARY KEY(`make`,`model`,`year`,`transmission`,`drivetrain`),
    FOREIGN KEY (`make`,`model`,`year`) REFERENCES `car` (`make`,`model`,`year`) ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS `engine_table`(
    `make` varchar(50) NOT NULL,
    `model` varchar(50) NOT NULL,
    `year` int(4) NOT NULL,
    `engine` varchar(50) NOT NULL, 
    PRIMARY KEY(`make`,`model`,`year`,`engine`),
    FOREIGN KEY (`make`,`model`,`year`) REFERENCES `car` (`make`,`model`,`year`) ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS `dtc`(
    `code` varchar(50) NOT NULL,
    `description` varchar(255) NOT NULL,
    PRIMARY KEY (`code`) 
);


CREATE TABLE IF NOT EXISTS `symptoms`(
    `name` varchar(50) NOT NULL,
    `symptom` varchar(255) NOT NULL,
    PRIMARY KEY(`name`,`symptom`),
    FOREIGN KEY (`name`) REFERENCES `issue` (`issue_name`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `purchases`(
    `part_id` int(2) NOT NULL,
    `retailer_name` varchar(50) NOT NULL,
    `account_id` varchar(30) NOT NULL,
    `date` varchar(10),
    `transaction_no` int(2) AUTO_INCREMENT,
    PRIMARY KEY(`transaction_no`),
    FOREIGN KEY (`part_id`) REFERENCES `car_part` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`retailer_name`) REFERENCES `retailer` (`name`) ON DELETE CASCADE,
    FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
);

ALTER TABLE purchases AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fits`(
    `part_id` int(2) NOT NULL,
    `make` varchar(50) NOT NULL,
    `model` varchar(50) NOT NULL,
    `year` int(4) NOT NULL,
    FOREIGN KEY (`part_id`) REFERENCES `car_part` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`make`,`model`,`year`) REFERENCES `car` (`make`,`model`,`year`) ON DELETE CASCADE 
);

CREATE TABLE IF NOT EXISTS `has`(
    `make` varchar(50) NOT NULL,
    `model` varchar(50) NOT NULL,
    `year` int(4) NOT NULL,
    `code` varchar(50),
    `name` varchar(50) NOT NULL,
    FOREIGN KEY (`make`,`model`,`year`) REFERENCES `car` (`make`,`model`,`year`) ON DELETE CASCADE, 
    FOREIGN KEY (`code`) REFERENCES `dtc` (`code`) ON DELETE CASCADE,
    FOREIGN KEY (`name`) REFERENCES `issue` (`issue_name`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `rate`(
    `mechanic_id` varchar(30) NOT NULL,
    `guide_title` varchar(50) NOT NULL,
    FOREIGN KEY (`mechanic_id`) REFERENCES `mechanic` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`guide_title`) REFERENCES `guide` (`title`) ON DELETE CASCADE
);


/*Table Insertions*/

INSERT INTO `car` VALUES ('Honda', 'Civic', 2000);
INSERT INTO `car` VALUES ('Honda', 'Accord', 2002);
INSERT INTO `car` VALUES ('Honda', 'Prelude', 1992);
INSERT INTO `car` VALUES ('Ford', 'Escape', 2012);
INSERT INTO `car` VALUES ('Ford', 'Focus', 2015);
INSERT INTO `car` VALUES ('Mazda','Mazda3', 2007 );
INSERT INTO `car` VALUES ('Mazda','Mazda3', 2012 );
INSERT INTO `car` VALUES ('Dodge','Challenger', 2010);

INSERT INTO `chassis_table` VALUES ('Honda', 'Civic', 2000 ,'Coupe');
INSERT INTO `chassis_table` VALUES ('Honda', 'Civic', 2000,'Sedan');
INSERT INTO `chassis_table` VALUES ('Honda', 'Accord', 2002,'Coupe');
INSERT INTO `chassis_table` VALUES ('Honda', 'Accord', 2002 ,'Sedan');
INSERT INTO `chassis_table` VALUES ('Honda', 'Prelude', 1992,'Coupe');
INSERT INTO `chassis_table` VALUES ('Ford', 'Escape', 2012, 'SUV');
INSERT INTO `chassis_table` VALUES ('Ford', 'Focus', 2015,'Hatchback');
INSERT INTO `chassis_table` VALUES ('Ford', 'Focus', 2015,'Sedan');
INSERT INTO `chassis_table` VALUES ('Mazda','Mazda3',2007,'Hatchback');
INSERT INTO `chassis_table` VALUES ('Mazda','Mazda3', 2007 ,'Sedan');
INSERT INTO `chassis_table` VALUES ('Mazda','Mazda3',2012,'Hatchback');
INSERT INTO `chassis_table` VALUES ('Mazda','Mazda3',2012,'Sedan');
INSERT INTO `chassis_table` VALUES ('Dodge', 'Challenger', 2010, 'Coupe');

INSERT INTO `transmission_table` VALUES ('Honda', 'Civic', 2000 , 'Standard', 'FWD');
INSERT INTO `transmission_table` VALUES ('Honda', 'Civic', 2000 , 'Automatic', 'FWD');
INSERT INTO `transmission_table` VALUES ('Honda', 'Accord', 2002, 'Standard', 'FWD');
INSERT INTO `transmission_table` VALUES ('Honda', 'Accord', 2002, 'Automatic', 'FWD');
INSERT INTO `transmission_table` VALUES ('Honda', 'Prelude', 1992, 'Standard', 'FWD');
INSERT INTO `transmission_table` VALUES ('Honda', 'Prelude', 1992, 'Automatic', 'FWD');
INSERT INTO `transmission_table` VALUES ('Ford', 'Escape', 2012,  'Automatic', 'AWD');
INSERT INTO `transmission_table` VALUES ('Ford', 'Focus', 2015, 'Standard', 'FWD');
INSERT INTO `transmission_table` VALUES ('Ford', 'Focus', 2015, 'Standard', 'AWD');
INSERT INTO `transmission_table` VALUES ('Ford', 'Focus', 2015, 'Automatic', 'FWD');
INSERT INTO `transmission_table` VALUES ('Mazda','Mazda3',2007, 'Standard', 'FWD');
INSERT INTO `transmission_table` VALUES ('Mazda','Mazda3',2007, 'Automatic', 'FWD');
INSERT INTO `transmission_table` VALUES ('Mazda','Mazda3',2012, 'Standard', 'FWD');
INSERT INTO `transmission_table` VALUES ('Mazda','Mazda3',2012, 'Automatic', 'FWD');
INSERT INTO `transmission_table` VALUES ('Dodge', 'Challenger', 2010, 'Standard', 'RWD');
INSERT INTO `transmission_table` VALUES ('Dodge', 'Challenger', 2010, 'Automatic', 'RWD');

INSERT INTO `engine_table` VALUES('Honda', 'Civic', 2000, 'I4-D16Y8');
INSERT INTO `engine_table` VALUES('Honda', 'Accord', 2002, 'V6-J30A1');
INSERT INTO `engine_table` VALUES('Honda', 'Accord', 2002, 'I4-F20A2');
INSERT INTO `engine_table` VALUES('Honda', 'Prelude', 1992, 'I4-F22A1');
INSERT INTO `engine_table` VALUES('Honda', 'Prelude', 1992, 'I4-H23A1');
INSERT INTO `engine_table` VALUES('Ford', 'Escape', 2012, 'I4-Ecoboost-1.5');
INSERT INTO `engine_table` VALUES('Ford', 'Escape', 2012, 'V6-Ecoboost-3.0');
INSERT INTO `engine_table` VALUES('Mazda', 'Mazda3', 2007, 'I4-MZRL-2.0');
INSERT INTO `engine_table` VALUES('Mazda', 'Mazda3', 2007, 'I4-MZRL-2.3');
INSERT INTO `engine_table` VALUES('Dodge', 'Challenger', 2010, 'V8-Hemi-6.1');

INSERT INTO `dtc` VALUES('P0300', "Random/Multiple Misfire Detected");
INSERT INTO `dtc` VALUES('P0301', "Cylinder 1 Misfire Detected");
INSERT INTO `dtc` VALUES('P0302', "Cylinder 2 Misfire Detected");
INSERT INTO `dtc` VALUES('P0303', "Cylinder 3 Misfire Detected");
INSERT INTO `dtc` VALUES('P0304', "Cylinder 4 Misfire Detected");
INSERT INTO `dtc` VALUES('P0305', "Cylinder 5 Misfire Detected");
INSERT INTO `dtc` VALUES('P0306', "Cylinder 6 Misfire Detected");
INSERT INTO `dtc` VALUES('P0307', "Cylinder 7 Misfire Detected");
INSERT INTO `dtc` VALUES('P0308', "Cylinder 8 Misfire Detected");
INSERT INTO `dtc` VALUES('P0440', "EVAP System Leak/Malfunction");
INSERT INTO `dtc` VALUES('P0606', "ECM/PCM Processor Fault");
INSERT INTO `dtc` VALUES('P0627', "Fuel Pump Control Circuit Open");
INSERT INTO `dtc` VALUES('P0885', "TCM Power Realy Control Scircuit Open");
INSERT INTO `dtc` VALUES('P0505', "Idle Control System Malfunction");
INSERT INTO `dtc` VALUES('P0131', "O2 Sensor Circuit Low Voltage");
INSERT INTO `dtc` VALUES('P0562', "System Voltage Low");

INSERT INTO `retailer` VALUES('Fuel Me Up','587-515-1235',4,'Calgary');
INSERT INTO `retailer` VALUES('Fast and Fuel-ious','888-555-5555',2,'Edmonton');
INSERT INTO `retailer` VALUES('Good Air Day','111-121-2121',NULL,'Puerto Rico');
INSERT INTO `retailer` VALUES('Strut Your Stuff','543-234-1234',5,'London');
INSERT INTO `retailer` VALUES('Come Bearing Gifts','999-999-9999',1,'Paris');
INSERT INTO `retailer` VALUES('Give Me A Brake','635-234-6543',4,'Hong Kong');
INSERT INTO `retailer` VALUES('Your Big Brake','023-234-1234',3,'Hong Kong');
INSERT INTO `retailer` VALUES('Giver Some Gasket','543-543-5433',2,'Calgary');
INSERT INTO `retailer` VALUES('Spark It Like Its Hot','949-393-5858',4,'Vancouver');
INSERT INTO `retailer` VALUES('Armed Battery','123-456-7890',5,'Toronto');

INSERT INTO `category` VALUES('Electrical System', NULL);
INSERT INTO `category` VALUES('Interior', NULL);
INSERT INTO `category` VALUES('Repair Parts', NULL);
INSERT INTO `category` VALUES('Exterior', NULL);
INSERT INTO `category` VALUES('Engine', NULL);
INSERT INTO `category` VALUES('Fuel System','Engine');
INSERT INTO `category` VALUES('Air Intake','Engine');
INSERT INTO `category` VALUES('Suspension','Exterior');
INSERT INTO `category` VALUES('Brake System','Repair Parts');
INSERT INTO `category` VALUES('Brake Pads','Brake System');
INSERT INTO `category` VALUES('Gaskets','Repair Parts');


INSERT INTO `car_part` VALUES(1, 'Fuel Pump', 110, 4, 'Fuel System', 'Fuel Me Up');
INSERT INTO `car_part` VALUES(2, 'Fuel Pump', 150, 8, 'Fuel System', 'Fast and Fuel-ious');
INSERT INTO `car_part` VALUES(3,'IAC Valve', 30, 7, 'Air Intake', 'Good Air Day');
INSERT INTO `car_part` VALUES(4,'EVAP Purge Solenoid', 75, 9, 'Fuel System', 'Fuel Me Up');
INSERT INTO `car_part` VALUES(5,'Macpherson Strut', 100, 4, 'Suspension', 'Strut Your Stuff');
INSERT INTO `car_part` VALUES(6,'Macpherson Strut', 300, 10, 'Suspension', 'Strut Your Stuff');
INSERT INTO `car_part` VALUES(7,'Wheel Bearing', 50, 2, 'Suspension', 'Come Bearing Gifts');
INSERT INTO `car_part` VALUES(8,'Brake Pad', 30, 5, 'Brake Pads', 'Give Me A Brake');
INSERT INTO `car_part` VALUES(9,'Brake Pad', 60, 7, 'Brake Pads', 'Your Big Brake');
INSERT INTO `car_part` VALUES(10,'Head Gasket', 70, 8, 'Gaskets', 'Giver Some Gasket');
INSERT INTO `car_part` VALUES(11,'Exhaust Manifold Gasket', 45, 3, 'Gaskets', 'Giver Some Gasket');
INSERT INTO `car_part` VALUES(12, 'Spark Plug', 15, 7, 'Electrical system', 'Spark It Like Its Hot');
INSERT INTO `car_part` VALUES(13, 'Battery', 130, 6, 'Electrical System', 'Armed Battery');
INSERT INTO `car_part` VALUES(14, 'Battery', 300, 10, 'Electrical System', 'Armed Battery');

INSERT INTO `issue` VALUES('No fuel to engine','Fuel Pump or its circuit has a fault', 1,4,2,1,'Fuel Pump'); 
INSERT INTO `issue` VALUES('Worn Spark Plugs','Worn sparkplugs are causing misfires',3,4,5,12,'Spark Plug'); 
INSERT INTO `issue` VALUES('EVAP System Leak','Computer cannot control the purge solenoid, so there is a leak.',4,3,2,4,'EVAP Purge Solenoid'); 
INSERT INTO `issue` VALUES('Dead Battery','Dead Battery can cause many different problems, all pertaining to the electrical system',3,2,1,13,'Battery'); 
INSERT INTO `issue` VALUES('Faulty IAC','Computer cannot control air intake due to faulty IAC valve',4,2,2,3,'IAC valve'); 
INSERT INTO `issue` VALUES('Worn Brakes', 'High pitched squealing noise whenever car is coming to a stop', 5,1,1,8,'Brake Pad');
INSERT INTO `issue` VALUES('Worn Wheel Bearing', 'Wheel bearing(s) are old and worn out, causeing noise or vibration', 2, 3, 3,7,'Wheel Bearing');

INSERT INTO `symptoms` VALUES('Worn Brakes','Squealing noise');
INSERT INTO `symptoms` VALUES('Worn Brakes','Little to no braking power');
INSERT INTO `symptoms` VALUES('Faulty IAC','Rough idle');
INSERT INTO `symptoms` VALUES('Faulty IAC','Crank but no start');
INSERT INTO `symptoms` VALUES('Worn Spark Plugs','Crank but no start');
INSERT INTO `symptoms` VALUES('Dead Battery','No crank');
INSERT INTO `symptoms` VALUES('No fuel to engine','Crank but no start');
INSERT INTO `symptoms` VALUES('No fuel to engine','Lack of fuel pump priming noise');
INSERT INTO `symptoms` VALUES('EVAP System Leak', 'Intermittent start');
INSERT INTO `symptoms` VALUES('EVAP System Leak', 'Poor fuel economy');
INSERT INTO `symptoms` VALUES('EVAP System Leak', 'Rough idle');

INSERT INTO `fits` VALUES(1, 'Mazda', 'Mazda3', 2007);
INSERT INTO `fits` VALUES(1, 'Mazda', 'Mazda3', 2012);
INSERT INTO `fits` VALUES(2, 'Dodge', 'Challenger', 2010);
INSERT INTO `fits` VALUES(3, 'Honda','Accord', 2002);
INSERT INTO `fits` VALUES(4, 'Honda','Civic', 2000);
INSERT INTO `fits` VALUES(5, 'Mazda', 'Mazda3', 2007);
INSERT INTO `fits` VALUES(6,'Honda','Accord',2002);
INSERT INTO `fits` VALUES(7,'Honda', 'Civic',2000);
INSERT INTO `fits` VALUES(8, 'Ford', 'Focus', 2015);
INSERT INTO `fits` VALUES(9, 'Honda', 'Prelude', 1992);
INSERT INTO `fits` VALUES(11,'Ford','Escape',2012);
INSERT INTO `fits` VALUES(12, 'Honda', 'Accord',2002);
INSERT INTO `fits` VALUES(13, 'Honda', 'Accord', 2002);
INSERT INTO `fits` VALUES(13, 'Honda', 'Prelude', 1992);
INSERT INTO `fits` VALUES(13, 'Honda', 'Civic', 2000);
INSERT INTO `fits` VALUES(14, 'Ford', 'Focus', 2015);


INSERT INTO `has` VALUES('Mazda', 'Mazda3', 2007,'P0627','No fuel to engine');
INSERT INTO `has` VALUES('Honda', 'Accord',2002, NULL, 'Worn Brakes');
INSERT INTO `has` VALUES('Honda', 'Accord',2002,'P0505','Faulty IAC');
INSERT INTO `has` VALUES('Honda', 'Civic', 2000,'P0440','EVAP System Leak');
INSERT INTO `has` VALUES('Honda', 'Civic', 2000, NULL, 'Worn Wheel Bearing');
INSERT INTO `has` VALUES('Ford', 'Focus', 2015,'P0300','Worn Spark Plugs');
INSERT INTO `has` VALUES('Ford','Escape',2012,'P0562','Dead Battery');

INSERT INTO `account` VALUES('John123', 'pa$$word', 'john123@gmail.com', '10-06-2019');
INSERT INTO `account` VALUES('Reus11', 'dortmund', 'marcoreus11@gmail.com', '11-09-2017');
INSERT INTO `account` VALUES('JamesBond007', 'astonmartin', 'bond007@gmail.com', '26-06-2007');
INSERT INTO `account` VALUES('Humdizzle', 'kobe81', 'humdizzle@gmail.com', '24-06-2006');
INSERT INTO `account` VALUES('Schumacher', 'ferrari7', 'msc@gmail.com', '13-05-2007');
INSERT INTO `account` VALUES('Starplatinum', 'cocopuffs', 'star@gmail.com', '23-01-2008');
INSERT INTO `account` VALUES('Hamilton', 'vegan44', 'lh44@gmail.com', '16-05-2007' );
INSERT INTO `account` VALUES('Dylan', 'admin', 'dylan@gmail.com', '17-02-2015');
INSERT INTO `account` VALUES('Roshan', 'admin2', 'rosh@gmail.com', '19-08-2004');

INSERT INTO `admin` VALUES('Dylan');
INSERT INTO `admin` VALUES('Humdizzle');
INSERT INTO `admin` VALUES('Roshan');

INSERT INTO `mechanic` VALUES('John123', '3616  Morris Street, Victoria, BC');
INSERT INTO `mechanic` VALUES('Reus11', '245 Prince Edward Street, Calgary, AB');
INSERT INTO `mechanic` VALUES('JamesBond007', '77 Baker Street, Toronto, ON');
INSERT INTO `mechanic` VALUES('Schumacher', '91 White Hart Lane, Vancouver, BC');
INSERT INTO `mechanic` VALUES('Starplatinum', '404 Green Land, Saskatoon, SK');
INSERT INTO `mechanic` VALUES('Hamilton', '167 Reapers Hideout, Edmonton, AB');

INSERT INTO `professional` VALUES('Schumacher', 'certification', 'Ferrari Garage');
INSERT INTO `professional` VALUES('Hamilton', 'certification', 'Mercedes Garage');
INSERT INTO `professional` VALUES('JamesBond007', 'certification', 'Aston Garage');

INSERT INTO `amateur` VALUES('John123');
INSERT INTO `amateur` VALUES('Reus11');
INSERT INTO `amateur` VALUES('Starplatinum');

INSERT INTO `purchases` VALUES(1, 'Fuel Me Up', 'Schumacher', '09-09-2020',1);
INSERT INTO `purchases` VALUES(2, 'Fast and Fuel-ious', 'JamesBond007', '08-07-2020',2);
INSERT INTO `purchases` VALUES(3, 'Good Air Day', 'John123', '23-07-2020',3);
INSERT INTO `purchases` VALUES(4, 'Fuel Me Up', 'Reus11', '12-09-2020',4);
INSERT INTO `purchases` VALUES(10, 'Giver Some Gasket', 'Reus11', '03-01-2019',5);
INSERT INTO `purchases` VALUES(12, 'Spark It Like Its Hot', 'Hamilton', '07-05-2020',6);
INSERT INTO `purchases` VALUES(13, 'Armed Battery', 'Hamilton', '07-05-2020',7);

INSERT INTO `guide` VALUES(3, 'How To Change Brake Pads', NULL,'https://www.youtube.com/watch?v=lU6OKQxSg8U','Hamilton','Dylan','Worn Brakes');

INSERT INTO `rate` VALUES('John123', 'How To Change Brake Pads');

INSERT INTO `step` 	VALUES('Jack Up The Car', 1, 'Place chalks under opposite wheel. Use the jack to jack up the car by the designated jackpoints. Then place jackstands under the frame, and lower the car onto the jackstands', 'How To Change Brake Pads');
INSERT INTO `step` 	VALUES('Remove The Wheel',2, 'Using a breaker bar, break the nuts of the wheel and then remove the nuts by hand. Pull off the wheel', 'How To Change Brake Pads');
INSERT INTO `step` 	VALUES('Remove The Caliper', 3, 'Remove the calipler mounting bolts that hold the caliper to its mounting bracket. Make sure ABS clip is unclipped. Hand caliper from strut using a bungiee cord', 'How To Change Brake Pads');
INSERT INTO `step` 	VALUES('Replace Brake Pads',4,'Remove old brake pads. Place new brake pads in their spot. Add a healthy amount of grease to the backs of new brake pads.', 'How To Change Brake Pads');
INSERT INTO `step` 	VALUES('Return Piston on Caliper', 5,'Open the cap on the brake fluid reservoir. Using a c-clamp, press the piston all the way back in.','How To Change Brake Pads');
INSERT INTO `step` 	VALUES('Reinstall Caliper', 6,'Place the caplier back on. Tighten bolts down to the proper torque spec, and clip the ABS harness back in', 'How To Change Brake Pads');
INSERT INTO `step` 	VALUES('Put Wheel On and Lower Car', 7, 'Place the wheel on the lugs, and hand tighten the lug nuts, in a criss-cross alternating pattern. Jack the car off the Jack stands, remove jackstands, and lower the car','How To Change Brake Pads');
INSERT INTO `step` 	VALUES('Tighten Lug Nuts',8, 'Using a torque bar, tighten the lug nuts to torque spec, in a criss-cross alternating pattern. Remove the chalks from the other wheel', 'How To Change Brake Pads');





















