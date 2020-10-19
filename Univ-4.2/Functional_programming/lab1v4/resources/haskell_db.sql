-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: univ_services_yk
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `idauthor` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idauthor`),
  UNIQUE KEY `idauthor_UNIQUE` (`idauthor`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Markuss','author1@gmail.com','+38author1phone'),(2,'Author2','author2@gmail.com','+38author2phone'),(3,'Author3','author3@gmail.com','+38author3phone'),(4,'Author4','author4@gmail.com','+38author4phone'),(6,'Author5','author1@gmail.com','+38author1phone'),(24,'nameT','mailT','phoneT'),(25,'Author25','author25@gmail.com','+38author25phone');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `legals`
--

DROP TABLE IF EXISTS `legals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `legals` (
  `idlegals` int NOT NULL AUTO_INCREMENT,
  `rules` text,
  `registration_info` text,
  `agreement` text,
  PRIMARY KEY (`idlegals`),
  UNIQUE KEY `idlegals_UNIQUE` (`idlegals`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legals`
--

LOCK TABLES `legals` WRITE;
/*!40000 ALTER TABLE `legals` DISABLE KEYS */;
/*!40000 ALTER TABLE `legals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `idService` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `annotation` varchar(45) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `eol` int DEFAULT NULL,
  `typeid` int DEFAULT NULL,
  `authorid` int DEFAULT NULL,
  `legalsid` int DEFAULT NULL,
  `statsid` int DEFAULT NULL,
  PRIMARY KEY (`idService`),
  UNIQUE KEY `idService_UNIQUE` (`idService`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `service_type_idx` (`typeid`),
  KEY `service_legals_idx` (`legalsid`),
  KEY `sevice_author_idx` (`authorid`),
  KEY `service_stats_idx` (`statsid`),
  CONSTRAINT `service_legals` FOREIGN KEY (`legalsid`) REFERENCES `legals` (`idlegals`),
  CONSTRAINT `service_stats` FOREIGN KEY (`statsid`) REFERENCES `stats` (`idstats`),
  CONSTRAINT `service_type` FOREIGN KEY (`typeid`) REFERENCES `types` (`idtypes`),
  CONSTRAINT `sevice_author` FOREIGN KEY (`authorid`) REFERENCES `authors` (`idauthor`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (3,'mtt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(4,'service4',NULL,NULL,'2020-05-01 21:28:43',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stats` (
  `idstats` int NOT NULL AUTO_INCREMENT,
  `users_registered` int unsigned DEFAULT '0',
  `popularity` int DEFAULT '0',
  PRIMARY KEY (`idstats`),
  UNIQUE KEY `idstats_UNIQUE` (`idstats`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `types` (
  `idtypes` int NOT NULL AUTO_INCREMENT,
  `typename` varchar(45) NOT NULL,
  PRIMARY KEY (`idtypes`),
  UNIQUE KEY `idtypes_UNIQUE` (`idtypes`),
  UNIQUE KEY `typename_UNIQUE` (`typename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-01 21:30:27
