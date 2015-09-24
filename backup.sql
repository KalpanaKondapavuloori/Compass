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
INSERT INTO `collection_meta` VALUES (1,4,'users'),(2,4,'roles'),(3,2,'projects'),(4,2,'issues'),(5,8,'queues');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_activity`
--

LOCK TABLES `issue_activity` WRITE;
/*!40000 ALTER TABLE `issue_activity` DISABLE KEYS */;
INSERT INTO `issue_activity` VALUES (1,6,'FIx in config',1,3,0,'2014-09-30 12:01:30','adminconfig','2014-10-14 15:26:13','Inder Kumar'),(2,6,'',3,2,1,'2014-10-14 15:26:13','Inder Kumar','2014-10-14 15:26:13','Inder Kumar'),(3,8,'Fix it',1,3,1,'2014-10-20 15:44:54','adminconfig','2014-10-20 15:44:54','adminconfig'),(4,9,'Fix in in t2',1,3,1,'2014-10-20 15:53:07','adminconfig','2014-10-20 15:53:07','adminconfig'),(5,10,'Fix in uat',1,3,1,'2014-10-20 16:07:25','adminconfig','2014-10-20 16:07:25','adminconfig');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_queues`
--

LOCK TABLES `issue_queues` WRITE;
/*!40000 ALTER TABLE `issue_queues` DISABLE KEYS */;
INSERT INTO `issue_queues` VALUES (1,1,2,'FIx in config','2014-09-30 12:01:30','adminconfig','2014-09-30 12:01:30','adminconfig',6),(2,2,3,'Test','2014-10-07 11:49:58','Pabitra','2014-10-07 11:49:58','Pabitra',6),(3,2,3,'comments','2014-10-07 15:09:44','Pabitra','2014-10-07 15:09:44','Pabitra',6),(4,3,6,'','2014-10-20 15:24:16','Inder Kumar','2014-10-20 15:24:16','Inder Kumar',6),(5,1,2,'Fix it','2014-10-20 15:44:54','adminconfig','2014-10-20 15:44:54','adminconfig',8),(6,2,3,'Comment','2014-10-20 15:45:42','Pabitra','2014-10-20 15:45:42','Pabitra',8),(7,3,2,'','2014-10-20 15:48:34','Inder Kumar','2014-10-20 15:48:34','Inder Kumar',8),(8,1,2,'Fix in in t2','2014-10-20 15:53:07','adminconfig','2014-10-20 15:53:07','adminconfig',9),(9,2,3,'Comment','2014-10-20 15:54:27','Pabitra','2014-10-20 15:54:27','Pabitra',9),(10,3,2,NULL,'2014-10-20 15:55:31','Inder Kumar','2014-10-20 15:55:31','Inder Kumar',9),(11,3,2,NULL,'2014-10-20 15:57:31','Inder Kumar','2014-10-20 15:57:31','Inder Kumar',9),(12,1,2,'Fix in uat','2014-10-20 16:07:25','adminconfig','2014-10-20 16:07:25','adminconfig',10),(13,2,3,'Comment','2014-10-20 16:08:20','Pabitra','2014-10-20 16:08:20','Pabitra',10),(14,3,2,NULL,'2014-10-20 16:09:32','Inder Kumar','2014-10-20 16:09:32','Inder Kumar',10);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_test_case`
--

LOCK TABLES `issue_test_case` WRITE;
/*!40000 ALTER TABLE `issue_test_case` DISABLE KEYS */;
INSERT INTO `issue_test_case` VALUES (1,6,'Stg-next','Test case','comments','2014-10-07 15:09:44','Pabitra','2014-10-07 15:09:44','Pabitra'),(2,8,'Config -t2','Test Case','Comment','2014-10-20 15:45:42','Pabitra','2014-10-20 15:45:42','Pabitra'),(3,9,'Caonfig-t2','test case','Comment','2014-10-20 15:54:27','Pabitra','2014-10-20 15:54:27','Pabitra'),(4,10,'t2','test case','Comment','2014-10-20 16:08:20','Pabitra','2014-10-20 16:08:20','Pabitra');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
INSERT INTO `issues` VALUES (6,'SFDC101','URL','Category','SREV1','Test Subject','Test Desc','Aspect',1,'PET1','Fixed','0000-00-00 00:00:00','Pabitra','2014-10-20 15:24:16','Inder Kumar',6),(7,'SFDC102','URL2','Category2','SREV2','Test Subject2','Test Desc 2','Blackboard',1,'PET2','New','0000-00-00 00:00:00','Pabitra','0000-00-00 00:00:00','pabitra',1),(8,'178596','url','cat','srev','Test Issue','test                            ','BlackBoard',1,'srev','Failed','2014-10-20 15:31:54','adminconfig','2014-10-20 15:48:35','Inder Kumar',2),(9,'14585','url','cat','srev','Test Issue1','            Test                ','BlackBoard',1,'srev','Failed','2014-10-20 15:52:21','adminconfig','2014-10-20 15:57:32','Inder Kumar',2),(10,'7845','url1','cat1','srev1','Test Issue45','test                            ','BlackBoard',1,'srev','Failed','2014-10-20 16:06:48','adminconfig','2014-10-20 16:09:32','Inder Kumar',2);
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset`
--

LOCK TABLES `password_reset` WRITE;
/*!40000 ALTER TABLE `password_reset` DISABLE KEYS */;
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
INSERT INTO `roles` VALUES (1,'Manager','2014-09-16 00:00:00','Anusha',NULL,NULL,'{\"users\":{\"create\":true,\"read\":true,\"update\":true,\"del\":true,\"global\":true}}'),(2,'Lead','2014-09-16 00:00:00','Anusha',NULL,NULL,'{\"users\":{\"create\":false,\"read\":true,\"update\":true,\"del\":true,\"global\":true}}'),(3,'Developer','2014-09-16 00:00:00','Anusha',NULL,NULL,'{\"users\":{\"create\":false,\"read\":true,\"update\":{\"default\":true,\"project\":false,\"role\":false},\"del\":false}}'),(4,'QA','2014-09-16 00:00:00','Anusha',NULL,NULL,'{\"users\":{\"create\":false,\"read\":false,\"update\":{\"default\":true,\"project\":false,\"role\":false},\"del\":false}}');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'adminconfig','petrodconfig@gmail.com','$2a$10$V1zESqqu4V4MIM6l8nT.gOFEym5Ju3G73w91CxsazYqP25ehW/m2y',NULL,1,1,1,NULL,NULL,'2014-09-16 00:00:00','Anusha',NULL,NULL),(2,'Inder Kumar','inderk@positiveedge.net','$2a$10$V1zESqqu4V4MIM6l8nT.gOFEym5Ju3G73w91CxsazYqP25ehW/m2y',NULL,4,1,1,'','','2014-09-16 00:00:00','',NULL,NULL),(3,'Pabitra','pray@positiveedge.net','$2a$10$V1zESqqu4V4MIM6l8nT.gOFEym5Ju3G73w91CxsazYqP25ehW/m2y',NULL,3,1,1,NULL,NULL,'2014-09-16 00:00:00','Pabitra','2014-09-16 00:00:00',NULL),(4,'Akshaya','akshay@positiveedge.net','$2a$10$V1zESqqu4V4MIM6l8nT.gOFEym5Ju3G73w91CxsazYqP25ehW/m2y',NULL,3,1,1,NULL,NULL,'2014-09-16 00:00:00','Pabitra','2014-09-16 00:00:00',NULL);
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


