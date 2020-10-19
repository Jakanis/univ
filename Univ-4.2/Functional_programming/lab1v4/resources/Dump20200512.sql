-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: univ_services_yk
-- ------------------------------------------------------
-- Server version	5.7.30-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authors` (
  `idauthor` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idauthor`),
  UNIQUE KEY `idauthor_UNIQUE` (`idauthor`)
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Markuss','Mark@gmail.com','+380...'),(2,'Wendi','Wendi@gmail.com','+38WendiPhone'),(3,'Alina','Alina@gmail.com','+38AlinaPhone'),(4,'Nikolya','Nikolya@gmail.com','+38NikolyaPhone'),(6,'Angelinka','Angelinka@gmail.com','+38AngelinkaPhone'),(24,'Eliziya','Eliziya@gmail.com','+38EliziyaPhone'),(116,'Zhitaryuk Yuli4ka','yZh@gmail.com','+380...'),(138,'Who am I?','I don`t know','+380...'),(222,'Kukushka','kk@gmail.com','+380...');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `legals`
--

DROP TABLE IF EXISTS `legals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `legals` (
  `idlegals` int(11) NOT NULL AUTO_INCREMENT,
  `rules` varchar(255) DEFAULT NULL,
  `registration_info` varchar(255) DEFAULT NULL,
  `agreement` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idlegals`),
  UNIQUE KEY `idlegals_UNIQUE` (`idlegals`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `legals`
--

LOCK TABLES `legals` WRITE;
/*!40000 ALTER TABLE `legals` DISABLE KEYS */;
INSERT INTO `legals` VALUES (26,'rule26','registration_info26','agreement26'),(27,'rule27','registration_info27','agreement27'),(28,'rule28','registration_info28','agreement28'),(29,'rule29','registration_info29','agreement29'),(30,'rule30','registration_info30','agreement30'),(31,'rule31','registration_info31','agreement31'),(56,'rules 7436 5','registered info','agree 223'),(58,'rules 7436 5','registered info','agree 223'),(60,'rules 7436 5','registered info','agree 223'),(62,'rules 7436 5','registered info','agree 223');
/*!40000 ALTER TABLE `legals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `idService` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `annotation` varchar(45) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `created` int(11) DEFAULT NULL,
  `eol` int(11) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  `authorid` int(11) DEFAULT NULL,
  `legalsid` int(11) DEFAULT NULL,
  `statsid` int(11) DEFAULT NULL,
  PRIMARY KEY (`idService`),
  UNIQUE KEY `idService_UNIQUE` (`idService`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (3,'service3','annotation3','version3',4,4747,45,1,26,40),(4,'serv4','not my service ann','v18.04',14,53,46,1,27,41),(39,'service39','annotation39','version39',243,46546,47,3,28,42),(50,'service50','annotation50','version50',243,45456,46,4,29,43),(51,'service51','annotation51','version51',24,363,47,6,30,44),(52,'service52','annotation52','version52',24,52,47,24,31,53);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stats` (
  `idstats` int(11) NOT NULL AUTO_INCREMENT,
  `users_registered` int(10) unsigned DEFAULT '0',
  `popularity` int(11) DEFAULT '0',
  PRIMARY KEY (`idstats`),
  UNIQUE KEY `idstats_UNIQUE` (`idstats`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stats`
--

LOCK TABLES `stats` WRITE;
/*!40000 ALTER TABLE `stats` DISABLE KEYS */;
INSERT INTO `stats` VALUES (40,90,500),(41,85,457),(42,35,256),(43,89,747),(44,94,375),(53,126,432);
/*!40000 ALTER TABLE `stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `idtypes` int(11) NOT NULL AUTO_INCREMENT,
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
INSERT INTO `types` VALUES (46,'ForStudents'),(47,'Internal'),(45,'Open');
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

-- Dump completed on 2020-05-12 14:53:00
