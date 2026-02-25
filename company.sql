/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: company
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dname` varchar(15) NOT NULL,
  `Dnumber` int(11) NOT NULL,
  `Mgr_ssn` char(9) DEFAULT NULL,
  `Mgr_start_date` date DEFAULT NULL,
  PRIMARY KEY (`Dnumber`),
  UNIQUE KEY `dname` (`dname`),
  KEY `Mgr_ssn` (`Mgr_ssn`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`Mgr_ssn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `chk_mgr_start` CHECK (`Mgr_start_date` >= '1970-01-01')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES
('Headquarters',1,'888665555','1981-06-19'),
('Administration',4,'987654321','1995-01-01'),
('Research',5,'123456789','2007-10-01');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependent`
--

DROP TABLE IF EXISTS `dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependent` (
  `essn` char(9) NOT NULL,
  `dependent_name` varchar(15) NOT NULL,
  `gender` char(1) DEFAULT NULL,
  `bdtate` date DEFAULT NULL,
  `relationship` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`essn`,`dependent_name`),
  CONSTRAINT `dependent_ibfk_1` FOREIGN KEY (`essn`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES
('123456789','alice','f','1988-12-30','daughter'),
('123456789','elizabeth','f','1967-05-05','spouse'),
('123456789','michael','m','1968-01-04','son'),
('333445555','alice','f','1986-04-05','daughter'),
('333445555','joy','f','1958-05-03','spouse'),
('333445555','theodore','m','1963-10-25','son'),
('453453453','John','M','1990-12-12','spouse'),
('987654321','abner','m','1942-02-28','spouse');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_locations`
--

DROP TABLE IF EXISTS `dept_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dept_locations` (
  `dno` int(11) NOT NULL,
  `dlocation` varchar(15) NOT NULL,
  PRIMARY KEY (`dno`,`dlocation`),
  CONSTRAINT `dept_locations_ibfk_1` FOREIGN KEY (`dno`) REFERENCES `department` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_locations`
--

LOCK TABLES `dept_locations` WRITE;
/*!40000 ALTER TABLE `dept_locations` DISABLE KEYS */;
INSERT INTO `dept_locations` VALUES
(1,'houston'),
(4,'houston'),
(5,'bellaire'),
(5,'sugarland');
/*!40000 ALTER TABLE `dept_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `fname` varchar(15) NOT NULL,
  `Minit` char(1) DEFAULT NULL,
  `lname` varchar(15) NOT NULL,
  `ssn` char(9) NOT NULL,
  `Bdate` date DEFAULT NULL,
  `Address` varchar(30) DEFAULT 'Not Provided',
  `Sex` char(1) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT 25000.00,
  `Super_ssn` char(9) DEFAULT NULL,
  `Dno` int(11) DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `Dno` (`Dno`),
  KEY `Super_ssn` (`Super_ssn`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`Super_ssn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`Super_ssn`) REFERENCES `employee` (`ssn`) ON DELETE SET NULL,
  CONSTRAINT `chk_salary` CHECK (`Salary` > 0),
  CONSTRAINT `chk_sex` CHECK (`Sex` in ('M','F')),
  CONSTRAINT `chk_bdate` CHECK (`Bdate` < '2030-12-31')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES
('John','B','Smith','123456789','1965-01-09','731 Fondren','m',30000.00,'333445555',5),
('Franklin','T','Wong','333445555','1955-12-08','638 Voss','m',40000.00,'888665555',5),
('Joyce','A','English','453453453','1972-07-31','5361 rice, houston','f',25000.00,'333445555',5),
('Richard','k','marini','653298653','1962-12-30','oak forest','m',37000.00,'653298653',4),
('Ramesh','K','Narayan','666884444','1962-09-15','975 fire oak, houston','m',38000.00,'333445555',5),
('James','E','Borg','888665555','1937-11-10','450 stone, houston','m',55000.00,'987654321',1),
('Jennifer','S','Wallace','987654321','1941-06-20','291 berry, houston','f',43000.00,'888665555',4),
('Ahmed','V','Jabber','987987987','1969-03-29','980 dallas, houston','m',25000.00,'987654321',4),
('Alicia','J','Zelaya','999887777','1968-07-19','3321 castle, houston','f',25000.00,'987654321',4);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project` (
  `pname` varchar(15) NOT NULL,
  `pno` int(11) NOT NULL,
  `plocation` varchar(15) DEFAULT NULL,
  `dno` int(11) DEFAULT NULL,
  PRIMARY KEY (`pno`),
  KEY `dno` (`dno`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`dno`) REFERENCES `department` (`Dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES
('productx',1,'bellaire',5),
('producty',2,'sugarland',5),
('productz',3,'houston',5),
('computirazion',10,'stafford',4),
('reorganization',20,'houston',1),
('newbenefits',30,'stafford',4);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `works_on` (
  `essn` char(9) NOT NULL,
  `pno` int(11) NOT NULL,
  `hours` decimal(3,1) DEFAULT 0.0,
  PRIMARY KEY (`essn`,`pno`),
  KEY `pno` (`pno`),
  CONSTRAINT `fk_work_emp` FOREIGN KEY (`essn`) REFERENCES `employee` (`ssn`) ON DELETE CASCADE,
  CONSTRAINT `works_on_ibfk_2` FOREIGN KEY (`essn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `chk_hours` CHECK (`hours` >= 0 and `hours` <= 60)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
INSERT INTO `works_on` VALUES
('123456789',1,32.5),
('123456789',2,7.5),
('453453453',1,20.0),
('453453453',2,20.0),
('666884444',3,40.0),
('888665555',20,10.0),
('987654321',20,15.0),
('987654321',30,20.0),
('987987987',10,35.5),
('987987987',30,5.0),
('999887777',10,5.0),
('999887777',30,30.0);
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-25 13:39:05
