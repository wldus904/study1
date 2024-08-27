-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: study
-- ------------------------------------------------------
-- Server version	5.5.5-10.11.0-MariaDB

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
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board` (
  `board_config_id` int(11) NOT NULL COMMENT '아이디',
  `board_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시글 번호',
  `title` varchar(200) NOT NULL COMMENT '제목',
  `content` text NOT NULL COMMENT '내용',
  `writer_member_id` varchar(8) NOT NULL COMMENT '작성자',
  `status` int(11) DEFAULT NULL COMMENT '상태값 0:정상 게시글 1: 삭제',
  `ref_id` varchar(8) DEFAULT NULL COMMENT 'self join 해서 답글',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `mod_date` datetime NOT NULL COMMENT '수정일',
  PRIMARY KEY (`board_id`),
  KEY `board_FK` (`board_config_id`),
  CONSTRAINT `board_FK` FOREIGN KEY (`board_config_id`) REFERENCES `board_config` (`board_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='게시판';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,'테스트 공지 사항','테스트 내용','admin1',1,NULL,'2020-01-01 00:00:00','2020-01-01 00:00:00'),(2,2,'테스트 상담 요청','상담 요청 내용','24010101',1,NULL,'2020-01-01 00:00:00','2020-01-01 00:00:00'),(1,3,'테스트 공지사항2','테스트 공지사항2 내용','admin1',1,NULL,'2024-08-23 10:55:18','2024-08-23 10:55:18'),(1,5,'테스트 공지사항44444','테스트 공지사항444444 내용','admin1',1,NULL,'2024-08-23 13:44:18','2024-08-23 13:44:54');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_config`
--

DROP TABLE IF EXISTS `board_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_config` (
  `board_config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '아이디',
  `title` varchar(200) NOT NULL COMMENT '게시판 이름',
  `type` int(11) NOT NULL COMMENT '게시판 타입 (0: 공지, 1: 학생 게시판',
  PRIMARY KEY (`board_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_config`
--

LOCK TABLES `board_config` WRITE;
/*!40000 ALTER TABLE `board_config` DISABLE KEYS */;
INSERT INTO `board_config` VALUES (1,'공지 사항',0),(2,'학생 게시판',1);
/*!40000 ALTER TABLE `board_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_student_requests`
--

DROP TABLE IF EXISTS `board_student_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_student_requests` (
  `board_student_requests_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `board_id` int(11) NOT NULL COMMENT '게시글 번호',
  `requests_type` int(11) NOT NULL DEFAULT 0 COMMENT '0: 질문 1: 상담 2: 건의',
  PRIMARY KEY (`board_student_requests_id`),
  KEY `board_student_requests_FK` (`board_id`),
  CONSTRAINT `board_student_requests_FK` FOREIGN KEY (`board_id`) REFERENCES `board` (`board_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='학생 게시판';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_student_requests`
--

LOCK TABLES `board_student_requests` WRITE;
/*!40000 ALTER TABLE `board_student_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_student_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_staff`
--

DROP TABLE IF EXISTS `class_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_staff` (
  `classroom_id` int(11) NOT NULL COMMENT '학년반_id',
  `member_id` varchar(8) NOT NULL COMMENT 'id',
  `subject_code` varchar(3) NOT NULL COMMENT '과목_code',
  KEY `class_staff_FK` (`subject_code`),
  KEY `class_staff_FK_1` (`member_id`),
  KEY `class_staff_FK_2` (`classroom_id`),
  CONSTRAINT `class_staff_FK` FOREIGN KEY (`subject_code`) REFERENCES `subject` (`subject_code`),
  CONSTRAINT `class_staff_FK_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `class_staff_FK_2` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='학급 교직원 구성원';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_staff`
--

LOCK TABLES `class_staff` WRITE;
/*!40000 ALTER TABLE `class_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_student`
--

DROP TABLE IF EXISTS `class_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_student` (
  `member_id` varchar(8) NOT NULL COMMENT 'id',
  `classroom_id` int(11) NOT NULL COMMENT '학년반_id',
  KEY `class_student_FK` (`member_id`),
  KEY `class_student_FK_1` (`classroom_id`),
  CONSTRAINT `class_student_FK` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `class_student_FK_1` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='반 학생 구성원';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_student`
--

LOCK TABLES `class_student` WRITE;
/*!40000 ALTER TABLE `class_student` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classroom`
--

DROP TABLE IF EXISTS `classroom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classroom` (
  `classroom_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '학년반_id',
  `year` int(4) NOT NULL COMMENT '년도',
  `grade` int(11) NOT NULL COMMENT '학년',
  `class` int(11) NOT NULL COMMENT '반',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `homeroom_teacher` varchar(8) DEFAULT NULL COMMENT '담임',
  PRIMARY KEY (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='학년반';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `member_id` varchar(8) NOT NULL COMMENT 'id',
  `password` varchar(100) NOT NULL COMMENT '비밀번호',
  `name` varchar(50) NOT NULL COMMENT '이름',
  `address` varchar(100) NOT NULL COMMENT '주소',
  `email` varchar(50) NOT NULL COMMENT '이메일',
  `phone` varchar(12) NOT NULL COMMENT '핸드폰',
  `grade` int(11) DEFAULT NULL COMMENT '1:학생 10:선생 99:관리자',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `mod_date` datetime NOT NULL COMMENT '수정일',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='맴버';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('24010101','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','김학생','서울특별시 금천구 가산동','student1@test.com','01011112222',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('admin1','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','김관리','서울특별시 금천구 가산동','admin1@test.com','01011112222',99,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('staff1','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','김선생','서울특별시 금천구 가산동','staff1@test.com','01022223333',10,'2020-01-01 00:00:00','2020-01-01 00:00:00');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refresh_token`
--

DROP TABLE IF EXISTS `refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refresh_token` (
  `token_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '토큰_id',
  `member_id` varchar(8) NOT NULL COMMENT '맴버_id',
  `refresh_token` varchar(255) NOT NULL COMMENT 'refresh_token',
  `expire_date` datetime NOT NULL COMMENT '마지막 유효 날짜',
  PRIMARY KEY (`token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COMMENT='refresh token';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_token`
--

LOCK TABLES `refresh_token` WRITE;
/*!40000 ALTER TABLE `refresh_token` DISABLE KEYS */;
INSERT INTO `refresh_token` VALUES (1,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MDk3MDAsImV4cCI6MTcyNDgwOTcwMCwic3ViIjoiMDEwMTExMTIyMjIifQ.9u0CZTxVl674wL5fV1aojc6nya0RQ4WJaI2c7Nluy2Y','2024-08-28 10:48:20'),(2,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MDk3NDQsImV4cCI6MTcyNDgwOTc0NCwic3ViIjoiMDEwMTExMTIyMjIifQ.RJbJQfmTLWJo3dk_GR0Z3KLtK3zdjISidUy3ayGJL_A','2024-08-28 10:49:04'),(5,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MDk5OTAsImV4cCI6MTcyNDgwOTk5MCwic3ViIjoiMDEwMTExMTIyMjIifQ.yAW2d2mygKbbDaNr59lE0Z387Y_zAULv-8aaeyhllJo','2024-08-28 10:53:10'),(6,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTAwMTYsImV4cCI6MTcyNDgxMDAxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.0Sb5iKmkHMnliAetzN73Rq4mlttK9a544Cu_w3BZXRY','2024-08-28 10:53:36'),(7,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTA2MTYsImV4cCI6MTcyNDgxMDYxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.Pmfm111NwcFRJ2me8efW4-5Obw-o4MBJABCpXx6TiOI','2024-08-28 11:03:36'),(8,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTA2MzMsImV4cCI6MTcyNDgxMDYzMywic3ViIjoiMDEwMTExMTIyMjIifQ.Z3GLNqqdcKNxNYDzqdx7UKbM807ETdQrX-wAWlN30SA','2024-08-28 11:03:53'),(9,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTM3NzUsImV4cCI6MTcyNDgxMzc3NSwic3ViIjoiMDEwMTExMTIyMjIifQ.VXAorJ9lS5UpT3QihldAhAnDGHd7pzIPh5nraH3zjzU','2024-08-28 11:56:15'),(10,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTM4MTksImV4cCI6MTcyNDgxMzgxOSwic3ViIjoiMDEwMTExMTIyMjIifQ.6nVfY_z0LOLa-gD76znHnp-d-4vr88RaUHPKpMQ4wBQ','2024-08-28 11:56:59'),(11,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4Mjk1NDcsImV4cCI6MTcyNDgyOTU0Nywic3ViIjoiMDEwMTExMTIyMjIifQ.knqqO6WQeiOM3go1Pxfllqd329OWiZHunyJhQ1USFxk','2024-08-28 16:19:07'),(12,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MDczMTEsImV4cCI6MTcyNDkwNzMxMSwic3ViIjoiMDEwMTExMTIyMjIifQ.O50nRSLw__98k9k59oecYAuglTXNePZq7D3O492FAQc','2024-08-29 13:55:11'),(13,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MDc0MDEsImV4cCI6MTcyNDkwNzQwMSwic3ViIjoiMDEwMTExMTIyMjIifQ.8jgPSj5eAQ_eyIg5zGMtuIheOPtqQ3lHHsZO7i0rYpQ','2024-08-29 13:56:41'),(14,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MDc3OTEsImV4cCI6MTcyNDkwNzc5MSwic3ViIjoiMDEwMTExMTIyMjIifQ.jzjwu1rq41H_bxPoyhj7-bVKyG2VVKduAUxTpIHMMZE','2024-08-29 14:03:11'),(15,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MTUyODUsImV4cCI6MTcyNDkxNTI4NSwic3ViIjoiMDEwMTExMTIyMjIifQ.baJV5loAqbVUfYt6MDys1AZJh2wuLNnTmDObXGuJ8no','2024-08-29 16:08:05'),(16,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MTU2OTcsImV4cCI6MTcyNDkxNTY5Nywic3ViIjoiMDEwMTExMTIyMjIifQ.JA26tdwAbc9vi4bhEk-ilBMtvEHM5c5428vwauJQonA','2024-08-29 16:14:57'),(17,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5NzMzNjIsImV4cCI6MTcyNDk3MzM2Miwic3ViIjoiMDEwMTExMTIyMjIifQ.tn2OYuFG_UnT3n-CUqBbnBrteB1iRO0DKMduTgNjx98','2024-08-30 08:16:02'),(18,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5ODEyNTYsImV4cCI6MTcyNDk4MTI1Niwic3ViIjoiMDEwMTExMTIyMjIifQ.Na9AKhrW4yMD8a1N4FECC46YdgrqjkzO0cnK0xNMqbI','2024-08-30 10:27:36'),(19,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5ODI5MTYsImV4cCI6MTcyNDk4MjkxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.SIt0cHfUxS6AqdONAOa4hBS_3ThuQHn6bVe93BQTc9Q','2024-08-30 10:55:16'),(20,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5ODc1MTYsImV4cCI6MTcyNDk4NzUxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.-6XuhPoDSLrRDwuY4sVbx1mn_H65mVYgiJc9yJSmpZs','2024-08-30 12:11:56'),(21,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5OTE0MjksImV4cCI6MTcyNDk5MTQyOSwic3ViIjoiMDEwMTExMTIyMjIifQ.63CKeFV3KJGmzHhYK5qLMvmyIr4w1yC50R6yDfg-ywg','2024-08-30 13:17:09'),(22,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5OTE2NzgsImV4cCI6MTcyNDk5MTY3OCwic3ViIjoiMDEwMTExMTIyMjIifQ.7MvvwMNtO0Qrauyq3OidWp670CQ54LWYhTPLFQaYMZY','2024-08-30 13:21:18'),(23,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5OTIxMTEsImV4cCI6MTcyNDk5MjExMSwic3ViIjoiMDEwMTExMTIyMjIifQ.DV3WsIMMcVrmyr-ljq0ldbKnIOchFKx1xV79eJkUzJU','2024-08-30 13:28:31'),(24,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5OTI4NTMsImV4cCI6MTcyNDk5Mjg1Mywic3ViIjoiMDEwMTExMTIyMjIifQ.-iO4l1TE5_2QUif_MBXvQhJ0XVZvU6MDZqmukubIVYA','2024-08-30 13:40:53'),(25,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMjk1ODYsImV4cCI6MTcyNTMyOTU4Niwic3ViIjoiMDEwMTExMTIyMjIifQ.PUKE3-fyVTVwyLjIulIE7clgVzwZVDgzVmQX5NtI1PE','2024-09-03 11:13:06'),(26,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzA1NDQsImV4cCI6MTcyNTMzMDU0NCwic3ViIjoiMDEwMTExMTIyMjIifQ.sEOEJntj_kQtlgRRQ5-pK1fwa5OY0y7EZpdSLyX7vUg','2024-09-03 11:29:04'),(27,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzA2NjMsImV4cCI6MTcyNTMzMDY2Mywic3ViIjoiMDEwMTExMTIyMjIifQ.biMGBJ_mNbSsF6rdt-aVjAUaqyCA7lEfbe5GVxA4KO0','2024-09-03 11:31:03'),(28,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzA3NjksImV4cCI6MTcyNTMzMDc2OSwic3ViIjoiMDEwMTExMTIyMjIifQ.ifKoRgbGbJ56zFaGEA7qlK4hYajeCM1G2TKflXIplW8','2024-09-03 11:32:49'),(29,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzI2MjEsImV4cCI6MTcyNTMzMjYyMSwic3ViIjoiMDEwMTExMTIyMjIifQ.5KsE8ENgJawdwF6o1pa3HzducUU3Yc6HPtQ_lizctmk','2024-09-03 12:03:41'),(30,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzY5MDAsImV4cCI6MTcyNTMzNjkwMCwic3ViIjoiMDEwMTExMTIyMjIifQ.U_WD-rFJpKUeTUl-NPniimQe4Os-49rKkRNX4XV1YjE','2024-09-03 13:15:00'),(31,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzg1NjMsImV4cCI6MTcyNTMzODU2Mywic3ViIjoiMDEwMTExMTIyMjIifQ.cCDum0i87LrF5CySJM9jOx7ZoaesiqHMBpICuYUTHkU','2024-09-03 13:42:43'),(32,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDI0NzQsImV4cCI6MTcyNTM0MjQ3NCwic3ViIjoiMDEwMTExMTIyMjIifQ.qzsfFnAt51jVXnZLWshpyhJGO4F0QQTi16YBLXAY104','2024-09-03 14:47:54'),(33,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDI5NjAsImV4cCI6MTcyNTM0Mjk2MCwic3ViIjoiMDEwMTExMTIyMjIifQ.YHeqeLQ3ywHht_Gv8eNCLO-gZGEPVSzfRUp8RoioEg4','2024-09-03 14:56:00'),(34,'24010101','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDI5NzksImV4cCI6MTcyNTM0Mjk3OSwic3ViIjoiMDEwMTExMTIyMjIifQ.GVzo4W8c_y9Rt8wzbiNvFCNPc0E99pKHemfansruACw','2024-09-03 14:56:19'),(35,'24010101','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDMzODIsImV4cCI6MTcyNTM0MzM4Miwic3ViIjoiMDEwMTExMTIyMjIifQ.GqdROKWSt1yurPNwohX2kSpnUaMvHy7NjHQGRMelhls','2024-09-03 15:03:02'),(36,'24010101','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDQyMDcsImV4cCI6MTcyNTM0NDIwNywic3ViIjoiMDEwMTExMTIyMjIifQ.Zh7sbnqLoU9ONHW8RgV0aTh58V4D9WISWk8wuDhn07g','2024-09-03 15:16:47'),(37,'24010101','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDYzMTYsImV4cCI6MTcyNTM0NjMxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.-JCoERmmwhzs5FfPC4-fCIjhmzCSoJ_D6ocSKvUtkgo','2024-09-03 15:51:56');
/*!40000 ALTER TABLE `refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject` (
  `subject_code` varchar(3) NOT NULL COMMENT '과목_code',
  `subject_name` varchar(10) NOT NULL COMMENT '과목명',
  PRIMARY KEY (`subject_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='과목';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'study'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-27 16:23:53
