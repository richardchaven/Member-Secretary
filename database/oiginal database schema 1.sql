DROP TABLE IF EXISTS `Announcement Interests`;
CREATE TABLE `Announcement Interests` (
  `Announcement ID` int(10) unsigned NOT NULL,
  `Interest ID` int(10) unsigned NOT NULL,
  Description varchar(100)  default NULL,
  PRIMARY KEY  (`Announcement ID`,`Interest ID`)
) ;


DROP TABLE IF EXISTS Announcements;
CREATE TABLE Announcements (
  ID int(10) unsigned NOT NULL auto_increment,
  Title varchar(20)  NOT NULL,
  Description varchar(100)  default NULL,
  `Planned Date` timestamp NULL default NULL,
  `Contact Types` set('Cell','Home Phone','Office Phone','Pager','EMail','SMS','Mailing Address','Delivery Address','Office Address','Web Site','Other')  default NULL,
  `Media Name` varchar(100)  default NULL COMMENT 'URL or file name',
  `Status` varchar(15)  default NULL,
  Notes text ,
  PRIMARY KEY  (ID)
) ;

DROP TABLE IF EXISTS `Event Announcement History`;
CREATE TABLE `Event Announcement History` (
  `Event ID` int(10) unsigned NOT NULL,
  `Announcement ID` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`Event ID`,`Announcement ID`)
) ;


DROP TABLE IF EXISTS `Event Interests`;
CREATE TABLE `Event Interests` (
  `Event ID` int(10) unsigned NOT NULL,
  `Interest ID` int(10) unsigned NOT NULL,
  Description varchar(100)  default NULL,
  PRIMARY KEY  (`Event ID`,`Interest ID`)
) ;


DROP TABLE IF EXISTS `Event Membership Prices`;
CREATE TABLE `Event Membership Prices` (
  `Event ID` int(10) unsigned NOT NULL,
  `Membership Type ID` int(10) unsigned NOT NULL,
  Deadline timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  Price decimal(5,2) default NULL,
  `Guest Price` decimal(5,2) default NULL,
  PRIMARY KEY  (`Event ID`,`Membership Type ID`,Deadline)
) ;

DROP TABLE IF EXISTS Events;
CREATE TABLE `Events` (
  ID int(10) unsigned NOT NULL auto_increment,
  Title varchar(20)  NOT NULL,
  Description varchar(100)  default NULL,
  `Planned Date` timestamp NULL default NULL,
  `Status` varchar(15)  default NULL,
  Notes text ,
  PRIMARY KEY  (ID)
) ;

DROP TABLE IF EXISTS Interests;
CREATE TABLE Interests (
  ID int(10) unsigned NOT NULL auto_increment,
  Title varchar(20)  NOT NULL,
  Description varchar(100)  default NULL,
  Notes text ,
  PRIMARY KEY  (ID)
) ;


DROP TABLE IF EXISTS `Inventory Types`;
CREATE TABLE `Inventory Types` (
  ID smallint(4) unsigned NOT NULL auto_increment,
  Title varchar(20) character set utf8  NOT NULL,
  Description varchar(100) character set utf8  default NULL,
  `Base Cost` decimal(5,2) unsigned default NULL,
  `Base Price` decimal(5,2) unsigned default NULL,
  `Default Expire Days` smallint(5) unsigned default NULL,
  Notes text character set utf8 ,
  PRIMARY KEY  (ID)
) ;

DROP TABLE IF EXISTS `Member Event Guests`;
CREATE TABLE `Member Event Guests` (
  `Member ID` int(10) unsigned NOT NULL,
  `Event ID` int(10) unsigned NOT NULL,
  `Guest Person ID` int(10) unsigned NOT NULL,
  Notes text ,
  PRIMARY KEY  (`Member ID`,`Event ID`,`Guest Person ID`)
) ;

DROP TABLE IF EXISTS `Member Event History`;
CREATE TABLE `Member Event History` (
  `Member ID` int(10) unsigned NOT NULL,
  `Event ID` int(10) unsigned NOT NULL,
  `Time` timestamp NULL default NULL,
  Notes text ,
  PRIMARY KEY  (`Member ID`,`Event ID`)
) ;


DROP TABLE IF EXISTS `Member Inventory Transfer History`;
CREATE TABLE `Member Inventory Transfer History` (
  `Giving Member ID` int(10) unsigned NOT NULL,
  `Receiving Member ID` int(10) unsigned NOT NULL,
  `Inventory Type ID` int(10) unsigned NOT NULL,
  `Transfer Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  Quantity smallint(5) unsigned NOT NULL,
  Notes text ,
  `Transferred By` varchar(20)  NOT NULL,
  PRIMARY KEY  (`Giving Member ID`,`Receiving Member ID`,`Inventory Type ID`,`Transfer Time`)
) ;

DROP TABLE IF EXISTS `Membership Audit`;
CREATE TABLE `Membership Audit` (
  ID int(10) unsigned NOT NULL auto_increment,
  `Member ID` int(10) unsigned NOT NULL,
  `Transaction ID` int(10) unsigned NOT NULL,
  `Data Name` varchar(20)  NOT NULL,
  `Old Value` varchar(20)  NOT NULL,
  `Changed By` varchar(20)  NOT NULL,
  `Changed Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (ID)
) ;

DROP TABLE IF EXISTS `Membership Inventory History`;
CREATE TABLE `Membership Inventory History` (
  `Member ID` int(10) unsigned NOT NULL,
  `Inventory Type ID` smallint(5) unsigned NOT NULL,
  `Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  Quantity smallint(5) unsigned NOT NULL,
  Notes text character set utf8 ,
  PRIMARY KEY  (`Member ID`,`Inventory Type ID`,`Time`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `Membership Inventory`;
CREATE TABLE `Membership Inventory` (
  `Membership ID` int(10) unsigned NOT NULL,
  `Inventory Type ID` smallint(5) unsigned NOT NULL,
  `Start Date` date NOT NULL,
  Quantity int(10) unsigned NOT NULL,
  `Expire Date` date default NULL,
  PRIMARY KEY  (`Membership ID`,`Inventory Type ID`,`Start Date`)
) ;

DROP TABLE IF EXISTS `Membership Type Inventory Price`;
CREATE TABLE `Membership Type Inventory Price` (
  `Membership Type ID` smallint(6) unsigned NOT NULL,
  `Inventory Type ID` smallint(6) unsigned NOT NULL,
  `Minimum Quantity` smallint(6) unsigned NOT NULL default '1' COMMENT 'yes, this is part of the key to allow tiers',
  Price decimal(5,2) NOT NULL,
  `Maximum Quantity` smallint(6) unsigned default NULL,
  PRIMARY KEY  (`Membership Type ID`,`Inventory Type ID`,`Minimum Quantity`)
) COMMENT='overrides Inventory Types.Price* Membership Types.Base Inven';

DROP TABLE IF EXISTS `Membership Type Inventory`;
CREATE TABLE `Membership Type Inventory` (
  `Membership Type ID` smallint(6) unsigned NOT NULL,
  `Inventory Type ID` smallint(6) unsigned NOT NULL,
  Quantity smallint(6) unsigned NOT NULL,
  `Expire Days After Membership Start` smallint(6) unsigned default NULL,
  PRIMARY KEY  (`Membership Type ID`,`Inventory Type ID`)
) ;

DROP TABLE IF EXISTS `Membership Types`;
CREATE TABLE `Membership Types` (
  ID int(11) unsigned NOT NULL auto_increment,
  Title varchar(20)  NOT NULL,
  Description varchar(100)  default NULL,
  Price decimal(5,2) default NULL,
  Period enum('One Month','Two Months','Quarter','Four Months','Six Months','One Year','Eighteen Months','Two Years','Five Years','Ten Years','Indefinitely','Other')  default NULL,
  `Base Event Price` decimal(5,2) default NULL,
  `Max Event Guest Count` tinyint(2) unsigned default NULL,
  `Base Event Guest Price` decimal(5,2) default NULL,
  `Base Inventory Discount Percent` tinyint(2) default NULL,
  Notes text ,
  PRIMARY KEY  (ID)
) ;


DROP TABLE IF EXISTS Membeships;
CREATE TABLE Membeships (
  ID int(10) unsigned NOT NULL auto_increment,
  `Person ID` int(10) unsigned NOT NULL,
  `Membership Type ID` smallint(5) unsigned NOT NULL,
  `Status` varchar(15)  default NULL,
  `Public ID` varchar(20) default NULL,
  `Amount Paid` decimal(5,2) default NULL,
  `Payment ID` varchar(20)  default NULL COMMENT 'track check number, credit card authorization, etc.',
  `Start Date` date NOT NULL,
  `Expire Date` date NOT NULL,
  `Source` varchar(30) default NULL,
  `Personal Identification Description` varchar(40)  default NULL,
  `Member Card ID` varchar(20)  default NULL,
  `Member Card Start Date` datetime default NULL,
  Notes mediumtext  NOT NULL,
  PRIMARY KEY  (ID)
) ;

DROP TABLE IF EXISTS `Person Announcement History`;
CREATE TABLE `Person Announcement History` (
  `Contact ID` int(10) unsigned NOT NULL,
  `Announcement ID` int(10) unsigned NOT NULL,
  `Sent Time` timestamp NULL default NULL,
  `Person ID` int(10) unsigned NOT NULL COMMENT 'Yes, we could look it up from Contact ID, but why',
  `Status` varchar(10)  default NULL COMMENT 'Pending, Bounced, etc.',
  PRIMARY KEY  (`Contact ID`,`Announcement ID`)
) ;

DROP TABLE IF EXISTS `Person Audit`;
CREATE TABLE `Person Audit` (
  ID int(10) unsigned NOT NULL auto_increment,
  `Person ID` int(10) unsigned NOT NULL,
  `Transaction ID` int(10) unsigned NOT NULL,
  `Data Name` varchar(20)  NOT NULL,
  `Old Value` varchar(50)  NOT NULL,
  `Changed By` varchar(20)  NOT NULL,
  `Changed Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (ID)
) ;
DROP TABLE IF EXISTS `Person Contacts`;
CREATE TABLE `Person Contacts` (
  ID int(10) unsigned NOT NULL auto_increment COMMENT 'Yes, it should be Person ID + Contact ID, but auto-increment does not work that way',
  `Person ID` int(10) unsigned NOT NULL,
  `Type` enum('Cell','Home Phone','Office Phone','Pager','EMail','SMS','Mailing Address','Delivery Address','Office Address','Web Site','Other') character set utf8 collate utf8_turkish_ci NOT NULL,
  Address varchar(50)  NOT NULL,
  PRIMARY KEY  (ID)
) ;

DROP TABLE IF EXISTS `Person Interests`;
CREATE TABLE `Person Interests` (
  `Person ID` int(10) unsigned NOT NULL,
  `Interest ID` smallint(5) unsigned NOT NULL,
  `Send Announcements` tinyint(1) default NULL,
  Notes text ,
  `Last Update` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`Person ID`,`Interest ID`)
) ;

DROP TABLE IF EXISTS `Person Messages`;
CREATE TABLE `Person Messages` (
  `To Person ID` int(10) unsigned NOT NULL,
  `From Person ID` int(10) unsigned NOT NULL,
  `Sent Time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `Text` text  NOT NULL,
  `Received Time` timestamp NULL default NULL,
  PRIMARY KEY  (`To Person ID`,`From Person ID`,`Sent Time`)
) ;


DROP TABLE IF EXISTS `Person Relationships`;
CREATE TABLE `Person Relationships` (
  `First Person ID` int(10) unsigned NOT NULL,
  `Second Person ID` int(10) unsigned NOT NULL,
  `Relationship Type ID` smallint(5) unsigned NOT NULL,
  Description varchar(100)  default NULL,
  PRIMARY KEY  (`First Person ID`,`Second Person ID`,`Relationship Type ID`)
) ;

DROP TABLE IF EXISTS Person `Relationship Types`;
CREATE TABLE `Person Relationship Types` (
  ID smallint(5) unsigned NOT NULL auto_increment,
  Title varchar(15)  NOT NULL,
  Description varchar(100)  default NULL,
  PRIMARY KEY  (ID)
) ;



DROP TABLE IF EXISTS Persons;
CREATE TABLE Persons (
  ID int(10) unsigned NOT NULL auto_increment,
  `Public ID` varchar(20)  default NULL,
  `First Name` varchar(20)  NOT NULL,
  `Last Name` varchar(20)  default NULL,
  `Mailing Address` varchar(40)  default NULL,
  `Mailing City` varchar(30)  default NULL,
  `Mailing Region` varchar(30)  default NULL,
  `Mailing Postal Code` varchar(15)  default NULL,
  `Mailing Country` varchar(25)  default NULL,
  `Orientation Completion Date` date default NULL,
  `Prefer Receive Messages` tinyint(1) default NULL,
  `Created By` varchar(20)  NOT NULL,
  `Created Date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (ID)
) ;

DROP TABLE IF EXISTS `Person Volunteer History`;
CREATE TABLE `Person Volunteer History` (
  `Person ID` int(10) unsigned NOT NULL,
  `Date` date NOT NULL,
  `Type` varchar(10)  NOT NULL COMMENT 'cleaning, painting, front desk, etc.',
  Quantity float default NULL,
  `Project Name` varchar(30)  default NULL,
  `Exchange Inventory Type ID` int(10) unsigned default NULL,
  `Exchange Quantity` smallint(5) unsigned default NULL,
  Notes text ,
  `Approved By` varchar(20)  NOT NULL,
  PRIMARY KEY  (`Person ID`,`Date`,`Type`)
) ;

