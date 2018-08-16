-- MySQL dump 10.13  Distrib 5.7.20, for Win32 (AMD64)
--
-- Host: localhost    Database: exchg
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Table structure for table `cat_lst`
--

DROP TABLE IF EXISTS `cat_lst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_lst` (
  `r_k` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_nme` varchar(45) NOT NULL,
  PRIMARY KEY (`r_k`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cpy_cat_lst`
--

DROP TABLE IF EXISTS `cpy_cat_lst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cpy_cat_lst` (
  `cpy_lst_r_k` int(10) unsigned NOT NULL,
  `cat_lst_r_k` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cpy_lst_r_k`,`cat_lst_r_k`),
  KEY `fk_cpy_lst_has_cat_lst_cat_lst1_idx` (`cat_lst_r_k`),
  KEY `fk_cpy_lst_has_cat_lst_cpy_lst1_idx` (`cpy_lst_r_k`),
  CONSTRAINT `fk_cpy_lst_has_cat_lst_cat_lst1` FOREIGN KEY (`cat_lst_r_k`) REFERENCES `cat_lst` (`r_k`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cpy_lst_has_cat_lst_cpy_lst1` FOREIGN KEY (`cpy_lst_r_k`) REFERENCES `cpy_lst` (`r_k`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `cpy_cty_cat_vw`
--

DROP TABLE IF EXISTS `cpy_cty_cat_vw`;
/*!50001 DROP VIEW IF EXISTS `cpy_cty_cat_vw`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `cpy_cty_cat_vw` AS SELECT 
 1 AS `cmp_id`,
 1 AS `cmp_cde`,
 1 AS `cmp_bgt`,
 1 AS `cmp_bd_prc`,
 1 AS `ctg_nme`,
 1 AS `cty_nm`,
 1 AS `cty_code`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cpy_cty_lst`
--

DROP TABLE IF EXISTS `cpy_cty_lst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cpy_cty_lst` (
  `cpy_lst_r_k` int(10) unsigned NOT NULL,
  `cty_lst_r_k` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cpy_lst_r_k`,`cty_lst_r_k`),
  KEY `fk_cty_lst_has_cpy_lst_cpy_lst1_idx` (`cpy_lst_r_k`),
  KEY `fk_cty_lst_has_cpy_lst_cty_lst_idx` (`cty_lst_r_k`),
  CONSTRAINT `fk_cty_lst_has_cpy_lst_cpy_lst1` FOREIGN KEY (`cpy_lst_r_k`) REFERENCES `cpy_lst` (`r_k`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cty_lst_has_cpy_lst_cty_lst` FOREIGN KEY (`cty_lst_r_k`) REFERENCES `cty_lst` (`r_k`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cpy_lst`
--

DROP TABLE IF EXISTS `cpy_lst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cpy_lst` (
  `r_k` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cpy_id` varchar(10) NOT NULL,
  `cpy_bgt` decimal(5,2) NOT NULL,
  `bid_prc` decimal(5,2) NOT NULL,
  `lst_upd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`r_k`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cty_lst`
--

DROP TABLE IF EXISTS `cty_lst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cty_lst` (
  `r_k` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cty_nme` varchar(50) NOT NULL,
  `cty_cde` varchar(5) NOT NULL,
  PRIMARY KEY (`r_k`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `cpy_cty_cat_vw`
--

/*!50001 DROP VIEW IF EXISTS `cpy_cty_cat_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cpy_cty_cat_vw` AS select `cp`.`r_k` AS `cmp_id`,`cp`.`cpy_id` AS `cmp_cde`,`cp`.`cpy_bgt` AS `cmp_bgt`,`cp`.`bid_prc` AS `cmp_bd_prc`,`ca`.`cat_nme` AS `ctg_nme`,`ct`.`cty_nme` AS `cty_nm`,`ct`.`cty_cde` AS `cty_code` from ((((`cpy_lst` `cp` join `cat_lst` `ca`) join `cpy_cat_lst` `cca`) join `cty_lst` `ct`) join `cpy_cty_lst` `cct`) where ((`cp`.`r_k` = `cca`.`cpy_lst_r_k`) and (`ca`.`r_k` = `cca`.`cat_lst_r_k`) and (`cp`.`r_k` = `cct`.`cpy_lst_r_k`) and (`ct`.`r_k` = `cct`.`cty_lst_r_k`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Dumping data for table `cat_lst`
--

LOCK TABLES `cat_lst` WRITE;
/*!40000 ALTER TABLE `cat_lst` DISABLE KEYS */;
INSERT INTO `cat_lst` VALUES (1,'Automobile'),(2,'Finance'),(3,'IT');
/*!40000 ALTER TABLE `cat_lst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cpy_cat_lst`
--

LOCK TABLES `cpy_cat_lst` WRITE;
/*!40000 ALTER TABLE `cpy_cat_lst` DISABLE KEYS */;
INSERT INTO `cpy_cat_lst` VALUES (1,1),(3,1),(1,2),(2,2),(2,3),(3,3);
/*!40000 ALTER TABLE `cpy_cat_lst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cpy_cty_lst`
--

LOCK TABLES `cpy_cty_lst` WRITE;
/*!40000 ALTER TABLE `cpy_cty_lst` DISABLE KEYS */;
INSERT INTO `cpy_cty_lst` VALUES (1,1),(1,2),(2,1),(2,3),(3,1),(3,4);
/*!40000 ALTER TABLE `cpy_cty_lst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cpy_lst`
--

LOCK TABLES `cpy_lst` WRITE;
/*!40000 ALTER TABLE `cpy_lst` DISABLE KEYS */;
INSERT INTO `cpy_lst` VALUES (1,'C1',1.00,0.10,'2018-08-12 20:59:32'),(2,'C2',2.00,0.30,'2018-08-12 20:59:32'),(3,'C3',3.00,0.05,'2018-08-12 20:59:32');
/*!40000 ALTER TABLE `cpy_lst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cty_lst`
--

LOCK TABLES `cty_lst` WRITE;
/*!40000 ALTER TABLE `cty_lst` DISABLE KEYS */;
INSERT INTO `cty_lst` VALUES (1,'UNITED STATES OF AMERICA','US'),(2,'FRANCE','FR'),(3,'INDIA','IN'),(4,'RUSSIA','RU');
/*!40000 ALTER TABLE `cty_lst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'exchg'
--
/*!50003 DROP PROCEDURE IF EXISTS `bgt_bid_sff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `bgt_bid_sff`(in prs_typ varchar(15), in bid_amt decimal(5,2), in cpy_dt json, out prc_stt json, out er_msg varchar(500))
begin
    declare i integer default 0;
    declare cpy_ln integer;
    declare cpy_rw json;
    declare cpy_rk integer;
    declare cpy_cd varchar(10);
    declare sprtr varchar(3);
    declare bd_prc decimal(5,2);
    declare bd_amt decimal(5,2);
    declare avl_bgt decimal(5,2);
    declare nw_arr json default json_array();
    declare mtch_obj json;
    declare lg_dt varchar(200);
	declare exit handler for sqlexception
	begin
		get diagnostics condition 1 @errno = mysql_errno, @text = message_text;
		set @err_msg = concat("ERR-", @errno, " : ", @text);
		select @err_msg into er_msg;
	end;

    if prs_typ = 'bid' then
        set lg_dt = 'BaseBid: ';
    else
        set lg_dt = 'BudgetCheck: ';
    end if;

	set cpy_ln = json_length(cpy_dt);
    
    set bd_amt = bid_amt / 100;

    while i < cpy_ln do
        set cpy_rw = json_extract(cpy_dt, concat('$[',i,']'));

        set cpy_rk = json_extract(cpy_rw, '$.cpy_rk');
        set cpy_cd = trim(both '"' from json_extract(cpy_rw, '$.cpy_id'));

        if lg_dt = 'BudgetCheck: ' or lg_dt = 'BaseBid: ' then
            set sprtr = '';
        else
            set sprtr = ',';
        end if;
        
        if prs_typ = 'budget' then
            select cpy_bgt into avl_bgt from cpy_lst where r_k = cpy_rk;

            if avl_bgt >= bd_amt then
                set lg_dt = concat(lg_dt, sprtr,'{', cpy_cd, ', Passed}');
                set nw_arr = json_array_append(nw_arr, '$', cpy_rw);
            else
                set lg_dt = concat(lg_dt, sprtr,'{', cpy_cd, ', Failed}');
            end if;
        else
            select bid_prc into bd_prc from cpy_lst where r_k = cpy_rk;

            if bd_prc > bd_amt then
                set lg_dt = concat(lg_dt, sprtr,'{', cpy_cd, ', Passed}');
                set cpy_rw = json_set(cpy_rw, '$.bd_prc', bd_prc);

                set nw_arr = json_array_append(nw_arr, '$', cpy_rw);
            else
                set lg_dt = concat(lg_dt, sprtr,'{', cpy_cd, ', Failed}');
            end if;
        end if;

        set i = i + 1;
    end while;

    set mtch_obj = json_object('cpy_dt', nw_arr, 'log_dt', lg_dt);

    set prc_stt = mtch_obj;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_enty_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_enty_id`(in enty_typ varchar(15), in enty_vl varchar(45), out prc_stt int, out er_msg varchar(500))
begin
	declare cnt integer;
	declare exit handler for sqlexception
	begin
		get diagnostics condition 1 @errno = mysql_errno, @text = message_text;
		set @err_msg = concat("ERR-", @errno, " : ", @text);
		select @err_msg into er_msg;
	end;

	if enty_typ = 'country' then
        select count(*) into cnt from cty_lst where cty_cde = enty_vl;
        if cnt = 1 then
            select r_k into prc_stt from cty_lst where cty_cde = enty_vl;
        else
            set prc_stt = 0;
        end if;
    else
        select count(*) into cnt from cat_lst where cat_nme = enty_vl;
        if cnt = 1 then
            select r_k into prc_stt from cat_lst where cat_nme = enty_vl;
        else
            set prc_stt = 0;
        end if;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mtch_by_cty_cat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mtch_by_cty_cat`(in cty_id int, in cat_id int, out prc_stt json, out er_msg varchar(500))
begin
    declare cty_cnt integer;
    declare cat_cnt integer;
    declare cpy_rk integer;
    declare cpy_cde varchar(10);
    declare sprtr varchar(3);
    declare cpy_obj json;
    declare lg_dt varchar(200) default 'BaseTargeting: ';
    declare lg_obj json;
	declare mtch_obj json;
    declare lg_arr json default json_array();
    declare mtch_arr json default json_array();
    declare done integer default 0;
    declare cpy_id_lst cursor for
        select r_k, cpy_id from cpy_lst;
    declare continue handler for not found set done = 1;
	declare exit handler for sqlexception
	begin
		get diagnostics condition 1 @errno = mysql_errno, @text = message_text;
		set @err_msg = concat("ERR-", @errno, " : ", @text);
		select @err_msg into er_msg;
	end;

	open cpy_id_lst;

    loop1: loop
        fetch cpy_id_lst into cpy_rk, cpy_cde;
    
        if done = 1 then
			leave loop1;
		end if;

        select count(*) into cty_cnt from cpy_cty_lst where cty_lst_r_k = cty_id and cpy_lst_r_k = cpy_rk;
        select count(*) into cat_cnt from cpy_cat_lst where cat_lst_r_k = cat_id and cpy_lst_r_k = cpy_rk;

        if lg_dt = 'BaseTargeting: ' then
            set sprtr = '';
        else
            set sprtr = ',';
        end if;

        if cty_cnt = 0 or cat_cnt = 0 then
            set lg_dt = concat(lg_dt, sprtr,'{', cpy_cde, ', Failed}');
        else
            set lg_dt = concat(lg_dt, sprtr,'{', cpy_cde, ', Passed}');

            set cpy_obj = json_object('cpy_rk', cpy_rk, 'cpy_id', cpy_cde, 'bd_prc', null);
            set mtch_arr = json_array_append(mtch_arr, '$', cpy_obj);
        end if;

    end loop loop1;

    close cpy_id_lst;

    set mtch_obj = json_object('cpy_dt', mtch_arr, 'log_dt', lg_dt);

    set prc_stt = mtch_obj;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `upd_cpy_bgt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `upd_cpy_bgt`(in cpy_rk int, in bid_amt decimal(5,2), out prc_stt int, out er_msg varchar(500))
begin
	declare exit handler for sqlexception
	begin
		get diagnostics condition 1 @errno = mysql_errno, @text = message_text;
		set @err_msg = concat("ERR-", @errno, " : ", @text);
		select @err_msg into er_msg;
        
        rollback;
	end;

	update cpy_lst set cpy_bgt = cpy_bgt - bid_amt where r_k = cpy_r_k;
    
    commit;

    set prc_stt = 1;
end ;;
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-16 10:14:11
