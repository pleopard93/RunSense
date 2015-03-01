-- phpMyAdmin SQL Dump
-- version 4.2.5
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Mar 01, 2015 at 02:49 AM
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
  `Foot` char(1) NOT NULL,
  `Metrics` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
`UserID` int(11) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Email` varchar(25) NOT NULL,
  `Password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `UserRun`
--

CREATE TABLE `UserRun` (
  `UserID` int(6) NOT NULL,
`RunID` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `User`
--
ALTER TABLE `User`
 ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `UserRun`
--
ALTER TABLE `UserRun`
 ADD PRIMARY KEY (`RunID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `UserRun`
--
ALTER TABLE `UserRun`
MODIFY `RunID` int(6) NOT NULL AUTO_INCREMENT;