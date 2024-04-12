-- MySQL dump 10.13  Distrib 5.7.32, for osx10.12 (x86_64)
--
-- Host: localhost    Database: qbox
-- ------------------------------------------------------
-- Server version	5.7.32

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
-- Table structure for table `ab_permission`
--

DROP TABLE IF EXISTS `ab_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_permission`
--

LOCK TABLES `ab_permission` WRITE;
/*!40000 ALTER TABLE `ab_permission` DISABLE KEYS */;
INSERT INTO `ab_permission` VALUES (3,'can_add'),(15,'can_chart'),(17,'can_dash1'),(4,'can_delete'),(6,'can_download'),(5,'can_edit'),(16,'can_get'),(19,'can_home'),(18,'can_index'),(22,'can_info'),(7,'can_list'),(21,'can_post'),(23,'can_put'),(20,'can_search'),(8,'can_show'),(2,'can_this_form_get'),(1,'can_this_form_post'),(9,'can_userinfo'),(14,'copyrole'),(24,'export'),(13,'menu_access'),(25,'muldelete'),(10,'resetmypassword'),(11,'resetpasswords'),(12,'userinfoedit');
/*!40000 ALTER TABLE `ab_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_permission_view`
--

DROP TABLE IF EXISTS `ab_permission_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_permission_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_id` int(11) DEFAULT NULL,
  `view_menu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_id` (`permission_id`,`view_menu_id`),
  KEY `view_menu_id` (`view_menu_id`),
  CONSTRAINT `ab_permission_view_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `ab_permission` (`id`),
  CONSTRAINT `ab_permission_view_ibfk_2` FOREIGN KEY (`view_menu_id`) REFERENCES `ab_view_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_permission_view`
--

LOCK TABLES `ab_permission_view` WRITE;
/*!40000 ALTER TABLE `ab_permission_view` DISABLE KEYS */;
INSERT INTO `ab_permission_view` VALUES (1,1,5),(3,1,6),(5,1,7),(2,2,5),(4,2,6),(6,2,7),(7,3,9),(19,3,12),(45,3,26),(53,3,29),(63,3,31),(69,3,32),(75,3,33),(81,3,34),(87,3,35),(93,3,36),(99,3,37),(105,3,38),(8,4,9),(20,4,12),(40,4,25),(46,4,26),(54,4,29),(64,4,31),(70,4,32),(76,4,33),(82,4,34),(88,4,35),(94,4,36),(100,4,37),(106,4,38),(9,5,9),(21,5,12),(47,5,26),(55,5,29),(65,5,31),(71,5,32),(77,5,33),(83,5,34),(89,5,35),(95,5,36),(101,5,37),(107,5,38),(10,6,9),(22,6,12),(48,6,26),(56,6,29),(66,6,31),(72,6,32),(78,6,33),(84,6,34),(90,6,35),(96,6,36),(102,6,37),(108,6,38),(11,7,9),(23,7,12),(29,7,16),(31,7,18),(33,7,20),(49,7,26),(57,7,29),(67,7,31),(73,7,32),(79,7,33),(85,7,34),(91,7,35),(97,7,36),(103,7,37),(109,7,38),(12,8,9),(24,8,12),(50,8,26),(58,8,29),(68,8,31),(74,8,32),(80,8,33),(86,8,34),(92,8,35),(98,8,36),(104,8,37),(110,8,38),(13,9,9),(14,10,9),(15,11,9),(16,12,9),(17,13,10),(18,13,11),(26,13,13),(28,13,15),(30,13,17),(32,13,19),(34,13,21),(62,13,23),(51,13,27),(52,13,28),(61,13,30),(25,14,12),(27,15,14),(35,16,22),(42,16,25),(36,17,23),(37,18,23),(38,19,23),(39,20,23),(41,21,25),(43,22,25),(44,23,25),(59,24,29),(60,25,29);
/*!40000 ALTER TABLE `ab_permission_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_permission_view_role`
--

DROP TABLE IF EXISTS `ab_permission_view_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_permission_view_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_view_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_view_id` (`permission_view_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `ab_permission_view_role_ibfk_1` FOREIGN KEY (`permission_view_id`) REFERENCES `ab_permission_view` (`id`),
  CONSTRAINT `ab_permission_view_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `ab_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_permission_view_role`
--

LOCK TABLES `ab_permission_view_role` WRITE;
/*!40000 ALTER TABLE `ab_permission_view_role` DISABLE KEYS */;
INSERT INTO `ab_permission_view_role` VALUES (1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),(6,6,1),(7,7,1),(8,8,1),(9,9,1),(10,10,1),(11,11,1),(12,12,1),(13,13,1),(14,14,1),(15,15,1),(16,16,1),(17,17,1),(18,18,1),(19,19,1),(20,20,1),(21,21,1),(22,22,1),(23,23,1),(24,24,1),(25,25,1),(26,26,1),(27,27,1),(28,28,1),(29,29,1),(30,30,1),(31,31,1),(32,32,1),(33,33,1),(34,34,1),(35,35,1),(36,36,1),(37,37,1),(38,38,1),(39,39,1),(40,40,1),(41,41,1),(42,42,1),(43,43,1),(44,44,1),(45,45,1),(46,46,1),(47,47,1),(48,48,1),(49,49,1),(50,50,1),(51,51,1),(52,52,1),(53,53,1),(54,54,1),(55,55,1),(56,56,1),(57,57,1),(58,58,1),(59,59,1),(60,60,1),(61,61,1),(62,62,1),(63,63,1),(64,64,1),(65,65,1),(66,66,1),(67,67,1),(68,68,1),(69,69,1),(70,70,1),(71,71,1),(72,72,1),(73,73,1),(74,74,1),(75,75,1),(76,76,1),(77,77,1),(78,78,1),(79,79,1),(80,80,1),(81,81,1),(82,82,1),(83,83,1),(84,84,1),(85,85,1),(86,86,1),(87,87,1),(88,88,1),(89,89,1),(90,90,1),(91,91,1),(92,92,1),(93,93,1),(94,94,1),(95,95,1),(96,96,1),(97,97,1),(98,98,1),(99,99,1),(100,100,1),(101,101,1),(102,102,1),(103,103,1),(104,104,1),(105,105,1),(106,106,1),(107,107,1),(108,108,1),(109,109,1),(110,110,1);
/*!40000 ALTER TABLE `ab_permission_view_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_register_user`
--

DROP TABLE IF EXISTS `ab_register_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_register_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registration_date` datetime DEFAULT NULL,
  `registration_hash` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_register_user`
--

LOCK TABLES `ab_register_user` WRITE;
/*!40000 ALTER TABLE `ab_register_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `ab_register_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_role`
--

DROP TABLE IF EXISTS `ab_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_role`
--

LOCK TABLES `ab_role` WRITE;
/*!40000 ALTER TABLE `ab_role` DISABLE KEYS */;
INSERT INTO `ab_role` VALUES (1,'Admin'),(2,'Public');
/*!40000 ALTER TABLE `ab_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_user`
--

DROP TABLE IF EXISTS `ab_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `email` varchar(320) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  `fail_login_count` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL,
  `created_by_fk` int(11) DEFAULT NULL,
  `changed_by_fk` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `ab_user_ibfk_1` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `ab_user_ibfk_2` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_user`
--

LOCK TABLES `ab_user` WRITE;
/*!40000 ALTER TABLE `ab_user` DISABLE KEYS */;
INSERT INTO `ab_user` VALUES (1,'admin','user','admin','pbkdf2:sha256:260000$M9XDlK1QAlcbdEQC$7fac9abcd2d064ca6d9e4cc2e3df08f42d5347b179170e688c0c99070cd7bf9b',1,'admin@fab.org',NULL,NULL,NULL,'2024-02-12 16:05:02','2024-02-12 16:05:02',NULL,NULL);
/*!40000 ALTER TABLE `ab_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_user_role`
--

DROP TABLE IF EXISTS `ab_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `ab_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `ab_user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `ab_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_user_role`
--

LOCK TABLES `ab_user_role` WRITE;
/*!40000 ALTER TABLE `ab_user_role` DISABLE KEYS */;
INSERT INTO `ab_user_role` VALUES (1,1,1);
/*!40000 ALTER TABLE `ab_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ab_view_menu`
--

DROP TABLE IF EXISTS `ab_view_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ab_view_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ab_view_menu`
--

LOCK TABLES `ab_view_menu` WRITE;
/*!40000 ALTER TABLE `ab_view_menu` DISABLE KEYS */;
INSERT INTO `ab_view_menu` VALUES (27,'Account'),(26,'AccountView'),(35,'AreaView'),(8,'AuthDBView'),(17,'Base Permissions'),(37,'BoxView'),(23,'Dashboard'),(31,'GroupView'),(13,'List Roles'),(10,'List Users'),(3,'LocaleView'),(22,'MenuApi'),(38,'MoveView'),(24,'MyView'),(21,'Permission on Views/Menus'),(16,'PermissionModelView'),(20,'PermissionViewModelView'),(33,'ProjectView'),(1,'QboxIndexView'),(6,'ResetMyPasswordView'),(5,'ResetPasswordView'),(12,'RoleModelView'),(36,'SectionView'),(11,'Security'),(4,'SecurityApi'),(28,'Settings'),(34,'SiteView'),(32,'TypeView'),(15,'User\'s Statistics'),(9,'UserDBModelView'),(7,'UserInfoEditView'),(14,'UserStatsChartView'),(2,'UtilView'),(18,'ViewMenuModelView'),(19,'Views/Menus'),(30,'Volume'),(25,'VolumeApi'),(29,'VolumeView');
/*!40000 ALTER TABLE `ab_view_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `account_ibfk_2` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('2024-02-12 16:05:19','2024-02-12 16:05:19',1,'TPIT',1,NULL,1,1);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `area_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`),
  CONSTRAINT `area_ibfk_2` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `area_ibfk_3` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` VALUES ('2024-02-12 16:05:19','2024-02-12 16:05:19',1,'AS 032',1,1,NULL,1,1);
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `box`
--

DROP TABLE IF EXISTS `box`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `box` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `section_id` (`section_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `box_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`),
  CONSTRAINT `box_ibfk_2` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `box_ibfk_3` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `box`
--

LOCK TABLES `box` WRITE;
/*!40000 ALTER TABLE `box` DISABLE KEYS */;
INSERT INTO `box` VALUES ('2024-02-12 16:05:19','2024-02-12 16:05:19',1,'60890',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',2,'60912',3,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',3,'60913',3,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',4,'60914',4,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',5,'60915',4,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',6,'60916',5,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',7,'60917',5,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',8,'60918',6,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',9,'60919',6,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',10,'60920',7,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',11,'60921',7,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',12,'60922',8,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',13,'60923',8,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',14,'60924',9,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',15,'60925',9,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',16,'60926',10,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',17,'60927',10,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',18,'60928',11,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',19,'60929',11,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',20,'60930',12,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',21,'60931',12,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',22,'60932',13,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',23,'60933',13,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',24,'60934',14,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',25,'60935',14,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',26,'60936',15,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',27,'60937',15,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',28,'60938',16,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',29,'60939',16,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',30,'60940',17,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',31,'60941',17,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',32,'60942',18,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',33,'60943',18,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',34,'60944',19,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',35,'60945',19,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',36,'60946',20,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',37,'60947',21,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',38,'60948',22,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',39,'60949',23,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',40,'60950',24,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',41,'60951',20,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',42,'60952',22,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',43,'60953',21,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',44,'60954',24,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',45,'60955',23,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',46,'60956',25,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',47,'60957',25,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',48,'60958',26,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',49,'60959',26,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',50,'60960',27,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',51,'60961',27,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',52,'60963',28,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',53,'60964',29,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',54,'60965',30,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',55,'60966',29,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',56,'60967',31,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',57,'60968',30,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',58,'60969',32,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',59,'60970',32,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',60,'60971',33,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',61,'60972',33,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',62,'60973',34,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',63,'60974',34,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',64,'60975',35,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',65,'60976',35,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',66,'60977',36,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',67,'60978',36,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',68,'60979',37,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',69,'61012',38,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',70,'61013',38,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',71,'61014',39,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',72,'61015',39,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',73,'61016',40,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',74,'61017',40,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',75,'61018',41,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',76,'61019',41,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',77,'61020',42,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',78,'61021',42,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',79,'61022',43,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',80,'61023',43,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',81,'61024',44,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',82,'61025',44,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',83,'61026',45,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',84,'61027',45,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',85,'61028',46,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',86,'61029',46,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',87,'61071',47,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',88,'61072',47,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',89,'61073',48,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',90,'61035',49,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',91,'61036',50,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',92,'61037',51,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',93,'61038',52,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',94,'61039',53,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',95,'61040',54,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',96,'61041',55,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',97,'61042',56,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',98,'61043',57,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',99,'61044',58,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',100,'61045',59,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',101,'61046',60,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',102,'61047',61,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',103,'61048',62,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',104,'61049',63,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',105,'61050',64,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',106,'61051',65,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',107,'61052',66,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',108,'61053',67,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',109,'61054',68,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',110,'61055',69,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',111,'61056',70,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',112,'61057',71,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',113,'61058',72,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',114,'61059',73,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',115,'61060',74,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',116,'61061',75,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',117,'61062',75,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',118,'61063',76,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',119,'61064',76,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',120,'61065',77,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',121,'61066',77,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',122,'61067',78,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',123,'61068',78,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',124,'61069',79,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',125,'61070',79,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',126,'61074',80,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',127,'61075',81,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',128,'61076',82,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',129,'61077',83,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',130,'61078',83,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',131,'61079',84,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',132,'61080',85,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',133,'61081',86,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',134,'61082',85,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',135,'61083',84,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',136,'61084',87,1,NULL,1,1),('2024-02-12 16:05:25','2024-02-12 16:05:25',137,'61085',87,1,NULL,1,1);
/*!40000 ALTER TABLE `box` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `group_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `group_ibfk_2` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `group_ibfk_3` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES ('2024-02-12 16:05:19','2024-02-12 16:05:19',1,'Workplace Environment',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',2,'Procurement/Trasporti',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',3,'Accounting/note spese',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',4,'Accounting / Receivables and Payables',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',5,'Accounting / Treasury',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',6,'General Ledger and Accounting',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',7,'DCC',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',8,'Site',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',9,'H.R.',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',10,'Legal',1,1,NULL,1,1);
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `move`
--

DROP TABLE IF EXISTS `move`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `move` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `volume_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `volume_id` (`volume_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `move_ibfk_1` FOREIGN KEY (`volume_id`) REFERENCES `volume` (`id`),
  CONSTRAINT `move_ibfk_2` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `move_ibfk_3` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `move`
--

LOCK TABLES `move` WRITE;
/*!40000 ALTER TABLE `move` DISABLE KEYS */;
/*!40000 ALTER TABLE `move` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `project_ibfk_2` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `project_ibfk_3` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('2024-02-12 16:05:19','2024-02-12 16:16:42',1,'066881B001','rgb(78, 179, 10, 0.5)','BUILDING MANTENANCE',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:16:42',2,'2542','rgb(174, 123, 122, 0.5)','SOCAR',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:16:42',3,'2546','rgb(78, 10, 189, 0.5)','UNIPETROL',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:16:42',4,'2522','rgb(69, 135, 73, 0.5)','DUSLO',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:16:42',5,'071973C','rgb(191, 50, 145, 0.5)','ENOC',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:16:42',6,'066928G001','rgb(104, 45, 42, 0.5)','STATUTORY COMPLIANCE',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:16:42',7,'067024J001','rgb(166, 117, 205, 0.5)','02512 - TPIDL STAFF SERVICES',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:16:42',8,'066034C007','rgb(32, 82, 60, 0.5)','MIDOR',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:16:42',9,'066880B001-066892B001','rgb(59, 124, 174, 0.5)','OFFICE STATIONARY / CANTEEN',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:16:42',10,'06880B001','rgb(121, 229, 83, 0.5)','OFFICE STATIONARY',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:16:42',11,'066888B001','rgb(167, 165, 127, 0.5)','LIBRARY',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:16:42',12,'066884B001','rgb(178, 45, 213, 0.5)','DEPRECIATIONS',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',13,'06881B001','rgb(132, 152, 93, 0.5)','BUILDING MANTENANCE',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',14,'066880B001','rgb(8, 222, 129, 0.5)','OFFICE STATIONARY',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',15,'066877B001','rgb(224, 232, 155, 0.5)','SECURITY AND GUARDS',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',16,'066887B001','rgb(228, 180, 59, 0.5)','LOGISTIC E SUPPLIES',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',17,'06887B001','rgb(150, 27, 124, 0.5)','SECURITY AND GUARDS',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',18,'0668892B001','rgb(185, 225, 122, 0.5)','CANTEEN',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',19,'066892B001','rgb(111, 168, 137, 0.5)','CANTEEN',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',20,'066886B001','rgb(157, 132, 225, 0.5)','GENERAL SERVICES MANAGEMENT',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',21,'0066881B001','rgb(37, 119, 17, 0.5)','BUILDING MANTENANCE',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:16:42',22,'072744C','rgb(22, 137, 129, 0.5)','Neste Singapore',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:16:42',23,'076971C','rgb(246, 241, 28, 0.5)','MOH - New Naphtha Complex EPC',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',24,'066891B001','rgb(52, 223, 130, 0.5)','Milan general service',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',25,'\n2329\n2345\n2363\n2375\n6959\n6965\n6968\n6973\n6974\n6977\n6978\n6989\n6991\n6996\n7000\n7001\n7002\n7003\n7004\n7005\n7007\n7008\n7009\n7010\n7012\n7013\n7014\n7015\n7016\n7021\n','rgb(81, 83, 180, 0.5)','Legal Operations - Rome OC',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',26,'2387\n2394\n2408\n2417\n7018\n7022\n7023\n7024\n7025\n7026\n7027\n7028\n7029\n7038\n7040\n7043\n7046','rgb(133, 85, 161, 0.5)','Legal Operations - Rome OC',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',27,'2317\n2421\n2430\n2431\n7042\n7047\n7048\n7049\n7050\n7052\n7054\n7055\n7059\n7062\n7063\n7064\n7066','rgb(115, 189, 49, 0.5)','Legal Operations - Rome OC',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',28,'7038\n7042\n7067\n7068\n7069\n7071\n7072\n7073\n7074\n7075\n7076\n7077\n7081\n7082\n7083\n7085\n7087\n7089\n7090\n2382\n2436','rgb(65, 210, 166, 0.5)','Legal Operations - Rome OC',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',29,'7072\n7077\n7087\n7092\n7093\n7094\n7097\n7098\n7100\n7102\n7104\n7105\n7109\n2471\n2472\n2473\n2475','rgb(161, 131, 64, 0.5)','Legal Operations - Rome OC',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',30,'7106\n7110\n7111\n7112\n7113\n7114\n7115\n7117\n7118\n7120\n7121\n7122\n7123\n7125\n7129\n7133\n7134\n7138\n7140\n7141\n7142\n7143\n7145\n7146\n7147\n7154\n7158\n7162\n2482\n2491\n2509','rgb(64, 193, 1, 0.5)','Legal Operations - Rome OC',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',31,'2520\n2543\n2546\n7135\n7159\n7163\n7164\n7168\n7169\n06981T001\n071350T001\n071521T001\n071392T001\n025005T001','rgb(148, 115, 239, 0.5)','Legal Operations - Rome OC',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',32,'000000','rgb(196, 123, 94, 0.5)','Legal Operations - Rome OC',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',33,'2514','rgb(210, 186, 74, 0.5)','OMSK',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',34,'1882-2882','rgb(9, 29, 112, 0.5)','VAL D\'AGRI',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',35,'2421','rgb(228, 235, 52, 0.5)','CANADA GAS TO LIQUID',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',36,'2407','rgb(238, 250, 53, 0.5)','CNRL CANADA',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',37,'2420','rgb(125, 85, 21, 0.5)','STABILIMENTO PRIOLO',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',38,'2381','rgb(103, 212, 19, 0.5)','UZBEKISTAN GTL PROJECT',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',39,'2133','rgb(224, 117, 71, 0.5)','PETROSA',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',40,'2162','rgb(55, 179, 137, 0.5)','ETILENE BRINDISI',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',41,'2157','rgb(237, 215, 73, 0.5)','NYNAS REFINING SWEDEN',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',42,'2262','rgb(161, 87, 59, 0.5)','GEEL 2/3',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',43,'2259','rgb(91, 19, 215, 0.5)','BYACO NANJING ACETIC ACID PROJECT ',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',44,'2252','rgb(217, 218, 145, 0.5)','OKLNG PROJECT ',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:16:42',45,'2272','rgb(46, 205, 186, 0.5)','CNRL CANADA  ',1,1,NULL,1,1),('2024-02-12 16:08:26','2024-02-12 16:16:42',46,'000002','rgb(29, 80, 23, 0.5)','test',1,1,NULL,1,1);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `area_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `area_id` (`area_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`),
  CONSTRAINT `section_ibfk_2` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `section_ibfk_3` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES ('2024-02-12 16:05:19','2024-02-12 16:05:19',1,'3270',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',2,'32700',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',3,'3645',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',4,'3646',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',5,'3647',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',6,'3648',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',7,'3650',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',8,'3651',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',9,'3652',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',10,'3653',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',11,'3655',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',12,'3656',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',13,'3657',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',14,'3658',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',15,'3660',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',16,'3661',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',17,'3675',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',18,'3676',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',19,'3677',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',20,'3564',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',21,'3568',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',22,'3567',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',23,'3565',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',24,'3566',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',25,'3572',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',26,'3571',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',27,'3570',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',28,'3569',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',29,'3485',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',30,'3486',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',31,'3487',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',32,'3484',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',33,'3523',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',34,'3522',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',35,'3521',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',36,'3520',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',37,'3519',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',38,'3514',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',39,'3510',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',40,'3515',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',41,'3511',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',42,'3516',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',43,'3512',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',44,'3517',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',45,'3513',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',46,'3518',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',47,'2838',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',48,'2837',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',49,'3588',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',50,'3589',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',51,'3590',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',52,'3591',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',53,'3592',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',54,'3593',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',55,'3594',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',56,'3595',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',57,'3596',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',58,'3597',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',59,'3598',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',60,'3599',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',61,'3600',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',62,'3601',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',63,'3602',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',64,'3603',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',65,'3604',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',66,'3605',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',67,'3606',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',68,'3607',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',69,'3608',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',70,'3609',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',71,'3610',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',72,'3611',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',73,'3612',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',74,'3613',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',75,'2608',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',76,'2609',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',77,'2610',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',78,'2611',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',79,'2612',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',80,'3229',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',81,'3230',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',82,'3131',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',83,'2843',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',84,'2844',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',85,'2846',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',86,'2842',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',87,'2845',1,1,NULL,1,1);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `site_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `site_ibfk_2` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `site_ibfk_3` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site`
--

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;
INSERT INTO `site` VALUES ('2024-02-12 16:05:19','2024-02-12 16:05:19',1,'Building A','Italy','Rome ','ND',1,1,NULL,1,1);
/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `activation_on` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `retention_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `retention_days` int(11) NOT NULL,
  `security_class` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `type_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `type_ibfk_2` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `type_ibfk_3` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES ('2024-02-12 16:05:19','2024-02-12 16:05:19',1,'HSE310','Chemical Inventories and Lists','Creation Date','5Y',1825,'General',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',2,'FIN720','Shipping and Receiving','Creation Date','10Y',3650,'General',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',3,'FIN010 ','Accounts Payable, Receivables, Journal Vouchers and Cost Accounting','Tax Year Closed','EVT+10Y',3650,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',4,'FIN210','Banking Records','Creation Date','10Y',3650,'Highly Confidential',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',5,'FIN730','Vendor Selections and Bidding Documentation - Unsuccessful','Creation Date','5Y',1825,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',6,'FIN710','Purchase Orders','Closed','EVT+10Y',3650,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',7,'ADM120','General Correspondence and Working Papers','Creation Date','5Y',1825,'General',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',8,'HSE260','Safety Compliance - Work Permits and Routine Safety Inspections','Creation Date','6Y',2190,'General',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',9,'HSE030','HSE Internal Audits, Inspections, and Reports','Creation Date','10Y',3650,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',10,'LGL140','Real Property','Property Obligation Ceases','EVT+15Y',5475,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',11,'LGL110','Contracts / Agreements - Customers, Vendors or Subcontractors','Termination of Contract and Warranty','EVT+15Y',5475,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',12,'PRJ010','Engineering Administration','Project Closed','EVT+10Y',3650,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',13,'PRJ020','Engineering Design Records','Project and Warranty Closed','EVT+30Y',10950,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',14,'FIN110','Internal, External and Vendor Audits','Close of Audit','EVT+10Y',3650,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',15,'PRJ090','Construction and Commissioning Records','Project Closed','EVT+10Y',3650,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',16,'HR010','Compensation and Benefits','Benefits End and Tax Year Closed','EVT+10Y',3650,'Highly Confidential',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',17,'HR120','Work Assignment and People Management','Employee Termination','EVT+6Y',2190,'Highly Confidential',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',18,'LGL120','Contracts / Agreements - General','Termination of Contract','EVT+10Y',3650,'Confidential',1,1,NULL,1,1),('2024-02-12 16:05:25','2024-02-12 16:05:25',19,'PRJ040','Manufacturing records','Project Closed','EVT+30Y',10950,'Confidential',1,1,NULL,1,1);
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume`
--

DROP TABLE IF EXISTS `volume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume` (
  `created_on` datetime NOT NULL,
  `changed_on` datetime NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `box_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `activation_date` date DEFAULT NULL,
  `endlife_date` date DEFAULT NULL,
  `account_number` int(11) DEFAULT NULL,
  `order_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_on` date DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by_fk` int(11) NOT NULL,
  `changed_by_fk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `box_id` (`box_id`),
  KEY `group_id` (`group_id`),
  KEY `type_id` (`type_id`),
  KEY `project_id` (`project_id`),
  KEY `created_by_fk` (`created_by_fk`),
  KEY `changed_by_fk` (`changed_by_fk`),
  CONSTRAINT `volume_ibfk_1` FOREIGN KEY (`box_id`) REFERENCES `box` (`id`),
  CONSTRAINT `volume_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `group` (`id`),
  CONSTRAINT `volume_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`),
  CONSTRAINT `volume_ibfk_4` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `volume_ibfk_5` FOREIGN KEY (`created_by_fk`) REFERENCES `ab_user` (`id`),
  CONSTRAINT `volume_ibfk_6` FOREIGN KEY (`changed_by_fk`) REFERENCES `ab_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=312 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume`
--

LOCK TABLES `volume` WRITE;
/*!40000 ALTER TABLE `volume` DISABLE KEYS */;
INSERT INTO `volume` VALUES ('2024-02-12 16:05:19','2024-02-12 16:05:19',1,'RIFIUTI SPECIALI VIALE CASTELLO DELLA MAGLIANA, N° 38 - FORMULARI DAL 2018 AL 2020 - REGISTRO CARICO/SCARICO RIFIUTI DAL 07/03/2014 AL 04/01/2019',1,1,1,1,'2014-03-07','2019-01-04','2019-01-04','2024-01-03',NULL,NULL,'Cristina Cutrona','2023-03-23',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',2,'RIFIUTI SPECIALI VIALE CASTELLO DELLA MAGLIANA, N° 68 - FORMULARI DAL 2019 AL 2020 - REGISTRO CARICO/SCARICO RIFIUTI DAL 07/02/2018 ALL 11/03/2020',1,1,1,1,'2018-02-07','2020-03-11','2020-03-12','2025-03-11',NULL,NULL,'Cristina Cutrona','2023-03-23',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',3,'MODELLO MUD VOL. 1',1,1,1,1,'1998-01-31','2010-12-31','2011-01-01','2015-12-31',NULL,NULL,'Cristina Cutrona','2023-03-23',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',4,'MODELLO MUD VOL. 2',1,1,1,1,'2011-01-31','2016-12-31','2017-01-01','2021-12-31',NULL,NULL,'Cristina Cutrona','2023-03-23',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',5,'MODELLO MUD VOL. 3',1,1,1,1,'2017-01-31','2021-12-31','2022-01-01','2026-12-31',NULL,NULL,'Cristina Cutrona','2023-03-23',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',6,'VARIE-DOCS  PER INCASSO,SOSTE, SRN DAP01+011 FINO A..)',2,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',7,'VARIE-DEMURRAGES + COPIA SN E SHIPPING DOCS',3,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',8,'SRN TPBN DA 01-070',4,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',9,'SRN 0001-0076',5,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',10,'SRN 0077-0182',6,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',11,'SRN 0183-0290',7,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',12,'SRN 0291-0386',8,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',13,'SRN 0387-0494',9,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',14,'SRN 0751-0885',10,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',15,'SRN 0886-0957+LV INVOICES+ SRN TPBN 071 -099',11,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',16,'SOA INVOICES + SPMAT CONVERGENCE PROJECT DOCS',12,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',17,'SRN 001-0225',13,2,2,3,'2016-09-30','2017-04-30','2017-05-01','2027-04-29',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',18,'SRN 0260-0386',14,2,2,3,'2016-09-30','2017-04-30','2017-05-01','2027-04-29',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',19,'SRN VARIOUS',15,2,2,3,'2016-09-30','2017-04-30','2017-05-01','2027-04-29',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',20,'SRN 001- 058',16,2,2,4,'2016-01-16','2017-12-22','2017-12-23','2027-12-21',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',21,'SRN 059-0143',17,2,2,4,'2016-01-16','2017-12-22','2017-12-23','2027-12-21',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',22,'SRN 144-0250',18,2,2,4,'2016-01-16','2017-12-22','2017-12-23','2027-12-21',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',23,'SRN 251-0370',19,2,2,4,'2016-01-16','2017-12-22','2017-12-23','2027-12-21',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',24,'SRN 0371-0486',20,2,2,4,'2016-01-16','2017-12-22','2017-12-23','2027-12-21',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',25,'SRN 0487-0519 + FATTURE GEODIS + SRN SOFMAN',21,2,2,4,'2016-01-16','2017-12-22','2017-12-23','2027-12-21',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',26,'SRN 001-100',22,2,2,5,'2017-01-08','2019-11-30','2019-12-01','2029-11-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',27,'SRN 101-270',23,2,2,5,'2017-01-08','2019-11-30','2019-12-01','2029-11-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',28,'SRN 0271-520',24,2,2,5,'2017-01-08','2019-11-30','2019-12-01','2029-11-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',29,'SRN 0521-689',25,2,2,5,'2017-01-08','2019-11-30','2019-12-01','2029-11-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',30,'SRN 690-823+FATTURE GEODIS',26,2,2,5,'2017-01-08','2019-11-30','2019-12-01','2029-11-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',31,'SOA INVOICES+ENOC FCA-DDP',27,2,2,5,'2017-01-08','2019-11-30','2019-12-01','2029-11-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',32,'SRN 0495-0617',28,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',33,'SRN 0618-0750',29,2,2,2,'2018-09-01','2019-12-30','2019-12-31','2029-12-28',NULL,NULL,'Riccardo Quercia','2023-01-16',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',34,'note spese da A a Bettoni',30,3,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Manuela Toscano','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',35,'note spese da Bianchi a Ciofo',31,3,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Manuela Toscano','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',36,'note spese da Cipriani a Fleres',32,3,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Manuela Toscano','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',37,'note spese da Florio a Marotta',33,3,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Manuela Toscano','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',38,'note spese da Marozza a Santopadre',34,3,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Manuela Toscano','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',39,'note spese da Santoro a Xu',35,3,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Manuela Toscano','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',40,'TP FRANCE NOMINATIVI da A a L',36,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',41,'2053 - DALLA A ALLA Z - 025536J001 NPCC - CDI FATTURE- ISPEZIONI',37,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',42,'2316/0 FATTURE O-Z - 2349 TECHNIP CORPORATE SERVICES - 2350 REFINING - 2351 LNG-GTL - 400 4001 TP -HQC',38,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',43,'1857 yamgas- Abu Dhabi- Korea- Incassi 2423 Petro-Ias - 2324 consorzio TIPS',39,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',44,'2013TPL- 2418 TPIDL - 2427 TPIDL 2511- TPIDL - 2512 TPIDL - 2501 TP VELAM ',40,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',45,'TP FRANCE NOMINATIVI da M a Z ',41,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',46,'2316/0 TECHNIP FMC - 2316/3 TP CDI ORE CASSE - 2316/3 FATTURE  A- F/ G- /L - M -N ',42,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',47,'2073 FATTURE DA A-Z - 2073 TP USA IPCO - 2412 INS.ACT- TP UK FATTURE ',43,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',48,'2501TP INDIA - 2513 - TP MEXICO - 2518 GENESISAND GAS - 018516J001RUSTECH- 0185516J002 TECHNIN FRANCE - 18516J003 TECHNIP BENELUX',44,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',49,'2036 - PETROCARABOBO- IAS- CONSORZIO TIPS',45,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-02-07',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',50,'Documentazione TPEU Verifica Fiscale 2018 - 2017 - 2016 - 2015',46,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',51,'Banco BPM - Incassi - Giroconti - Contabili - Garanzie',46,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',52,'Banco BPM - Pagamenti SUPAY - GNPAY',46,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',53,'HSBC - Contabili',46,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',54,'BNL  - Giroconti - Contabili - Garanzie',46,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',55,'Credite Agricole - Contabili garanzie',46,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',56,'Intesa San Paolo - Incassi - Contabili - Garanzie - Giroconti',47,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',57,'Intesa San Paolo - Pagamenti SUPAY - GNPAY',47,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',58,'Societe Generale - Contabili',47,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:19','2024-02-12 16:05:19',59,'Unicredit - Incassi - Contabili - Garanzie - Giroconti',47,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',60,'Giroconti banche sede',48,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',61,'ODP - Coge - Note spese - Garanzie',48,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',62,'ODP - Banche (Amundi)',48,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',63,'ODP - Fornitori - Branch Toscano',48,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',64,'Documentazione da Front Office',48,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',65,'Incassi dal 4291881',49,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',66,'TPEU - Operazioni in cambi',49,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',67,'TPEU - Giroconti - Interessi - Contabilità',49,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',68,'Partitari dal 2017 al 2021',49,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',69,'Poteri di firma dal 21/10/2019 - Apertura c/c dal 1/11/2016 al 31/10/2018 - Modifica IBAN 2018 - 2019',49,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',70,'Verifica tassi dal 2017 al 2021',50,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',71,'Riconciliazioni bancarie - Estratti conto - BNL Euro 512101003 - Credit Agricole Euro 512101004 - Banco BPM Euro 1067 512101005',50,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',72,'Riconciliazioni bancarie - Estratti conto - Banca BPM Euro 12640 512101007 - Unicredit Euro 512101008 - HSBC Euro 512101009',50,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',73,'Estratti conto Societe Generale 512101012 - Unicredit CAD 512101014 - Banco BPM CHF 512101015',50,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',74,'Estratti conto Banco BPM CNY 512101016 - Unicredit GBP 512101017 - HSBC MXN 512101021',50,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',75,'Estratti conto Unicredit RUB 512101022 - BNL USD 512101023 - Credit Agricole USD 512101024',51,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',76,'Estratti conto Banco BPM USD 512101025 - Unicredit USD 512101026 - Societe Generale USD 512101029',51,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',77,'Estratti conto HSBC USD 512101035 - San Paolo Euro 512101036 - San Paolo JPY 512101037',51,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',78,'Estratti conto San Paolo USD 512101038 - San Paolo ZAR 512101039',51,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',79,'Fidejussioni al personale dal 2016 al 2021',51,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',80,'Interessi 2021',52,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',81,'BPER - MPS - Banco di Sondrio - Contabili - Estratti conto',52,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',82,'Petty cash Vietnam',52,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',83,'TEN. IS. - Contabili - ODP - Tassi - Scalari - Poteri di firma - Interessi',52,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',84,'TEN. IS. - RICONCILIAZIONI BANCARIE ',52,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',85,'BNL EUR USD - Contabili - Estratti conto - Giroconti',52,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-02-01',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',86,'Numero 17: UNICREDIT :  INCASSI -  CONTABILI - GIROCONTI - CORRISP. ZA - COMM. GAR. LETT.CREDITO',53,6,4,6,'2019-01-01','2019-12-31','2020-01-01','2029-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',87,'Numero 9: UNICREDIT :  INCASSI -  CONTABILI - GIROCONTI - CORRISP. ZA - COMM. GAR. LETT.CREDITO',53,6,4,6,'2020-01-01','2020-12-30','2020-12-31','2030-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',88,'Numero 12: CALYON  ',53,6,4,6,'2019-01-01','2019-12-31','2020-01-01','2029-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',89,'Numero 4: CALYON  ',53,6,4,6,'2020-01-01','2020-12-30','2020-12-31','2030-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',90,'Numero 7: E/C QUADRATI  DA:   512101028 A   512101039',53,6,4,6,'2016-01-01','2016-12-30','2016-12-31','2026-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',91,'Numero 6: E/C QUADRATI  DA:   512101034 A   512101037',54,6,4,6,'2017-01-01','2017-12-31','2018-01-01','2027-12-30',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',92,'17 - INTESA S.PAOLO : G C -  CONTABILI - CORRISP. ZA  - GARANZIE',54,6,4,6,'2014-01-01','2014-12-31','2015-01-01','2024-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',93,'12 - CREDITO BERGAMASCO:  CONTABILI - GC - CORR. ZA - CONT.GARANZIE',54,6,4,6,'2014-01-01','2014-12-31','2015-01-01','2024-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',94,'11 - BANCO POPOLARE:  CONTABILI - GC - CORR. ZA - CONT.GARANZIE INCASSI- SPOT',54,6,4,6,'2015-01-01','2015-12-31','2016-01-01','2025-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',95,'15 - INTESA S.PAOLO : G C -  CONTABILI - CORRISP. ZA  - GARANZIE',54,6,4,6,'2015-01-01','2015-12-31','2016-01-01','2025-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',96,'10 - BANCO POPOLARE 1067:  INCASSI-CONTABILI - GC -  - CONT.GARANZIE - CORR. ZA',55,6,4,6,'2016-01-01','2016-12-30','2016-12-31','2026-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',97,'13 - INTESA S.PAOLO : G C -  CONTABILI - CORRISP. ZA  - GARANZIE',55,6,4,6,'2016-01-01','2016-12-30','2016-12-31','2026-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',98,'9 - BANCO POPOLARE  INCASSI-CONTABILI - GC -  - CONT.GARANZIE - CORR. ZA',55,6,4,6,'2018-01-01','2018-12-31','2019-01-01','2028-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',99,'5 - E/C QUADRATI  DA:   512101026 A   512101035',55,6,4,6,'2018-01-01','2018-12-31','2019-01-01','2028-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',100,'12 - HSBC',56,6,4,6,'2018-01-01','2018-12-31','2019-01-01','2028-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',101,'10 - BANCO POPOLARE  INCASSI-CONTABILI - GC -  - CONT.GARANZIE - CORR. ZA',56,6,4,6,'2019-01-01','2019-12-31','2020-01-01','2029-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',102,'15 - INTESA S.PAOLO : G C -  CONTABILI - CORRISP. ZA  - CONT. GARANZIE-INCASSI',56,6,4,6,'2019-01-01','2019-12-31','2020-01-01','2029-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',103,'2 - BANCO POPOLARE  INCASSI-CONTABILI - GC -  - CONT.GARANZIE - CORR. ZA',56,6,4,6,'2020-01-01','2020-12-30','2020-12-31','2030-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',104,'7 - INTESA S.PAOLO : G C -  CONTABILI - CORRISP. ZA  - CONT. GARANZIE-INCASSI',56,6,4,6,'2020-01-01','2020-12-30','2020-12-31','2030-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',105,'13 - INTESA S.PAOLO : INCASSI- CUPAY- SUPAY- GNPAY',56,6,4,6,'2017-01-01','2017-12-31','2018-01-01','2027-12-30',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',106,'14 - INTESA S.PAOLO : CONTABILI- CONTABILI GARANZIE- GIROFONDI- CORRISPONDENZA',57,6,4,6,'2017-01-01','2017-12-31','2018-01-01','2027-12-30',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',107,'23 -  E/C ( BNL-CREDITE AGRICOLE\'- BPOP 1067) QUADRATI  DA:  512101003 A   512101005',57,6,4,6,'2020-01-01','2020-12-30','2020-12-31','2030-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',108,'1 -BNL: G C -  CONTABILI - CORRISP. ZA  - GARANZIE',57,6,4,6,'2020-01-01','2020-12-30','2020-12-31','2030-12-29',NULL,NULL,'Francesca Zigon','2023-02-08',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',109,'TP ENERGIES Bonifici a fondi ed F24 versati (n.file dal 1421 al 1424)',58,6,3,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Francesca Altea','2023-02-14',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',110,'TP EN. SOLUTIONS Bonifici a fondi ed F24 versati (n.file dal 1425 al 1427)',59,6,3,7,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Francesca Altea','2023-02-14',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',111,'OFFERTE E CONSUNTIVI -FORNITORI VARI',60,1,5,1,'2020-01-01','2020-12-31','2021-01-01','2025-12-31',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',112,'OFFERTE E CONSUNTIVI -MODITECH',60,1,5,1,'2020-01-01','2021-12-31','2022-01-01','2026-12-31',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',113,'ORDINI E CESPITI PROGETTI VARI ',60,1,6,1,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',114,'ORDINI COMMESSE- DEUGRO',60,1,6,8,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',115,'ORDINI COMMESSE',60,1,6,9,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',116,'ORDINI - COMMESSE-UNIGUM',61,1,6,10,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',117,'ORDINI - BIBLIOTECA',61,1,6,11,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',118,'ORDINI - CESPITI ',61,1,6,12,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:20','2024-02-12 16:05:20',119,'ORDINI -COMMESSA-SERVIZI',61,1,6,1,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',120,'ORDINI -TRULLI-ORDINE PER LAVORI RIMOZIONE EDIFICIO F N87819',61,1,6,13,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',121,'ORDINI - MODITECH',62,1,6,1,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',122,'PROGRESSIVO PROMEMORIA',62,1,7,1,'2021-01-01','2021-12-31','2022-01-01','2026-12-31',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',123,'PROGRESSIVO LETTERE',62,1,7,1,'2021-01-01','2021-12-31','2022-01-01','2026-12-31',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',124,'CONTRATTO UNIGUM - FORNITURA DPI -CONTRATTI- CONFERME D\'ORDINE-CORRISPONDENZA',62,1,6,14,'2019-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',125,'CONTRATTO UNIGUM - FORNITURA DPI -CONTRATTI- CONFERME D\'ORDINE-WORK ORDER- CORRISPONDENZA',62,1,6,14,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',126,'VERBALI VERIFICHE SEMESTRALI - ESTINTORI-RILEVAZIONE FUMI -IMPIANTO SPEGNIMENTO CED - PORTE TAGLIAFUOCO - IDRANTI -ALLARME EVACUAZIONE VOL. 1',63,1,8,1,'2014-01-01','2018-12-31','2019-01-01','2024-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',127,'CONTRATTO GIAMA - SERVIZIO DI PORTIERATO E VIGILANZA - CONTRATTI -CORRISPONDENZA - DICHIARAZIONI VOL. 4',63,1,6,15,'2016-01-01','2018-12-31','2019-01-01','2028-12-29',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',128,'CONTRATTO GIAMA - SERVIZIO DI PORTIERATO E VIGILANZA - CONTRATTI -CORRISPONDENZA - DICHIARAZIONI VOL. 5',63,1,6,15,'2018-01-01','2019-12-31','2020-01-01','2029-12-29',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',129,'CONTRATTO - SCHINDLER-SERVIZIO DI  MANUTENZIONE ASCENSORI EDIFICI A,B E C3',64,1,6,1,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',130,'CONTRATTO SIRIO- SIRIO DIV. SIC.- CONSUELNZA PRATICHE GESTIONE RIFIUTI SPECIALI E IN MATERIA DI SICUREZZA SUL LAVORO ',64,1,6,1,'2018-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',131,'CONTRATTO SAMIT SERVIZIO DI LOGISTICA',64,1,6,16,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',132,'CONTRATTO PRIMETECH - SERVIZIO MANUTENZIONE UPS ',64,1,6,1,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',133,'CONTRATTO ECONOMATO - BLUGRAFIC - CARTOTECNICA BARONE-DEXCO-EURTIMBRI-GRASSO ANTONINO ',64,1,6,14,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',134,'CONTRATTO GIAMA- SERVIZIO DI VIGILANZA ARMATA E PORTIERATO - CONTRATTO DOCUMENTAZIONE DL.G.231/2001 E D.LGS. 81/2008',65,1,6,15,'2020-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',135,'RDO PER CONTRATTO SERVIZIO DI PORTIERATO E DI VIGILANZA - SECURITE\' - OFFERTA DOC.  D.LGS. 231/2001 DOC. D.LGS. 81/2008',65,1,6,17,'2020-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',136,'RDO PER CONTRATTO SERVIZIO DI PORTIERATO E DI VIGILANZA - SICURITALIA- OFFERTA DOC.  D.LGS. 231/2001 DOC. D.LGS. 81/2008',65,1,6,16,'2020-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',137,'RDO N. 164115 PER IGIENE AMBIENTALE ',65,1,6,1,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',138,'CONTRATTO - SAMIT-CONTRATTO PULIZIA ED IGIENE AMBIENTALE',65,1,6,1,'2021-01-01','2023-01-31','2023-02-01','2033-01-29',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',139,'CONTRATTO- ALIMENTAZIONE AMBIENTALE - SERVIZI ANALISI - ACQUE BIANCHE E NERE-AMBIENTALI.EROGATORI DI ACQUA-CONTROLLI IGIENICO SANITARI MENSE ',66,1,6,18,'2020-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',140,'CONTRATTO ALIMENTAZIONE AMBIENTE - SERVIZI DI CONTROLLI ANALISI EDIFICI TECHNIP -ACQUE NERE E BIANCHE- LEGIONELLA- TORRI DI RAFFREDDAMENTO E UTA- EROGATORI ACQUA E MENSE A E C ',66,1,6,18,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',141,'CONTRATTO FALCOGNANA RECUPERI-SERVIZI DI RACCOLTA TRASPORTO E SMALTIMENTO RIFIUTI SPECIALI - CONTRATTO - QUALIFICHE- CORRISPOND. ',66,1,6,1,'2020-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',142,'CONTRATTO GIOJA-CONVENZIONE PER UTILIZZO SERVIZIO MENSA EDIFICIO L-CONTRATTI QUALIFICA-CORRISPOND.',66,1,6,19,'2020-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',143,'CONTRATTO MODITECH-CONTRATTO PER MANUTENZIONE ORDINARIA - CONTRATTO -SAL VOL. 1',67,1,6,1,'2018-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',144,'CONTRATTO MODITECH-CONTRATTO PER MANUTENZIONE ORDINARIA - DOCUMENTAZIONE D.LGS. 231/2001 E 81/2008 -PATENTINO F GAS- DURF-CORRISPONDENZA-CONFIDENTIALITY UNDERTAKING VOL. 2',67,1,6,1,'2018-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',145,'CONTRATTO MODITECH- CONTRATTO MANUTENZIONE ORDINARIA - SUBAPPALTI- A.C. BUILDING- BLITZ ANTINCENDIO- CARTARO-C.P.E.-DE PAOLIS VOL. 3',67,1,6,1,'2018-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',146,'CONTRATTO MODITECH-CONTRATTO MANUTENZIONE ORDINARIA- SUBAPPALTI-ERGASIA-ESSECI SERVICE-FLOORING-MANUTENIONE GENERALE- META PROJECT-SIRA VOL. 4',67,1,6,1,'2018-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',147,'CONTRATTO PEDEVILLA-SERVIZIO DI  RISTORAZIONE MENSA EDIFICIO V- CONTRATTI-QUALIFICA-CORRISPONDENZA',67,1,6,19,'2014-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',148,'NOTE SPESE PER CASSA',68,1,3,20,'2013-01-01','2016-12-31','2017-01-01','2026-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',149,'CONTRATTO SCHINDLER-RAPPORTINI ASCENSORI-ASSISTENZA TECNICA',68,1,9,1,'2020-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',150,'AFFITTI PASSIVI- PARROCCHIA NATIVITA\' DI MARIA SANTISSIMA',68,1,10,21,'2004-03-01','2022-06-30','2022-07-01','2037-06-27',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',151,'AFFITTI PASSIVI- STI SERVIZI -ALMA. EDIFICIO C2 6° PIANO E 3° PIANO',68,1,10,1,'2019-01-01','2020-07-31','2020-08-01','2035-07-29',NULL,NULL,'Cristina Cutrona','2023-03-02',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',152,'AG 001 CORRISPOSNDENZA',69,7,11,22,'2018-12-13','2018-12-13','2018-12-14','2033-12-10',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',153,'AG 010 MOM',69,7,12,22,'2019-04-04','2019-04-04','2019-04-05','2029-04-02',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',154,'AG 060 CONTRATTO CON TPB',69,7,11,22,'2018-06-20','2018-06-20','2018-06-21','2033-06-17',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',155,'AG 203 P&I MODIFICATION REQUEST VOL. 1 e 2',69,7,12,22,'2020-02-26','2020-02-26','2020-02-27','2030-02-24',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',156,'AG 250 CORRISPONDENZA',69,7,12,22,'2020-02-28','2020-02-28','2020-02-29','2030-02-26',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',157,'AG 410 PERMITTING VOL. 1 A 9',69,7,13,22,'2019-05-20','2019-05-20','2019-05-21','2049-05-13',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',158,'AG 410 PERMITTING VOL. 10 A 13',70,7,13,22,'2019-05-20','2019-05-20','2019-05-21','2049-05-13',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',159,'AG 501 AUDIT',70,7,14,22,'2018-12-07','2018-12-07','2018-12-08','2028-12-05',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',160,'AG 801',70,7,12,22,'2019-06-25','2019-06-25','2019-06-26','2029-06-23',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',161,'AG 809',70,7,12,22,'2019-01-09','2019-01-09','2019-01-10','2029-01-07',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',162,'AG 202 VOL. 1 A 3',70,7,13,22,'2019-07-02','2019-07-02','2019-07-03','2049-06-25',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',163,'AG 202 VOL. 4 A 8',71,7,13,22,'2019-07-02','2019-07-02','2019-07-03','2049-06-25',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',164,'AG 202 VOL. 9 A 11',72,7,13,22,'2019-07-02','2019-07-02','2019-07-03','2049-06-25',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',165,'AG 252 VOL. 1 A 2',72,7,13,22,'2020-03-28','2020-03-28','2020-03-29','2050-03-22',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',166,'AG 252 VOL. 3 A 7',73,7,13,22,'2020-03-28','2020-03-28','2020-03-29','2050-03-22',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',167,'AG 252 VOL. 8 A 12',74,7,13,22,'2020-03-28','2020-03-28','2020-03-29','2050-03-22',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',168,'AG 252 VOL. 13 A 17',75,7,13,22,'2020-03-28','2020-03-28','2020-03-29','2050-03-22',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',169,'AG 252 VOL. 18 A 19',76,7,13,22,'2020-03-28','2020-03-28','2020-03-29','2050-03-22',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',170,'AG 253 VOL. 1 A 2',76,7,13,22,'2018-06-25','2018-06-25','2018-06-26','2048-06-18',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',171,'AG 504 VOL.1 E 3',76,7,14,22,'2019-11-13','2019-11-13','2019-11-14','2029-11-11',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',172,'AG 504 VOL.2 E 4 A 7',77,7,14,22,'2019-11-13','2019-11-13','2019-11-14','2029-11-11',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',173,'CO 100 ',77,7,12,22,'2018-11-16','2018-11-16','2018-11-17','2028-11-14',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',174,'MR 0110.001 A 0511.002',78,7,13,22,'2020-01-15','2020-01-15','2020-01-16','2050-01-08',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',175,'MR 0570.001 A 0710.002',79,7,13,22,'2018-12-04','2018-12-04','2018-12-05','2048-11-27',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',176,'MR 0811.001 A 0910.004',80,7,13,22,'2019-05-30','2019-05-30','2019-05-31','2049-05-23',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',177,'MR 0910.005 A 1340.003',81,7,13,22,'2019-06-11','2019-06-11','2019-06-12','2049-06-04',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',178,'MR 1547.001 A 1563.003',82,7,13,22,'2020-01-17','2020-01-17','2020-01-18','2050-01-10',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',179,'MR 1340.101 A 1546.001',83,7,13,22,'2019-09-25','2019-09-25','2019-09-26','2049-09-18',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',180,'MR 1564.001 A 200-MR 1541.001',84,7,13,22,'2019-07-30','2019-07-30','2019-07-31','2049-07-23',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',181,'200-MR 1543.001 A 200-MR 2410.002',85,7,13,22,'2019-04-23','2019-04-23','2019-04-24','2049-04-16',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:21','2024-02-12 16:05:21',182,'MR 2520.001 A MR 4263.001',86,7,13,22,'2020-01-29','2020-01-29','2020-01-30','2050-01-22',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',183,'PG 001 LT TO NESTE',86,7,12,22,'2018-11-13','2018-11-13','2018-11-14','2028-11-11',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',184,'PG 103 TR TO VEDORS',86,7,12,22,'2020-03-11','2020-03-11','2020-03-12','2030-03-10',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',185,'PG 102 LT TO EDL',86,7,12,22,'2019-10-24','2019-10-24','2019-10-25','2029-10-22',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',186,'PG046 TR A BENELUX',86,7,12,22,'2019-06-07','2019-06-07','2019-06-08','2029-06-05',NULL,NULL,'Silvia Giorgio','2023-05-04',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',187,'TPIT - SOX - Controlli conti mensile - apertura nuovi conti - Aggiornamento posting type',87,6,3,6,'2017-01-01','2018-12-31','2019-01-01','2028-12-29',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',188,'Chiusura contabilità Branch Svizzera',87,6,3,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',189,'Branch office - Varie',87,6,3,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',190,'TPDL Closing',87,6,3,7,'2020-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',191,'TPPIT Closing - Q1 2021 - Q2 2021 - Q3 2021 - Q4 2021',87,6,3,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',192,'TPIT - SOX 2017 - FSCP',87,6,3,6,'2017-01-01','2017-12-31','2018-01-01','2027-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',193,'TPIT - SOX Q3 2017 ',88,6,3,6,'2017-07-01','2017-09-30','2017-10-01','2027-09-29',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',194,'TPIT - SOX Q4 2017 ',88,6,3,6,'2017-10-01','2017-12-31','2018-01-01','2027-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',195,'TPIT - SOX Q1 2017 ',88,6,3,6,'2017-01-01','2017-03-31','2017-04-01','2027-03-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',196,'TPIT - Closing Q1 2018',88,6,3,6,'2018-01-01','2018-03-31','2018-04-01','2028-03-29',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',197,'TPIT - Closing Q2 2018',88,6,3,6,'2018-04-01','2018-06-30','2018-07-01','2028-06-28',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',198,'TPIT - Closing Q3 2018',88,6,3,6,'2018-07-01','2018-09-30','2018-10-01','2028-09-28',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',199,'TPDL - Libro giornale 2016 1 di 2',89,6,3,7,'2016-01-01','2016-12-31','2017-01-01','2026-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',200,'TPDL - Libro giornale 2016 2 di 2',89,6,3,7,'2016-01-01','2016-12-31','2017-01-01','2026-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',201,'Consorzi - TP HQC - TIPS',89,5,4,6,'2020-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',202,'TPL - Eurocash - Reconciliazioni bancarie - Scalari - Tassi - Giroconti',89,5,4,6,'2021-01-01','2021-12-31','2022-01-01','2031-12-30',NULL,NULL,'Irma Ciocci','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',203,'Site Monthly Work Progress Report - WPS (INTRAKAT)',90,8,12,23,'2021-01-01','2022-12-17','2022-12-18','2032-12-15',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',204,'Accounting Ledgers from/to Subcontractors (INTRAKAT) VOL. 1 A 4',90,8,3,23,'2021-01-01','2022-11-11','2022-11-12','2032-11-09',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',205,'New Prices Report from/to Subcontractors (INTRAKAT)',90,8,3,23,'2021-01-01','2022-09-15','2022-09-16','2032-09-13',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',206,'Backcharges to Subcontractor (INTRAKAT)',90,8,3,23,'2021-01-01','2022-12-16','2022-12-17','2032-12-14',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',207,'Site Letters to - INTRAKAT vol. 1 e 2\n L-TPG-INK-XXXXX ',91,8,12,23,'2020-11-03','2022-12-21','2022-12-22','2032-12-19',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',208,'Site Letters to ANIPSOTIKI\nL-TPG-ANP-XXXXX ',91,8,12,23,'2021-02-17','2022-10-22','2022-10-23','2032-10-20',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',209,'Site Letters to ZISIMOPOULOS \nL-TPG-ZSM-XXXXX ',91,8,12,23,'2022-06-16','2022-12-16','2022-12-17','2032-12-14',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',210,'Site Letters to SOLARCA\nL-TPG-SLR-XXXXX  ',91,8,12,23,'2022-06-16','2022-12-16','2022-12-17','2032-12-14',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',211,'Site Minutes of Meeting with  INTRAKAT vol. 1 a 3\nMOM-TPG-INK-XXXXX ',91,8,12,23,'2020-11-02','2022-07-27','2022-07-28','2032-07-25',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',212,'Site Minutes of Meeting with  ANIPSOTIKI \nMOM-TPG-ANP-XXXXX ',91,8,12,23,'2021-01-07','2021-01-07','2021-01-08','2031-01-06',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',213,'Site Monthly Work Progress Report - WPS (ANIPSOTIKI)',91,8,12,23,'2021-02-11','2021-12-13','2021-12-14','2031-12-12',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',214,'Site VRSWO - Variation Orders (INTRAKAT) da  1 a 3',92,8,15,23,'2020-10-01','2022-11-01','2022-11-02','2032-10-30',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',215,'Site Letters to GLOBCHEM\nL-TPG-GLS-XXXXX ',92,8,12,23,'2022-08-11','2022-12-20','2022-12-21','2032-12-18',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:22','2024-02-12 16:05:22',216,'Site Minutes of Meeting with  BNT/IMP/INK/MHL vol. 1 e 2\nMOM-TPG-CON-XXXXX ',92,8,12,23,'2021-09-21','2022-11-30','2022-12-01','2032-11-28',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',217,'Site Monthly Work Progress Report - WPS (GLOBCHEM)',92,8,12,23,'2022-10-11','2022-10-11','2022-10-12','2032-10-09',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',218,'Mechanical Completion Notices (MCN)',93,8,15,23,'2022-06-03','2022-11-18','2022-11-19','2032-11-16',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',219,'Ready  for Commisssiong  Notices (RFCN)',93,8,15,23,'2022-06-17','2022-09-28','2022-09-29','2032-09-26',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',220,'Site Letters to IMPES\n L-TPG-IMP-XXXXX',93,8,12,23,'2021-06-09','2023-03-02','2023-03-03','2033-02-28',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',221,'Letters to Client \nL-TPIT-MOH-XXXXX',93,8,12,23,'2022-07-19','2022-03-01','2022-03-02','2032-02-28',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',222,'Site Minutes of Meeting with the Client  MOM-TPG-MOH-XXXXX',93,8,12,23,'2022-04-15','2023-01-31','2023-02-01','2033-01-29',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',223,'Site Monthly Work Progress Report - WPS (IMPES)',93,8,12,23,'2021-08-03','2023-01-25','2023-01-26','2033-01-23',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',224,'New Prices Report from/to Subcontractors (IMPES)',93,8,3,23,'2021-10-18','2022-10-27','2022-10-28','2032-10-25',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',225,'Backcharges to Subcontractor (IMPES)',93,8,3,23,'2022-01-24','2022-12-13','2022-12-14','2032-12-11',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',226,'Site Letters to MUEHLAHN \nL-TPG-MHL-XXXXX',94,8,12,23,'2021-10-15','2023-02-28','2023-03-01','2033-02-26',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',227,'Site Minutes of Meeting with   IMPES vol. 1 a 3 MOM-TPG-IMP-XXXXX',94,8,12,23,'2021-05-25','2022-09-13','2022-09-14','2032-09-11',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',228,'Site Minutes of Meeting with   MUEHLHAN vol. 1 e 2\nMOM-TPG-MHL-XXXXX ',94,8,12,23,'2021-09-28','2022-05-16','2022-05-17','2032-05-14',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',229,'Accounting Ledgers from/to Subcontractors (IMPES)',94,8,3,23,'2022-05-26','2022-12-10','2022-12-11','2032-12-08',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',230,'Site VRSWO - Variation Orders (IMPES) vol 1 a 4',95,8,15,23,'2021-10-22','2023-01-31','2023-02-01','2033-01-29',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',231,'Site VRSWO - Variation Orders (MUEHLHAN)',96,8,15,23,'2022-06-07','2023-02-10','2023-02-11','2033-02-08',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',232,'Site VRSWO - Variation Orders (BONATTI FIREPROOFING)',96,8,15,23,'2022-12-15','2022-12-15','2022-12-16','2032-12-13',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',233,'Site Letters to BONATTI FIREPROOFING \nL-TPG-BFP-XXXXX',96,8,12,23,'2022-09-14','2023-02-08','2023-02-09','2033-02-06',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',234,'Site Minutes of Meeting with  BONATTI -FIREPROOFING \nMOM-TPG-BFP-XXXXX ',96,8,12,23,'2022-08-22','2022-08-22','2022-08-23','2032-08-20',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',235,'Site Monthly Work Progress Report - WPS (MUEHLAHN)',96,8,12,23,'2022-03-31','2022-12-12','2022-12-13','2032-12-10',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',236,'Site Monthly Work Progress Report - WPS vol. 1 e 2\n(BONATTI FIREPROOFING)',96,8,12,23,'2022-11-17','2022-12-14','2022-12-15','2032-12-12',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',237,'Site Monthly Work Progress Report - WPS (BONATTI )',96,8,12,23,'2021-03-04','2022-12-13','2022-12-14','2032-12-11',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',238,'New Prices Report from/to Subcontractors (MUEHLHAN)',96,8,3,23,'2022-10-04','2022-10-04','2022-10-05','2032-10-02',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',239,'Backcharges to Subcontractor (BONATTI)',96,8,3,23,'2022-06-13','2022-12-14','2022-12-15','2032-12-12',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',240,'Site Minutes of Meeting with BONATTI  VOL. 1 A 4 MOM-TPG-BNT-XXXXX ',97,8,12,23,'2021-01-13','2023-01-16','2023-01-17','2033-01-14',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',241,'Accounting Ledgers from/to Subcontractors BONATTI)',97,8,3,23,'2022-10-12','2023-02-23','2023-02-24','2033-02-21',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',242,'New Prices Report from/to Subcontractors (BONATTI)',97,8,3,23,'2021-04-26','2023-01-23','2023-01-24','2033-01-21',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',243,'Site Letters to BONATTI  vol. 1 a 3\nL-TPG-BNT-XXXXX -',98,8,12,23,'2021-01-14','2023-02-28','2023-03-01','2033-02-26',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',244,'QUALITY AUDIT REPORT',98,8,8,23,'2022-05-27','2022-05-27','2022-05-28','2028-05-26',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',245,'TIME SHEET',98,8,16,23,'2022-11-01','2022-11-01','2022-11-02','2032-10-30',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',246,'DOWN PAYMENT',98,8,3,23,'2021-02-03','2021-02-03','2021-02-04','2031-02-02',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',247,'LETTER OF RESP E GUARANTEE',98,8,12,23,'2022-08-01','2022-08-01','2022-08-02','2032-07-30',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',248,'Site VRSWO - Variation Orders (BONATTI) vol. 1 a 6',99,8,15,23,'2021-11-04','2022-10-11','2022-10-12','2032-10-09',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',249,'Site VRSWO - Variation Orders (BONATTI) 4 volumi',100,8,15,23,'2022-06-13','2023-01-23','2023-01-24','2033-01-21',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',250,'Site VRSWO - Variation Orders (BONATTI) vol. 9 a 14',101,8,15,23,'2022-11-09','2023-02-09','2023-02-10','2033-02-07',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',251,'Work Permit Appointments',102,8,8,23,'2020-10-10','2022-10-27','2022-10-28','2028-10-26',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',252,'health and safety file',102,8,8,23,'2020-10-10','2020-10-10','2020-10-11','2026-10-10',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',253,'Work Permit da1 a 5',102,8,8,23,'2021-09-09','2022-11-04','2022-11-05','2028-11-03',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',254,'Work Permit DA 1 A 340 + VEHICLE EQUIPMENT + PTW INSPECTION',103,8,8,23,'2020-10-12','2021-07-30','2021-07-31','2027-07-30',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',255,'Work Permit DA 341 A 820',104,8,8,23,'2021-08-02','2021-11-24','2021-11-25','2027-11-24',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',256,'Work Permit DA 821 A 1300',105,8,8,23,'2021-11-18','2022-02-08','2022-02-09','2028-02-08',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',257,'Work Permit DA 1301 A 1782',106,8,8,23,'2022-02-08','2022-04-07','2022-04-08','2028-04-06',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',258,'Work Permit DA 1783 A 2243',107,8,8,23,'2022-04-07','2022-06-03','2022-06-04','2028-06-02',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',259,'Work Permit DA 2244 A 2760',108,8,8,23,'2022-06-03','2022-08-18','2022-08-19','2028-08-17',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',260,'Work Permit DA 2761 A 3392',109,8,8,23,'2022-08-18','2022-11-07','2022-11-08','2028-11-06',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',261,'Field Purchase Order VOL. 5',110,8,15,23,'2020-07-15','2022-12-19','2022-12-20','2032-12-17',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',262,'Stationery order + Certification of confirmations + Service agreements',111,8,3,23,'2020-09-30','2022-08-31','2022-09-01','2032-08-29',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',263,'S.O. Invoices VOL. 1 A 3',111,8,3,23,'2020-09-30','2022-08-31','2022-09-01','2032-08-29',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',264,'S.O. Invoices + MR DA 1 A 125 + BANK',112,8,3,23,'2022-09-01','2022-12-30','2022-12-31','2032-12-28',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',265,'DCS/ESD SITE DW + VRSWOs',113,8,13,23,'2021-10-01','2021-10-01','2021-10-02','2051-09-25',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',266,'SAT CERTIFICATES',114,8,13,23,'2021-10-01','2021-10-01','2021-10-02','2051-09-25',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',267,'Hand over surplus',115,8,13,23,'2021-10-01','2021-10-01','2021-10-02','2051-09-25',NULL,NULL,'Aurelia Carbotti','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',268,'1958 Inspection Activities 61402S Volume 1 - 2 - 3 - 4 ---- 072744j003 Technip Singapore',116,4,3,6,'2022-01-31','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',269,'2456 066997J001 TP INDONESIA---024948J001 Technical Assist. ICPO ----060695K009  - ---021949J002 FMC----021949J003 TECHNIPINDIA',117,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',270,'Fatture clienti da n1 a 168 serie V1',118,4,3,6,'2022-01-01','2022-12-31','2021-01-01','2030-12-30',NULL,NULL,'Maria Antonietta Buglioni','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',271,'Fatture clienti da n1 a 361 serie V1',119,4,3,6,'2020-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Maria Antonietta Buglioni','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',272,'Fatture clienti da n362 a 1022 serie V1',120,4,3,6,'2020-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Maria Antonietta Buglioni','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',273,'Fatture clienti serie V1 vol.12 vol.13- Fatture clienti serie E0 e serie P9 - Shipping Invoice da 1 a 541 da 542 a ',121,4,3,6,'2020-01-01','2020-12-31','2021-01-01','2030-12-30',NULL,NULL,'Maria Antonietta Buglioni','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',274,'Fatture clienti - Proforma da 1 a 85-2021- Fatture Proforma 2021 da 1 a 53  -  Fatture clienti 2021 da 1 a 27 SERIE E0 - - Fatture clienti serie P9 - - Fatture Clienti serie V1 ANNO 2021 DA 1 A 262 - ',122,4,3,6,'2020-01-01','2020-12-31','2022-01-01','2031-12-30',NULL,NULL,'Maria Antonietta Buglioni','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',275,'Fatture Clienti SerieV1 ANNO 2021 DA 1 A 1054',123,4,3,6,'2021-01-01','2021-12-31','2021-01-01','2030-12-30',NULL,NULL,'Maria Antonietta Buglioni','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',276,'Fatture Clienti serie V1 ANNO 2021 DA 1055A 1519 - TPIT UAE VAT 2020 - - Corrispondenza Conferme Saldo da anno 2016 a anno 2020 ',124,4,3,6,'2020-01-01','2020-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-06-22',1,1,NULL,1,1),('2024-02-12 16:05:23','2024-02-12 16:05:23',277,'070809K001 Yam Gaz- TP OCEANIA- TP NET- TCS - TP FRANCE TP GHAMP- TP JGC CORAL - TP GEOPR. TP USA- TP INDIA - - - 070809K001 INCASSI - 2053/0 TP ABU DHABI CDI PER ISPEZIONI FATTURE PER ISPEZ. 2053 /0 TP ABU DHABI CDI - 2053/0 TP ABU DHABI STAMPA ORE INCASSI - 2053/0 ABU DHABI FATTURE PER ASSEGNATI A-F + ADJUSTMENTS',125,4,3,6,'2022-01-01','2022-12-31','2023-01-01','2032-12-29',NULL,NULL,'Maria Antonietta Buglioni','2023-10-16',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',278,'Assenze del personale, certificati originali',126,9,17,24,'2003-01-01','2006-12-31','2007-01-01','2012-12-30',NULL,NULL,'Fabiola Rugger','2023-10-16',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',279,'Documenti di trasporto, lettere di vettura,bolle di consegna',127,9,7,24,'2018-01-01','2018-01-31','2018-02-01','2023-01-31',NULL,NULL,'Fabiola Rugger','2023-10-16',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',280,'Bolle di consegna,bollettini spedizione',128,9,7,24,'2013-01-01','2013-12-31','2014-01-01','2018-12-31',NULL,NULL,'Fabiola Rugger','2023-10-16',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',281,'Bolle di consegna,bollettini spedizione DDT',128,9,7,24,'2014-01-01','2014-12-31','2015-01-01','2019-12-31',NULL,NULL,'Fabiola Rugger','2023-10-16',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',282,'Bollettini trasporto, lettere di vettura DDT',128,9,7,24,'2015-01-01','2015-12-31','2016-01-01','2020-12-30',NULL,NULL,'Fabiola Rugger','2023-10-16',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',283,'Lettere di vettura DDT',128,9,7,24,'2016-01-01','2016-12-31','2017-01-01','2021-12-31',NULL,NULL,'Fabiola Rugger','2023-10-16',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',284,'ATT-ATC PROJECT REVIEW',129,10,18,25,'2008-01-01','2010-12-31','2011-01-01','2020-12-29',NULL,NULL,'Patrizia di Biagio','2023-11-15',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',285,'ATT-ATC',129,10,18,26,'2010-01-01','2011-12-31','2012-01-01','2021-12-29',NULL,NULL,'Patrizia di Biagio','2023-11-15',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',286,'ATT-ATC',130,10,18,30,'2013-01-01','2015-12-31','2016-01-01','2025-12-29',NULL,NULL,'Patrizia di Biagio','2023-11-15',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',287,'ATT-ATC- TPIT',130,10,18,32,'2009-01-01','2011-12-31','2012-01-01','2021-12-29',NULL,NULL,'Patrizia di Biagio','2023-11-15',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',288,'ATT-ATC- TPIT',131,10,18,32,'2012-01-01','2014-12-31','2015-01-01','2024-12-29',NULL,NULL,'Patrizia di Biagio','2023-11-15',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',289,'AG 290 - RACCOGLITORI FINE IMPIANTO - INSPECTION REPORT - ML - QAL VARIE MR',132,7,12,33,'2018-12-01','2019-04-01','2020-01-01','2029-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',290,'AG 290 - RACCOGLITORI DI FINE IMPIANTO - INSPECTION REPORT - ML - QAL VARIE MR',132,7,12,33,'2018-12-01','2019-04-01','2020-01-01','2029-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',291,'AG 290 - RACCOGLITORI DI FINE IMPIANTO - MOC - SFR RATING REPORT - DOC VARI',132,7,12,33,'2018-12-01','2019-12-01','2020-01-01','2029-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',292,'AG 290 - RACCOGLITORI DI FINE IMPIANTO - TR CLIENTE  - LT DA DUSLO',132,7,12,4,'2018-11-01','2019-05-01','2020-01-01','2029-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',293,'AG 290 - RACCOGLITORI DI FINE IMPIANTO  - LT DA DUSLO',132,7,12,4,'2019-06-01','2019-12-01','2020-01-01','2029-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',294,'AG 290 - RACCOGLITORI DI FINE IMPIANTO  - LT DA DUSLO',133,7,12,4,'2020-01-01','2021-12-01','2022-01-01','2031-12-30',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',295,'AG 103 - CD VARI - ML',133,7,12,4,'2020-01-01','2020-12-01','2022-01-01','2031-12-30',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',296,'AG 242 - RACCOGLITORE DI FINE IMPIANTO',133,7,12,34,'2007-05-01','2009-05-01','2015-01-01','2024-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',297,'AG 290 - RACCOGLITORI DI FINE IMPIANTO  - TR TO SASOL',133,7,12,35,'2011-05-01','2011-12-01','2015-01-01','2024-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',298,'AG 290 - RACCOGLITORI DI FINE IMPIANTO  - LT ',133,7,12,36,'2011-09-01','2011-12-01','2015-01-01','2024-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',299,'PG 206 - RACCOGLITORE DI FINE IMPIANTO',134,7,12,39,'2004-01-01','2005-12-01','2015-01-01','2024-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',300,'AG 242 - RACCOGLITORE DI FINE IMPIANTO',134,7,12,40,'2007-03-01','2008-12-01','2015-01-01','2024-12-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',301,'CONTRATTO - MOM ',135,7,11,23,'2018-09-01','2020-05-01','2022-11-01','2037-10-28',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',302,'AG 800 - CO - 100 - PG - 002 - 007',135,7,12,23,'2018-09-02','2020-05-01','2022-11-01','2032-10-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',303,'ATA-RN VARI',135,7,13,23,'2019-05-01','2019-06-01','2022-11-01','2052-10-24',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',304,'ATA-RN VARI',136,7,13,23,'2019-08-01','2019-09-01','2022-11-01','2052-10-24',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',305,'LOA-PO VARI-CONFIRM-COPY',136,7,12,23,'2020-01-01','2020-02-01','2022-11-01','2032-10-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:24','2024-02-12 16:05:24',306,'LOA-PO VARI - CONFIRM. COPY',136,7,12,23,'2020-03-01','2020-04-01','2022-11-01','2032-10-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:25','2024-02-12 16:05:25',307,'AG 504 - CU C3 SPLITTER',136,7,14,23,'2020-05-01','2021-05-01','2022-11-01','2032-10-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:25','2024-02-12 16:05:25',308,'AG 103 - AG 062 UOP',136,7,19,23,'2020-01-01','2021-01-01','2022-11-01','2052-10-24',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:25','2024-02-12 16:05:25',309,'AG 504 - CU VENDORS',137,7,14,23,'2018-01-01','2020-01-01','2022-11-01','2032-10-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:25','2024-02-12 16:05:25',310,'AG 504 - CU CONSTRUCTION E PRECOMMISSIONING',137,7,14,23,'2019-01-03','2021-01-01','2022-11-01','2032-10-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1),('2024-02-12 16:05:25','2024-02-12 16:05:25',311,'AG 504 - CU others',137,7,14,23,'2019-01-04','2021-01-01','2022-11-01','2032-10-29',NULL,NULL,'Silvia Giorgio','2023-11-21',1,1,NULL,1,1);
/*!40000 ALTER TABLE `volume` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-19 16:39:07
