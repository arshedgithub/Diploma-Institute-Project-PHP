-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: eduzilla
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `coursemodule`
--

DROP TABLE IF EXISTS `coursemodule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coursemodule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `creditvalue` int DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `diploma_id` int NOT NULL,
  `coordinator_id` int NOT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  KEY `fk_coursemodule_diploma1_idx` (`diploma_id`),
  KEY `fk_coursemodule_lecturers1_idx` (`coordinator_id`),
  KEY `fk_coursemodule_department1_idx` (`department_id`),
  CONSTRAINT `fk_coursemodule_department1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `fk_coursemodule_diploma1` FOREIGN KEY (`diploma_id`) REFERENCES `diploma` (`id`),
  CONSTRAINT `fk_coursemodule_lecturers1` FOREIGN KEY (`coordinator_id`) REFERENCES `lecturers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coursemodule`
--

LOCK TABLES `coursemodule` WRITE;
/*!40000 ALTER TABLE `coursemodule` DISABLE KEYS */;
INSERT INTO `coursemodule` VALUES (1,'IT1101','Introduction To HR',3,'introduction',1,8,2),(2,'IT1102','Introduction To Management',4,'',1,8,2),(3,'IT1001','Introduction to Web Designing',3,'Introduction',2,8,1),(4,'IT0002','HTML',4,'Basic HTML ',2,9,1),(5,'IT0003','CSS and Sass',4,'styling using css and learning other css frameworks',2,10,1),(6,'IT0004','Modern JS',4,'learning ES6 javascript',2,9,1),(7,'MG00021','Management Principles',4,'Basic management principles',1,10,3);
/*!40000 ALTER TABLE `coursemodule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coursemodule_has_lecturers`
--

DROP TABLE IF EXISTS `coursemodule_has_lecturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coursemodule_has_lecturers` (
  `coursemodule_id` int NOT NULL,
  `lecturers_id` int NOT NULL,
  PRIMARY KEY (`coursemodule_id`,`lecturers_id`),
  KEY `fk_coursemodule_has_lecturers_lecturers1_idx` (`lecturers_id`),
  KEY `fk_coursemodule_has_lecturers_coursemodule1_idx` (`coursemodule_id`),
  CONSTRAINT `fk_coursemodule_has_lecturers_coursemodule1` FOREIGN KEY (`coursemodule_id`) REFERENCES `coursemodule` (`id`),
  CONSTRAINT `fk_coursemodule_has_lecturers_lecturers1` FOREIGN KEY (`lecturers_id`) REFERENCES `lecturers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coursemodule_has_lecturers`
--

LOCK TABLES `coursemodule_has_lecturers` WRITE;
/*!40000 ALTER TABLE `coursemodule_has_lecturers` DISABLE KEYS */;
/*!40000 ALTER TABLE `coursemodule_has_lecturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'IT Department'),(2,'HR Department'),(3,'Finance Department');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diploma`
--

DROP TABLE IF EXISTS `diploma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diploma` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diploma`
--

LOCK TABLES `diploma` WRITE;
/*!40000 ALTER TABLE `diploma` DISABLE KEYS */;
INSERT INTO `diploma` VALUES (1,'Dipoma in HR Management','In this course you will learn Human Resource Management.'),(2,'Dipoma in Web Designing','In this course you will learn Designing web Applications');
/*!40000 ALTER TABLE `diploma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gender`
--

DROP TABLE IF EXISTS `gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gender` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender`
--

LOCK TABLES `gender` WRITE;
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` VALUES (1,'Male'),(2,'Female');
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturers`
--

DROP TABLE IF EXISTS `lecturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `regno` varchar(45) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `middlename` varchar(45) DEFAULT NULL,
  `contact` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `gender_id` int NOT NULL,
  `user_id` int NOT NULL,
  `status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `regno_UNIQUE` (`regno`),
  UNIQUE KEY `contact_UNIQUE` (`contact`),
  KEY `fk_student_gender1_idx` (`gender_id`),
  KEY `fk_student_user1_idx` (`user_id`),
  KEY `fk_lecturers_status1_idx` (`status_id`),
  CONSTRAINT `fk_lecturers_status1` FOREIGN KEY (`status_id`) REFERENCES `lecturerstatus` (`id`),
  CONSTRAINT `fk_student_gender10` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`),
  CONSTRAINT `fk_student_user10` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturers`
--

LOCK TABLES `lecturers` WRITE;
/*!40000 ALTER TABLE `lecturers` DISABLE KEYS */;
INSERT INTO `lecturers` VALUES (8,'LR-240001','Arshed','Ahemd','','o023','2sjl',1,16,1),(9,'LR-240002','Rajitha','Perera','De','029328490','99c, colombo 10',1,19,1),(10,'LR-240003','Kamala','Dissanayake','','9203902990','99d, sydney',2,20,1);
/*!40000 ALTER TABLE `lecturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturerstatus`
--

DROP TABLE IF EXISTS `lecturerstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturerstatus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturerstatus`
--

LOCK TABLES `lecturerstatus` WRITE;
/*!40000 ALTER TABLE `lecturerstatus` DISABLE KEYS */;
INSERT INTO `lecturerstatus` VALUES (1,'Temporary'),(2,'Contract'),(3,'Permanent');
/*!40000 ALTER TABLE `lecturerstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Lecturer'),(3,'Student');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `regno` varchar(45) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) DEFAULT NULL,
  `middlename` varchar(45) DEFAULT NULL,
  `contact` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `gender_id` int NOT NULL,
  `user_id` int NOT NULL,
  `studentstatus_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `regno_UNIQUE` (`regno`),
  UNIQUE KEY `contact_UNIQUE` (`contact`),
  KEY `fk_student_gender1_idx` (`gender_id`),
  KEY `fk_student_user1_idx` (`user_id`),
  KEY `fk_students_studentstatus1_idx` (`studentstatus_id`),
  CONSTRAINT `fk_student_gender1` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`),
  CONSTRAINT `fk_student_user1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_students_studentstatus1` FOREIGN KEY (`studentstatus_id`) REFERENCES `studentstatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'SR-240001','Kamal','Perera','','d','j3i',NULL,1,17,1),(2,'SR-240002','Nimal','Silva','De','82309090','2u392/co',NULL,1,18,1);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentstatus`
--

DROP TABLE IF EXISTS `studentstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentstatus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentstatus`
--

LOCK TABLES `studentstatus` WRITE;
/*!40000 ALTER TABLE `studentstatus` DISABLE KEYS */;
INSERT INTO `studentstatus` VALUES (1,'Active'),(2,'Suspended');
/*!40000 ALTER TABLE `studentstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `userstatus_id` int NOT NULL DEFAULT '1',
  `roles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `fk_user_userstatus_idx` (`userstatus_id`),
  KEY `fk_user_roles1_idx` (`roles_id`),
  CONSTRAINT `fk_user_roles1` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `fk_user_userstatus` FOREIGN KEY (`userstatus_id`) REFERENCES `userstatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (16,'Arshed Ahemd','arshed','$2y$10$sW7e1mWXl2tb5/NPMJhhzudmtbUEwSBt9eSET84xAu8wSAEoRmQKy','ades@gm.com',1,2),(17,'Kamal Perera','kamal','$2y$10$uXMW7qgD4Ul9mQsGaabc7OrfV23sqZ4qr7XWai/g9jjXSiGC5jABy','pasindub32@gmail.com',1,3),(18,'Nimal Silva','nimal','$2y$10$.uz5IObd7q9AmlhBIR4BcuNnGmH4t2zw87FFexo5Ygtn6MH1svHdW','nimal@gma.co',1,3),(19,'Rajitha Perera','rajitha','$2y$10$2TEa1YPeZXEtkLAKZfTLjOC7531l/zz94CSuLcDojlSv.U5l31lWW','rajitha@ghk.co',1,2),(20,'Kamala Dissanayake','kamala','$2y$10$KNjAz7TGsfI.hD8X9RZ6MufHfZqhaLG9IL2Z5h9DVa3RIX2VbjU62','kamai#@mgm.yd',1,2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userstatus`
--

DROP TABLE IF EXISTS `userstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userstatus` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userstatus`
--

LOCK TABLES `userstatus` WRITE;
/*!40000 ALTER TABLE `userstatus` DISABLE KEYS */;
INSERT INTO `userstatus` VALUES (1,'Active'),(2,'Inactive');
/*!40000 ALTER TABLE `userstatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-15 15:50:25
