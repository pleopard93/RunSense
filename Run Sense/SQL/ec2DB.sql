-- phpMyAdmin SQL Dump
-- version 4.2.5
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Mar 01, 2015 at 03:24 PM
-- Server version: 5.5.38
-- PHP Version: 5.5.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `hackdfw`
--

-- --------------------------------------------------------

--
-- Table structure for table `Run`
--

CREATE TABLE `Run` (
  `RunID` int(6) NOT NULL,
  `StepNumber` int(6) NOT NULL,
  `StepType` varchar(12) NOT NULL,
  `Metrics` varchar(40) NOT NULL,
  `Pronation` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Run`
--

INSERT INTO `Run` (`RunID`, `StepNumber`, `StepType`, `Metrics`, `Pronation`) VALUES
(0, 1, 'R', 'left ball/right ball/heel', ''),
(2, 0, 'L', 'heel', ''),
(2, 1, 'L', 'heel', ''),
(2, 3, 'R', 'right ball', '');

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
`UserID` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Email` varchar(25) NOT NULL,
  `Password` varchar(25) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`UserID`, `Name`, `Email`, `Password`) VALUES
(1, 'Tom', 'tkennedy@smu.edu', 'pass');

-- --------------------------------------------------------

--
-- Table structure for table `UserRun`
--

CREATE TABLE `UserRun` (
  `UserID` int(6) NOT NULL,
`RunID` int(6) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `UserRun`
--

INSERT INTO `UserRun` (`UserID`, `RunID`) VALUES
(1, 1),
(2, 2);


ALTER TABLE `User`
 ADD PRIMARY KEY (`UserID`);

ALTER TABLE `UserRun`
 ADD PRIMARY KEY (`RunID`);


ALTER TABLE `User`
MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `UserRun`
--
ALTER TABLE `UserRun`
MODIFY `RunID` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;