-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Mar 23, 2014 at 05:23 AM
-- Server version: 5.5.35
-- PHP Version: 5.3.10-1ubuntu3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `veh123_Database`
--

-- --------------------------------------------------------

--
-- Table structure for table `Brands`
--

DROP TABLE IF EXISTS `Brands`;
CREATE TABLE IF NOT EXISTS `Brands` (
  `Brand_Code` int(11) NOT NULL,
  `Brand_Name` text NOT NULL,
  `Other_Details` longtext NOT NULL,
  PRIMARY KEY (`Brand_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Countries`
--

DROP TABLE IF EXISTS `Countries`;
CREATE TABLE IF NOT EXISTS `Countries` (
  `Country_Code` int(11) NOT NULL,
  `Country_Name` text NOT NULL,
  `Principal_Currency` text NOT NULL,
  PRIMARY KEY (`Country_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Manufacturing_Plants`
--

DROP TABLE IF EXISTS `Manufacturing_Plants`;
CREATE TABLE IF NOT EXISTS `Manufacturing_Plants` (
  `Plant_ID` int(11) NOT NULL,
  `Country_Code` int(11) NOT NULL,
  `Plant_Name` text NOT NULL,
  `Plant_Location` text NOT NULL,
  `Other_Details` longtext,
  PRIMARY KEY (`Plant_ID`),
  UNIQUE KEY `Country_Code` (`Country_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Plants_and_Models`
--

DROP TABLE IF EXISTS `Plants_and_Models`;
CREATE TABLE IF NOT EXISTS `Plants_and_Models` (
  `Plant_ID` int(11) NOT NULL,
  `Model_Code` int(11) NOT NULL,
  PRIMARY KEY (`Plant_ID`,`Model_Code`),
  KEY `Model_Code` (`Model_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Sales_Outlets`
--

DROP TABLE IF EXISTS `Sales_Outlets`;
CREATE TABLE IF NOT EXISTS `Sales_Outlets` (
  `Sales_Outlet_ID` int(11) NOT NULL,
  `Country_Code` int(11) NOT NULL,
  `Location` text NOT NULL,
  `Other_Details` text NOT NULL,
  PRIMARY KEY (`Sales_Outlet_ID`),
  UNIQUE KEY `Country_Code` (`Country_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Sales_Outlets_and_Models`
--

DROP TABLE IF EXISTS `Sales_Outlets_and_Models`;
CREATE TABLE IF NOT EXISTS `Sales_Outlets_and_Models` (
  `Sales_Outlet_ID` int(11) NOT NULL,
  `Model_Code` int(11) NOT NULL,
  `Average_Weekly_Sales_Targets` int(11) NOT NULL,
  PRIMARY KEY (`Sales_Outlet_ID`,`Model_Code`),
  KEY `Model_Code` (`Model_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Vehicles`
--

DROP TABLE IF EXISTS `Vehicles`;
CREATE TABLE IF NOT EXISTS `Vehicles` (
  `Vehicle_ID` int(11) NOT NULL,
  `Model_Code` int(11) NOT NULL,
  `Vehicle_Category_Code` int(11) NOT NULL,
  `Other_Details` text,
  PRIMARY KEY (`Vehicle_ID`),
  UNIQUE KEY `Model_Code` (`Model_Code`,`Vehicle_Category_Code`),
  KEY `Vehicle_Category_Code` (`Vehicle_Category_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Vehicle_Categories`
--

DROP TABLE IF EXISTS `Vehicle_Categories`;
CREATE TABLE IF NOT EXISTS `Vehicle_Categories` (
  `Vehicle_Category_Code` int(11) NOT NULL,
  `Vehicle_Category_Description` text NOT NULL,
  PRIMARY KEY (`Vehicle_Category_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Vehicle_Models`
--

DROP TABLE IF EXISTS `Vehicle_Models`;
CREATE TABLE IF NOT EXISTS `Vehicle_Models` (
  `Model_Code` int(11) NOT NULL AUTO_INCREMENT,
  `Brand_Code` int(11) NOT NULL,
  `Model_Name` text NOT NULL,
  PRIMARY KEY (`Model_Code`),
  UNIQUE KEY `Brand_Code` (`Brand_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Vehicle_Model_Categories`
--

DROP TABLE IF EXISTS `Vehicle_Model_Categories`;
CREATE TABLE IF NOT EXISTS `Vehicle_Model_Categories` (
  `Model_Code` int(11) NOT NULL,
  `Vehicle_Category_Code` int(11) NOT NULL,
  PRIMARY KEY (`Model_Code`,`Vehicle_Category_Code`),
  KEY `Vehicle_Category_Code` (`Vehicle_Category_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Manufacturing_Plants`
--
ALTER TABLE `Manufacturing_Plants`
  ADD CONSTRAINT `Manufacturing_Plants_ibfk_1` FOREIGN KEY (`Country_Code`) REFERENCES `Countries` (`Country_Code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Plants_and_Models`
--
ALTER TABLE `Plants_and_Models`
  ADD CONSTRAINT `Plants_and_Models_ibfk_2` FOREIGN KEY (`Model_Code`) REFERENCES `Vehicle_Models` (`Model_Code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Plants_and_Models_ibfk_1` FOREIGN KEY (`Plant_ID`) REFERENCES `Manufacturing_Plants` (`Plant_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Sales_Outlets`
--
ALTER TABLE `Sales_Outlets`
  ADD CONSTRAINT `Sales_Outlets_ibfk_1` FOREIGN KEY (`Country_Code`) REFERENCES `Countries` (`Country_Code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Sales_Outlets_and_Models`
--
ALTER TABLE `Sales_Outlets_and_Models`
  ADD CONSTRAINT `Sales_Outlets_and_Models_ibfk_2` FOREIGN KEY (`Model_Code`) REFERENCES `Vehicle_Models` (`Model_Code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Sales_Outlets_and_Models_ibfk_1` FOREIGN KEY (`Sales_Outlet_ID`) REFERENCES `Sales_Outlets` (`Sales_Outlet_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Vehicles`
--
ALTER TABLE `Vehicles`
  ADD CONSTRAINT `Vehicles_ibfk_2` FOREIGN KEY (`Vehicle_Category_Code`) REFERENCES `Vehicle_Model_Categories` (`Vehicle_Category_Code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Vehicles_ibfk_1` FOREIGN KEY (`Model_Code`) REFERENCES `Vehicle_Models` (`Model_Code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Vehicle_Models`
--
ALTER TABLE `Vehicle_Models`
  ADD CONSTRAINT `Vehicle_Models_ibfk_1` FOREIGN KEY (`Brand_Code`) REFERENCES `Brands` (`Brand_Code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Vehicle_Model_Categories`
--
ALTER TABLE `Vehicle_Model_Categories`
  ADD CONSTRAINT `Vehicle_Model_Categories_ibfk_2` FOREIGN KEY (`Vehicle_Category_Code`) REFERENCES `Vehicle_Categories` (`Vehicle_Category_Code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Vehicle_Model_Categories_ibfk_1` FOREIGN KEY (`Model_Code`) REFERENCES `Vehicle_Models` (`Model_Code`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
