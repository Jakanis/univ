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
) ENGINE=InnoDB AUTO_INCREMENT=360 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Author1','author1@gmail.com','+380509293701'),(2,'Author2','author2@gmail.com','+380509293702'),(3,'Author3','author3@gmail.com','+380509293703'),(4,'Author4','author4@gmail.com','+380509293704'),(5,'Author5','author5@gmail.com','+380509293705');
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
  `rules` varchar(255) DEFAULT NULL,
  `registration_info` varchar(255) DEFAULT NULL,
  `agreement` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idlegals`),
  UNIQUE KEY `idlegals_UNIQUE` (`idlegals`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legals`
--

LOCK TABLES `legals` WRITE;
/*!40000 ALTER TABLE `legals` DISABLE KEYS */;
INSERT INTO `legals` VALUES (1,'rule1','registration_info1','agreement1'),(2,'rule2','registration_info2','agreement2'),(3,'rule3','registration_info3','agreement3'),(4,'rule4','registration_info4','agreement4'),(5,'rule5','registration_info5','agreement5');
/*!40000 ALTER TABLE `legals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `idService` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `annotation` varchar(45) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `created` int DEFAULT NULL,
  `eol` int DEFAULT NULL,
  `typeid` int DEFAULT NULL,
  `authorid` int DEFAULT NULL,
  `legalsid` int DEFAULT NULL,
  `statsid` int DEFAULT NULL,
  PRIMARY KEY (`idService`),
  UNIQUE KEY `idService_UNIQUE` (`idService`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'service1','annotation1','version1',4,4747,1,1,1,1),(2,'service2','annotation2','v2.0',14,53,1,1,2,2),(3,'service3','annotation3','v3',243,46546,2,3,3,3),(4,'service4','annotation4','v4',243,45456,3,4,4,4),(5,'service5','annotation5','v5',24,363,3,5,5,5);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
INSERT INTO `stats` VALUES (1,90,500),(2,85,457),(3,35,256),(4,89,747),(5,94,375);
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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'ForStudents'),(2,'Internal'),(3,'Open');
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

-- Dump completed on 2020-05-13 16:03:21
