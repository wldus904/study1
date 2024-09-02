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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='게시판';
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
  KEY `class_staff_FK_2` (`classroom_id`),
  KEY `class_staff_FK1` (`member_id`),
  CONSTRAINT `class_staff_FK1` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `class_staff_FK_2` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='학급 교직원 구성원';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_staff`
--

LOCK TABLES `class_staff` WRITE;
/*!40000 ALTER TABLE `class_staff` DISABLE KEYS */;
INSERT INTO `class_staff` VALUES (1,'staff1','KOR'),(1,'staff2','ENG'),(1,'staff3','MAT'),(1,'staff4','PHY'),(1,'staff5','CHE'),(1,'staff6','BIO'),(1,'staff7','ESS'),(2,'staff1','KOR'),(2,'staff2','ENG'),(2,'staff3','MAT'),(2,'staff5','PHY'),(2,'staff6','CHE'),(2,'staff7','BIO'),(2,'staff4','ESS'),(3,'staff1','KOR'),(3,'staff2','ENG'),(3,'staff3','MAT'),(3,'staff6','PHY'),(3,'staff7','CHE'),(3,'staff4','BIO'),(3,'staff5','ESS'),(4,'staff1','KOR'),(4,'staff2','ENG'),(4,'staff3','MAT'),(4,'staff7','PHY'),(4,'staff4','CHE'),(4,'staff5','BIO'),(4,'staff6','ESS'),(5,'staff1','KOR'),(5,'staff2','ENG'),(5,'staff3','MAT'),(5,'staff4','PHY'),(5,'staff5','CHE'),(5,'staff6','BIO'),(5,'staff7','ESS'),(6,'staff1','KOR'),(6,'staff2','ENG'),(6,'staff3','MAT'),(6,'staff5','PHY'),(6,'staff6','CHE'),(6,'staff7','BIO'),(6,'staff4','ESS');
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
  KEY `class_student_FK_1` (`classroom_id`),
  KEY `class_student_FK` (`member_id`),
  CONSTRAINT `class_student_FK` FOREIGN KEY (`member_id`) REFERENCES `member` (`member_id`),
  CONSTRAINT `class_student_FK_1` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`classroom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='반 학생 구성원';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_student`
--

LOCK TABLES `class_student` WRITE;
/*!40000 ALTER TABLE `class_student` DISABLE KEYS */;
INSERT INTO `class_student` VALUES ('22020401',1),('22020402',1),('22020403',1),('22020404',2),('22020405',2),('22020406',2),('22020408',3),('22020409',3),('22020410',4),('22020411',4),('22020412',4),('22020413',5),('22020414',5),('22020415',5),('22020416',6),('22020417',6),('22020418',6),('22020407',3);
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
  `class_section` int(11) NOT NULL COMMENT '반',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `homeroom_teacher` varchar(8) DEFAULT NULL COMMENT '담임',
  PRIMARY KEY (`classroom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='학년반';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classroom`
--

LOCK TABLES `classroom` WRITE;
/*!40000 ALTER TABLE `classroom` DISABLE KEYS */;
INSERT INTO `classroom` VALUES (1,2020,1,1,'2020-01-01 00:00:00','staff1'),(2,2020,1,2,'2020-01-01 00:00:00','staff2'),(3,2020,2,1,'2020-01-01 00:00:00','staff3'),(4,2020,2,2,'2020-01-01 00:00:00','staff4'),(5,2020,3,1,'2020-01-01 00:00:00','staff5'),(6,2020,3,2,'2020-01-01 00:00:00','staff6');
/*!40000 ALTER TABLE `classroom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam` (
  `exam_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '시험_id',
  `semester` tinyint(1) NOT NULL COMMENT '학기',
  `title` varchar(50) NOT NULL COMMENT '시험 이름',
  `reg_date` datetime NOT NULL COMMENT '동록일',
  `mod_date` datetime NOT NULL COMMENT '수정일',
  PRIMARY KEY (`exam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='시험 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
INSERT INTO `exam` VALUES (1,1,'1학기 중간고사','2024-09-02 15:04:34','2024-09-02 15:04:34');
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_score`
--

DROP TABLE IF EXISTS `exam_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_score` (
  `exam_score_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '시험 점수_id',
  `exam_subject_id` int(11) NOT NULL COMMENT '과목 시험 id',
  `exam_id` int(11) NOT NULL COMMENT '시험_id',
  `member_id` varchar(8) NOT NULL COMMENT '학생_id',
  `score` int(3) NOT NULL COMMENT '점수',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `mod_date` datetime NOT NULL COMMENT '수정일',
  PRIMARY KEY (`exam_score_id`),
  KEY `exam_score_FK` (`exam_subject_id`),
  CONSTRAINT `exam_score_FK` FOREIGN KEY (`exam_subject_id`) REFERENCES `exam_subject` (`exam_subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='학생 시험 점수';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_score`
--

LOCK TABLES `exam_score` WRITE;
/*!40000 ALTER TABLE `exam_score` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_subject`
--

DROP TABLE IF EXISTS `exam_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_subject` (
  `exam_subject_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '과목 시험 id',
  `exam_id` int(11) NOT NULL COMMENT '시험_id',
  `subject_code` varchar(3) DEFAULT NULL COMMENT '과목',
  `tester` varchar(8) DEFAULT NULL COMMENT '출제자_id',
  `exam_date` date DEFAULT NULL COMMENT '시험 날짜',
  `exam_order` int(11) DEFAULT 1 COMMENT '시험 순서',
  `exam_duration_minute` int(11) DEFAULT NULL COMMENT '시험 시간(분)',
  `grade` int(11) DEFAULT NULL COMMENT '대상 학년',
  PRIMARY KEY (`exam_subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='시험 과목';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_subject`
--

LOCK TABLES `exam_subject` WRITE;
/*!40000 ALTER TABLE `exam_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_subject` ENABLE KEYS */;
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
INSERT INTO `member` VALUES ('22020401','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','A학생','서울특별시 금천구 가산동','student1@test.com','01099112233',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020402','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','B학생','서울특별시 금천구 가산동','student2@test.com','01044556677',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020403','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','C학생','서울특별시 금천구 가산동','student3@test.com','01088991122',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020404','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','D학생','서울특별시 금천구 가산동','student4@test.com','01033445566',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020405','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','E학생','서울특별시 금천구 가산동','student5@test.com','01077889911',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020406','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','F학생','서울특별시 금천구 가산동','student6@test.com','01022334455',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020407','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','G학생','서울특별시 금천구 가산동','student7@test.com','01066778899',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020408','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','H학생','서울특별시 금천구 가산동','student8@test.com','01099887766',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020409','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','I학생','서울특별시 금천구 가산동','student9@test.com','01055443322',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020410','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','J학생','서울특별시 금천구 가산동','student10@test.com','01011998877',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020411','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','K학생','서울특별시 금천구 가산동','student11@test.com','01066554433',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020412','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','L학생','서울특별시 금천구 가산동','student12@test.com','01022119988',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020413','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','M학생','서울특별시 금천구 가산동','student13@test.com','01077665544',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020414','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','N학생','서울특별시 금천구 가산동','student14@test.com','01033221199',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020415','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','O학생','서울특별시 금천구 가산동','student15@test.com','01088776655',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020416','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','P학생','서울특별시 금천구 가산동','student16@test.com','01044332211',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020417','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','Q학생','서울특별시 금천구 가산동','student17@test.com','01098765432',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('22020418','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','R학생','서울특별시 금천구 가산동','student18@test.com','01019876543',1,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('24082927','$2a$10$01ybBQ8WU3OOtDBdR1e0M.SXHobLRudkVCM/aYhjhL9OcCn73HeSe','테스트11111111','서울시 금천구 가산동','student4@test.com','01055552222',0,'2024-08-29 10:32:09','2024-08-29 10:32:09'),('admin1','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','김관리','서울특별시 금천구 가산동','admin1@test.com','01011112222',99,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('staff1','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','김선생','서울특별시 금천구 가산동','staff1@test.com','01022223333',10,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('staff2','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','이선생','서울특별시 금천구 가산동','staff2@test.com','01044445555',10,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('staff3','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','박선생','서울특별시 금천구 가산동','staff3@test.com','01066667777',10,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('staff4','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','최선생','서울특별시 금천구 가산동','staff4@test.com','01088889999',10,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('staff5','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','조선생','서울특별시 금천구 가산동','staff5@test.com','01012345678',10,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('staff6','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','석선생','서울특별시 금천구 가산동','staff6@test.com','01011223344',10,'2020-01-01 00:00:00','2020-01-01 00:00:00'),('staff7','$2a$10$QfMJGaMusX8dNMB07XSVRuWNBAvTtrqYwBg6U5uSa/AW4TjNar9G2','마선생','서울특별시 금천구 가산동','staff7@test.com','01055667788',10,'2020-01-01 00:00:00','2020-01-01 00:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COMMENT='refresh token';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_token`
--

LOCK TABLES `refresh_token` WRITE;
/*!40000 ALTER TABLE `refresh_token` DISABLE KEYS */;
INSERT INTO `refresh_token` VALUES (1,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MDk3MDAsImV4cCI6MTcyNDgwOTcwMCwic3ViIjoiMDEwMTExMTIyMjIifQ.9u0CZTxVl674wL5fV1aojc6nya0RQ4WJaI2c7Nluy2Y','2024-08-28 10:48:20'),(2,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MDk3NDQsImV4cCI6MTcyNDgwOTc0NCwic3ViIjoiMDEwMTExMTIyMjIifQ.RJbJQfmTLWJo3dk_GR0Z3KLtK3zdjISidUy3ayGJL_A','2024-08-28 10:49:04'),(5,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MDk5OTAsImV4cCI6MTcyNDgwOTk5MCwic3ViIjoiMDEwMTExMTIyMjIifQ.yAW2d2mygKbbDaNr59lE0Z387Y_zAULv-8aaeyhllJo','2024-08-28 10:53:10'),(6,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTAwMTYsImV4cCI6MTcyNDgxMDAxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.0Sb5iKmkHMnliAetzN73Rq4mlttK9a544Cu_w3BZXRY','2024-08-28 10:53:36'),(7,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTA2MTYsImV4cCI6MTcyNDgxMDYxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.Pmfm111NwcFRJ2me8efW4-5Obw-o4MBJABCpXx6TiOI','2024-08-28 11:03:36'),(8,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTA2MzMsImV4cCI6MTcyNDgxMDYzMywic3ViIjoiMDEwMTExMTIyMjIifQ.Z3GLNqqdcKNxNYDzqdx7UKbM807ETdQrX-wAWlN30SA','2024-08-28 11:03:53'),(9,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTM3NzUsImV4cCI6MTcyNDgxMzc3NSwic3ViIjoiMDEwMTExMTIyMjIifQ.VXAorJ9lS5UpT3QihldAhAnDGHd7pzIPh5nraH3zjzU','2024-08-28 11:56:15'),(10,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4MTM4MTksImV4cCI6MTcyNDgxMzgxOSwic3ViIjoiMDEwMTExMTIyMjIifQ.6nVfY_z0LOLa-gD76znHnp-d-4vr88RaUHPKpMQ4wBQ','2024-08-28 11:56:59'),(11,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ4Mjk1NDcsImV4cCI6MTcyNDgyOTU0Nywic3ViIjoiMDEwMTExMTIyMjIifQ.knqqO6WQeiOM3go1Pxfllqd329OWiZHunyJhQ1USFxk','2024-08-28 16:19:07'),(12,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MDczMTEsImV4cCI6MTcyNDkwNzMxMSwic3ViIjoiMDEwMTExMTIyMjIifQ.O50nRSLw__98k9k59oecYAuglTXNePZq7D3O492FAQc','2024-08-29 13:55:11'),(13,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MDc0MDEsImV4cCI6MTcyNDkwNzQwMSwic3ViIjoiMDEwMTExMTIyMjIifQ.8jgPSj5eAQ_eyIg5zGMtuIheOPtqQ3lHHsZO7i0rYpQ','2024-08-29 13:56:41'),(14,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MDc3OTEsImV4cCI6MTcyNDkwNzc5MSwic3ViIjoiMDEwMTExMTIyMjIifQ.jzjwu1rq41H_bxPoyhj7-bVKyG2VVKduAUxTpIHMMZE','2024-08-29 14:03:11'),(15,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MTUyODUsImV4cCI6MTcyNDkxNTI4NSwic3ViIjoiMDEwMTExMTIyMjIifQ.baJV5loAqbVUfYt6MDys1AZJh2wuLNnTmDObXGuJ8no','2024-08-29 16:08:05'),(16,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5MTU2OTcsImV4cCI6MTcyNDkxNTY5Nywic3ViIjoiMDEwMTExMTIyMjIifQ.JA26tdwAbc9vi4bhEk-ilBMtvEHM5c5428vwauJQonA','2024-08-29 16:14:57'),(17,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5NzMzNjIsImV4cCI6MTcyNDk3MzM2Miwic3ViIjoiMDEwMTExMTIyMjIifQ.tn2OYuFG_UnT3n-CUqBbnBrteB1iRO0DKMduTgNjx98','2024-08-30 08:16:02'),(18,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5ODEyNTYsImV4cCI6MTcyNDk4MTI1Niwic3ViIjoiMDEwMTExMTIyMjIifQ.Na9AKhrW4yMD8a1N4FECC46YdgrqjkzO0cnK0xNMqbI','2024-08-30 10:27:36'),(19,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5ODI5MTYsImV4cCI6MTcyNDk4MjkxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.SIt0cHfUxS6AqdONAOa4hBS_3ThuQHn6bVe93BQTc9Q','2024-08-30 10:55:16'),(20,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5ODc1MTYsImV4cCI6MTcyNDk4NzUxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.-6XuhPoDSLrRDwuY4sVbx1mn_H65mVYgiJc9yJSmpZs','2024-08-30 12:11:56'),(21,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5OTE0MjksImV4cCI6MTcyNDk5MTQyOSwic3ViIjoiMDEwMTExMTIyMjIifQ.63CKeFV3KJGmzHhYK5qLMvmyIr4w1yC50R6yDfg-ywg','2024-08-30 13:17:09'),(22,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5OTE2NzgsImV4cCI6MTcyNDk5MTY3OCwic3ViIjoiMDEwMTExMTIyMjIifQ.7MvvwMNtO0Qrauyq3OidWp670CQ54LWYhTPLFQaYMZY','2024-08-30 13:21:18'),(23,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5OTIxMTEsImV4cCI6MTcyNDk5MjExMSwic3ViIjoiMDEwMTExMTIyMjIifQ.DV3WsIMMcVrmyr-ljq0ldbKnIOchFKx1xV79eJkUzJU','2024-08-30 13:28:31'),(24,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjQ5OTI4NTMsImV4cCI6MTcyNDk5Mjg1Mywic3ViIjoiMDEwMTExMTIyMjIifQ.-iO4l1TE5_2QUif_MBXvQhJ0XVZvU6MDZqmukubIVYA','2024-08-30 13:40:53'),(25,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMjk1ODYsImV4cCI6MTcyNTMyOTU4Niwic3ViIjoiMDEwMTExMTIyMjIifQ.PUKE3-fyVTVwyLjIulIE7clgVzwZVDgzVmQX5NtI1PE','2024-09-03 11:13:06'),(26,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzA1NDQsImV4cCI6MTcyNTMzMDU0NCwic3ViIjoiMDEwMTExMTIyMjIifQ.sEOEJntj_kQtlgRRQ5-pK1fwa5OY0y7EZpdSLyX7vUg','2024-09-03 11:29:04'),(27,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzA2NjMsImV4cCI6MTcyNTMzMDY2Mywic3ViIjoiMDEwMTExMTIyMjIifQ.biMGBJ_mNbSsF6rdt-aVjAUaqyCA7lEfbe5GVxA4KO0','2024-09-03 11:31:03'),(28,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzA3NjksImV4cCI6MTcyNTMzMDc2OSwic3ViIjoiMDEwMTExMTIyMjIifQ.ifKoRgbGbJ56zFaGEA7qlK4hYajeCM1G2TKflXIplW8','2024-09-03 11:32:49'),(29,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzI2MjEsImV4cCI6MTcyNTMzMjYyMSwic3ViIjoiMDEwMTExMTIyMjIifQ.5KsE8ENgJawdwF6o1pa3HzducUU3Yc6HPtQ_lizctmk','2024-09-03 12:03:41'),(30,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzY5MDAsImV4cCI6MTcyNTMzNjkwMCwic3ViIjoiMDEwMTExMTIyMjIifQ.U_WD-rFJpKUeTUl-NPniimQe4Os-49rKkRNX4XV1YjE','2024-09-03 13:15:00'),(31,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzMzg1NjMsImV4cCI6MTcyNTMzODU2Mywic3ViIjoiMDEwMTExMTIyMjIifQ.cCDum0i87LrF5CySJM9jOx7ZoaesiqHMBpICuYUTHkU','2024-09-03 13:42:43'),(32,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDI0NzQsImV4cCI6MTcyNTM0MjQ3NCwic3ViIjoiMDEwMTExMTIyMjIifQ.qzsfFnAt51jVXnZLWshpyhJGO4F0QQTi16YBLXAY104','2024-09-03 14:47:54'),(33,'admin1','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDI5NjAsImV4cCI6MTcyNTM0Mjk2MCwic3ViIjoiMDEwMTExMTIyMjIifQ.YHeqeLQ3ywHht_Gv8eNCLO-gZGEPVSzfRUp8RoioEg4','2024-09-03 14:56:00'),(34,'24010101','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDI5NzksImV4cCI6MTcyNTM0Mjk3OSwic3ViIjoiMDEwMTExMTIyMjIifQ.GVzo4W8c_y9Rt8wzbiNvFCNPc0E99pKHemfansruACw','2024-09-03 14:56:19'),(35,'24010101','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDMzODIsImV4cCI6MTcyNTM0MzM4Miwic3ViIjoiMDEwMTExMTIyMjIifQ.GqdROKWSt1yurPNwohX2kSpnUaMvHy7NjHQGRMelhls','2024-09-03 15:03:02'),(36,'24010101','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDQyMDcsImV4cCI6MTcyNTM0NDIwNywic3ViIjoiMDEwMTExMTIyMjIifQ.Zh7sbnqLoU9ONHW8RgV0aTh58V4D9WISWk8wuDhn07g','2024-09-03 15:16:47'),(37,'24010101','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjUzNDYzMTYsImV4cCI6MTcyNTM0NjMxNiwic3ViIjoiMDEwMTExMTIyMjIifQ.-JCoERmmwhzs5FfPC4-fCIjhmzCSoJ_D6ocSKvUtkgo','2024-09-03 15:51:56'),(38,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0MzExNjQsImV4cCI6MTcyNTQzMTE2NCwic3ViIjoiMDEwOTkxMTIyMzMifQ.EJVbhWyxQlghAQ8bkX136H734HuzhYBy94Hi5Bd6OCg','2024-09-04 15:26:04'),(39,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0MzEyNTcsImV4cCI6MTcyNTQzMTI1Nywic3ViIjoiMDEwOTkxMTIyMzMifQ.KJ9n4ePubT8frnhlYxqJ80oXpRhV6p9AZPCTH7JcCuY','2024-09-04 15:27:37'),(40,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0MzE3MzIsImV4cCI6MTcyNTQzMTczMiwic3ViIjoiMDEwOTkxMTIyMzMifQ.nbnH5XgM74zY2qWbuGmXTTI5LdRpwsKpZUt4j0mUelQ','2024-09-04 15:35:32'),(41,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0MzIyOTUsImV4cCI6MTcyNTQzMjI5NSwic3ViIjoiMDEwOTkxMTIyMzMifQ.GU1lflvyZKYEU51PHTJqMEzjekJIRGDwlYsNOCo7ccQ','2024-09-04 15:44:55'),(42,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0MzUwMDgsImV4cCI6MTcyNTQzNTAwOCwic3ViIjoiMDEwOTkxMTIyMzMifQ.JjI-9wovlVWCZplwc470HwsSEiPL5TrP4r7lzZBZ5ys','2024-09-04 16:30:08'),(43,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0MzU2NDQsImV4cCI6MTcyNTQzNTY0NCwic3ViIjoiMDEwOTkxMTIyMzMifQ.wagQCu3ZTdUbFr9s1XF-Q4RliHY3AELRgaUVoxgSDtw','2024-09-04 16:40:44'),(44,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0MzU4NTIsImV4cCI6MTcyNTQzNTg1Miwic3ViIjoiMDEwOTkxMTIyMzMifQ.hcq0GearA5l3278kXb5pEEk5cMHPYQJJ-jN78VbDoog','2024-09-04 16:44:12'),(45,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0OTM5NjUsImV4cCI6MTcyNTQ5Mzk2NSwic3ViIjoiMDEwOTkxMTIyMzMifQ.GwthswBI5DAU_t7-te7uU0BAzlQJ9VEvDw0SJRtQ0Zg','2024-09-05 08:52:45'),(46,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0OTQ0NjgsImV4cCI6MTcyNTQ5NDQ2OCwic3ViIjoiMDEwOTkxMTIyMzMifQ.yRpW8hPWMtOM5BFXNqvH8aoLqNXTjNg5CziWbWeTI88','2024-09-05 09:01:08'),(47,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0OTUzMTEsImV4cCI6MTcyNTQ5NTMxMSwic3ViIjoiMDEwOTkxMTIyMzMifQ.zSOS_4ZgJ6gkSOFc6x83GFLTdxzLTzCr7NLAen_mYEo','2024-09-05 09:15:11'),(48,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0OTg5MzAsImV4cCI6MTcyNTQ5ODkzMCwic3ViIjoiMDEwOTkxMTIyMzMifQ.8PEio-zaNO7nf7AOEWYqv8OnUj1eZAGATDdKY5BXx0k','2024-09-05 10:15:30'),(49,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU0OTk4MTYsImV4cCI6MTcyNTQ5OTgxNiwic3ViIjoiMDEwOTkxMTIyMzMifQ.SHzuY5X9XDXwyq93lnJbGIbwpLMY5XNQajy5SoDH5bw','2024-09-05 10:30:16'),(50,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU1ODQ4MzksImV4cCI6MTcyNTU4NDgzOSwic3ViIjoiMDEwOTkxMTIyMzMifQ.Cf4uDK2qte_dM7YFLqq_f759wjWFL7qJ-WapmAvXoGs','2024-09-06 10:07:19'),(51,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU1OTA3OTcsImV4cCI6MTcyNTU5MDc5Nywic3ViIjoiMDEwOTkxMTIyMzMifQ.OJY4EA0k_MN7O72LxUDuP749TrEZ8Xn-13aSa3Y-9eU','2024-09-06 11:46:37'),(52,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU1OTE1NzcsImV4cCI6MTcyNTU5MTU3Nywic3ViIjoiMDEwOTkxMTIyMzMifQ.jF9H0mkkPKcBzVLh7KBydyisIgrltmUT3fAfmmASDtc','2024-09-06 11:59:37'),(53,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU1OTYyNjAsImV4cCI6MTcyNTU5NjI2MCwic3ViIjoiMDEwOTkxMTIyMzMifQ.pVlxB0vqIQl2TnEhU0mBI5c3Rf-LYqNeAYFxKPYAFp4','2024-09-06 13:17:40'),(54,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU1OTc3NTEsImV4cCI6MTcyNTU5Nzc1MSwic3ViIjoiMDEwOTkxMTIyMzMifQ.4xjAjAzujBeKs5tGta7ciHVoko3RRA2QE1jZARtH4pM','2024-09-06 13:42:31'),(55,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU1OTk4MzcsImV4cCI6MTcyNTU5OTgzNywic3ViIjoiMDEwOTkxMTIyMzMifQ.81EFa2MZnN_uC5XaFV1ESMm76arug0BeHU_3z6ogZAI','2024-09-06 14:17:17'),(56,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU2MDIxMDUsImV4cCI6MTcyNTYwMjEwNSwic3ViIjoiMDEwOTkxMTIyMzMifQ.AR0qJAEyYk93oiSbQJmcsfZ4JbSFmotdtV3Qab7K1X0','2024-09-06 14:55:05'),(57,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU4NDAzNDYsImV4cCI6MTcyNTg0MDM0Niwic3ViIjoiMDEwOTkxMTIyMzMifQ.sE8QT2jrHyaod9YeYzptYbXdV7_l4-K8WXsMnW7PBJA','2024-09-09 09:05:46'),(58,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU4NDMwMTQsImV4cCI6MTcyNTg0MzAxNCwic3ViIjoiMDEwOTkxMTIyMzMifQ.3dlo6wsJwLUNACd3F-p-fuavrALai0H2f5GmJ-g7vgE','2024-09-09 09:50:14'),(59,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU4NDUxMjMsImV4cCI6MTcyNTg0NTEyMywic3ViIjoiMDEwOTkxMTIyMzMifQ.-HDIPLHwG9c98Beww5YKPNM6IBTZk3coVd0-d48zbwU','2024-09-09 10:25:23'),(60,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU4NDcwMDksImV4cCI6MTcyNTg0NzAwOSwic3ViIjoiMDEwOTkxMTIyMzMifQ.No4NP_nxhv4vuKioebt_54w08ANatPPUuTl6SPnnAYc','2024-09-09 10:56:49'),(61,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU4NTAxOTksImV4cCI6MTcyNTg1MDE5OSwic3ViIjoiMDEwOTkxMTIyMzMifQ.WcP5-GRnFyR-iPvD7bAWFPKdhtqVAGUyvxFpnpPz83Q','2024-09-09 11:49:59'),(62,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU4NjE2MzMsImV4cCI6MTcyNTg2MTYzMywic3ViIjoiMDEwOTkxMTIyMzMifQ.4_tbecLXw-UrI5zOzUwTjeOUCoioMdeHfxxsn-TGAZQ','2024-09-09 15:00:33'),(63,'22020401','eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MjU4NjYxOTUsImV4cCI6MTcyNTg2NjE5NSwic3ViIjoiMDEwOTkxMTIyMzMifQ.YsMGyovxKlWsAoOpsRBY0jn0HpOMleF5elntWptTGNw','2024-09-09 16:16:35');
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
INSERT INTO `subject` VALUES ('BIO','생물'),('CHE','화학'),('ENG','영어'),('ESS','지구과학'),('KOR','국어'),('MAT','수학'),('PHY','물리');
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

-- Dump completed on 2024-09-02 16:31:02
