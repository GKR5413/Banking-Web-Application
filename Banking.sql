-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: testing
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `acc_no` bigint NOT NULL AUTO_INCREMENT,
  `acc_type` varchar(30) NOT NULL,
  `acc_status` varchar(10) NOT NULL,
  `user_id` int NOT NULL,
  `brn_id` int NOT NULL DEFAULT '1775',
  `total_Account_Balance` double(10,2) DEFAULT NULL,
  PRIMARY KEY (`acc_no`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `brn_id` (`brn_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usr_info` (`user_id`),
  CONSTRAINT `accounts_ibfk_2` FOREIGN KEY (`brn_id`) REFERENCES `branch` (`brn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22030000000004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (22030000000000,'current','active',10000000,1775,70353.87),(22030000000001,'savings','active',10000001,1775,5700.00),(22030000000002,'savings','active',10000005,1775,10000.00),(22030000000003,'savings','active',10000006,1775,10000.00);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Initial_Balance` BEFORE INSERT ON `accounts` FOR EACH ROW SET NEW.total_Account_Balance = 10000.00 */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `brn_id` int NOT NULL,
  `brn_name` varchar(75) DEFAULT NULL,
  `ifsc_code` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`brn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (1775,'banking','BANK0000128');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checking`
--

DROP TABLE IF EXISTS `checking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checking` (
  `res_proof` mediumblob,
  `fin_proof` mediumblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checking`
--

LOCK TABLES `checking` WRITE;
/*!40000 ALTER TABLE `checking` DISABLE KEYS */;
/*!40000 ALTER TABLE `checking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demat`
--

DROP TABLE IF EXISTS `demat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demat` (
  `user_id` int NOT NULL,
  `demat_acc_no` bigint NOT NULL AUTO_INCREMENT,
  `original_total_value` double(11,2) DEFAULT NULL,
  `Current_market_value` double(11,2) DEFAULT NULL,
  PRIMARY KEY (`demat_acc_no`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `demat_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usr_info` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125647336523277 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demat`
--

LOCK TABLES `demat` WRITE;
/*!40000 ALTER TABLE `demat` DISABLE KEYS */;
INSERT INTO `demat` VALUES (10000000,125647336523273,31453.26,34053.26),(10000001,125647336523274,0.00,0.00),(10000005,125647336523275,NULL,NULL),(10000006,125647336523276,0.00,0.00);
/*!40000 ALTER TABLE `demat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `assign_value_on_demat_insert` BEFORE INSERT ON `demat` FOR EACH ROW set new.original_total_value = 0.00, new.Current_market_value = 0.00 */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `new_shares`
--

DROP TABLE IF EXISTS `new_shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_shares` (
  `stock_name` varchar(17) NOT NULL,
  `stock_price` double(11,2) NOT NULL,
  `no_of_avl_stocks` int DEFAULT NULL,
  `sno` bigint NOT NULL AUTO_INCREMENT,
  `stock_id` varchar(50) NOT NULL,
  PRIMARY KEY (`sno`),
  UNIQUE KEY `sno_UNIQUE` (`sno`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_shares`
--

LOCK TABLES `new_shares` WRITE;
/*!40000 ALTER TABLE `new_shares` DISABLE KEYS */;
INSERT INTO `new_shares` VALUES ('FIS',56.00,142,1,'FI001'),('Amazon.com, Inc.',99.92,49967,2,'AM002'),('Meta Platforms',213.85,69978,3,'ME003'),('Reliance inds.',234.85,6968,4,'RE004'),('Tata Consultancy',322.85,7000,5,'TA005'),('HDFC Bank',162.99,200,6,'HD006'),('infosys',114.79,200,7,'IN007'),('HDFC',137.79,800,8,'HD008'),('ITC LTD',392.79,9783,9,'IT009'),('LIC',392.79,6325,10,'LI0010'),('L&T',223.00,25,11,'L&0011'),('Asian Paints',276.99,25,12,'AS0012'),('Wipro',276.99,25,13,'WI0013'),('Tata Motors ltd',276.99,25,14,'TA0014'),('Bajaj Auto',300.99,999,15,'BA0015'),('yaswanth',9999.00,1,16,'YA0016'),('Jaswanth',9999.00,1,17,'JA0017');
/*!40000 ALTER TABLE `new_shares` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_marketvalue_in_all_tables` BEFORE INSERT ON `new_shares` FOR EACH ROW BEGIN
	
    Update shares 
    Set current_market_price = new.stock_price
    where stock_name = new.stock_name;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Add_Stock_Id` BEFORE INSERT ON `new_shares` FOR EACH ROW Begin 
set new.stock_id = concat(upper(left(new.stock_name,2)), '00', (select(max(sno)) from new_shares) + 1);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_marketvalue_in_all_tables_onupdate` BEFORE UPDATE ON `new_shares` FOR EACH ROW BEGIN
	
    Update shares 
    Set current_market_price = new.stock_price
    where stock_name = new.stock_name;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `overdraft`
--

DROP TABLE IF EXISTS `overdraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `overdraft` (
  `user_id` int NOT NULL,
  `rqloan_amnt` double(15,2) NOT NULL,
  `mnth_incm` double(10,2) NOT NULL,
  `mode_of_salary` varchar(10) NOT NULL,
  KEY `user_id` (`user_id`),
  CONSTRAINT `overdraft_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usr_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `overdraft`
--

LOCK TABLES `overdraft` WRITE;
/*!40000 ALTER TABLE `overdraft` DISABLE KEYS */;
INSERT INTO `overdraft` VALUES (10000000,10000000.00,20000.00,'check'),(10000000,10000000.00,1223.00,'cash'),(10000000,10000000.00,213123.00,'cash'),(10000000,10000000.00,99999.00,'check'),(10000000,10000000.00,88888.00,'cash'),(10000000,10000000.00,1223313.00,'cash'),(10000000,10000000.00,1223313.00,'cash'),(10000000,10.00,1223.00,'cash'),(10000000,10.00,1223.00,'cash'),(10000000,1200.00,1223.00,'cash'),(10000000,11.00,1223.00,'cash'),(10000000,12.00,1223.00,'cash'),(10000000,12.00,1223.00,'check'),(10000000,11.00,1223.00,'cash'),(10000000,1200.00,1223313.00,'cash'),(10000000,10.00,1223.00,'cash'),(10000000,10.00,1223313.00,'cash'),(10000000,10.00,1223.00,'cash'),(10000000,1200.00,1223.00,'cash'),(10000000,1200.00,1223.00,'cash'),(10000000,11.00,1223.00,'check'),(10000000,555.00,1223.00,'cash'),(10000000,11.00,1223.00,'cash'),(10000000,1.00,1223.00,'cash'),(10000000,12.00,1223.00,'cash'),(10000000,11.00,1223.00,'cash'),(10000000,1200.00,1223.00,'check'),(10000000,33.00,1223.00,'cash'),(10000000,10.00,1223.00,'cash'),(10000000,44444.00,5555555.00,'cash'),(10000000,10.00,1223313.00,'cash');
/*!40000 ALTER TABLE `overdraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shares`
--

DROP TABLE IF EXISTS `shares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shares` (
  `stock_name` varchar(17) DEFAULT NULL,
  `original_price` double(11,2) DEFAULT NULL,
  `current_market_price` double(11,2) DEFAULT NULL,
  `no_stocks` int DEFAULT NULL,
  `demat_acc_no` bigint NOT NULL,
  `sno` bigint NOT NULL AUTO_INCREMENT,
  `stock_id` varchar(50) NOT NULL,
  UNIQUE KEY `shares_id` (`sno`),
  KEY `demat_acc_no` (`demat_acc_no`),
  CONSTRAINT `shares_ibfk_1` FOREIGN KEY (`demat_acc_no`) REFERENCES `demat` (`demat_acc_no`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shares`
--

LOCK TABLES `shares` WRITE;
/*!40000 ALTER TABLE `shares` DISABLE KEYS */;
INSERT INTO `shares` VALUES ('FIS',56.00,56.00,80,125647336523273,1,'FI001'),('Amazon.com, Inc.',99.92,99.92,2,125647336523273,2,'AM002'),('Meta Platforms',213.85,213.85,2,125647336523273,3,'ME003'),('Reliance inds.',234.85,234.85,1,125647336523273,4,'RE004');
/*!40000 ALTER TABLE `shares` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `changes_after_buying_stocks_for_insert_into_shares` AFTER INSERT ON `shares` FOR EACH ROW BEGIN
    
    Declare org_amount_after_buying double(11,2);
    Declare market_amount_after_buying double(11,2);

	#update current market price and original price in demat table
		        
		set market_amount_after_buying = (new.current_market_price * new.no_stocks);
		set org_amount_after_buying = (new.original_price * new.no_stocks);
        
        Update demat
		set demat.original_total_value = ((demat.original_total_value ) + org_amount_after_buying), 
			demat.Current_market_value = ((demat.Current_market_value ) + market_amount_after_buying)
		where demat.demat_acc_no = new.demat_acc_no;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `shares_AFTER_UPDATE` AFTER UPDATE ON `shares` FOR EACH ROW BEGIN
	Declare org_amount_before_buying double(11,2);
    Declare market_amount_before_buying double(11,2);
    
    Declare org_amount_after_buying double(11,2);
    Declare market_amount_after_buying double(11,2);

	#update current market price and original price in demat table
		
        set market_amount_before_buying = (old.current_market_price * old.no_stocks);
		set org_amount_before_buying = (old.original_price * old.no_stocks);
        
		set market_amount_after_buying = (new.current_market_price * new.no_stocks);
		set org_amount_after_buying = (new.original_price * new.no_stocks);
        
        Update demat
		set demat.original_total_value = ((demat.original_total_value - org_amount_before_buying) + org_amount_after_buying), 
			demat.Current_market_value = ((demat.Current_market_value - market_amount_before_buying) + market_amount_after_buying)
		where demat.demat_acc_no = old.demat_acc_no;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_delete_in_shares` AFTER DELETE ON `shares` FOR EACH ROW BEGIN
    
		Declare original_amount double(11,2);
        Declare Market_amount double(11,2);
    
		Set original_amount = old.original_price * old.no_stocks;
        Set Market_amount = old.current_market_price * old.no_stocks;
		
        update demat
        set original_total_value = (original_total_value - original_amount),
			Current_market_value = (Current_market_value - Market_amount)
		where demat_acc_no = old.demat_acc_no;
        
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `data` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES ('yas'),('jas'),('surya'),('raju');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `t_date` date NOT NULL,
  `acc_no` bigint NOT NULL,
  `sno` int NOT NULL AUTO_INCREMENT,
  `pmnt_method` varchar(30) NOT NULL,
  `pmnt_type` varchar(11) NOT NULL,
  `amnt` double(11,2) NOT NULL,
  `t_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sno`),
  KEY `acc_no` (`acc_no`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`acc_no`) REFERENCES `accounts` (`acc_no`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES ('2023-04-17',22030000000000,6,'Overdraft','credit',12.00,'OD202341719210'),('2023-04-17',22030000000000,7,'Overdraft','credit',11.00,'OD202341719310'),('2023-04-17',22030000000000,12,'Overdraft','credit',1.00,'202311'),('2023-04-17',22030000000000,13,'Overdraft','credit',12.00,'202312'),('2023-04-17',22030000000000,14,'Overdraft','credit',11.00,'202314'),('2023-04-17',22030000000000,15,'Overdraft','credit',1200.00,'202315'),('2023-04-17',22030000000000,16,'Overdraft','credit',33.00,'OD202341719423616'),('2023-04-17',22030000000000,17,'Overdraft','credit',10.00,'OD202341719484617'),('2023-04-17',22030000000000,18,'Demat Trade','credit',728.00,'DMT_S202341719485518'),('2023-04-17',22030000000000,22,'Demat Trade','credit',840.00,'DMT_S202341719532922'),('2023-04-17',22030000000000,24,'Overdraft','credit',44444.00,'OD202341719562023'),('2023-04-18',22030000000000,35,'Demat Trade','credit',168.00,'DMT_S202341810154735'),('2023-04-18',22030000000000,41,'Demat Trade','debit',112.00,'successful'),('2023-04-18',22030000000000,43,'Demat Trade','debit',0.00,'DMTB202341810315'),('2023-04-18',22030000000000,44,'Demat Trade','debit',199.84,'DMTB202341810325'),('2023-04-18',22030000000000,45,'Demat Trade','debit',99.92,'DMTB2023418103335'),('2023-04-18',22030000000000,46,'Demat Trade','debit',199.84,'DMTB2023418103440'),('2023-04-18',22030000000000,47,'Demat Trade','credit',1008.00,'DMTS202341810361447'),('2023-04-18',22030000000000,48,'Demat Trade','debit',112.00,'DMTB2023418103647'),('2023-04-18',22030000000000,49,'Demat Trade','debit',168.00,'DMTB202341810385249'),('2023-04-18',22030000000000,50,'Demat Trade','debit',112.00,'DMTB202341810391450'),('2023-04-18',22030000000000,51,'Demat Trade','Credit',112.00,'DMTS20234181040451'),('2023-04-18',22030000000000,52,'Overdraft','credit',10.00,'OD2023418124452'),('2023-04-18',22030000000000,53,'Demat Trade','Credit',56.00,'DMTS202341816132553'),('2023-04-18',22030000000000,54,'Demat Trade','Debit',448.00,'DMTB202341816244654'),('2023-04-18',22030000000000,55,'Demat Trade','Debit',112.00,'DMTB202341816253955'),('2023-04-18',22030000000000,56,'Demat Trade','Debit',1176.00,'DMTB202341816255656'),('2023-04-18',22030000000000,57,'Demat Trade','Debit',952.00,'DMTB202341816261357'),('2023-04-18',22030000000000,58,'Demat Trade','Debit',199.84,'DMTB202341816293458'),('2023-04-18',22030000000000,59,'Demat Trade','Debit',112.00,'DMTB202341816312159'),('2023-04-18',22030000000000,60,'Demat Trade','Debit',99.92,'DMTB2023418173860'),('2023-04-18',22030000000000,61,'Demat Trade','Debit',99.92,'DMTB20234181732661'),('2023-04-18',22030000000000,62,'Demat Trade','Debit',427.70,'DMTB20234181735162'),('2023-04-18',22030000000000,63,'Demat Trade','Credit',672.00,'DMTS20234182017263'),('2023-04-18',22030000000000,64,'Demat Trade','Debit',1288.00,'DMTB202341820192264'),('2023-04-19',22030000000000,65,'Demat Trade','Debit',234.85,'DMTB20234191015465');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `Total_Balance_After_Transaction` AFTER INSERT ON `transaction` FOR EACH ROW Begin
	if new.pmnt_type = "debit" then
		update accounts 
        set total_Account_Balance = (total_Account_Balance - new.amnt)
        where accounts.acc_no = new.acc_no;
	elseif new.pmnt_type = "credit" then
        update accounts 
        set total_Account_Balance = (total_Account_Balance + new.amnt )
		where accounts.acc_no = new.acc_no;
	end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `user_cred` varchar(40) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usr_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (10000000,'125CA2B90F62574B8070DCAB162EA23A'),(10000001,'ED51AD884A4C6D169B49E6ED32CF1EC5'),(10000004,'7DD479D8C9F32036953392E39EFA5CFB'),(10000005,'93D5A03F4692EFA76268F90EC80AC490'),(10000006,'D78CF849B7FD767D242A3C36AC219A25');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usr_info`
--

DROP TABLE IF EXISTS `usr_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usr_info` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `acc_type` varchar(20) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `fname` varchar(30) NOT NULL,
  `lname` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `mail_id` varchar(62) NOT NULL,
  `ph_no` bigint NOT NULL,
  `street` varchar(100) NOT NULL,
  `city` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL,
  `zipcode` int NOT NULL,
  `res_id` varchar(12) DEFAULT NULL,
  `fin_id` varchar(10) NOT NULL,
  `res_proof` varchar(225) DEFAULT NULL,
  `fin_proof` varchar(225) DEFAULT NULL,
  `brn_id` int DEFAULT '1775',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `mail_id` (`mail_id`),
  UNIQUE KEY `ph_no` (`ph_no`),
  UNIQUE KEY `fin_id` (`fin_id`),
  UNIQUE KEY `res_id` (`res_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000007 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usr_info`
--

LOCK TABLES `usr_info` WRITE;
/*!40000 ALTER TABLE `usr_info` DISABLE KEYS */;
INSERT INTO `usr_info` VALUES (10000000,'current','eur','Yaswanth','Korrapati','2023-03-01','yaswanth320@gmail.com',9010415663,'Ashok Nagar','Hyderabad','Telangana','India',509301,'924701222033','BEMPY2053N','Screenshot (137).png','Screenshot (137).png',1775),(10000001,'savings','rupee','Jaswanth','K','2023-03-01','jaswanthKk1@gmail.com',8801124325,'AshokNagar','Hyderabad','Telangana','India',509301,'924701222044','BEMPY2053Q','No File Uploaded','No File Uploaded',1775),(10000004,'savings','usd','Vinay','K','2023-03-16','vinayKk1@gmail.com',8989891283,'Ashok Nagar','Guntur','AP','India',872817,'789871289387','ZEMPY2200K','No File Uploaded','No File Uploaded',1775),(10000005,'savings','usd','Vijay','B','2023-03-02','vijay@gmail.com',9812903908,'sahfldasf','sadflhsafd','ap','indian',127837,'921893890218','zempy0202K','No File Uploaded','No File Uploaded',1775),(10000006,'savings','eur','dhanush','gutta','2023-03-31','dhanush@gmail.com',8829292918,'ramayana Street','kandukur','AP','India',217382,'217721874812','BEMOY1236R','No File Uploaded','No File Uploaded',1775);
/*!40000 ALTER TABLE `usr_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'testing'
--

--
-- Dumping routines for database 'testing'
--
/*!50003 DROP PROCEDURE IF EXISTS `buyStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buyStock`(
	IN in_stock_name varchar(17),
    IN in_stock_id varchar(50),
    out out_stock_id varchar(50),
    out out_stock_name varchar(17),
    out out_stock_price double(11,2),
    out out_stock_avl_qunatity int
    )
BEGIN
	
    select stock_id,stock_name, stock_price, no_of_avl_stocks 
    into out_stock_id,out_stock_name, out_stock_price, out_stock_avl_qunatity 
    from new_shares
    where stock_name = in_stock_name And stock_id = in_stock_id; 
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkVariables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkVariables`(
	IN in_email varchar(62),
    IN in_phone bigint,
    IN in_res_id varchar(12),
    IN in_fin_id varchar(10),
    OUT out_email int,
    OUT	out_phone int,
    OUT	out_res_id int,
    OUT	out_fin_id int
)
BEGIN
	
    -- Email check
    Select user_id into out_email from usr_info where mail_id = in_email;
    
    -- Phone Check
	Select user_id into out_phone from usr_info where ph_no = in_phone;
    
    -- aadhar check
    Select coalesce(user_id,0) into out_res_id from usr_info where res_id = in_res_id;
    
    -- pan check
    Select coalesce(user_id,0) into out_fin_id from usr_info where fin_id = in_fin_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetchData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchData`()
BEGIN
	select * from test;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetchNewShares` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchNewShares`(
    IN in_offset INT,
    IN in_limit INT,
	IN in_sortfield varchar(30),
    IN in_sortdir varchar(10),
     IN in_Keyword varchar(50)
)
BEGIN
	IF in_Keyword IS NULL OR in_Keyword='' then
		 set @query = "SELECT * FROM new_shares";
		 set @query = concat(@query, " order by ");
		 set @query = concat(@query, in_sortfield);
		 set @query = CONCAT(@query, " ");
		 set @query = concat(@query, in_sortdir);
		 set @query = concat(@query, " Limit ");
		 set @query = concat(@query, in_offset);
		 set @query = CONCAT(@query, ", ");
		 set @query = concat(@query, in_limit);
		 prepare stmt from @query;
		 Execute stmt;
	ELSEIF in_Keyword IS NOT NULL then
		 set @query = "SELECT * FROM new_shares where";
          set @query = concat(@query, " ( ");
		 set @query = concat(@query, " stock_name like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " stock_id like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
	     set @query = concat(@query, " stock_price like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
          set @query = concat(@query, " no_of_avl_stocks like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
          set @query = concat(@query, " )");
		 set @query = concat(@query, " order by ");
		 set @query = concat(@query, in_sortfield);
		 set @query = CONCAT(@query, " ");
		 set @query = concat(@query, in_sortdir);
		 set @query = concat(@query, " Limit ");
		 set @query = concat(@query, in_offset);
		 set @query = CONCAT(@query, ", ");
		 set @query = concat(@query, in_limit);
		 prepare stmt from @query;
		 Execute stmt;
	END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_Acc_No` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_Acc_No`(
	IN in_user_id int,
    OUT out_acc_no bigint,
    out out_original_total_amount double(11,2),
    out out_market_total_amount double(11,2)
)
BEGIN
	Select demat_acc_no, original_total_value, Current_market_value
    into out_acc_no, out_original_total_amount, out_market_total_amount
    From demat
    where user_id = in_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fetch_shares` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetch_shares`(
	IN in_accno bigint,
    IN in_offset int,
    IN in_limit int,
    IN in_sortfield varchar(30),
    IN in_sortdir varchar(10),
	IN in_Keyword varchar(50)
)
BEGIN

	IF in_Keyword IS NULL OR in_Keyword='' then
		 set @query = "select * From shares where demat_acc_no = ";
		 set @query = concat(@query, in_accno);
		 set @query = concat(@query, " order by ");
		 set @query = concat(@query, in_sortfield);
		 set @query = CONCAT(@query, " ");
		 set @query = concat(@query, in_sortdir);
		 set @query = concat(@query, " Limit ");
		 set @query = concat(@query, in_offset);
		 set @query = CONCAT(@query, ", ");
		 set @query = concat(@query, in_limit);
		 prepare stmt from @query;
		 Execute stmt;
	ELSEIF in_Keyword IS NOT NULL then
	     set @query = "select * From shares where demat_acc_no = ";
		 set @query = concat(@query, in_accno);
		 set @query = concat(@query, " AND ");
         set @query = concat(@query, " ( ");
		 set @query = concat(@query, " stock_name like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " stock_id like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
	     set @query = concat(@query, " original_price like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " current_market_price like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
          set @query = concat(@query, " no_stocks like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
          set @query = concat(@query, " )");
		 set @query = concat(@query, " order by ");
		 set @query = concat(@query, in_sortfield);
		 set @query = CONCAT(@query, " ");
		 set @query = concat(@query, in_sortdir);
		 set @query = concat(@query, " Limit ");
		 set @query = concat(@query, in_offset);
		set @query = CONCAT(@query, ", ");
		 set @query = concat(@query, in_limit);
		 prepare stmt from @query;
		 Execute stmt;
	END if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GeekLoop` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GeekLoop`()
BEGIN
DECLARE no INT;
  SET no = 0;
  s_loop: LOOP
    SET no = no +1;
    update shares set stock_id =  new_shares.stock_id where stock_name = new_shares.stock_name; 
    IF no = 17 THEN
     LEAVE s_loop;
    END IF;
 END LOOP s_loop;
SELECT no;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `login_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login_user`(IN in_user_id varchar(10),
                               out out_cred varchar(40)
)
BEGIN
	# Fetch pass from User table
    SELECT cast(aes_decrypt(unhex(`user_cred`), 'cred') as char(50))
    INTO out_cred
    FROM  user 
    WHERE user_id = in_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `od_Application` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `od_Application`(
	IN in_userId int,
    IN in_rqloan_amnt double(11,2),
    IN in_mnth_incm double(11,2),
    IN in_mode_of_salary varchar(10),
    OUT out_msg varchar(100)
)
BEGIN
	
    Declare account_no bigint;
    Declare tid varchar(50);

	INSERT INTO overdraft(
			user_id,
            rqloan_amnt,
            mnth_incm,
            mode_of_salary
    )
    VALUES(
			in_userId,
			in_rqloan_amnt,
			in_mnth_incm,
			in_mode_of_salary
	);
    
    select acc_no into account_no
			from accounts
            where user_id = in_userId;

	select concat('OD',year(CURRENT_TIMESTAMP()),month(CURRENT_TIMESTAMP()),day(CURRENT_TIMESTAMP()),hour(CURRENT_TIMESTAMP()),
    minute(CURRENT_TIMESTAMP()),second(CURRENT_TIMESTAMP()),(select max(sno) from transaction where acc_no = account_no)+1) into tid;
    
	 insert into transaction(t_date, acc_no, pmnt_method, pmnt_type, amnt, t_id) 
		values (now(), account_no, 'Overdraft', 'credit', in_rqloan_amnt, tid);
    
    Select "Successful: Amount has been credited into Current Account" into out_msg;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `processbuy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `processbuy`(
 in in_stock_id varchar(50),
 in in_stock_name varchar(17),
 in in_no_of_stock int,
 in in_user_id int,
 out out_msg varchar(200)
)
BEGIN
	Declare total_available_stocks int;
    Declare price double(11,2);
    Declare acc_no bigint;
    Declare var int;
    Declare notunique int;
    Declare trade_amount double(11,2);
    Declare account_no bigint;
    Declare account_balance double(11,2);
	Declare tid varchar(50);
    SELECT 
		no_of_avl_stocks, stock_price
	INTO total_available_stocks , price FROM
		new_shares
	WHERE
		stock_name = in_stock_name;
    
    Set trade_amount = (price * in_no_of_stock);
    
    select total_Account_Balance into account_balance
		from accounts 
        where user_id = in_user_id;
    
    IF ( account_balance < trade_amount) THEN
        
        Select "Transaction Failed: Insufficient Balance." into out_msg;
   
   Else 
		
	SELECT 
		demat_acc_no
	INTO acc_no FROM
		demat
	WHERE
		user_id = in_user_id;
		

	SELECT 
		accounts.acc_no
	INTO account_no FROM
		accounts
	WHERE
		accounts.user_id = in_user_id;
		
	SELECT 
		COUNT(1)
	INTO notunique FROM
		shares
	WHERE
		stock_name = in_stock_name
			AND original_price = price;
		
       select concat('DMTB',year(CURRENT_TIMESTAMP()),month(CURRENT_TIMESTAMP()),day(CURRENT_TIMESTAMP()),hour(CURRENT_TIMESTAMP()),
			minute(CURRENT_TIMESTAMP()),second(CURRENT_TIMESTAMP()),(select max(sno) from transaction)+1) into tid;
        
		insert into transaction(t_date, acc_no, pmnt_method, pmnt_type, amnt, t_id) 
		values (now(), account_no, 'Demat Trade', 'Debit', trade_amount, tid);
        
        
        
		IF (total_available_stocks = in_no_of_stock) then
			
		If (notunique = 0) then
			
			insert into shares(stock_name, original_price, current_market_price, no_stocks, demat_acc_no, stock_id)
			values( in_stock_name, price, price, in_no_of_stock, acc_no, in_stock_id);
		
		Elseif (notunique = 1) then
				
				update shares
				set no_stocks = no_stocks + in_no_of_stock
				where demat_acc_no = acc_no and stock_name=in_stock_name;
		End if;
			
			
	DELETE FROM new_shares 
	WHERE
		stock_name = in_stock_name;

			
		Elseif(total_available_stocks > in_no_of_stock) then
			
				If (notunique = 0) then
			
			insert into shares(stock_name, original_price, current_market_price, no_stocks, demat_acc_no, stock_id)
			values( in_stock_name, price, price, in_no_of_stock, acc_no, in_stock_id);
		
		Elseif (notunique = 1) then
				
				update shares
				set no_stocks = no_stocks + in_no_of_stock
				where demat_acc_no = acc_no and stock_name=in_stock_name;
		End if;
			
			set var = (total_available_stocks - in_no_of_stock);
			UPDATE new_shares 
	SET 
		no_of_avl_stocks = var
		where stock_name = in_stock_name;
			
		Elseif(total_available_stocks < no_of_avl_stocks) then
			select "Transaction Failed: selected quantity exceeds the avaialbale no of stocks" into out_msg;
		END if;
		 select "SUCCESSFUL: Transaction Completed." into out_msg;
	End if;
    
   
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `register_User` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register_User`(
									IN in_acc_type varchar(20), 
									IN in_currency varchar(10), 
									IN in_fname varchar(30), 
									IN in_lname varchar(20),
									IN in_dob date,
									IN in_mail_id varchar(62),
									IN in_ph_no bigint,
									IN in_street varchar(100),
									IN in_city varchar(20),
									IN in_state varchar(20),
									In in_country varchar(20),
									IN in_zipcode int,
									IN in_res_id varchar(12),
									IN in_fin_id varchar(10),
									IN in_res_proof varchar(225),
									IN in_fin_proof varchar(225),
                                    IN in_cred varchar(40),
                                    OUT out_msg varchar(100)
)
BEGIN
	
    # Variable Declaration
    
    DECLARE id BIGINT;

	# Inserting data into Registration table
	insert into usr_info (  acc_type,
							currency,
                            fname,
                            lname,
                            dob,
                            mail_id,
                            ph_no,
                            street,
                            city,
                            state,
                            country,
                            zipcode,
                            res_id,
                            fin_id,
                            res_proof,
                            fin_proof)
	values(	in_acc_type,
			in_currency,
            in_fname,
            in_lname,
            in_dob,
            in_mail_id,
            in_ph_no,
            in_street,
            in_city,
            in_state,
            in_country,
            in_zipcode,
            in_res_id,
            in_fin_id,
            in_res_proof,
            in_fin_proof
    );
    
    # Inserting data into login table
	Insert into User (user_id, user_cred) 
    values ((Select user_id 
			From usr_info 
            Where mail_id = in_mail_id),hex(aes_encrypt(in_cred, 'cred'))); 
            
	#Inserting data into Accounts
    insert into accounts (acc_type, acc_status, user_id, total_Account_Balance) 
    values (in_acc_type, 'active', (Select user_id 
			From usr_info 
            Where mail_id = in_mail_id), null
	);
    
    # INserting user id into Demat Table to generate Demat account number
    Insert into demat (user_id)
    values((Select user_id 
			From usr_info 
            Where mail_id = in_mail_id));
    
    # return successful updation msg
    Select "Registration Successful" into out_msg;
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `resetPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `resetPassword`(
	IN in_user_id int,
    IN in_cred varchar(40),
    OUT out_msg varchar(100)
)
BEGIN
	# Reset Password in User Table
    UPDATE user
	SET	user_cred = hex(aes_encrypt(in_cred, 'cred'))
	WHERE user_id = in_user_id;
    
    Select "Password Updated Successfully" into out_msg;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `selected_stock_from_shares` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `selected_stock_from_shares`(
INOUT in_out_sno bigint,
out out_stock_id varchar(50),
INOUT in_out_stock_name varchar(17),
IN in_demat_acc_no bigint,
OUT out_market_price double(11,2),
OUT out_no_stocks int
)
BEGIN
	Select sno,stock_id, stock_name, current_market_price, no_stocks
    Into in_out_sno, out_stock_id, in_out_stock_name, out_market_price, out_no_stocks
    From shares
    Where sno = in_out_sno AND stock_name = in_out_stock_name AND  demat_acc_no = in_demat_acc_no;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sellStock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sellStock`(
IN in_Stock_name varchar(17),
IN in_no_of_stocks int,
IN in_user_id int,
IN in_sno bigint,
out out_msg varchar(100)
)
BEGIN
		Declare AccountNumber Bigint;
		Declare Price double(11,2);
        Declare Transaction_amount double(11,2);
        Declare uniquevalue int;
        Declare Dac_number bigint;
        Declare noof_stocks_inhand int;
        Declare OrignalPrice double(11,2);
        Declare tid varchar(50);
        
SELECT 
    demat_acc_no
INTO Dac_number FROM
    demat
WHERE
    user_id = in_user_id;
        
SELECT 
    accounts.acc_no
INTO AccountNumber FROM
    accounts
WHERE
    accounts.user_id = in_user_id;
    
SELECT 
    current_market_price
INTO Price FROM
    shares
WHERE
    stock_name = in_stock_name
        AND sno = in_sno;

        Set Transaction_amount = Price * in_no_of_stocks;
        
        select concat('DMTS',year(CURRENT_TIMESTAMP()),month(CURRENT_TIMESTAMP()),day(CURRENT_TIMESTAMP()),hour(CURRENT_TIMESTAMP()),
			minute(CURRENT_TIMESTAMP()),second(CURRENT_TIMESTAMP()),(select max(sno) from transaction)+1) into tid;
        
		# update transaction table
		Set Transaction_amount = (price * in_no_of_stocks);
        
		insert into transaction(t_date, acc_no, pmnt_method, pmnt_type, amnt, t_id) 
		values (now(), AccountNumber, 'Demat Trade', 'Credit', Transaction_amount, tid);
		
		SELECT 
    COUNT(1)
INTO uniquevalue FROM
    new_shares
WHERE
    stock_name = in_stock_name;
        
SELECT 
    no_stocks
INTO noof_stocks_inhand FROM
    shares
WHERE
    stock_name = in_stock_name
        AND sno = in_sno;
       
		If (noof_stocks_inhand > in_no_of_stocks) then
			
            		# update the stock quantity in newShares when some stocks are sold
         If (uniquevalue = 1) then
				update new_shares
				set no_of_avl_stocks = no_of_avl_stocks + in_no_of_stocks
				where stock_name = in_stock_name;
			
            Elseif (uniquevalue = 0) then
				Insert into new_shares (stock_name, stock_price, no_of_avl_stocks)
                values (in_stock_name, Price, in_no_of_stocks);
                
		End if;
            
            
            
			UPDATE shares 
SET 
    no_stocks = no_stocks - in_no_of_stocks
WHERE
    stock_name = in_stock_name
        AND sno = in_sno;
            

		Elseif (noof_stocks_inhand = in_no_of_stocks) then

		            # update the stock quantity in newShares when some stocks are sold
         If (uniquevalue = 1) then
				update new_shares
				set no_of_avl_stocks = no_of_avl_stocks + in_no_of_stocks
				where stock_name = in_stock_name;
			
            Elseif (uniquevalue = 0) then
				Insert into new_shares (stock_name, stock_price, no_of_avl_stocks)
                values (in_stock_name, Price, in_no_of_stocks);
                
		End if;



DELETE FROM shares 
WHERE
    stock_name = in_stock_name
    AND sno = in_sno;
            
 
            
		End if;
        
SELECT 
    original_price
INTO OrignalPrice FROM
    shares
WHERE
    stock_name = in_stock_name
        AND sno = in_sno;
        
Set OrignalPrice = (OrignalPrice * in_no_of_stocks);
        
Select 'SUCCESS: Sell Transaction Completed.' into out_msg;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `totalNoofNewSharesAvailable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `totalNoofNewSharesAvailable`(
		out out_totalcount int,
         in in_Keyword varchar(50)
)
BEGIN
	
	IF in_Keyword IS NULL OR in_Keyword='' then
			Select count(*) into out_totalcount
			From new_shares;
	ELSEIF in_Keyword IS NOT NULL then
		 set @query = "SELECT count(*) into @temp FROM  new_shares where";
		 set @query = concat(@query, " ( ");
		 set @query = concat(@query, " stock_name like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " stock_id like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
	     set @query = concat(@query, " stock_price like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
          set @query = concat(@query, " no_of_avl_stocks like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
          set @query = concat(@query, " );");
		 prepare stmt from @query;
		 Execute stmt;
         
         select @temp into out_totalcount;
         
	END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `totalsharesbeingheld` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `totalsharesbeingheld`(
	IN in_user_id int,
	out out_totalcount int,
     in in_Keyword varchar(50)
)
BEGIN

	Declare v_acc_no BIGINT;
    
    Select demat_acc_no into v_acc_no
	from demat 
	where user_id = in_user_id;
                            
	IF in_Keyword IS NULL OR in_Keyword='' then
		Select count(*) into out_totalcount
		From shares
		Where demat_acc_no = v_acc_no;
	ELSEIF in_Keyword IS NOT NULL then
		   set @query = "select count(*) into @temp From shares where demat_acc_no = ";
		 set @query = concat(@query, v_acc_no);
		 set @query = concat(@query, " AND ");
         set @query = concat(@query, " ( ");
		 set @query = concat(@query, " stock_name like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " stock_id like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
	     set @query = concat(@query, " original_price like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " current_market_price like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
          set @query = concat(@query, " no_stocks like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
          set @query = concat(@query, " );");
		 prepare stmt from @query;
		 Execute stmt;
         
          select @temp into out_totalcount;
         
    END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `total_noof_transactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `total_noof_transactions`(
	in in_user_id int,
    out out_totalcount int,
    in in_Keyword varchar(50)
)
BEGIN
	
	Declare v_acc_no BIGINT;
        
    select acc_no into v_acc_no
	from accounts
	where user_id = in_user_id;
	
    
	IF in_Keyword IS NULL OR in_Keyword='' then
        	
    select count(*) into out_totalcount
    From transaction
    where acc_no = v_acc_no;
        
	ELSEIF in_Keyword IS NOT NULL then
	
		set @query = "SELECT count(*) into  @temp";
        set @query = concat(@query, " FROM transaction where acc_no = ");
		 set @query = concat(@query, v_acc_no);
         set @query = concat(@query, " AND ");
         set @query = concat(@query, " ( ");
		 set @query = concat(@query, " t_date like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " pmnt_method like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
	     set @query = concat(@query, " pmnt_type like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " amnt like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
          set @query = concat(@query, " t_id like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " ); "); 
		 prepare stmt from @query;
		 Execute stmt; 
         
         select @temp into out_totalcount;
	END if;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `T_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `T_data`(
	
    IN in_accno BIGINT,
    IN in_offset INT,
    IN in_limit INT,
    IN in_sortfield varchar(30),
    IN in_sortdir varchar(10),
    IN in_Keyword varchar(50)
)
BEGIN
	IF in_Keyword IS NULL OR in_Keyword='' then
		set @query = "SELECT * FROM transaction where acc_no = ";
		 set @query = concat(@query, in_accno);
		 set @query = concat(@query, " order by ");
		 set @query = concat(@query, in_sortfield);
		 set @query = CONCAT(@query, " ");
		 set @query = concat(@query, in_sortdir);
		 set @query = concat(@query, " Limit ");
		 set @query = concat(@query, in_offset);
		set @query = CONCAT(@query, ", ");
		 set @query = concat(@query, in_limit);
		 prepare stmt from @query;
		 Execute stmt;
	ELSEIF in_Keyword IS NOT NULL then
    
		set @query = "SELECT * FROM transaction where acc_no = ";
		 set @query = concat(@query, in_accno);
         set @query = concat(@query, " AND ");
         set @query = concat(@query, " ( ");
		 set @query = concat(@query, " t_date like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " pmnt_method like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
	     set @query = concat(@query, " pmnt_type like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
		 set @query = concat(@query, " amnt like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
         set @query = concat(@query, " OR ");
          set @query = concat(@query, " t_id like ");
		 set @query = CONCAT(@query, "'%");
         set @query = concat(@query, in_Keyword);
		 set @query = CONCAT(@query, "%' ");
          set @query = concat(@query, " )");
		 set @query = concat(@query, " order by ");
		 set @query = concat(@query, in_sortfield);
		 set @query = CONCAT(@query, " ");
		 set @query = concat(@query, in_sortdir);
		 set @query = concat(@query, " Limit ");
		 set @query = concat(@query, in_offset);
		set @query = CONCAT(@query, ", ");
		 set @query = concat(@query, in_limit);
        
		 prepare stmt from @query;
		 Execute stmt;
	END if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `userInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `userInfo`(
	IN in_userid int,
    out out_accno bigint,
    out out_acctype varchar(30),
    out out_ifsc varchar(11),
    out out_branchname varchar(75),
    out out_branchid int,
    out out_accstatus varchar(20),
    out out_currency varchar(20),
    out out_balance double(10,2)
)
BEGIN
	# Fetching User details from Accounts and Brach tables
    select accounts.acc_no, accounts.acc_type, branch.ifsc_code, branch.brn_name, accounts.brn_id, accounts.total_Account_Balance
    into out_accno, out_acctype, out_ifsc, out_branchname, out_branchId, out_balance
	from accounts, branch 
	where accounts.user_id = in_userid AND accounts.brn_id = branch.brn_id;
    
    Select 'Active' into out_accstatus;
    
    select currency
    Into out_currency
    from usr_info
    where user_id = in_userid;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ValidateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ValidateUser`(
	IN in_user_id int,
    OUT out_email varchar(62)
)
BEGIN
	# Check if User_id is present in the user_signup table
	Select mail_id 
    INTO out_email
    FROM usr_info
    WHERE user_id = in_user_id;
END ;;
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

-- Dump completed on 2023-06-12 12:04:41
