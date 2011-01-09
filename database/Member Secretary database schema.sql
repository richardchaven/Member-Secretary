-- phpMyAdmin SQL Dump
-- version 3.1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 25, 2009 at 05:30 PM
-- Server version: 5.1.30
-- PHP Version: 5.2.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `edges1`

DROP TABLE IF EXISTS Announcements;
CREATE TABLE Announcements (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(20) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Planned Date` timestamp NULL DEFAULT NULL,
  `Periodical ID` smallint unsigned DEFAULT NULL,
  `Contact Types` set('Cell','Home Phone','Office Phone','Pager','EMail','SMS','Mailing Address','Delivery Address','Office Address','Web Site','Other') DEFAULT NULL,
  `Media Name` varchar(100) DEFAULT NULL COMMENT 'URL or file name',
  `Status` varchar(15) DEFAULT NULL,
  `Notes` text,
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Announcement_Interests`;
CREATE TABLE `Announcement_Interests` (
  `Announcement ID` int(10) unsigned NOT NULL,
  `Interest ID` int(10) unsigned NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Announcement ID`,`Interest ID`)
);

DROP TABLE IF EXISTS `Event_Types`;
CREATE TABLE `Event_Types` (
  `ID` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `Class` enum('Orientation','Training','Introduction','Activity','Board Meeting','Administrative Meeting','Work Crew','Volunteer') DEFAULT 'Activity',
  `Default Title` varchar(20) NOT NULL,
  `Default Description` varchar(100) DEFAULT NULL,
  `Default Effective Period` enum('One Month','Two Months','Quarter','Four Months','Six Months','One Year','Eighteen Months','Two Years','Five Years','Ten Years','Indefinitely','Other') DEFAULT NULL COMMENT 'If this is training, how long until someone must renew',
  `Default Location ID` int(10) DEFAULT NULL,
  `Default Base Price` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Events`;
CREATE TABLE `Events` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Event Type ID` smallint(4) unsigned NOT NULL,
  `Title` varchar(20) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Location ID` int(10) unsigned DEFAULT NULL,
  `Planned Time` timestamp NULL DEFAULT NULL,
  `Effective Period` enum('One Month','Two Months','Quarter','Four Months','Six Months','One Year','Eighteen Months','Two Years','Five Years','Ten Years','Indefinitely','Other') DEFAULT NULL COMMENT 'If this is training, how long until someone must renew',
  `Base Price` decimal(5,2) DEFAULT NULL,
  `Status` varchar(15) DEFAULT NULL,
  `Notes` text,
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Event_Membership_Prices`;
CREATE TABLE `Event_Membership_Prices` (
  `Event ID` int(10) unsigned NOT NULL,
  `Membership Type ID` smallint unsigned NOT NULL,
  `Deadline` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Price` decimal(5,2) DEFAULT NULL,
  `Guest Price` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`Event ID`,`Membership Type ID`,`Deadline`)
);

DROP TABLE IF EXISTS `Event_Announcement_History`;
CREATE TABLE `Event_Announcement_History` (
  `Event ID` int(10) unsigned NOT NULL,
  `Announcement ID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Event ID`,`Announcement ID`)
);

DROP TABLE IF EXISTS `Event_Interests`;
CREATE TABLE `Event_Interests` (
  `Event ID` int(10) unsigned NOT NULL,
  `Interest ID` int(10) unsigned NOT NULL,
  `Description` varchar(100) DEFAULT NULL COMMENT 'Describe how the event relates to this interest',
  PRIMARY KEY (`Event ID`,`Interest ID`)
);

DROP TABLE IF EXISTS `Interests`;
CREATE TABLE `Interests` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(20) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Notes` text,
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Inventory_Types`;
CREATE TABLE `Inventory_Types` (
  `ID` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(20) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Base Cost` decimal(5,2) unsigned DEFAULT NULL,
  `Base Price` decimal(5,2) unsigned DEFAULT NULL,
  `Entry Event Type ID` smallint(4) unsigned DEFAULT NULL, 
  `Guest Entry Event Type ID` smallint(4) unsigned DEFAULT NULL, 
  `Default Expire Days` smallint(5) unsigned DEFAULT NULL,
  `Notes` text CHARACTER SET utf8,
  PRIMARY KEY (`ID`)
) COMMENT='these can be rental hours, subscriptions to periodicals, loan items';

DROP TABLE IF EXISTS `Club_Inventory`;
CREATE TABLE `Club_Inventory` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Inventory Type ID` smallint unsigned NOT NULL,
  `Aquisition Date` timestamp DEFAULT CURRENT_TIMESTAMP,
  `Quantity` smallint(6) unsigned NOT NULL,
  `Cost Per Unit` decimal(5,2) DEFAULT NULL,
  `Source` varchar(30) DEFAULT NULL,
  `Identification` varchar(50) DEFAULT NULL COMMENT 'serial numbers, etc',
  `Notes` text CHARACTER SET utf8,
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Locations`;
CREATE TABLE `Locations` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(20) NOT NULL,
  `Description` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `Maximum Capacity` smallint(5) unsigned DEFAULT NULL,
  `URL` varchar(100) DEFAULT NULL COMMENT 'e.g. Google Map link',
  `Public Notes` text,
  `Private Notes` text,
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Membership_Types`;
CREATE TABLE `Membership_Types` (
  `ID` smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(20) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Price` decimal(5,2) DEFAULT NULL,
  `Dependant On Membership Type ID` smallint(6) unsigned DEFAULT NULL,
  `Maximum Dependant Memberships Count` tinyint(2) unsigned DEFAULT NULL,
  `Period` enum('One Month','Two Months','Quarter','Four Months','Six Months','One Year','Eighteen Months','Two Years','Five Years','Ten Years','Indefinitely','Other') DEFAULT NULL,
  `Base Event Price` decimal(5,2) DEFAULT NULL,
  `Maximum Event Guest Count` tinyint(2) unsigned DEFAULT NULL,
  `Base Event Guest Price` decimal(5,2) DEFAULT NULL,
  `Base Inventory Discount Percent` tinyint(2) unsigned DEFAULT NULL,
  `Notes` text,
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Membership_Type_Required_Events`;
CREATE TABLE `Membership_Type_Required_Events` (
  `Membership Type ID` smallint unsigned NOT NULL,
  `Event Type ID` smallint unsigned NOT NULL,
  `Quantity` smallint(6) unsigned DEFAULT 1,
  PRIMARY KEY (`Membership Type ID`,`Event Type ID`)
) COMMENT='the person must have attended these events (e.g. training) before puchasing this type of membership';

DROP TABLE IF EXISTS `Membership_Type_Included_Inventory`;
CREATE TABLE `Membership_Type_Included_Inventory` (
  `Membership Type ID` smallint unsigned NOT NULL,
  `Inventory Type ID` smallint unsigned NOT NULL,
  `Quantity` smallint(6) unsigned NOT NULL,
  `Expires With Membership` boolean DEFAULT true,
  PRIMARY KEY (`Membership Type ID`,`Inventory Type ID`)
);

DROP TABLE IF EXISTS `Membership_Type_Inventory_Prices`;
CREATE TABLE `Membership_Type_Inventory_Prices` (
  `Membership Type ID` smallint unsigned NOT NULL,
  `Inventory Type ID` smallint unsigned NOT NULL,
  `Minimum Quantity` smallint(6) unsigned NOT NULL DEFAULT '1' COMMENT 'yes, this is part of the key to allow tiers',
  `Price` decimal(5,2) NOT NULL,
  `Maximum Quantity` smallint(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`Membership Type ID`,`Inventory Type ID`,`Minimum Quantity`)
) COMMENT='overrides Inventory Types.Price* Membership Types.Base Inven';

DROP TABLE IF EXISTS `Membership_Type_Volunteer_Requirements`;
CREATE TABLE `Membership_Type_Volunteer_Requirements` (
  `Membership Type ID` smallint unsigned NOT NULL,
  `Type` varchar(10) DEFAULT '' COMMENT 'cleaning, painting, front desk, etc.',
  `Quantity` float DEFAULT NULL COMMENT 'usually hours',
  PRIMARY KEY (`Membership Type ID`,`Type`)
) COMMENT='These memberships must perform this amount of volunteer service';

DROP TABLE IF EXISTS `Members`;
CREATE TABLE `Members` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Person ID` int(10) unsigned NOT NULL,
  `Membership Type ID` smallint unsigned NOT NULL,
  `Dependant On Member ID` int(10) DEFAULT NULL COMMENT 'e.g. family memberships',
  `Status` varchar(15) DEFAULT NULL,
  `Amount Paid` decimal(5,2) DEFAULT NULL,
  `Payment ID` varchar(20) DEFAULT NULL COMMENT 'track check number, credit card authorization, etc.',
  `Start Date` date NOT NULL,
  `Expire Date` date NOT NULL,
  `Source` varchar(30) DEFAULT NULL,
  `Personal Identification Description` varchar(40) DEFAULT NULL COMMENT 'Drivers License, etc.',
  `Member Card ID` varchar(20) DEFAULT NULL COMMENT 'this is the id of the card, not the member',
  `Member Card Start Date` datetime DEFAULT NULL,
  `Created By Person ID` varchar(20) NOT NULL,
  `Created Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Notes` text NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Person ID` (`Person ID`),
  KEY `Member Card ID` (`Member Card ID`)
);

DROP TABLE IF EXISTS `Member_Audit`;
CREATE TABLE `Member_Audit` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Member ID` int(10) unsigned NOT NULL,
  `Transaction ID` int(10) unsigned NOT NULL,
  `Data Name` varchar(20) NOT NULL,
  `Old Value` varchar(20) NOT NULL,
  `Changed By Person ID` int unsigned NOT NULL,
  `Changed Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `Member ID` (`Member ID`)
);

DROP TABLE IF EXISTS `Periodical_Announcements`;
CREATE TABLE `Periodical_Announcements` (
  `ID` int(10) unsigned NOT NULL,
  `Title` varchar(40) NOT NULL,
  `Frequency` enum('Bi Weekly','Monthly','Bi Monthly','Quarterly','Every Four Months','Every Six Months','Annually','Other') DEFAULT 'Monthly',
  `Inventory Type ID` smallint unsigned DEFAULT NULL COMMENT 'many periodicals can be instances of a single Inventory item (e.g. 12 issues)',
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Persons`;
CREATE TABLE `Persons` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Public Identifier` varchar(60) DEFAULT NULL COMMENT 'screen name, scene name, handle, ID number, alias',
  `Public Identifier Primary Metaphone` varchar(4) DEFAULT NULL ,
  `Public Identifier Secondary Metaphone` varchar(4) DEFAULT NULL ,
  `First Name` varchar(20) NOT NULL,
  `Last Name` varchar(20) DEFAULT NULL,
  `Last Name Primary Metaphone` varchar(4) DEFAULT NULL,
  `Last Name Secondary Metaphone` varchar(4) DEFAULT NULL,
  `Messages Perference` enum ('None','Relationship','Any')  DEFAULT 'None',
  `Messages Notification Contact ID` int(10) unsigned DEFAULT NULL,
  `Created By Person ID` varchar(20) NOT NULL,
  `Created Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Notes` text,
  PRIMARY KEY (`ID`),
  KEY `Public Identifier Primary Metaphone` (`Public Identifier Primary Metaphone`),
  KEY `Public Identifier Secondary Metaphone` (`Public Identifier Secondary Metaphone`),
  KEY `Last Name Primary Metaphone` (`Last Name Primary Metaphone`),
  KEY `Last Name Secondary Metaphone` (`Last Name Secondary Metaphone`)
);

DROP TABLE IF EXISTS `Person_Announcement_History`;
CREATE TABLE `Person_Announcement_History` (
  `Contact ID` int(10) unsigned NOT NULL,
  `Announcement ID` int(10) unsigned NOT NULL,
  `Sent Time` timestamp NULL DEFAULT NULL,
  `Person ID` int(10) unsigned NOT NULL COMMENT 'Yes, we could look it up from Contact ID, but why',
  `Status` varchar(10) DEFAULT NULL COMMENT 'Pending, Bounced, etc.',
  PRIMARY KEY (`Contact ID`,`Announcement ID`),
  KEY `Person ID` (`Person ID`)
) COMMENT='the individual announcements sent to this individual member';

DROP TABLE IF EXISTS `Person_Audit`;
CREATE TABLE `Person_Audit` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Person ID` int(10) unsigned NOT NULL,
  `Transaction ID` int(10) unsigned NOT NULL,
  `Data Name` varchar(20) NOT NULL,
  `Old Value` varchar(50) NOT NULL,
  `Changed By Person ID` int unsigned NOT NULL,
  `Changed Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `Person ID` (`ID`)
);

DROP TABLE IF EXISTS `Person_Addresses`;
CREATE TABLE `Person_Addresses` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Yes, it should be Person ID + Address ID, but auto-increment does not work that way',
  `Person ID` int(10) unsigned NOT NULL,
  `Type` enum('Mailing Address','Delivery Address','Office Address') NOT NULL,
  `Address` varchar(60) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `Region` varchar(30) DEFAULT NULL,
  `Postal Code` varchar(20) DEFAULT NULL,
  `Country` varchar(25) DEFAULT NULL,
  `Start Date` date DEFAULT NULL,
  `End Date` date DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Person ID` (`ID`)
);

DROP TABLE IF EXISTS `Person_Contacts`;
CREATE TABLE `Person_Contacts` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Yes, it should be Person ID + Contact ID, but auto-increment does not work that way',
  `Person ID` int(10) unsigned NOT NULL,
  `Type` enum('Cell','Home Phone','Office Phone','Fax','Pager','EMail','SMS','Web Site','Other') NOT NULL,
  `Address` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Person ID` (`ID`)
);

DROP TABLE IF EXISTS `Person_Current_Inventory`;
CREATE TABLE `Person_Current_Inventory` (
  `Person ID` int(10) unsigned NOT NULL,
  `Inventory Type ID` smallint(5) unsigned NOT NULL,
  `Start Date` date NOT NULL COMMENT 'in order to support Expire Date, we must have batches of Types',
  `Quantity` int(10) unsigned NOT NULL,
  `Expire Date` date DEFAULT NULL,
  PRIMARY KEY (`Person ID`,`Inventory Type ID`,`Start Date`),
  KEY `Inventory Type ID` (`Inventory Type ID`)
);

DROP TABLE IF EXISTS `Person_Inventory_Purchase_History`;
CREATE TABLE `Person_Inventory_Purchase_History` (
  `Person ID` int(10) unsigned NOT NULL,
  `Inventory Type ID` smallint(5) unsigned NOT NULL,
  `Purchase Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Quantity` smallint(5) unsigned NOT NULL,
  `Price Per Unit` decimal(5,2) unsigned NOT NULL,
  `Notes` text CHARACTER SET utf8,
  PRIMARY KEY (`Person ID`,`Inventory Type ID`,`Purchase Date`)
);

DROP TABLE IF EXISTS `Person_Inventory_Transfer_History`;
CREATE TABLE `Person_Inventory_Transfer_History` (
  `Giving Person ID` int(10) unsigned NOT NULL,
  `Receiving Person ID` int(10) unsigned NOT NULL,
  `Inventory Type ID` int(10) unsigned NOT NULL,
  `Transfer Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Quantity` smallint(5) unsigned NOT NULL,
  `Notes` text,
  `Transferred By Person ID` varchar(20) NOT NULL,
  PRIMARY KEY (`Giving Person ID`,`Receiving Person ID`,`Inventory Type ID`,`Transfer Time`)
);

DROP TABLE IF EXISTS `Person_Event_History`;
CREATE TABLE `Person_Event_History` (
  `Person ID` int(10) unsigned NOT NULL,
  `Event ID` int(10) unsigned NOT NULL,
  `Time` timestamp NULL DEFAULT NULL,
  `Notes` text,
  `Expiration Date` date DEFAULT NULL,
  PRIMARY KEY (`Person ID`,`Event ID`)
);

DROP TABLE IF EXISTS `Person_Event_Guests`;
CREATE TABLE `Person_Event_Guests` (
  `Person ID` int(10) unsigned NOT NULL,
  `Event ID` int(10) unsigned NOT NULL,
  `Guest Person ID` int(10) unsigned NOT NULL,
  `Notes` text,
  PRIMARY KEY (`Person ID`,`Event ID`,`Guest Person ID`),
  KEY `Guest Person ID` (`Guest Person ID`)
);

DROP TABLE IF EXISTS `Person_Interests`;
CREATE TABLE `Person_Interests` (
  `Person ID` int(10) unsigned NOT NULL,
  `Interest ID` smallint(5) unsigned NOT NULL,
  `Send Announcements` tinyint(1) DEFAULT NULL,
  `Notes` text,
  `Last Update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Person ID`,`Interest ID`),
  KEY `Interest ID` (`Interest ID`)
);

DROP TABLE IF EXISTS `Person_Messages`;
CREATE TABLE `Person_Messages` (
  `To Person ID` int(10) unsigned NOT NULL,
  `From Person ID` int(10) unsigned NOT NULL,
  `Sent Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Text` text NOT NULL,
  `Notification Time` timestamp NULL DEFAULT NULL,
  `Notification Contact ID` int(10) unsigned DEFAULT NULL,
  `Received Time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`To Person ID`,`From Person ID`,`Sent Time`),
  KEY `From Person ID` (`From Person ID`)
);

DROP TABLE IF EXISTS `Person_Relationship_Types`;
CREATE TABLE `Person_Relationship_Types` (
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(15) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Automatic Reciprocal Relationship Type ID` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Person_Relationships`;
CREATE TABLE `Person_Relationships` (
  `First Person ID` int(10) unsigned NOT NULL,
  `Second Person ID` int(10) unsigned NOT NULL,
  `Relationship Type ID` smallint(5) unsigned NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`First Person ID`,`Second Person ID`,`Relationship Type ID`),
  KEY `Second Person ID` (`Second Person ID`)
);

DROP TABLE IF EXISTS `Person_Title_Types`;
CREATE TABLE `Person_Title_Types` (
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `Title` varchar(15) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `Default Period` enum('One Month','Two Months','Quarter','Four Months','Six Months','One Year','Eighteen Months','Two Years','Five Years','Ten Years','Indefinitely','Other') DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `Person_Title_History`;
CREATE TABLE `Person_Title_History` (
  `Person ID` int(10) unsigned NOT NULL,
  `Title ID` smallint(5) NOT NULL,
  `Start Date` date NOT NULL,
  `End Date` date DEFAULT NULL,
  `Notes` text,
  PRIMARY KEY (`Person ID`, `Title ID`, `Start Date`)
);

DROP TABLE IF EXISTS `Person_Volunteer_History`;
CREATE TABLE `Person_Volunteer_History` (
  `Person ID` int(10) unsigned NOT NULL,
  `Date` date NOT NULL,
  `Type` varchar(10) NOT NULL COMMENT 'cleaning, painting, front desk, etc.',
  `Amount` float DEFAULT NULL,
  `Project Name` varchar(30) DEFAULT NULL,
  `Exchange Inventory Type ID` int(10) unsigned DEFAULT NULL,
  `Exchange Quantity` smallint(5) unsigned DEFAULT NULL,
  `Notes` text,
  `Approved By Person ID` int unsigned NOT NULL,
  PRIMARY KEY (`Person ID`,`Date`,`Type`)
);

DROP TABLE IF EXISTS `NEXT_ID`;
CREATE TABLE `NEXT_ID` (
`TABLE_NAME` VARCHAR( 50 ) NOT NULL ,
`ID` BIGINT NOT NULL DEFAULT '0',
PRIMARY KEY ( `TABLE_NAME` )
);

DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `User Name` varchar(50) NOT NULL,
  `Password Hash` varchar(40) NOT NULL, 
  `Most Recent Password Change` timestamp DEFAULT CURRENT_TIMESTAMP,
  `Highest Seed` bigint unsigned DEFAULT 0 COMMENT 'do not accept login attempts unless the seed is higher than this',
  `Start Date` timestamp NOT NULL,
  `Expiration Date` timestamp NOT NULL,
  `Status` enum('active','suspended') DEFAULT 'active', 
  `Person ID` int(10) unsigned DEFAULT NULL,
  `Most Recent Login Attempt Time` timestamp,
  `Failed Login Attempt Count` tinyint unsigned DEFAULT 0 COMMENT 'counted from the last successful login',
  `Most Recent Login Time` timestamp,
  `Most Recent Logout Time` timestamp,
  `Most Recent Request Time` timestamp,
  `Roles` set('admin','full','members','lookups','reports','events','announcements','persons','view','edit','delete','create') DEFAULT NULL,
  `Login Count` smallint unsigned DEFAULT 0,
  `Login Count Start Date` timestamp,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `User Name` (`User Name`),
  KEY `Person ID` (`Person ID`)
);

INSERT INTO `Users` 
	(`User Name` ,`Password Hash` ,
	`Start Date` ,`Expiration Date`,
	`Roles`)
VALUES ('admin', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 
	CURRENT_DATE( ) , ADDDATE(CURRENT_DATE( ), 999), 
	'admin,full,members,lookups,reports,events,announcements,persons,view,edit,delete,create');
