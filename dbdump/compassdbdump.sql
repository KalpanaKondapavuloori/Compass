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
INSERT INTO `collection_meta` VALUES (1,24,'users'),(2,4,'roles'),(3,1,'projects'),(4,72,'issues'),(5,6,'queues');
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
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_activity`
--

LOCK TABLES `issue_activity` WRITE;
/*!40000 ALTER TABLE `issue_activity` DISABLE KEYS */;
INSERT INTO `issue_activity` VALUES (1,1,'',1,2,1,'2014-10-14 12:20:41','Admin Config','2014-10-14 12:20:41','Admin Config'),(2,3,'Pls work on this.',3,2,0,'2015-01-07 14:40:05','Anusha Saravanan','2015-01-29 13:24:11','3'),(3,3,NULL,3,2,0,'2015-01-08 16:26:29','3','2015-01-29 13:24:11','3'),(4,3,NULL,3,2,0,'2015-01-08 16:26:29','3','2015-01-29 13:24:11','3'),(5,3,NULL,3,2,0,'2015-01-08 16:28:36','3','2015-01-29 13:24:11','3'),(6,3,NULL,3,2,0,'2015-01-08 16:28:49','3','2015-01-29 13:24:11','3'),(7,3,NULL,3,2,0,'2015-01-08 16:28:49','3','2015-01-29 13:24:11','3'),(8,3,NULL,3,2,0,'2015-01-08 16:31:02','3','2015-01-29 13:24:11','3'),(9,3,NULL,3,2,0,'2015-01-08 16:33:19','3','2015-01-29 13:24:11','3'),(10,3,NULL,3,2,0,'2015-01-08 16:33:58','3','2015-01-29 13:24:11','3'),(11,3,NULL,3,2,0,'2015-01-08 16:33:58','3','2015-01-29 13:24:11','3'),(12,3,NULL,3,2,0,'2015-01-08 16:34:09','3','2015-01-29 13:24:11','3'),(13,3,NULL,3,2,0,'2015-01-08 16:34:09','3','2015-01-29 13:24:11','3'),(14,3,NULL,3,4,0,'2015-01-08 16:35:01','3','2015-01-29 13:24:11','3'),(15,3,'DO this',3,4,0,'2015-01-08 17:29:28','3','2015-01-29 13:24:11','3'),(16,3,'',3,2,0,'2015-01-08 17:39:31','3','2015-01-29 13:24:11','3'),(17,3,'',3,2,0,'2015-01-08 17:39:46','3','2015-01-29 13:24:11','3'),(18,3,'',3,2,0,'2015-01-08 17:40:13','3','2015-01-29 13:24:11','3'),(19,3,'',3,2,0,'2015-01-08 17:43:38','3','2015-01-29 13:24:11','3'),(20,3,'',3,5,0,'2015-01-08 17:45:08','3','2015-01-29 13:24:11','3'),(21,3,'',3,4,0,'2015-01-08 17:46:43','3','2015-01-29 13:24:11','3'),(22,3,'Please test in uat02.\ndfkhdk\n\'sdfkshdlkfsd\nfdslkfhsdlfsd\nfsdjflskd\nsdfjksdfksd\nsfdlkjlfks\nklsdfklsd',3,5,0,'2015-01-08 18:06:04','3','2015-01-29 13:24:11','3'),(23,4,'Pls work on this. Put the fix on uat02.',3,2,0,'2015-01-08 18:13:29','3','2015-02-09 11:53:08','5'),(24,4,'Please test in uat02.\nlksdfsd\nsdflksdl\nlksjflksd\nlksdjflksd\n',3,NULL,0,'2015-01-08 18:13:44','3','2015-02-09 11:53:08','5'),(25,4,'',3,NULL,0,'2015-01-08 18:26:10','3','2015-02-09 11:53:08','5'),(26,4,'',3,NULL,0,'2015-01-08 18:27:07','3','2015-02-09 11:53:08','5'),(27,4,'',3,3,0,'2015-01-08 18:28:31','3','2015-02-09 11:53:08','5'),(28,4,'',3,3,0,'2015-01-08 18:29:58','3','2015-02-09 11:53:08','5'),(29,3,'',3,3,0,'2015-01-08 18:29:58','3','2015-01-29 13:24:11','3'),(30,3,'',3,3,0,'2015-01-08 18:30:43','3','2015-01-29 13:24:11','3'),(31,3,'',3,NULL,0,'2015-01-08 18:45:00','3','2015-01-29 13:24:11','3'),(32,3,'',3,NULL,0,'2015-01-08 18:46:46','3','2015-01-29 13:24:11','3'),(33,3,'',3,NULL,0,'2015-01-08 18:47:54','3','2015-01-29 13:24:11','3'),(34,3,'',3,2,0,'2015-01-08 18:48:38','3','2015-01-29 13:24:11','3'),(35,3,'',3,2,0,'2015-01-08 18:48:38','3','2015-01-29 13:24:11','3'),(36,3,'Please test in yyt.\nrtyryrtyrt',3,NULL,0,'2015-01-08 18:48:48','3','2015-01-29 13:24:11','3'),(37,3,'',3,NULL,0,'2015-01-08 18:48:55','3','2015-01-29 13:24:11','3'),(38,6,'',3,3,0,'2015-01-09 12:38:39','3','2015-01-29 13:24:11','3'),(39,6,'',3,3,0,'2015-01-09 12:42:35','3','2015-01-29 13:24:11','3'),(40,6,'',3,3,0,'2015-01-09 12:43:49','3','2015-01-29 13:24:11','3'),(41,6,'',3,3,0,'2015-01-09 12:44:10','3','2015-01-29 13:24:11','3'),(42,5,'',3,3,0,'2015-01-09 12:46:22','3','2015-01-09 17:21:35','2'),(43,4,'',3,NULL,0,'2015-01-09 12:47:11','3','2015-02-09 11:53:08','5'),(44,4,'',3,3,0,'2015-01-09 12:49:18','3','2015-02-09 11:53:08','5'),(45,4,'Please test in sa.\nasdsadas',3,5,0,'2015-01-09 12:50:43','3','2015-02-09 11:53:08','5'),(46,4,'',3,NULL,0,'2015-01-09 12:51:09','3','2015-02-09 11:53:08','5'),(47,4,'',3,3,0,'2015-01-09 12:51:13','3','2015-02-09 11:53:08','5'),(48,4,'Please test in dfa.\nasdadas',3,NULL,0,'2015-01-09 12:56:06','3','2015-02-09 11:53:08','5'),(49,4,'',3,NULL,0,'2015-01-09 12:56:14','3','2015-02-09 11:53:08','5'),(50,4,'',3,3,0,'2015-01-09 12:56:20','3','2015-02-09 11:53:08','5'),(51,4,'Please test in dsadsa.\nasds',3,NULL,0,'2015-01-09 12:56:45','3','2015-02-09 11:53:08','5'),(52,4,'',3,NULL,0,'2015-01-09 12:56:50','3','2015-02-09 11:53:08','5'),(53,4,'',3,3,0,'2015-01-09 12:56:53','3','2015-02-09 11:53:08','5'),(54,4,'Please test in dffsgd.\ndfgdgdfg',3,5,0,'2015-01-09 12:57:44','3','2015-02-09 11:53:08','5'),(55,4,'',3,NULL,0,'2015-01-09 12:57:50','3','2015-02-09 11:53:08','5'),(56,4,'',3,3,0,'2015-01-09 12:57:54','3','2015-02-09 11:53:08','5'),(57,5,'Please test in Test in.\nsdkjfdslkfslkdf',3,5,0,'2015-01-09 12:58:42','3','2015-01-09 17:21:35','2'),(58,5,'',3,NULL,0,'2015-01-09 12:59:00','3','2015-01-09 17:21:35','2'),(59,5,'',3,3,0,'2015-01-09 12:59:12','3','2015-01-09 17:21:35','2'),(60,5,'dasdsad',3,4,0,'2015-01-09 12:59:31','3','2015-01-09 17:21:35','2'),(61,5,'dasdsad',3,4,0,'2015-01-09 12:59:31','3','2015-01-09 17:21:35','2'),(62,5,'Please test in asda.\ndasdasd',3,5,0,'2015-01-09 12:59:52','3','2015-01-09 17:21:35','2'),(63,5,'',3,NULL,0,'2015-01-09 12:59:58','3','2015-01-09 17:21:35','2'),(64,4,'Please test in UAT02.\ndkjfhakjdas',3,NULL,0,'2015-01-09 13:21:05','3','2015-02-09 11:53:08','5'),(65,4,'',5,5,0,'2015-01-09 13:22:17','5','2015-02-09 11:53:08','5'),(66,4,'',5,NULL,0,'2015-01-09 13:23:03','5','2015-02-09 11:53:08','5'),(67,4,'',2,2,0,'2015-01-09 13:24:30','2','2015-02-09 11:53:08','5'),(68,4,'Please test in uat02.\ntest again.',2,5,0,'2015-01-09 13:24:41','2','2015-02-09 11:53:08','5'),(69,5,'',3,NULL,0,'2015-01-09 13:33:23','3','2015-01-09 17:21:35','2'),(70,3,'',3,NULL,0,'2015-01-09 13:33:23','3','2015-01-29 13:24:11','3'),(71,3,'',3,NULL,0,'2015-01-09 13:38:18','3','2015-01-29 13:24:11','3'),(72,3,'',3,NULL,0,'2015-01-09 13:39:29','3','2015-01-29 13:24:11','3'),(73,5,'',3,NULL,0,'2015-01-09 13:39:29','3','2015-01-09 17:21:35','2'),(74,3,'adasds',3,4,0,'2015-01-09 13:39:57','3','2015-01-29 13:24:11','3'),(75,5,'',3,2,0,'2015-01-09 15:04:11','3','2015-01-09 17:21:35','2'),(76,4,'',5,5,0,'2015-01-09 17:20:23','5','2015-02-09 11:53:08','5'),(77,4,'',5,NULL,0,'2015-01-09 17:20:45','5','2015-02-09 11:53:08','5'),(78,4,'',5,NULL,0,'2015-01-09 17:20:45','5','2015-02-09 11:53:08','5'),(79,4,'',5,NULL,0,'2015-01-09 17:20:45','5','2015-02-09 11:53:08','5'),(80,4,'',2,2,0,'2015-01-09 17:21:15','2','2015-02-09 11:53:08','5'),(81,4,'Please test in sadad.\nasdasdasdas',2,5,0,'2015-01-09 17:21:23','2','2015-02-09 11:53:08','5'),(82,5,'',2,2,1,'2015-01-09 17:21:35','2','2015-01-09 17:21:35','2'),(83,4,'',5,NULL,0,'2015-01-14 14:35:30','5','2015-02-09 11:53:08','5'),(84,4,'',3,NULL,0,'2015-01-14 14:35:44','3','2015-02-09 11:53:08','5'),(85,4,'',3,3,0,'2015-01-14 15:21:12','3','2015-02-09 11:53:08','5'),(86,4,'Please test in uat02.\ncomments',2,5,0,'2015-01-22 15:07:14','2','2015-02-09 11:53:08','5'),(87,4,'',5,NULL,0,'2015-01-22 15:07:42','5','2015-02-09 11:53:08','5'),(88,4,'',2,2,0,'2015-01-22 15:08:24','2','2015-02-09 11:53:08','5'),(89,4,'',2,2,0,'2015-01-22 15:08:36','2','2015-02-09 11:53:08','5'),(90,4,'Please test in uat022.\nsdfslf',2,5,0,'2015-01-22 15:08:51','2','2015-02-09 11:53:08','5'),(91,4,'',5,NULL,0,'2015-01-22 15:09:49','5','2015-02-09 11:53:08','5'),(92,4,'sdsdfs',3,2,0,'2015-01-22 15:10:27','3','2015-02-09 11:53:08','5'),(93,4,'soome comm',3,2,0,'2015-01-22 15:22:42','3','2015-02-09 11:53:08','5'),(94,4,'adasdsa',3,2,0,'2015-01-22 15:24:37','3','2015-02-09 11:53:08','5'),(95,4,'Please test in uat2.\nakjdasjksd',3,NULL,0,'2015-01-22 15:28:20','3','2015-02-09 11:53:08','5'),(96,3,'Please test in uat02.\nkjsfh',3,5,0,'2015-01-22 15:29:00','3','2015-01-29 13:24:11','3'),(97,9,'New Issue Created',0,NULL,0,'2015-01-23 12:37:21','Anusha Saravanan','2015-01-29 13:24:11','3'),(98,10,'New Issue Created',0,NULL,0,'2015-01-23 12:38:52','Anusha Saravanan','2015-01-28 16:13:53','2'),(99,11,'New Issue Created',0,NULL,0,'2015-01-23 13:35:56','Anusha Saravanan','2015-01-29 13:28:45','3'),(100,11,'UAT02',3,2,0,'2015-01-27 12:34:20','3','2015-01-29 13:28:45','3'),(101,10,'UAT02',3,2,0,'2015-01-27 12:34:20','3','2015-01-28 16:13:53','2'),(102,9,'config',3,2,0,'2015-01-27 12:34:31','3','2015-01-29 13:24:11','3'),(103,11,'Please test in UAT02.\nPlease test.',2,5,0,'2015-01-27 12:35:57','2','2015-01-29 13:28:45','3'),(104,9,'Please test in uat02.\nplease test',2,5,0,'2015-01-27 12:36:10','2','2015-01-29 13:24:11','3'),(105,10,'Please test in uat02.\nplease test',2,5,0,'2015-01-27 12:36:10','2','2015-01-28 16:13:53','2'),(106,4,'',5,NULL,0,'2015-01-27 12:36:53','5','2015-02-09 11:53:08','5'),(107,10,'',5,NULL,0,'2015-01-27 12:36:53','5','2015-01-28 16:13:53','2'),(108,11,'',5,NULL,0,'2015-01-27 12:36:59','5','2015-01-29 13:28:45','3'),(109,9,'',5,NULL,0,'2015-01-27 12:36:59','5','2015-01-29 13:24:11','3'),(110,3,'',5,NULL,0,'2015-01-27 12:37:03','5','2015-01-29 13:24:11','3'),(111,10,'',2,2,0,'2015-01-27 12:37:36','2','2015-01-28 16:13:53','2'),(112,4,'',2,2,0,'2015-01-27 12:37:36','2','2015-02-09 11:53:08','5'),(113,10,'uat02\n',3,2,0,'2015-01-28 15:56:37','3','2015-01-28 16:13:53','2'),(114,4,'config',3,2,0,'2015-01-28 15:56:51','3','2015-02-09 11:53:08','5'),(115,10,'Please test in config and uat02..\nStep 1.\nStep 2.',2,5,0,'2015-01-28 15:57:28','2','2015-01-28 16:13:53','2'),(116,4,'Please test in config and uat02..\nStep 1.\nStep 2.',2,5,0,'2015-01-28 15:57:28','2','2015-02-09 11:53:08','5'),(117,10,'',5,2,0,'2015-01-28 16:00:30','5','2015-01-28 16:13:53','2'),(118,4,'',5,NULL,0,'2015-01-28 16:04:01','5','2015-02-09 11:53:08','5'),(119,10,'',2,2,1,'2015-01-28 16:13:53','2','2015-01-28 16:13:53','2'),(120,10,'',2,2,1,'2015-01-28 16:13:53','2','2015-01-28 16:13:53','2'),(121,6,'cnfig\n',3,2,0,'2015-01-28 16:15:41','3','2015-01-29 13:24:11','3'),(122,6,'Please test in uat02.\ntest',2,5,0,'2015-01-28 16:17:15','2','2015-01-29 13:24:11','3'),(123,6,'',5,2,0,'2015-01-28 16:18:22','5','2015-01-29 13:24:11','3'),(124,6,'',2,2,0,'2015-01-28 16:20:48','2','2015-01-29 13:24:11','3'),(125,6,'Please test in uat02.\nretest pls',2,5,0,'2015-01-28 16:23:36','2','2015-01-29 13:24:11','3'),(126,6,'Failed in uat02.',5,2,0,'2015-01-28 16:26:21','5','2015-01-29 13:24:11','3'),(127,6,'Please test in uat02.\nplease retest.',2,5,0,'2015-01-28 17:26:38','2','2015-01-29 13:24:11','3'),(128,6,'Teek he bhai. Pass ho gaya.',5,2,0,'2015-01-28 17:26:56','5','2015-01-29 13:24:11','3'),(129,4,'',3,NULL,0,'2015-01-28 17:29:25','3','2015-02-09 11:53:08','5'),(130,4,'',3,2,0,'2015-01-28 17:29:39','3','2015-02-09 11:53:08','5'),(131,4,'Please test in Uat02.\nlksdfld\nsdlkfjsdlk',2,NULL,0,'2015-01-28 17:30:12','2','2015-02-09 11:53:08','5'),(132,4,'',5,5,0,'2015-01-28 17:31:09','5','2015-02-09 11:53:08','5'),(133,4,'Failed',5,2,0,'2015-01-28 17:32:02','5','2015-02-09 11:53:08','5'),(134,6,'',3,NULL,0,'2015-01-29 13:21:50','3','2015-01-29 13:24:11','3'),(135,3,'',3,NULL,0,'2015-01-29 13:21:50','3','2015-01-29 13:24:11','3'),(136,9,'',3,NULL,0,'2015-01-29 13:21:50','3','2015-01-29 13:24:11','3'),(137,11,'',3,NULL,0,'2015-01-29 13:21:50','3','2015-01-29 13:28:45','3'),(138,6,'',3,NULL,0,'2015-01-29 13:22:30','3','2015-01-29 13:24:11','3'),(139,3,'',3,NULL,0,'2015-01-29 13:22:30','3','2015-01-29 13:24:11','3'),(140,3,'',3,2,0,'2015-01-29 13:22:38','3','2015-01-29 13:24:11','3'),(141,6,'',3,2,0,'2015-01-29 13:22:38','3','2015-01-29 13:24:11','3'),(142,3,'Please test in any.\nlkafdl',2,NULL,0,'2015-01-29 13:22:58','2','2015-01-29 13:24:11','3'),(143,6,'Please test in any.\nlkafdl',2,NULL,0,'2015-01-29 13:22:58','2','2015-01-29 13:24:11','3'),(144,3,'',5,2,0,'2015-01-29 13:23:08','5','2015-01-29 13:24:11','3'),(145,6,'',5,2,0,'2015-01-29 13:23:08','5','2015-01-29 13:24:11','3'),(146,3,'',3,NULL,0,'2015-01-29 13:23:23','3','2015-01-29 13:24:11','3'),(147,6,'',3,NULL,0,'2015-01-29 13:23:23','3','2015-01-29 13:24:11','3'),(148,3,'',3,NULL,1,'2015-01-29 13:24:11','3','2015-01-29 13:24:11','3'),(149,9,'',3,NULL,1,'2015-01-29 13:24:11','3','2015-01-29 13:24:11','3'),(150,11,'',3,NULL,0,'2015-01-29 13:24:11','3','2015-01-29 13:28:45','3'),(151,6,'',3,NULL,1,'2015-01-29 13:24:11','3','2015-01-29 13:24:11','3'),(152,11,'',3,NULL,0,'2015-01-29 13:28:29','3','2015-01-29 13:28:45','3'),(153,11,'',3,2,1,'2015-01-29 13:28:45','3','2015-01-29 13:28:45','3'),(154,12,'New Issue Created',0,NULL,1,'2015-01-30 16:23:37','Anusha Saravanan','2015-01-30 16:23:37','Anusha Saravanan'),(155,13,'New Issue Created',0,NULL,0,'2015-01-30 16:36:55','Anusha Saravanan','2015-01-30 16:41:53','5'),(156,13,'Please test in dfsdf.\ndsffsdf',3,NULL,0,'2015-01-30 16:41:26','3','2015-01-30 16:41:53','5'),(157,13,'Please test in dfsdf.\ndsffsdf',3,NULL,0,'2015-01-30 16:41:26','3','2015-01-30 16:41:53','5'),(158,13,'Please test in dfsdf.\ndsffsdf',3,NULL,0,'2015-01-30 16:41:26','3','2015-01-30 16:41:53','5'),(159,13,'aadsda',5,3,1,'2015-01-30 16:41:53','5','2015-01-30 16:41:53','5'),(160,4,'Please test in uat02.\nTEst 1\n',2,NULL,0,'2015-02-09 11:52:54','2','2015-02-09 11:53:08','5'),(161,4,'',5,2,1,'2015-02-09 11:53:08','5','2015-02-09 11:53:08','5');
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
  PRIMARY KEY (`id`),
  KEY `queues_from` (`from_queue`),
  KEY `queues_to` (`to_queue`),
  CONSTRAINT `issue_queues_ibfk_1` FOREIGN KEY (`from_queue`) REFERENCES `queues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `issue_queues_ibfk_2` FOREIGN KEY (`to_queue`) REFERENCES `queues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_queues`
--

LOCK TABLES `issue_queues` WRITE;
/*!40000 ALTER TABLE `issue_queues` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_test_case`
--

LOCK TABLES `issue_test_case` WRITE;
/*!40000 ALTER TABLE `issue_test_case` DISABLE KEYS */;
INSERT INTO `issue_test_case` VALUES (1,1,'config-t2','1. Login as Bill.Moor.\r\n2. Goto Opportunities->Offers.\r\n3. Open any offer.\r\n4. Check the lookup values for result reason field.\r\n5. Lookup values should have only short hyphen, not long hyphen.\r\n6. Login as bruce lewis, goto app.lookups.\r\n7. Check values for group ResultReason. None of the lookups should have spaces before or after name.','','2014-10-14 12:21:51','Admin Config','2014-10-14 12:21:51','Admin Config'),(2,3,'Config','Test case steps here','comments here','2015-01-07 14:42:33','Balaganesh Damodaran','2015-01-07 14:42:33','Balaganesh Damodaran');
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
  `current_owner` text,
  PRIMARY KEY (`id`),
  KEY `issues_project` (`project`),
  KEY `issues_queue` (`queue`),
  CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`project`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `issues_ibfk_2` FOREIGN KEY (`queue`) REFERENCES `queues` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
INSERT INTO `issues` VALUES (1,'116104','https://servicesource.my.salesforce.com/5006000000fN6lo?srPos=0&srKp=500','','','Issues with Lookup Value for Opportunities','PER Solomon de los Reyes\r\n\r\nFor the following Result/Reason lookup the name \"HA - Bad Data – BDT\" has two different kind of dashes in the display name. In addition the name for this lookup has a tab before the name, \"	haBDT\". Please resolve.                    ','Bluecoat',1,'Low','Deleted','2014-10-14 12:19:45','Admin Config','2015-01-07 14:49:53','Anusha Saravanan',2,NULL),(2,'','','','','','					','',1,'','Deleted','2015-01-06 15:15:01','Anusha Saravanan','2015-01-06 15:15:12','Anusha Saravanan',6,NULL),(3,'130589','https://servicesource.my.salesforce.com/5006000000ipzOU','','','Cisco Op-Gen Problems','PER Graham Carter\r\n problems experienced during Op-Gen.\r\n\r\nWe recently went through Op-Gen for 90,000 service Assets for Cisco.\r\n\r\n1) We tagged the Services Assets into batches of 2000 (47)\r\n2) Ran Op-Gen for all 47 tagged batches\r\n3) 31 of the batches generated Opportunities with no Offers\r\n4)Op-Gen had to be \'Undone\' but this left Opps with Opportunity Generated = True\r\n5) Remaining 31 batches Op-Gen\'d again and this left 11 batches with the same problem (No Offers)\r\n6) Repeated 4-5 until all were done.\r\n\r\nWe need to get Op-Gen fixed for Cisco Tenant as this is an enterprise customer with huge growth potential and we need to be able to load and Op-Gen without going through all the massaging and rework.\r\n\r\nThanks\r\n\r\nGraham','CiscoINC',1,'','Closed','2015-01-07 14:38:00','Anusha Saravanan','2015-01-07 14:42:33','',3,NULL),(4,'aadha','aodfjadz','','','test','oadla','aoij',1,'adfja','QA - Failed','2015-01-08 18:13:12','Anusha Saravanan','2015-01-14 15:02:24','3',2,NULL),(5,'123','','','','test issue','oadla','Bluecoat',1,'adfja','Deleted','2015-01-09 11:47:28','Anusha Saravanan','2015-01-23 12:16:19','Anusha Saravanan',4,'2'),(6,'123577','https://servicesource.my.salesforce.com/5006000000hCDyM','','','Saved filters on Opportunities Search page not functioning.','Hi Renew QA,\r\n\r\nThe saved or default filters on Opportunities Search page is not functioning. Example Error: SELLING-PERIOD: >=AN-aN-ONaN while it supposed to be FY15Q2 format.\r\n\r\nUser ID: cho\r\nCurrent Issue: Saved or default filters for field SELLING-PERIOD on Opportunities Search page is not functioning. Its displaying unknown character. (>=AN-aN-ONaN)\r\nSteps:\r\n1. Go to Opportunities Search Page and clicked on one of the Save Filters example: Q2Q3.\r\n2. On the Search row where u can input your search field, you will notice that the Field for SELLING-PERIOD: >=AN-aN-ONaN. If i\'m not mistaken it suppose to be in FY15Q3 format.\r\n3. But however if you performed a normal search where you input in the field that you need, the SELLING-PERIOD field seem to be working fine.\r\nExpected Result: Saved or default filters for field SELLING-PERIOD on Opportunities Search page functioning.\r\nScreenshot: Kindly find the attachment as your references.\r\nTested using Bill Moore profile still the same issue.\r\n\r\nPlease assist.\r\n\r\nThanks,\r\nLionel','Blackboard',1,'','Closed','2015-01-09 12:21:26','Anusha Saravanan','0000-00-00 00:00:00','',3,NULL),(7,'231','lkd','','','Some Issue','sldkfl','bb',1,'','New','2015-01-23 12:15:42','Anusha Saravanan','0000-00-00 00:00:00','',6,NULL),(8,'1234','url','','','New Issue','addkfad','BB',1,'','New','2015-01-23 12:16:35','Anusha Saravanan','0000-00-00 00:00:00','',6,NULL),(9,'2345','kjfhdkj','','','Test New Issue','adjkfhaskj','Test',1,'','Closed','2015-01-23 12:37:21','Anusha Saravanan','2015-02-09 11:45:12','Anusha Saravanan',3,'5'),(10,'sdfhk','skjfhsk','','','Test New Issue 2','adkjfad','ddlfk',1,'','Deleted','2015-01-23 12:38:52','Anusha Saravanan','2015-01-28 16:14:49','Balaganesh Damodaran',2,'2'),(11,'34566','kjsdhfk','','','New Issue 3','kjadfkjad','jhkdf',1,'','Reopened','2015-01-23 13:35:56','Anusha Saravanan','0000-00-00 00:00:00','',2,'2'),(12,'93','dlkfjl','','','test','sldkjf;lsdk','Stryker',1,'','New','2015-01-30 16:23:37','Anusha Saravanan','0000-00-00 00:00:00','',6,NULL),(13,'ExtID','klsdhf','','','Test New Issue 3','sdkhfk','Stryker',1,'','QA - Passed','2015-01-30 16:36:55','Anusha Saravanan','0000-00-00 00:00:00','',4,NULL);
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_insert_issues AFTER INSERT ON issues
FOR EACH ROW UPDATE collection_meta SET count = count + 1 WHERE collection = "issues" */;;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_update_issues AFTER UPDATE ON issues FOR EACH ROW BEGIN
IF (OLD.status <> NEW.status) THEN
UPDATE collection_meta SET count = count + IF(NEW.status = "Deleted", -1, 1) WHERE collection = "issues";
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_delete_issues AFTER DELETE ON issues
FOR EACH ROW UPDATE collection_meta SET count = count - 1 WHERE collection = "issues" */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset`
--

LOCK TABLES `password_reset` WRITE;
/*!40000 ALTER TABLE `password_reset` DISABLE KEYS */;
INSERT INTO `password_reset` VALUES (4,'48d4a7591b2bdf7979aa9792a3d46b0e',12,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(5,'9677cd81658f4ddba8d82b2e33b829e1',13,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(6,'0a1c96a0a5793a692e55b2598447cb37',14,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(7,'0e5cb92028f6f2ccb56b6edb91d01ef8',15,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(8,'4426ae34dde4191d4740a346cbc1eb1e',16,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(9,'57bae5b163bfb1b5ceaa99fa89164553',17,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(10,'47d7a1ac6f00aa75f83c8ebb52ba3c27',18,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(11,'16d46ab22f2da06fdb77605e6bb0182d',19,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(12,'59c1f7c0d4e5bdc6c9eaa223be66f676',20,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(13,'81a65c3fd83d2d47db66e695a8c47ef1',21,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(14,'a0838adf6f50b79c637e2edf25115fdf',22,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(15,'62f838a0dccdfb9224cbffe3b43a21c4',23,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(16,'7c8eed75efc7b31a7b4819bc480e7cf6',24,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(17,'153397ae478c47afcfb0e03e2b44a448',25,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(18,'3c3ad8a99ddd02ef37336035edde3ec3',26,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(19,'81c9b7cd9b215321d8ed79aad5369fa7',28,'0000-00-00 00:00:00','','0000-00-00 00:00:00',''),(20,'1632b89b08e1dff3936c97e7ded2e813',2,'0000-00-00 00:00:00','','0000-00-00 00:00:00','');
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
  `flow_config` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (1,'ROD Config','Renew On Demand Tenant Configuration','2015-09-16 00:00:00','Anusha','2015-01-30 16:41:20','1','{\"users\":{\"defaults\":{\"role\":\"Developer\"}},\"issues\":{\"list\":{\"queue\":{\"QA\":\"QA\",\"Developer\":\"Dev\",\"*\":\"*\"},\"owner\":{\"Developer\":\"@user\",\"*\":\"*\"}},\"fields\":{\"available\":{\"status\":[\"New\",\"Open\",\"QA - Pending\",\"QA - Failed\",\"QA - Passed\",\"Released\",\"Closed\",\"Reopened\"]},\"defaults\":{\"status\":\"New\",\"queue\":\"Need To Work\"}},\"flows\":{\"assignDev\":{\"transitions\":{\"status\":{\"New\":\"Open\",\"*\":\"Reopened\"},\"queue\":{\"*\":\"Dev\"},\"current_owner\":{\"*\":\"$currentOwner\"}},\"conditions\":{\"status\":[\"!QA - Pending\",\"!QA - Passed\"]},\"sideEffects\":{\"activity\":{\"assignedTo\":\"$currentOwner\"},\"notify\":[{\"to\":\"@assignee\",\"template\":{\"key\":\"issueAssigned\",\"values\":{\"issue\":{\"id\":\"#id\",\"summary\":\"#subject\",\"tenant\":\"#tenant\",\"comments\":\"$comments\",\"externalID\":\"#external_id\",\"externalURL\":\"#external_url\"}}}}]}},\"assignQA\":{\"transitions\":{\"status\":{\"*\":\"QA - Pending\"},\"queue\":{\"*\":\"QA\"},\"current_owner\":{\"*\":\"$currentOwner\"}},\"conditions\":{\"status\":[\"Open\",\"Reopened\",\"New\",\"QA - Failed\"]},\"sideEffects\":{\"activity\":{\"assignedTo\":\"$currentOwner\"},\"notify\":[{\"to\":\"@assignee\",\"template\":{\"key\":\"issueAssigned\",\"values\":{\"issue\":{\"id\":\"#id\",\"summary\":\"#subject\",\"tenant\":\"#tenant\",\"comments\":\"$comments\",\"externalID\":\"#external_id\",\"externalURL\":\"#external_url\"}}}}]}},\"takeIssueQA\":{\"transitions\":{\"current_owner\":{\"*\":\"@user\"}},\"conditions\":{\"status\":[\"QA - Pending\"]},\"sideEffects\":{\"activity\":{\"assignedTo\":\"@user\"}}},\"takeIssueDev\":{\"transitions\":{\"status\":{\"Reopened\":\"Reopened\",\"*\":\"Open\"},\"current_owner\":{\"*\":\"@user\"}},\"conditions\":{\"status\":[\"!QA - Pending\",\"!QA - Passed\",\"!Released\",\"!Closed\"]},\"sideEffects\":{\"activity\":{\"assignedTo\":\"@user\"}}},\"releaseIssue\":{\"transitions\":{\"status\":{\"*\":\"Released\"},\"queue\":{\"*\":\"Released\"}},\"conditions\":{\"status\":[\"QA - Passed\"]}},\"closeIssue\":{\"transitions\":{\"status\":{\"*\":\"Closed\"},\"queue\":{\"*\":\"Released\"}},\"conditions\":{\"status\":[\"Released\"]}},\"reopenIssue\":{\"transitions\":{\"status\":{\"*\":\"Reopened\"},\"queue\":{\"*\":\"Need To Work\"}},\"conditions\":{\"status\":[\"QA - Passed\",\"QA - Failed\",\"Closed\",\"Released\"]}},\"passIssue\":{\"transitions\":{\"status\":{\"*\":\"QA - Passed\"},\"queue\":{\"*\":\"Pending Release\"}},\"conditions\":{\"status\":[\"QA - Pending\"]},\"sideEffects\":{\"notify\":[{\"to\":\"@previousOwner\",\"template\":{\"key\":\"issuePassed\",\"values\":{\"issue\":{\"id\":\"#id\",\"summary\":\"#subject\",\"tenant\":\"#tenant\",\"comments\":\"$comments\",\"externalID\":\"#external_id\",\"externalURL\":\"#external_url\"}}}}]}},\"failIssue\":{\"transitions\":{\"status\":{\"*\":\"QA - Failed\"},\"queue\":{\"*\":\"Dev\"}},\"conditions\":{\"status\":[\"QA - Pending\"]},\"sideEffects\":{\"activity\":{\"assignedTo\":\"@previousOwner\"},\"notify\":[{\"to\":\"@previousOwner\",\"template\":{\"key\":\"issueFailed\",\"values\":{\"issue\":{\"id\":\"#id\",\"summary\":\"#subject\",\"tenant\":\"#tenant\",\"comments\":\"$comments\",\"externalID\":\"#external_id\",\"externalURL\":\"#external_url\"}}}}]}}}}}');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_insert_projects AFTER INSERT ON projects
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_delete_projects AFTER DELETE ON projects
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queues`
--

LOCK TABLES `queues` WRITE;
/*!40000 ALTER TABLE `queues` DISABLE KEYS */;
INSERT INTO `queues` VALUES (1,'QA',1,'2014-09-26 15:05:56','adminconfig','0000-00-00 00:00:00',''),(2,'Dev',1,'2014-09-26 15:06:03','adminconfig','0000-00-00 00:00:00',''),(3,'Released',1,'2014-09-26 15:06:10','adminconfig','0000-00-00 00:00:00',''),(4,'Pending Release',1,'2014-09-26 15:06:17','adminconfig','0000-00-00 00:00:00',''),(5,'Product Team',1,'2014-09-26 15:06:25','adminconfig','0000-00-00 00:00:00',''),(6,'Need To Work',1,'2015-01-06 15:14:37','Anusha Saravanan','0000-00-00 00:00:00','');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_insert_queues AFTER INSERT ON queues
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_delete_queues AFTER DELETE ON queues
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
INSERT INTO `roles` VALUES (1,'Manager','2014-09-16 00:00:00','Anusha','2014-09-29 17:56:01','adminconfig','{\"users\":{\"create\":true,\"read\":true,\"update\":true,\"del\":true,\"global\":true},\"roles\":{\"create\":true,\"read\":true,\"update\":true,\"del\":true},\"projects\":{\"create\":true,\"read\":true,\"update\":true,\"del\":true},\"queues\":{\"create\":true,\"read\":true,\"update\":true,\"del\":true}}'),(2,'Lead','2014-09-16 00:00:00','Anusha','2015-01-30 16:14:44','Admin Config','{\"users\":{\"create\":true,\"read\":true,\"update\":true,\"del\":true,\"global\":true},\"queues\":{\"create\":true,\"read\":true,\"update\":true,\"del\":true},\"issues\":{\"create\":true,\"read\":true,\"assignDev\":true,\"delete\":true,\"take\":true,\"resolve\":true,\"assignQA\":true,\"update\":true,\"release\":true,\"close\":true,\"reopen\":true}}'),(3,'Developer','2014-09-16 00:00:00','Anusha','2015-01-09 13:24:20','Admin Config','{\"users\":{\"create\":false,\"read\":true,\"update\":{\"default\":true,\"project\":false,\"role\":false},\"del\":false},\"issues\":{\"assignQA\":true,\"read\":true,\"take\":true,\"update\":true}}'),(4,'QA','2014-09-16 00:00:00','Anusha','2015-01-09 13:21:45','Admin Config','{\"users\":{\"create\":false,\"read\":true,\"update\":{\"default\":true,\"project\":false,\"role\":false},\"del\":false},\"issues\":{\"take\":true,\"resolve\":true,\"read\":true}}');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_insert_roles AFTER INSERT ON roles
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_delete_roles AFTER DELETE ON roles
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
  UNIQUE KEY `user_unique_email` (`email`),
  KEY `users_role` (`role`),
  KEY `users_project_id` (`project`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`project`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin Config','petrodconfig@gmail.com','$2a$10$V1zESqqu4V4MIM6l8nT.gOFEym5Ju3G73w91CxsazYqP25ehW/m2y',NULL,1,1,1,'',NULL,'2014-09-16 00:00:00','Anusha','2014-09-29 18:05:23','1'),(2,'Balaganesh Damodaran','balaganeshd@positiveedge.net','$2a$10$VNPQVl2pBqIVHB1H2pA4wuKQOCd2RYmfFUYsKNCSE6GmaDfmt.1te',NULL,3,1,1,'',NULL,'2014-09-26 14:47:14','1','2015-02-09 11:52:04','3'),(3,'Anusha Saravanan','anushasr@positiveedge.net','$2a$10$1vjZ8OV8jjE67.pJ/KljWe45lzj.31DBuQD0WMyxM0IY.gzQghOW6',NULL,2,1,1,'',NULL,'2014-09-26 14:48:00','1',NULL,NULL),(4,'Akshay Kamble','akshayk@positiveedge.net','$2a$10$ZajTNc0rWOJ9c1tVM4/mAefSupEShGYsCH5nSlahMCgxOEBYaHP/a',NULL,3,1,1,'',NULL,'2014-09-26 14:51:46','1',NULL,NULL),(5,'Avishek Kumar Singh','avisheks@positiveedge.net','$2a$10$T2nuI82ExJAArLKJu0peG.x8YJvGzIe0JcSAHK.DxH1wXliZB84fW',NULL,4,1,1,'',NULL,'2014-09-29 14:21:45','1',NULL,NULL),(8,'Test User Inactive','bg.play@gmail.com','$2a$10$0wrZW9muuGeENlrgkQ6iCuG2fZNCvC4sCdNekwlXfjop.kjdzCGg.',NULL,2,1,0,'',NULL,'2015-01-21 13:12:40','3',NULL,NULL),(9,'Test User Inactive 1','bg.play+t4@gmail.com','$2a$10$CC5glWHm5.NT0AWyLZ90E.eCh64QH7aAj6uvB95V73guIOJe/PKYu',NULL,2,1,0,'',NULL,'2015-01-21 13:16:47','3',NULL,NULL),(10,'Test User Inactive 2','bg.play+t5@gmail.com','$2a$10$PUZKbgf/Df5V5riqfJKWoembGw5jwglEsacu27BwVHOXfQiQV35wy',NULL,2,1,0,'',NULL,'2015-01-21 13:19:00','3',NULL,NULL),(12,'Test User Role','bg.play+t6@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-21 13:34:00','3',NULL,NULL),(13,'Test Emails','bg.play+t8@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 12:37:00','3',NULL,NULL),(14,'Test Email 2','bg.play+t9@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 12:38:50','3',NULL,NULL),(15,'Test Email 3','bg.play+t10@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 12:39:44','3',NULL,NULL),(16,'Test Email 4','bg.play+t16@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 12:40:35','3',NULL,NULL),(17,'Test User Inactive 1','bg.play+t17@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 12:43:05','3',NULL,NULL),(18,'Test User Role','bg.play+t18@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 12:43:42','3',NULL,NULL),(19,'tedfad','bg.play+t116@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 12:44:39','3',NULL,NULL),(20,'Test User Inactive 2','bg.play+t14@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 13:36:54','3',NULL,NULL),(21,'telhsd','bg.play+t15@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 13:38:36','3',NULL,NULL),(22,'adasd','bg.play+t61@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 13:39:52','3',NULL,NULL),(23,'sadad','dadajsk@sdlhflds.dafasd','',NULL,3,1,0,'',NULL,'2015-01-22 13:40:51','3',NULL,NULL),(24,'ahiashdhsald','dskj@sjkfdkasdjkka.asdkjksa','',NULL,3,1,0,'zfha',NULL,'2015-01-22 13:43:00','3',NULL,NULL),(25,'mail test','bg.play+t62@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 13:43:27','3',NULL,NULL),(26,'name','bg.play+t41@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 13:44:30','3',NULL,NULL),(28,'Test Email User','bg.play+t1161@gmail.com','',NULL,3,1,0,'',NULL,'2015-01-22 13:47:05','3',NULL,NULL);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_insert_users AFTER INSERT ON users
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
/*!50003 CREATE*/ /*!50017 DEFINER=`compassapi`@`localhost`*/ /*!50003 TRIGGER collection_meta_delete_users AFTER DELETE ON users
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

-- Dump completed on 2015-02-17 12:44:51
