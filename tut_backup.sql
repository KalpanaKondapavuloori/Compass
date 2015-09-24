-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: compassdb
-- ------------------------------------------------------
-- Server version	5.5.38-0ubuntu0.12.04.1

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
-- Table structure for table `collection_meta`
--

DROP TABLE IF EXISTS `collection_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collection_meta` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `count` int(11) NOT NULL,
  `collection` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `collection_meta_collection` (`collection`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collection_meta`
--

LOCK TABLES `collection_meta` WRITE;
/*!40000 ALTER TABLE `collection_meta` DISABLE KEYS */;
INSERT INTO `collection_meta` VALUES (1,6,'users'),(2,4,'roles'),(3,2,'projects'),(4,2,'issues'),(5,8,'queues');
/*!40000 ALTER TABLE `collection_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_activity`
--

DROP TABLE IF EXISTS `issue_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue` int(11) NOT NULL,
  `comments` text,
  `assigned_by` tinyint(4) DEFAULT NULL,
  `assigned_to` tinyint(4) DEFAULT NULL,
  `isCurrent` tinyint(1) NOT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `modified_on` datetime NOT NULL,
  `modified_by` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_activity_issue` (`issue`),
  CONSTRAINT `issue_activity_ibfk_1` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_activity`
--

LOCK TABLES `issue_activity` WRITE;
/*!40000 ALTER TABLE `issue_activity` DISABLE KEYS */;
INSERT INTO `issue_activity` VALUES (1,8,'fix in config',1,3,0,'2014-11-03 16:40:50','adminconfig','2014-12-09 16:29:46','Anusha Saravanan'),(2,8,'',3,2,0,'2014-11-03 16:52:17','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(3,8,'',2,2,0,'2014-11-17 15:24:47','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(4,8,'Fix in config',5,3,0,'2014-11-19 15:13:53','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan'),(5,8,'ds',5,3,0,'2014-11-19 16:17:14','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan'),(6,8,'',3,2,0,'2014-11-19 16:17:59','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(7,8,'fix in confi..',1,3,0,'2014-11-25 16:35:48','adminconfig','2014-12-09 16:29:46','Anusha Saravanan'),(8,8,'',3,3,0,'2014-11-25 16:49:38','Pabitra','2014-12-09 16:29:46','Anusha Saravanan'),(9,8,'s',5,3,0,'2014-11-25 16:51:23','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan'),(10,10,'config',5,3,0,'2014-11-26 12:42:37','Anusha Saravanan','2014-12-09 17:26:28','Inder Kumar'),(11,10,'config',5,3,0,'2014-11-26 12:42:37','Anusha Saravanan','2014-12-09 17:26:28','Inder Kumar'),(12,10,'',3,2,0,'2014-11-26 13:06:12','Inder Kumar','2014-12-09 17:26:28','Inder Kumar'),(13,10,'',2,2,0,'2014-11-26 13:06:22','Inder Kumar','2014-12-09 17:26:28','Inder Kumar'),(14,8,'',3,2,0,'2014-11-26 13:10:10','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(15,8,'',2,3,0,'2014-11-26 13:10:15','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(16,8,'',3,2,0,'2014-11-26 15:07:36','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(17,8,'',2,3,0,'2014-11-26 15:07:53','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(18,8,'',3,2,0,'2014-11-26 15:08:26','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(19,8,'sdgf',5,3,0,'2014-11-26 15:31:16','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan'),(20,8,'',3,2,0,'2014-11-26 15:31:56','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(21,8,'Try to fix as soon as possible',5,3,0,'2014-11-26 16:15:11','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan'),(22,8,'',3,2,0,'2014-11-26 16:16:49','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(23,6,'fix in config',5,3,0,'2014-11-26 16:45:01','Anusha Saravanan','2014-11-26 16:47:28','Inder Kumar'),(24,6,'',3,2,1,'2014-11-26 16:47:28','Inder Kumar','2014-11-26 16:47:28','Inder Kumar'),(25,7,'',5,3,0,'2014-11-26 16:48:54','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan'),(26,7,'fail',2,5,0,'2014-11-26 16:50:03','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(27,8,'',5,3,0,'2014-11-26 16:51:35','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan'),(28,8,'',3,2,0,'2014-11-26 16:52:02','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(29,8,'',2,3,0,'2014-11-26 16:52:10','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(30,7,'',5,2,0,'2014-11-26 17:06:11','Inder Kumar','2014-12-09 16:29:46','Anusha Saravanan'),(31,7,'',5,3,1,'2014-12-09 16:29:46','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan'),(32,8,'',5,3,1,'2014-12-09 16:29:46','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan'),(33,10,'',5,3,0,'2014-12-09 17:25:33','Anusha Saravanan','2014-12-09 17:26:28','Inder Kumar'),(34,10,'',3,2,1,'2014-12-09 17:26:28','Inder Kumar','2014-12-09 17:26:28','Inder Kumar'),(35,9,'test',5,3,1,'2014-12-16 11:55:56','Anusha Saravanan','2014-12-16 11:55:56','Anusha Saravanan'),(36,9,'test',5,3,1,'2014-12-16 11:55:56','Anusha Saravanan','2014-12-16 11:55:56','Anusha Saravanan');
/*!40000 ALTER TABLE `issue_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_queues`
--

DROP TABLE IF EXISTS `issue_queues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_queues` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `from_queue` tinyint(4) NOT NULL,
  `to_queue` tinyint(4) NOT NULL,
  `comments` text,
  `created_on` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `modified_on` datetime NOT NULL,
  `modified_by` varchar(30) NOT NULL,
  `issue` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `queues_from` (`from_queue`),
  KEY `queues_to` (`to_queue`),
  KEY `issue_queues_ibfk_3` (`issue`),
  CONSTRAINT `issue_queues_ibfk_1` FOREIGN KEY (`from_queue`) REFERENCES `queues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `issue_queues_ibfk_2` FOREIGN KEY (`to_queue`) REFERENCES `queues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `issue_queues_ibfk_3` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_queues`
--

LOCK TABLES `issue_queues` WRITE;
/*!40000 ALTER TABLE `issue_queues` DISABLE KEYS */;
INSERT INTO `issue_queues` VALUES (1,2,3,'test...','2014-11-03 16:40:31','adminconfig','2014-11-03 16:40:31','adminconfig',8),(2,1,2,'fix in config','2014-11-03 16:40:50','adminconfig','2014-11-03 16:40:50','adminconfig',8),(3,2,3,'test','2014-11-03 16:50:07','Pabitra','2014-11-03 16:50:07','Pabitra',8),(4,3,6,'passed','2014-11-17 15:25:03','Inder Kumar','2014-11-17 15:25:03','Inder Kumar',8),(5,6,7,'rdfhtg','2014-11-17 15:54:28','Anusha Saravanan','2014-11-17 15:54:28','Anusha Saravanan',8),(6,7,1,'failed','2014-11-17 15:57:18','Anusha Saravanan','2014-11-17 15:57:18','Anusha Saravanan',8),(7,7,1,'failed','2014-11-17 15:58:13','Anusha Saravanan','2014-11-17 15:58:13','Anusha Saravanan',8),(8,1,2,'Fix in config','2014-11-19 15:13:53','Anusha Saravanan','2014-11-19 15:13:53','Anusha Saravanan',8),(9,2,3,'test in config....','2014-11-19 16:13:11','Pabitra','2014-11-19 16:13:11','Pabitra',8),(10,6,7,'','2014-11-19 16:13:20','Pabitra','2014-11-19 16:13:20','Pabitra',8),(11,2,3,'czcx','2014-11-19 16:14:11','Pabitra','2014-11-19 16:14:11','Pabitra',8),(12,6,7,'','2014-11-19 16:14:11','Pabitra','2014-11-19 16:14:11','Pabitra',8),(13,7,1,'failed','2014-11-19 16:16:58','Anusha Saravanan','2014-11-19 16:16:58','Anusha Saravanan',8),(14,1,2,'ds','2014-11-19 16:17:14','Anusha Saravanan','2014-11-19 16:17:14','Anusha Saravanan',8),(15,2,3,'sad','2014-11-19 16:17:39','Pabitra','2014-11-19 16:17:39','Pabitra',8),(16,6,7,'','2014-11-19 16:17:39','Pabitra','2014-11-19 16:17:39','Pabitra',8),(17,3,6,'sadsd','2014-11-19 16:18:11','Inder Kumar','2014-11-19 16:18:11','Inder Kumar',8),(18,6,7,'wsd','2014-11-19 16:18:44','Anusha Saravanan','2014-11-19 16:18:44','Anusha Saravanan',8),(19,7,1,'sas','2014-11-19 16:18:56','Anusha Saravanan','2014-11-19 16:18:56','Anusha Saravanan',8),(20,1,2,'fix in confi..','2014-11-25 16:35:48','adminconfig','2014-11-25 16:35:48','adminconfig',8),(21,2,3,'test in config','2014-11-25 16:50:29','Pabitra','2014-11-25 16:50:29','Pabitra',8),(22,6,7,'','2014-11-25 16:50:29','Pabitra','2014-11-25 16:50:29','Pabitra',8),(23,1,2,'s','2014-11-25 16:51:23','Anusha Saravanan','2014-11-25 16:51:23','Anusha Saravanan',8),(24,2,3,'test','2014-11-25 16:51:52','Pabitra','2014-11-25 16:51:52','Pabitra',8),(25,6,7,'','2014-11-25 16:51:52','Pabitra','2014-11-25 16:51:52','Pabitra',8),(26,2,3,'cjbv','2014-11-25 16:52:21','Pabitra','2014-11-25 16:52:21','Pabitra',8),(27,6,7,'','2014-11-25 16:52:21','Pabitra','2014-11-25 16:52:21','Pabitra',8),(28,7,1,'','2014-11-26 12:30:40','Anusha Saravanan','2014-11-26 12:30:40','Anusha Saravanan',8),(29,7,1,'','2014-11-26 12:30:43','Anusha Saravanan','2014-11-26 12:30:43','Anusha Saravanan',8),(30,1,2,'config','2014-11-26 12:42:37','Anusha Saravanan','2014-11-26 12:42:37','Anusha Saravanan',10),(31,1,2,'config','2014-11-26 12:42:37','Anusha Saravanan','2014-11-26 12:42:37','Anusha Saravanan',10),(32,2,3,'waresh','2014-11-26 12:45:01','Pabitra','2014-11-26 12:45:01','Pabitra',10),(33,6,7,'','2014-11-26 12:45:01','Pabitra','2014-11-26 12:45:01','Pabitra',10),(34,2,3,'esgd','2014-11-26 12:46:23','Pabitra','2014-11-26 12:46:23','Pabitra',10),(35,6,7,'','2014-11-26 12:46:23','Pabitra','2014-11-26 12:46:23','Pabitra',10),(36,2,3,'dx','2014-11-26 12:54:25','Pabitra','2014-11-26 12:54:25','Pabitra',10),(37,6,7,'','2014-11-26 12:54:25','Pabitra','2014-11-26 12:54:25','Pabitra',10),(38,2,3,'xgfcgv','2014-11-26 13:05:15','Pabitra','2014-11-26 13:05:15','Pabitra',10),(39,3,6,'','2014-11-26 13:07:28','Inder Kumar','2014-11-26 13:07:28','Inder Kumar',10),(40,6,7,'sf','2014-11-26 13:07:48','Anusha Saravanan','2014-11-26 13:07:48','Anusha Saravanan',10),(41,6,7,'sf','2014-11-26 13:07:51','Anusha Saravanan','2014-11-26 13:07:51','Anusha Saravanan',10),(42,7,1,'qERETR','2014-11-26 13:08:04','Anusha Saravanan','2014-11-26 13:08:04','Anusha Saravanan',10),(43,2,3,'SDGFH','2014-11-26 13:09:11','Pabitra','2014-11-26 13:09:11','Pabitra',8),(44,3,2,'','2014-11-26 13:10:15','Inder Kumar','2014-11-26 13:10:15','Inder Kumar',8),(45,2,3,'TDRY','2014-11-26 13:10:54','Pabitra','2014-11-26 13:10:54','Pabitra',8),(46,3,2,'','2014-11-26 15:07:53','Inder Kumar','2014-11-26 15:07:53','Inder Kumar',8),(47,2,3,'cbv','2014-11-26 15:08:13','Pabitra','2014-11-26 15:08:13','Pabitra',8),(48,3,6,'gf','2014-11-26 15:08:32','Inder Kumar','2014-11-26 15:08:32','Inder Kumar',8),(49,6,7,'pass','2014-11-26 15:14:33','Anusha Saravanan','2014-11-26 15:14:33','Anusha Saravanan',8),(50,6,7,'pass','2014-11-26 15:25:16','Anusha Saravanan','2014-11-26 15:25:16','Anusha Saravanan',8),(51,6,7,'passed','2014-11-26 15:27:10','Anusha Saravanan','2014-11-26 15:27:10','Anusha Saravanan',8),(52,6,7,'df','2014-11-26 15:27:54','Anusha Saravanan','2014-11-26 15:27:54','Anusha Saravanan',8),(53,6,7,'sdgfg','2014-11-26 15:29:20','Anusha Saravanan','2014-11-26 15:29:20','Anusha Saravanan',8),(54,7,1,'dd','2014-11-26 15:30:18','Anusha Saravanan','2014-11-26 15:30:18','Anusha Saravanan',8),(55,2,3,'dfgh','2014-11-26 15:30:57','Anusha Saravanan','2014-11-26 15:30:57','Anusha Saravanan',8),(56,1,2,'sdgf','2014-11-26 15:31:16','Anusha Saravanan','2014-11-26 15:31:16','Anusha Saravanan',8),(57,2,3,'j','2014-11-26 15:31:30','Pabitra','2014-11-26 15:31:30','Pabitra',8),(58,3,6,'fdf','2014-11-26 15:32:06','Inder Kumar','2014-11-26 15:32:06','Inder Kumar',8),(59,2,3,'ads','2014-11-26 15:36:30','Anusha Saravanan','2014-11-26 15:36:30','Anusha Saravanan',8),(60,3,6,'wxsac','2014-11-26 15:36:38','Inder Kumar','2014-11-26 15:36:38','Inder Kumar',8),(61,2,3,'','2014-11-26 15:37:36','Anusha Saravanan','2014-11-26 15:37:36','Anusha Saravanan',8),(62,3,6,'wxsac','2014-11-26 15:37:46','Inder Kumar','2014-11-26 15:37:46','Inder Kumar',8),(63,2,3,'','2014-11-26 15:44:55','Anusha Saravanan','2014-11-26 15:44:55','Anusha Saravanan',8),(64,3,6,'wxsac','2014-11-26 15:48:18','Inder Kumar','2014-11-26 15:48:18','Inder Kumar',8),(65,3,6,'wxsac','2014-11-26 15:50:18','Inder Kumar','2014-11-26 15:50:18','Inder Kumar',8),(66,2,3,'','2014-11-26 15:52:49','Anusha Saravanan','2014-11-26 15:52:49','Anusha Saravanan',8),(67,3,6,'wxsac','2014-11-26 15:52:56','Inder Kumar','2014-11-26 15:52:56','Inder Kumar',8),(68,2,3,'','2014-11-26 15:54:26','Anusha Saravanan','2014-11-26 15:54:26','Anusha Saravanan',8),(69,3,6,'wxsac','2014-11-26 15:54:31','Inder Kumar','2014-11-26 15:54:31','Inder Kumar',8),(70,6,7,'','2014-11-26 15:55:12','Anusha Saravanan','2014-11-26 15:55:12','Anusha Saravanan',8),(71,1,2,'Try to fix as soon as possible','2014-11-26 16:15:11','Anusha Saravanan','2014-11-26 16:15:11','Anusha Saravanan',8),(72,2,3,'test as soon as possible','2014-11-26 16:16:27','Pabitra','2014-11-26 16:16:27','Pabitra',8),(73,3,6,'Working as Expected.','2014-11-26 16:17:13','Inder Kumar','2014-11-26 16:17:13','Inder Kumar',8),(74,1,2,'fix in config','2014-11-26 16:45:01','Anusha Saravanan','2014-11-26 16:45:01','Anusha Saravanan',6),(75,2,3,'test in config','2014-11-26 16:46:40','Pabitra','2014-11-26 16:46:40','Pabitra',6),(76,3,6,'Working as expected.','2014-11-26 16:48:19','Inder Kumar','2014-11-26 16:48:19','Inder Kumar',6),(77,1,2,'','2014-11-26 16:48:54','Anusha Saravanan','2014-11-26 16:48:54','Anusha Saravanan',7),(78,2,3,'','2014-11-26 16:49:14','Pabitra','2014-11-26 16:49:14','Pabitra',7),(79,3,2,'fail','2014-11-26 16:50:03','Inder Kumar','2014-11-26 16:50:03','Inder Kumar',7),(80,1,2,'','2014-11-26 16:51:35','Anusha Saravanan','2014-11-26 16:51:35','Anusha Saravanan',8),(81,2,3,'','2014-11-26 16:51:49','Pabitra','2014-11-26 16:51:49','Pabitra',8),(82,3,2,'','2014-11-26 16:52:10','Inder Kumar','2014-11-26 16:52:10','Inder Kumar',8),(83,6,7,'','2014-11-26 17:03:12','Anusha Saravanan','2014-11-26 17:03:12','Anusha Saravanan',6),(84,6,7,'','2014-11-26 17:03:37','Anusha Saravanan','2014-11-26 17:03:37','Anusha Saravanan',7),(85,2,3,'','2014-11-26 17:05:18','Anusha Saravanan','2014-11-26 17:05:18','Anusha Saravanan',6),(86,2,3,'','2014-11-26 17:05:52','Anusha Saravanan','2014-11-26 17:05:52','Anusha Saravanan',7),(87,1,2,'','2014-12-09 16:29:46','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan',8),(88,1,2,'','2014-12-09 16:29:46','Anusha Saravanan','2014-12-09 16:29:46','Anusha Saravanan',7),(89,1,2,'','2014-12-09 17:25:33','Anusha Saravanan','2014-12-09 17:25:33','Anusha Saravanan',10),(90,2,3,'','2014-12-09 17:26:11','Pabitra','2014-12-09 17:26:11','Pabitra',10),(91,3,6,'','2014-12-09 17:26:36','Inder Kumar','2014-12-09 17:26:36','Inder Kumar',10),(92,1,2,'test','2014-12-16 11:55:56','Anusha Saravanan','2014-12-16 11:55:56','Anusha Saravanan',9),(93,1,2,'test','2014-12-16 11:55:56','Anusha Saravanan','2014-12-16 11:55:56','Anusha Saravanan',9);
/*!40000 ALTER TABLE `issue_queues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_test_case`
--

DROP TABLE IF EXISTS `issue_test_case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue_test_case` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue` int(11) NOT NULL,
  `environment` varchar(30) DEFAULT NULL,
  `steps` text NOT NULL,
  `comments` text,
  `created_on` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `modified_on` datetime NOT NULL,
  `modified_by` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_test_case_issue` (`issue`),
  CONSTRAINT `issue_test_case_ibfk_1` FOREIGN KEY (`issue`) REFERENCES `issues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_test_case`
--

LOCK TABLES `issue_test_case` WRITE;
/*!40000 ALTER TABLE `issue_test_case` DISABLE KEYS */;
INSERT INTO `issue_test_case` VALUES (1,6,'Stg-next','Test case','comments','2014-10-07 15:09:44','Pabitra','2014-10-07 15:09:44','Pabitra'),(2,8,'Config -t2','Test Case','Comment','2014-10-20 15:45:42','Pabitra','2014-10-20 15:45:42','Pabitra'),(3,9,'Caonfig-t2','test case','Comment','2014-10-20 15:54:27','Pabitra','2014-10-20 15:54:27','Pabitra'),(4,10,'t2','test case','Comment','2014-10-20 16:08:20','Pabitra','2014-10-20 16:08:20','Pabitra'),(5,6,'config','1.\r\n2.\r\n3.','Test ASAP','2014-10-30 15:40:48','Pabitra','2014-10-30 15:40:48','Pabitra'),(6,8,'config','1.','.','2014-10-30 15:44:59','Pabitra','2014-10-30 15:44:59','Pabitra'),(7,9,'t2','1;...','','2014-10-30 15:45:15','Pabitra','2014-10-30 15:45:15','Pabitra'),(8,8,'t2','...','','2014-10-30 15:46:33','Pabitra','2014-10-30 15:46:33','Pabitra'),(9,9,'config','1.','','2014-10-31 10:56:36','Pabitra','2014-10-31 10:56:36','Pabitra'),(10,9,'cionfj','xd','','2014-10-31 12:21:46','Pabitra','2014-10-31 12:21:46','Pabitra'),(11,9,'config','','','2014-10-31 12:25:08','Pabitra','2014-10-31 12:25:08','Pabitra'),(12,9,'t2','','','2014-10-31 12:27:21','Pabitra','2014-10-31 12:27:21','Pabitra'),(13,9,'t2','','','2014-10-31 12:28:04','Pabitra','2014-10-31 12:28:04','Pabitra'),(14,9,'t2','','','2014-10-31 12:41:02','Pabitra','2014-10-31 12:41:02','Pabitra'),(15,9,'','','','2014-10-31 12:46:19','Pabitra','2014-10-31 12:46:19','Pabitra'),(16,9,'','','','2014-10-31 12:48:02','Pabitra','2014-10-31 12:48:02','Pabitra'),(17,9,'config','1.\r\n2.\r\n','test','2014-11-03 16:03:33','Pabitra','2014-11-03 16:03:33','Pabitra'),(18,9,'t2','gfhg','h','2014-11-03 16:05:37','Pabitra','2014-11-03 16:05:37','Pabitra'),(19,9,'asd','sfdcvs','dxf','2014-11-03 16:08:12','Pabitra','2014-11-03 16:08:12','Pabitra'),(20,9,'Config','Test case','Comment','2014-11-03 16:25:48','Pabitra','2014-11-03 16:25:48','Pabitra'),(21,9,'t2','test cases','cmmt','2014-11-03 16:30:42','Pabitra','2014-11-03 16:30:42','Pabitra'),(22,9,'t22','test casess','c','2014-11-03 16:32:48','Pabitra','2014-11-03 16:32:48','Pabitra'),(23,8,'config','1.\r\n2.','test...','2014-11-03 16:40:31','adminconfig','2014-11-03 16:40:31','adminconfig'),(24,8,'config','1.\r\n2.\r\n','test','2014-11-03 16:50:07','Pabitra','2014-11-03 16:50:07','Pabitra'),(25,8,'config','1.\r\n2.\r\n','test in config....','2014-11-19 16:13:11','Pabitra','2014-11-19 16:13:11','Pabitra'),(26,8,'sd','sasdx','czcx','2014-11-19 16:14:11','Pabitra','2014-11-19 16:14:11','Pabitra'),(27,8,'daf','sasd','sad','2014-11-19 16:17:39','Pabitra','2014-11-19 16:17:39','Pabitra'),(28,8,'config','1.\r\n2.\r\n','test in config','2014-11-25 16:50:29','Pabitra','2014-11-25 16:50:29','Pabitra'),(29,8,'config','1\r\n2\r\n','test','2014-11-25 16:51:52','Pabitra','2014-11-25 16:51:52','Pabitra'),(30,8,'srd','fhcgjv','cjbv','2014-11-25 16:52:21','Pabitra','2014-11-25 16:52:21','Pabitra'),(31,10,'config','1.\r\n2.\r\n','waresh','2014-11-26 12:45:01','Pabitra','2014-11-26 12:45:01','Pabitra'),(32,10,'wrse','sregxc','esgd','2014-11-26 12:46:23','Pabitra','2014-11-26 12:46:23','Pabitra'),(33,10,'ersf','fds','dx','2014-11-26 12:54:25','Pabitra','2014-11-26 12:54:25','Pabitra'),(34,10,'sfdcgv','dxgfchgv','xgfcgv','2014-11-26 13:05:14','Pabitra','2014-11-26 13:05:14','Pabitra'),(35,8,'AG','SDF','SDGFH','2014-11-26 13:09:11','Pabitra','2014-11-26 13:09:11','Pabitra'),(36,8,'QEWRSERD','RSETDF','TDRY','2014-11-26 13:10:54','Pabitra','2014-11-26 13:10:54','Pabitra'),(37,8,'fg','gfcb','cbv','2014-11-26 15:08:13','Pabitra','2014-11-26 15:08:13','Pabitra'),(38,8,'tdfg','fdgh','dfgh','2014-11-26 15:30:57','Anusha Saravanan','2014-11-26 15:30:57','Anusha Saravanan'),(39,8,'dfcvhj','tuyhjgh','j','2014-11-26 15:31:30','Pabitra','2014-11-26 15:31:30','Pabitra'),(40,8,'efd','efdesf','ads','2014-11-26 15:36:30','Anusha Saravanan','2014-11-26 15:36:30','Anusha Saravanan'),(41,8,'','','','2014-11-26 15:37:36','Anusha Saravanan','2014-11-26 15:37:36','Anusha Saravanan'),(42,8,'','','','2014-11-26 15:44:55','Anusha Saravanan','2014-11-26 15:44:55','Anusha Saravanan'),(43,8,'','','','2014-11-26 15:52:49','Anusha Saravanan','2014-11-26 15:52:49','Anusha Saravanan'),(44,8,'','','','2014-11-26 15:54:25','Anusha Saravanan','2014-11-26 15:54:25','Anusha Saravanan'),(45,8,'t2','1.\r\n2.\r\n3.','test as soon as possible','2014-11-26 16:16:27','Pabitra','2014-11-26 16:16:27','Pabitra'),(46,6,'config','1.\r\n2.\r\n','test in config','2014-11-26 16:46:40','Pabitra','2014-11-26 16:46:40','Pabitra'),(47,7,'','','','2014-11-26 16:49:14','Pabitra','2014-11-26 16:49:14','Pabitra'),(48,8,'','','','2014-11-26 16:51:49','Pabitra','2014-11-26 16:51:49','Pabitra'),(49,6,'','','','2014-11-26 17:05:18','Anusha Saravanan','2014-11-26 17:05:18','Anusha Saravanan'),(50,7,'config','1. open a opp tab','','2014-11-26 17:05:52','Anusha Saravanan','2014-11-26 17:05:52','Anusha Saravanan'),(51,10,'','','','2014-12-09 17:26:11','Pabitra','2014-12-09 17:26:11','Pabitra');
/*!40000 ALTER TABLE `issue_test_case` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `external_id` varchar(30) DEFAULT NULL,
  `external_url` varchar(2083) DEFAULT NULL,
  `external_category` varchar(30) DEFAULT NULL,
  `external_severity` varchar(5) DEFAULT NULL,
  `subject` varchar(500) NOT NULL,
  `description` text NOT NULL,
  `tenant` varchar(50) NOT NULL,
  `project` smallint(6) NOT NULL,
  `severity` varchar(5) DEFAULT NULL,
  `status` varchar(30) NOT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `modified_on` datetime NOT NULL,
  `modified_by` varchar(30) NOT NULL,
  `queue` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issues_project` (`project`),
  KEY `issues_queue` (`queue`),
  CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`project`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `issues_ibfk_2` FOREIGN KEY (`queue`) REFERENCES `queues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
INSERT INTO `issues` VALUES (6,'SFDC101','URL','Category','SREV1','Test Subject','Test Desc','Aspect',1,'PET1','QA-pending','0000-00-00 00:00:00','Pabitra','2014-11-26 17:05:18','Anusha Saravanan',3),(7,'SFDC102','URL2','Category2','SREV2','Test Subject2','Test Desc 2','Blackboard',1,'PET2','Open','0000-00-00 00:00:00','Pabitra','2014-12-09 16:29:46','Anusha Saravanan',2),(8,'178596','url','cat','srev','Test Issue','test                            ','BlackBoard',1,'srev','Open','2014-10-20 15:31:54','adminconfig','2014-12-09 16:29:46','Anusha Saravanan',2),(9,'14585','url','cat','srev','Test Issue1','            Test                ','BlackBoard',1,'srev','Open','2014-10-20 15:52:21','adminconfig','2014-12-16 11:55:56','Anusha Saravanan',2),(10,'7845','url1','cat1','srev1','Test Issue45','test                            ','BlackBoard',1,'srev','Fixed','2014-10-20 16:06:48','adminconfig','2014-12-09 17:26:36','Inder Kumar',6),(11,'0001','Ext URL','Ext Category','Ext S','For testing purpose','                            ','Test',1,'0','Deleted','2014-11-26 16:24:08','Anusha Saravanan','2014-11-26 17:00:40','Anusha Saravanan',1),(12,'','','','','','                            ','0',1,'0','New','2014-11-26 17:09:18','Anusha Saravanan','0000-00-00 00:00:00','',1),(13,'111','','','','','                            ','test',1,'0','New','2014-12-11 11:49:49','Anusha Saravanan','0000-00-00 00:00:00','',1),(14,'SFDC23','url1','Ext Category','Ext S','For testing purpose','TEST','Aspect',1,'srev2','New','2014-12-11 12:02:47','Anusha Saravanan','0000-00-00 00:00:00','',1),(15,'','','','','','                            ','',1,'','New','2014-12-11 16:25:59','Anusha Saravanan','0000-00-00 00:00:00','',1),(16,'11111','','','','','                            ','',1,'','New','2014-12-11 16:26:15','Anusha Saravanan','0000-00-00 00:00:00','',1);
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset`
--

DROP TABLE IF EXISTS `password_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `code` varchar(40) NOT NULL,
  `user` smallint(6) NOT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `modified_on` datetime NOT NULL,
  `modified_by` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `password_reset_user` (`user`),
  KEY `password_reset_code` (`code`),
  CONSTRAINT `password_reset_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset`
--

LOCK TABLES `password_reset` WRITE;
/*!40000 ALTER TABLE `password_reset` DISABLE KEYS */;
INSERT INTO `password_reset` VALUES (1,'43e301731f382e3567db219fb04c040b',6,'0000-00-00 00:00:00','','0000-00-00 00:00:00','');
/*!40000 ALTER TABLE `password_reset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `modified_on` datetime DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'ROD Config','Test','2015-09-16 00:00:00','Anusha',NULL,NULL),(2,'Atlas CRM','Test','0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00',NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER collection_meta_insert_projects AFTER INSERT ON projects
FOR EACH ROW UPDATE collection_meta SET count = count + 1 WHERE collection = "projects" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER collection_meta_delete_projects AFTER DELETE ON projects
FOR EACH ROW UPDATE collection_meta SET count = count - 1 WHERE collection = "projects" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `queues`
--

DROP TABLE IF EXISTS `queues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queues` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `project` smallint(6) NOT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `modified_on` datetime NOT NULL,
  `modified_by` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_queues_project` (`project`),
  CONSTRAINT `queues_ibfk_1` FOREIGN KEY (`project`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queues`
--

LOCK TABLES `queues` WRITE;
/*!40000 ALTER TABLE `queues` DISABLE KEYS */;
INSERT INTO `queues` VALUES (1,'Need To Work',1,'0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00','Pabitra'),(2,'Dev',1,'0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00','Pabitra'),(3,'QA',1,'0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00','Pabitra'),(4,'Need To Work',2,'0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00','Pabitra'),(5,'Dev',2,'0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00','Pabitra'),(6,'To Be Released',1,'0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00','Pabitra'),(7,'Released',1,'0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00','Pabitra'),(8,'QA-pending',1,'0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00','Pabitra');
/*!40000 ALTER TABLE `queues` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER collection_meta_insert_queues AFTER INSERT ON queues
FOR EACH ROW UPDATE collection_meta SET count = count + 1 WHERE collection = "queues" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER collection_meta_delete_queues AFTER DELETE ON queues
FOR EACH ROW UPDATE collection_meta SET count = count - 1 WHERE collection = "queues" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `created_on` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `modified_on` datetime DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  `permissions` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Manager','2014-09-16 00:00:00','Anusha',NULL,NULL,'{\"users\":{\"create\":true,\"read\":true,\"update\":true,\"del\":true,\"global\":true}}'),(2,'Lead','2014-09-16 00:00:00','Anusha',NULL,NULL,'{\"users\":{\"create\":false,\"read\":true,\"update\":true,\"del\":true,\"global\":true},\"issues\":{\"create\":true,\"assignDev\":true,\"delete\":true,\"resolve\":true,\"assignQA\":true,\"release\":true,\"reopen\":true}}'),(3,'Developer','2014-09-16 00:00:00','Anusha',NULL,NULL,'{\"users\":{\"create\":false,\"read\":true,\"update\":{\"default\":true,\"project\":false,\"role\":false},\"del\":false},\"issues\":{\"assignQA\":true}}'),(4,'QA','2014-09-16 00:00:00','Anusha',NULL,NULL,'{\"users\":{\"create\":false,\"read\":false,\"update\":{\"default\":true,\"project\":false,\"role\":false},\"del\":false},\"issues\":{\"take\":true,\"resolve\":true}}');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER collection_meta_insert_roles AFTER INSERT ON roles
FOR EACH ROW UPDATE collection_meta SET count = count + 1 WHERE collection = "roles" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER collection_meta_delete_roles AFTER DELETE ON roles
FOR EACH ROW UPDATE collection_meta SET count = count - 1 WHERE collection = "roles" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(65) NOT NULL,
  `img_url` varchar(250) DEFAULT NULL,
  `role` tinyint(4) NOT NULL,
  `project` smallint(6) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `phone` varchar(25) DEFAULT NULL,
  `about` text,
  `created_on` datetime NOT NULL,
  `created_by` varchar(30) NOT NULL,
  `modified_on` datetime DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_role` (`role`),
  KEY `users_project_id` (`project`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`project`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'adminconfig','petrodconfig@gmail.com','$2a$10$V1zESqqu4V4MIM6l8nT.gOFEym5Ju3G73w91CxsazYqP25ehW/m2y',NULL,1,1,1,NULL,NULL,'2014-09-16 00:00:00','Anusha',NULL,NULL),(2,'Inder Kumar','inderk@positiveedge.net','$2a$10$V1zESqqu4V4MIM6l8nT.gOFEym5Ju3G73w91CxsazYqP25ehW/m2y',NULL,4,1,1,'','','2014-09-16 00:00:00','',NULL,NULL),(3,'Pabitra','pray@positiveedge.net','$2a$10$V1zESqqu4V4MIM6l8nT.gOFEym5Ju3G73w91CxsazYqP25ehW/m2y',NULL,3,1,1,NULL,NULL,'2014-09-16 00:00:00','Pabitra','2014-09-16 00:00:00',NULL),(4,'Akshaya','akshay@positiveedge.net','$2a$10$V1zESqqu4V4MIM6l8nT.gOFEym5Ju3G73w91CxsazYqP25ehW/m2y',NULL,3,1,1,NULL,NULL,'2014-09-16 00:00:00','Pabitra','2014-09-16 00:00:00',NULL),(5,'Anusha Saravanan','anushasr@positiveedge.net','$2a$10$.WoRO/H4j8m4L/ZpF1TRqeg91wTugOo2Lz4jHAoiVgL.gMRlLdljO',NULL,2,1,1,'',NULL,'2014-11-11 12:10:04','1',NULL,NULL),(6,'Avishek Kumar','test@positiveedge.net','',NULL,3,1,1,'',NULL,'2014-11-26 17:10:44','1',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER collection_meta_insert_users AFTER INSERT ON users
FOR EACH ROW UPDATE collection_meta SET count = count + 1 WHERE collection = "users" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_update_users AFTER UPDATE ON users FOR EACH ROW BEGIN
IF (OLD.active <> NEW.active) THEN
UPDATE collection_meta SET count = count + IF(NEW.active = 1, 1, -1) WHERE collection = "users";
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER collection_meta_delete_users AFTER DELETE ON users
FOR EACH ROW UPDATE collection_meta SET count = count - 1 WHERE collection = "users" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-16 12:19:17
