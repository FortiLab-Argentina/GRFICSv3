/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.23-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: scadalts
-- ------------------------------------------------------
-- Server version	10.6.23-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category_views_hierarchy`
--

DROP TABLE IF EXISTS `category_views_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_views_hierarchy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`,`parentId`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_views_hierarchy`
--

LOCK TABLES `category_views_hierarchy` WRITE;
/*!40000 ALTER TABLE `category_views_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_views_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compoundEventDetectors`
--

DROP TABLE IF EXISTS `compoundEventDetectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `compoundEventDetectors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `returnToNormal` char(1) NOT NULL,
  `disabled` char(1) NOT NULL,
  `conditionText` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `compoundEventDetectorsUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compoundEventDetectors`
--

LOCK TABLES `compoundEventDetectors` WRITE;
/*!40000 ALTER TABLE `compoundEventDetectors` DISABLE KEYS */;
/*!40000 ALTER TABLE `compoundEventDetectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataPointUsers`
--

DROP TABLE IF EXISTS `dataPointUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataPointUsers` (
  `dataPointId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `permission` int(11) NOT NULL,
  KEY `dataPointUsersFk1` (`dataPointId`),
  KEY `dataPointUsersFk2` (`userId`),
  CONSTRAINT `dataPointUsersFk1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`),
  CONSTRAINT `dataPointUsersFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataPointUsers`
--

LOCK TABLES `dataPointUsers` WRITE;
/*!40000 ALTER TABLE `dataPointUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataPointUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataPointUsersProfiles`
--

DROP TABLE IF EXISTS `dataPointUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataPointUsersProfiles` (
  `dataPointId` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  `permission` int(11) NOT NULL,
  KEY `dataPointUsersProfilesFk1` (`dataPointId`),
  KEY `dataPointUsersProfilesFk2` (`userProfileId`),
  CONSTRAINT `dataPointUsersProfilesFk1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dataPointUsersProfilesFk2` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataPointUsersProfiles`
--

LOCK TABLES `dataPointUsersProfiles` WRITE;
/*!40000 ALTER TABLE `dataPointUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataPointUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataPoints`
--

DROP TABLE IF EXISTS `dataPoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataPoints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `dataSourceId` int(11) NOT NULL,
  `data` longblob NOT NULL,
  `pointName` varchar(250) DEFAULT NULL COMMENT 'copy point name from data',
  `plcAlarmLevel` tinyint(8) DEFAULT NULL COMMENT '1 - FAULT, 2 - ALARM',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dataPointsUn1` (`xid`),
  KEY `dataPointsFk1` (`dataSourceId`),
  CONSTRAINT `dataPointsFk1` FOREIGN KEY (`dataSourceId`) REFERENCES `dataSources` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataPoints`
--

LOCK TABLES `dataPoints` WRITE;
/*!40000 ALTER TABLE `dataPoints` DISABLE KEYS */;
INSERT INTO `dataPoints` VALUES (1,'DP_909767',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw<\0\0\0\n\0AValve\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0d\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','AValve',0),(2,'DP_399996',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwB\0\0\0\n\0ProductValve\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0j\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','ProductValve',0),(3,'DP_253175',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw;\0\0\0\n\0AFlow\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0e\0\0\0\0\0\0ASCII\0?èUõ=»K\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','AFlow',0),(4,'DP_481174',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwA\0\0\0\n\0ProductFlow\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0k\0\0\0\0\0\0ASCII\0?@˛Ûªy\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','ProductFlow',0),(5,'DP_292928',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw<\0\0\0\n\0BValve\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0f\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','BValve',0),(6,'DP_876667',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw;\0\0\0\n\0BFlow\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0g\0\0\0\0\0\0ASCII\0?@˛Ûªy\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','BFlow',0),(7,'DP_490067',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw@\0\0\0\n\0\nPurgeValve\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0h\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','PurgeValve',0),(8,'DP_313787',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw?\0\0\0\n\0	PurgeFlow\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0i\0\0\0\0\0\0ASCII\0?ü;dZ¨\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','PurgeFlow',0),(9,'DP_159283',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw>\0\0\0\n\0Pressure\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0l\0\0\0\0\0\0ASCII\0?©\0ˇÄSM\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Pressure',0),(10,'DP_816839',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw;\0\0\0\n\0Level\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0m\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Level',0),(11,'DP_653712',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw;\0\0\0\n\0AComp\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0n\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','AComp',0),(12,'DP_991399',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw;\0\0\0\n\0BComp\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0o\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','BComp',0),(13,'DP_133416',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw;\0\0\0\n\0CComp\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0p\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','CComp',0),(14,'DP_236403',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw9\0\0\0\n\0Run\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0(\0\0\0\0\0\0ASCII?\0\0\0\0\0\0\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Run',0),(15,'DP_517919',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw@\0\0\0\n\0\nManualMode\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ASCII?\0\0\0\0\0\0\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','ManualMode',0),(16,'DP_701144',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw@\0\0\0\n\0\nF1ManualSP\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0,com.serotonin.mango.view.text.AnalogRendererˇˇˇˇˇˇˇˇ\0L\0formatq\0~\0L\0formatInstancet\0Ljava/text/DecimalFormat;L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\00.0\0%xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0ASCII?Y\0ÇˇÇ\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0b\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','F1ManualSP',0),(17,'DP_554268',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpw@\0\0\0\n\0\nF2ManualSP\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0,com.serotonin.mango.view.text.AnalogRendererˇˇˇˇˇˇˇˇ\0L\0formatq\0~\0L\0formatInstancet\0Ljava/text/DecimalFormat;L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\00.0\0%xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ASCII?Y\0ÇˇÇ\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','F2ManualSP',0),(18,'DP_925974',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwC\0\0\0\n\0\rPurgeManualSP\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0,com.serotonin.mango.view.text.AnalogRendererˇˇˇˇˇˇˇˇ\0L\0formatq\0~\0L\0formatInstancet\0Ljava/text/DecimalFormat;L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\00.0\0%xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ASCII?Y\0ÇˇÇ\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0b\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','PurgeManualSP',0),(19,'DP_878538',1,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwE\0\0\0\n\0ProductManualSP\0TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0,com.serotonin.mango.view.text.AnalogRendererˇˇˇˇˇˇˇˇ\0L\0formatq\0~\0L\0formatInstancet\0Ljava/text/DecimalFormat;L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\00.0\0%xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0ASCII?Y\0ÇˇÇ\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','ProductManualSP',0),(20,'DP_724966',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwL\0\0\0\n\0Copy of AValve\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0d\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of AValve',0),(21,'DP_484754',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwR\0\0\0\n\0Copy of ProductValve\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0j\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of ProductValve',0),(22,'DP_133169',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwK\0\0\0\n\0\rCopy of AFlow\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0e\0\0\0\0\0\0ASCII\0?èUõ=»K\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of AFlow',0),(23,'DP_497584',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwQ\0\0\0\n\0Copy of ProductFlow\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0k\0\0\0\0\0\0ASCII\0?@˛Ûªy\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of ProductFlow',0),(24,'DP_510164',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwL\0\0\0\n\0Copy of BValve\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0f\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of BValve',0),(25,'DP_959114',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwK\0\0\0\n\0\rCopy of BFlow\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0g\0\0\0\0\0\0ASCII\0?@˛Ûªy\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of BFlow',0),(26,'DP_032245',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwP\0\0\0\n\0Copy of PurgeValve\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0h\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of PurgeValve',0),(27,'DP_043652',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwO\0\0\0\n\0Copy of PurgeFlow\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0i\0\0\0\0\0\0ASCII\0?ü;dZ¨\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of PurgeFlow',0),(28,'DP_500502',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwN\0\0\0\n\0Copy of Pressure\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0l\0\0\0\0\0\0ASCII\0?©\0ˇÄSM\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of Pressure',0),(29,'DP_300824',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwK\0\0\0\n\0\rCopy of Level\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0m\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of Level',0),(30,'DP_913412',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwK\0\0\0\n\0\rCopy of AComp\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0n\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of AComp',0),(31,'DP_954080',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwK\0\0\0\n\0\rCopy of BComp\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0o\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of BComp',0),(32,'DP_308811',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwK\0\0\0\n\0\rCopy of CComp\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0p\0\0\0\0\0\0ASCII\0?Y\0ÔÔH\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of CComp',0),(33,'DP_440569',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwI\0\0\0\n\0Copy of Run\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0(\0\0\0\0\0\0ASCII?\0\0\0\0\0\0\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of Run',0),(34,'DP_628504',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwP\0\0\0\n\0Copy of ManualMode\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0+com.serotonin.mango.view.text.PlainRendererˇˇˇˇˇˇˇˇ\0L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\0\0xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ASCII?\0\0\0\0\0\0\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of ManualMode',0),(35,'DP_418489',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwP\0\0\0\n\0Copy of F1ManualSP\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0,com.serotonin.mango.view.text.AnalogRendererˇˇˇˇˇˇˇˇ\0L\0formatq\0~\0L\0formatInstancet\0Ljava/text/DecimalFormat;L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\00.0\0%xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0ASCII?Y\0ÇˇÇ\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0b\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of F1ManualSP',0),(36,'DP_488973',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwP\0\0\0\n\0Copy of F2ManualSP\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0,com.serotonin.mango.view.text.AnalogRendererˇˇˇˇˇˇˇˇ\0L\0formatq\0~\0L\0formatInstancet\0Ljava/text/DecimalFormat;L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\00.0\0%xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ASCII?Y\0ÇˇÇ\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of F2ManualSP',0),(37,'DP_897111',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwS\0\0\0\n\0Copy of PurgeManualSP\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0,com.serotonin.mango.view.text.AnalogRendererˇˇˇˇˇˇˇˇ\0L\0formatq\0~\0L\0formatInstancet\0Ljava/text/DecimalFormat;L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\00.0\0%xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ASCII?Y\0ÇˇÇ\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0b\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of PurgeManualSP',0),(38,'DP_274257',2,'¨Ì\0sr\0\"com.serotonin.mango.vo.DataPointVOˇˇˇˇˇˇˇˇ\0\"I\0dataSourceIdI\0dataSourceTypeIdI\0defaultCacheSizeZ\0discardExtremeValuesD\0discardHighLimitD\0discardLowLimitZ\0enabledI\0engineeringUnitsI\0idI\0intervalLoggingPeriodI\0intervalLoggingPeriodTypeI\0intervalLoggingTypeI\0loggingTypeI\0\rpointFolderIdI\0purgePeriodI\0\rpurgeStrategyI\0	purgeTypeI\0purgeValuesLimitZ\0settableD\0	toleranceL\0chartColourt\0Ljava/lang/String;L\0\rchartRenderert\0.Lcom/serotonin/mango/view/chart/ChartRenderer;L\0commentst\0Ljava/util/List;L\0dataSourceNameq\0~\0L\0\rdataSourceXidq\0~\0L\0descriptionq\0~\0L\0\ndeviceNameq\0~\0L\0eventDetectorsq\0~\0L\0eventTextRenderert\02Lcom/serotonin/mango/view/event/EventTextRenderer;L\0	lastValuet\01Lcom/serotonin/mango/rt/dataImage/PointValueTime;L\0nameq\0~\0L\0pointLocatort\02Lcom/serotonin/mango/vo/dataSource/PointLocatorVO;L\0textRenderert\0,Lcom/serotonin/mango/view/text/TextRenderer;L\0xidq\0~\0xpwU\0\0\0\n\0Copy of ProductManualSP\0Copy of TenEast\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0sr\0,com.serotonin.mango.view.text.AnalogRendererˇˇˇˇˇˇˇˇ\0L\0formatq\0~\0L\0formatInstancet\0Ljava/text/DecimalFormat;L\0suffixq\0~\0xr\0.com.serotonin.mango.view.text.BaseTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0\00.0\0%xpsr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusPointLocatorVOˇˇˇˇˇˇˇˇ\0D\0additiveB\0bitI\0modbusDataTypeD\0\nmultiplierI\0offsetI\0rangeI\0\rregisterCountZ\0settableOverrideI\0slaveIdZ\0slaveMonitorZ\0\rsocketMonitorL\0charsetq\0~\0xr\08com.serotonin.mango.vo.dataSource.AbstractPointLocatorVOˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw4\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r\0\0\0\0\0\0ASCII?Y\0ÇˇÇ\0\0\0\0\0\0\0\0xw\0\0\0\0ˇÔˇˇˇˇˇˇÔˇˇˇˇˇˇ\0\0\0_\0\0\0sr\00com.serotonin.mango.view.event.NoneEventRendererˇˇˇˇˇˇˇˇ\0\0xr\04com.serotonin.mango.view.event.BaseEventTextRendererˇˇˇˇˇˇˇˇ\0\0xpw\0\0\0xw\0\0\0xw\0\0\0\0\0\0dx','Copy of ProductManualSP',0);
/*!40000 ALTER TABLE `dataPoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataSourceUsers`
--

DROP TABLE IF EXISTS `dataSourceUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataSourceUsers` (
  `dataSourceId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  KEY `dataSourceUsersFk1` (`dataSourceId`),
  KEY `dataSourceUsersFk2` (`userId`),
  CONSTRAINT `dataSourceUsersFk1` FOREIGN KEY (`dataSourceId`) REFERENCES `dataSources` (`id`),
  CONSTRAINT `dataSourceUsersFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataSourceUsers`
--

LOCK TABLES `dataSourceUsers` WRITE;
/*!40000 ALTER TABLE `dataSourceUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataSourceUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataSourceUsersProfiles`
--

DROP TABLE IF EXISTS `dataSourceUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataSourceUsersProfiles` (
  `dataSourceId` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  KEY `dataSourceUsersProfilesFk1` (`dataSourceId`),
  KEY `dataSourceUsersProfilesFk2` (`userProfileId`),
  CONSTRAINT `dataSourceUsersProfilesFk1` FOREIGN KEY (`dataSourceId`) REFERENCES `dataSources` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dataSourceUsersProfilesFk2` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataSourceUsersProfiles`
--

LOCK TABLES `dataSourceUsersProfiles` WRITE;
/*!40000 ALTER TABLE `dataSourceUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `dataSourceUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataSources`
--

DROP TABLE IF EXISTS `dataSources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dataSources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(40) NOT NULL,
  `dataSourceType` int(11) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dataSourcesUn1` (`xid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataSources`
--

LOCK TABLES `dataSources` WRITE;
/*!40000 ALTER TABLE `dataSources` DISABLE KEYS */;
INSERT INTO `dataSources` VALUES (1,'DS_939670','TenEast',3,'¨Ì\0sr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusIpDataSourceVOˇˇˇˇˇˇˇˇ\0Z\0createSocketMonitorPointZ\0encapsulatedI\0portL\0hostt\0Ljava/lang/String;L\0\rtransportTypet\0MLcom/serotonin/mango/vo/dataSource/modbus/ModbusIpDataSourceVO$TransportType;xr\0;com.serotonin.mango.vo.dataSource.modbus.ModbusDataSourceVOˇˇˇˇˇˇˇˇ\0\nZ\0contiguousBatchesZ\0createSlaveMonitorPointsI\0maxReadBitCountI\0maxReadRegisterCountI\0maxWriteRegisterCountZ\0quantizeI\0retriesI\0timeoutI\0updatePeriodTypeI\0\rupdatePeriodsxr\0.com.serotonin.mango.vo.dataSource.DataSourceVOˇˇˇˇˇˇˇˇ\0Z\0enabledI\0idL\0alarmLevelst\0Ljava/util/Map;L\0nameq\0~\0L\0statet\0!Lorg/scada_lts/ds/state/IStateDs;L\0xidq\0~\0xpw\0\0\0sr\0java.util.HashMap⁄¡√`—\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0sr\0java.lang.Integer‚†§˜Åá8\0I\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0sq\0~\0\n\0\0\0q\0~\0\rq\0~\0\rsq\0~\0\n\0\0\0q\0~\0\rxsr\0.org.scada_lts.ds.state.UserChangeEnableStateDs(¶&yÜ|\0\0xpxw#\0\0\0\0\0\0\0\0\0\0\0\0Ù\0\0\0\0\0\0\0–\0\0\0}\0\0\0xxw\0\0\0~r\0Kcom.serotonin.mango.vo.dataSource.modbus.ModbusIpDataSourceVO$TransportType\0\0\0\0\0\0\0\0\0\0xr\0java.lang.Enum\0\0\0\0\0\0\0\0\0\0xpt\0TCP_KEEP_ALIVEw\0192.168.243.20\0\0ˆ\0\0x'),(2,'DS_287779','Copy of TenEast',3,'¨Ì\0sr\0=com.serotonin.mango.vo.dataSource.modbus.ModbusIpDataSourceVOˇˇˇˇˇˇˇˇ\0Z\0createSocketMonitorPointZ\0encapsulatedI\0portL\0hostt\0Ljava/lang/String;L\0\rtransportTypet\0MLcom/serotonin/mango/vo/dataSource/modbus/ModbusIpDataSourceVO$TransportType;xr\0;com.serotonin.mango.vo.dataSource.modbus.ModbusDataSourceVOˇˇˇˇˇˇˇˇ\0\nZ\0contiguousBatchesZ\0createSlaveMonitorPointsI\0maxReadBitCountI\0maxReadRegisterCountI\0maxWriteRegisterCountZ\0quantizeI\0retriesI\0timeoutI\0updatePeriodTypeI\0\rupdatePeriodsxr\0.com.serotonin.mango.vo.dataSource.DataSourceVOˇˇˇˇˇˇˇˇ\0Z\0enabledI\0idL\0alarmLevelst\0Ljava/util/Map;L\0nameq\0~\0L\0statet\0!Lorg/scada_lts/ds/state/IStateDs;L\0xidq\0~\0xpw\0\0\0\0sr\0java.util.HashMap⁄¡√`—\0F\0\nloadFactorI\0	thresholdxp?@\0\0\0\0\0w\0\0\0\0\0\0sr\0java.lang.Integer‚†§˜Åá8\0I\0valuexr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0sq\0~\0\n\0\0\0q\0~\0\rq\0~\0\rsq\0~\0\n\0\0\0q\0~\0\rxsr\00org.scada_lts.ds.state.UserCpChangeEnableStateDs,⁄ªô\0qLy\0\0xpxw#\0\0\0\0\0\0\0\0\0\0\0\0Ù\0\0\0\0\0\0\0–\0\0\0}\0\0\0xxw\0\0\0~r\0Kcom.serotonin.mango.vo.dataSource.modbus.ModbusIpDataSourceVO$TransportType\0\0\0\0\0\0\0\0\0\0xr\0java.lang.Enum\0\0\0\0\0\0\0\0\0\0xpt\0TCP_KEEP_ALIVEw\0192.168.243.20\0\0ˆ\0\0x');
/*!40000 ALTER TABLE `dataSources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventDetectorTemplates`
--

DROP TABLE IF EXISTS `eventDetectorTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventDetectorTemplates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventDetectorTemplates`
--

LOCK TABLES `eventDetectorTemplates` WRITE;
/*!40000 ALTER TABLE `eventDetectorTemplates` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventDetectorTemplates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventHandlers`
--

DROP TABLE IF EXISTS `eventHandlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventHandlers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `eventTypeId` int(11) NOT NULL,
  `eventTypeRef1` int(11) NOT NULL,
  `eventTypeRef2` int(11) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `eventHandlersUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventHandlers`
--

LOCK TABLES `eventHandlers` WRITE;
/*!40000 ALTER TABLE `eventHandlers` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventHandlers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeId` int(11) NOT NULL,
  `typeRef1` int(11) NOT NULL,
  `typeRef2` int(11) NOT NULL,
  `activeTs` bigint(20) NOT NULL,
  `rtnApplicable` char(1) NOT NULL,
  `rtnTs` bigint(20) DEFAULT NULL,
  `rtnCause` int(11) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `message` longtext DEFAULT NULL,
  `ackTs` bigint(20) DEFAULT NULL,
  `ackUserId` int(11) DEFAULT NULL,
  `alternateAckSource` int(11) DEFAULT NULL,
  `shortMessage` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eventsFk1` (`ackUserId`),
  CONSTRAINT `eventsFk1` FOREIGN KEY (`ackUserId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,4,1,0,1784687734716,'N',0,0,1,'event.system.startup|',0,NULL,NULL,'event.system.startup|'),(2,4,2,0,1784687736142,'N',0,0,1,'event.system.shutdown|',0,NULL,NULL,'event.system.shutdown|'),(3,3,1,3,1784687757259,'Y',1784728456445,4,2,'event.ds|TenEast|[event.exception2|com.serotonin.modbus4j.exception.ModbusInitException|java.net.SocketTimeoutException: connect timed out|]',0,NULL,NULL,'event.ds|TenEast|[event.exception2|com.serotonin.modbus4j.exception.ModbusInitException|java.net.SocketTimeoutException: connect timed out|]'),(4,4,1,0,1784687757537,'N',0,0,1,'event.system.startup|',0,NULL,NULL,'event.system.startup|'),(5,4,4,4,1784728444813,'Y',0,0,1,'event.login|admin|',0,NULL,NULL,'event.login|admin|'),(6,8,1,1,1784728456467,'N',0,0,1,'event.audit.changed|admin (4)|[event.audit.dataSource|]1|[event.audit.propertyList.1|[event.audit.changedProperty|[common.enabled|][common.true|][common.false|]]]',0,NULL,NULL,'event.audit.changed|admin (4)|[event.audit.dataSource|]1|[event.audit.propertyList.1|[event.audit.changedProperty|[common.enabled|][common.true|][common.false|]]]'),(7,8,1,1,1784728475390,'N',0,0,1,'event.audit.changed|admin (4)|[event.audit.dataSource|]1|[event.audit.propertyList.1|[event.audit.changedProperty|[dsEdit.modbusIp.host|]192.168.95.2|192.168.243.20|]]',0,NULL,NULL,'event.audit.changed|admin (4)|[event.audit.dataSource|]1|[event.audit.propertyList.1|[event.audit.changedProperty|[dsEdit.modbusIp.host|]192.168.95.2|192.168.243.20|]]'),(8,8,1,1,1784728481339,'N',0,0,1,'event.audit.changed|admin (4)|[event.audit.dataSource|]1|[event.audit.propertyList.1|[event.audit.changedProperty|[common.enabled|][common.false|][common.true|]]]',0,NULL,NULL,'event.audit.changed|admin (4)|[event.audit.dataSource|]1|[event.audit.propertyList.1|[event.audit.changedProperty|[common.enabled|][common.false|][common.true|]]]'),(9,8,1,2,1784728528751,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataSource|]2|[event.audit.propertyList.17|[event.audit.property|[dsEdit.head.name|]Copy of TenEast|][event.audit.property|[common.xid|]DS_287779|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[dsEdit.updatePeriod|][common.tp.description|2|[common.tp.seconds|]]][event.audit.property|[dsEdit.quantize|][common.false|]][event.audit.property|[dsEdit.modbus.timeout|]500|][event.audit.property|[dsEdit.modbus.retries|]2|][event.audit.property|[dsEdit.modbus.contiguousBatches|][common.false|]][event.audit.property|[dsEdit.modbus.createSlaveMonitorPoints|][common.false|]][event.audit.property|[dsEdit.modbus.maxReadBitCount|]2000|][event.audit.property|[dsEdit.modbus.maxReadRegisterCount|]125|][event.audit.property|[dsEdit.modbus.maxWriteRegisterCount|]120|][event.audit.property|[dsEdit.modbusIp.transportType|]dsEdit.modbusIp.transportType.tcpKA|][event.audit.property|[dsEdit.modbusIp.host|]192.168.243.20|][event.audit.property|[dsEdit.modbusIp.port|]502|][event.audit.property|[dsEdit.modbusIp.encapsulated|][common.false|]][event.audit.property|[dsEdit.modbusIp.createSocketMonitorPoint|][common.false|]]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataSource|]2|[event.audit.propertyList.17|[event.audit.property|[dsEdit.head.name|]Copy of TenEast|][event.audit.property|[common.xid|]DS_287779|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[dsEdit.updatePeriod|][common.tp.description|2|[common.tp.seconds|]]][event.audit.property|[dsEdit.quantize|][common.false|]][event.audit.property|[dsEdit.modbus.timeout|]500|][event.audit.property|[dsEdit.modbus.retries|]2|][event.audit.property|[dsEdit.modbus.contiguousBatches|][common.false|]][event.audit.property|[dsEdit.modbus.createSlaveMonitorPoints|][common.false|]][event.audit.property|[dsEdit.modbus.maxReadBitCount|]2000|][event.audit.property|[dsEdit.modbus.maxReadRegisterCount|]125|][event.audit.property|[dsEdit.modbus.maxWriteRegisterCount|]120|][event.audit.property|[dsEdit.modbusIp.transportType|]dsEdit.modbusIp.transportType.tcpKA|][event.audit.property|[dsEdit.modbusIp.host|]192.168.243.20|][event.audit.property|[dsEdit.modbusIp.port|]502|][event.audit.property|[dsEdit.modbusIp.encapsulated|][common.false|]][event.audit.property|[dsEdit.modbusIp.createSocketMonitorPoint|][common.false|]]]'),(10,8,2,20,1784728528764,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]20|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_724966|][event.audit.property|[dsEdit.points.name|]Copy of AValve|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]100|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]20|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_724966|][event.audit.property|[dsEdit.points.name|]Copy of AValve|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]100|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(11,8,2,21,1784728528780,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]21|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_484754|][event.audit.property|[dsEdit.points.name|]Copy of ProductValve|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]106|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]21|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_484754|][event.audit.property|[dsEdit.points.name|]Copy of ProductValve|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]106|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(12,8,2,22,1784728528788,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]22|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_133169|][event.audit.property|[dsEdit.points.name|]Copy of AFlow|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]101|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0153|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]22|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_133169|][event.audit.property|[dsEdit.points.name|]Copy of AFlow|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]101|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0153|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(13,8,2,23,1784728528795,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]23|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_497584|][event.audit.property|[dsEdit.points.name|]Copy of ProductFlow|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]107|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.00762951|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]23|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_497584|][event.audit.property|[dsEdit.points.name|]Copy of ProductFlow|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]107|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.00762951|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(14,8,2,24,1784728528817,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]24|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_510164|][event.audit.property|[dsEdit.points.name|]Copy of BValve|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]102|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]24|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_510164|][event.audit.property|[dsEdit.points.name|]Copy of BValve|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]102|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(15,8,2,25,1784728528823,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]25|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_959114|][event.audit.property|[dsEdit.points.name|]Copy of BFlow|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]103|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.00762951|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]25|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_959114|][event.audit.property|[dsEdit.points.name|]Copy of BFlow|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]103|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.00762951|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(16,8,2,26,1784728528830,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]26|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_032245|][event.audit.property|[dsEdit.points.name|]Copy of PurgeValve|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]104|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]26|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_032245|][event.audit.property|[dsEdit.points.name|]Copy of PurgeValve|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]104|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(17,8,2,27,1784728528843,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]27|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_043652|][event.audit.property|[dsEdit.points.name|]Copy of PurgeFlow|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]105|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0305|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]27|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_043652|][event.audit.property|[dsEdit.points.name|]Copy of PurgeFlow|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]105|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0305|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(18,8,2,28,1784728528850,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]28|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_500502|][event.audit.property|[dsEdit.points.name|]Copy of Pressure|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]108|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.04882887|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]28|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_500502|][event.audit.property|[dsEdit.points.name|]Copy of Pressure|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]108|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.04882887|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(19,8,2,29,1784728528862,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]29|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_300824|][event.audit.property|[dsEdit.points.name|]Copy of Level|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]109|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]29|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_300824|][event.audit.property|[dsEdit.points.name|]Copy of Level|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]109|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(20,8,2,30,1784728528868,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]30|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_913412|][event.audit.property|[dsEdit.points.name|]Copy of AComp|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]110|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]30|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_913412|][event.audit.property|[dsEdit.points.name|]Copy of AComp|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]110|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(21,8,2,31,1784728528880,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]31|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_954080|][event.audit.property|[dsEdit.points.name|]Copy of BComp|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]111|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]31|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_954080|][event.audit.property|[dsEdit.points.name|]Copy of BComp|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]111|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(22,8,2,32,1784728528886,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]32|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_308811|][event.audit.property|[dsEdit.points.name|]Copy of CComp|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]112|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]32|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_308811|][event.audit.property|[dsEdit.points.name|]Copy of CComp|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.inputRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]112|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.false|]][event.audit.property|[dsEdit.modbus.multiplier|]0.0015259022|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(23,8,2,33,1784728528891,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]33|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_440569|][event.audit.property|[dsEdit.points.name|]Copy of Run|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.coilStatus|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.binary|]][event.audit.property|[dsEdit.modbus.offset|]40|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]1.0|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]33|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_440569|][event.audit.property|[dsEdit.points.name|]Copy of Run|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.coilStatus|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.binary|]][event.audit.property|[dsEdit.modbus.offset|]40|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]1.0|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(24,8,2,34,1784728528896,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]34|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_628504|][event.audit.property|[dsEdit.points.name|]Copy of ManualMode|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.coilStatus|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.binary|]][event.audit.property|[dsEdit.modbus.offset|]0|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]1.0|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]34|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_628504|][event.audit.property|[dsEdit.points.name|]Copy of ManualMode|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.coilStatus|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.binary|]][event.audit.property|[dsEdit.modbus.offset|]0|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]1.0|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(25,8,2,35,1784728528909,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]35|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_418489|][event.audit.property|[dsEdit.points.name|]Copy of F1ManualSP|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]98|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.holdingRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]10|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]0.001526|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]35|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_418489|][event.audit.property|[dsEdit.points.name|]Copy of F1ManualSP|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]98|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.holdingRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]10|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]0.001526|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(26,8,2,36,1784728528915,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]36|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_488973|][event.audit.property|[dsEdit.points.name|]Copy of F2ManualSP|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.holdingRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]11|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]0.001526|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]36|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_488973|][event.audit.property|[dsEdit.points.name|]Copy of F2ManualSP|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.holdingRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]11|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]0.001526|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(27,8,2,37,1784728528926,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]37|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_897111|][event.audit.property|[dsEdit.points.name|]Copy of PurgeManualSP|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]98|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.holdingRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]12|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]0.001526|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]37|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_897111|][event.audit.property|[dsEdit.points.name|]Copy of PurgeManualSP|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]98|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.holdingRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]12|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]0.001526|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]'),(28,8,2,38,1784728528932,'N',0,0,1,'event.audit.added|admin (4)|[event.audit.dataPoint|]38|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_274257|][event.audit.property|[dsEdit.points.name|]Copy of ProductManualSP|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.holdingRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]13|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]0.001526|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]',0,NULL,NULL,'event.audit.added|admin (4)|[event.audit.dataPoint|]38|[event.audit.propertyList.25|[event.audit.property|[common.xid|]DP_274257|][event.audit.property|[dsEdit.points.name|]Copy of ProductManualSP|][event.audit.property|[common.enabled|][common.false|]][event.audit.property|[pointEdit.logging.type|][pointEdit.logging.type.change|]][event.audit.property|[pointEdit.logging.period|][common.tp.description|15|[common.tp.minutes|]]][event.audit.property|[pointEdit.logging.valueType|][pointEdit.logging.valueType.instant|]][event.audit.property|[pointEdit.logging.tolerance|]0.0|][event.audit.property|[pointEdit.logging.purge|][common.tp.description|1|[common.tp.years|]]][event.audit.property|[pointEdit.logging.defaultCache|]1|][event.audit.property|[pointEdit.logging.discard|][common.false|]][event.audit.property|[pointEdit.logging.discardLow|]-1.7976931348623157E308|][event.audit.property|[pointEdit.logging.engineeringUnits|]95|][event.audit.property|[pointEdit.props.chartColour|]|][event.audit.property|[pointEdit.logging.purgeStrategy|][common.unknown|]][event.audit.property|[pointEdit.logging.purgeValuesLimit|]100|][event.audit.property|[dsEdit.modbus.slaveId|]1|][event.audit.property|[dsEdit.modbus.registerRange|][dsEdit.modbus.holdingRegister|]][event.audit.property|[dsEdit.modbus.modbusDataType|][dsEdit.modbus.modbusDataType.2bUnsigned|]][event.audit.property|[dsEdit.modbus.offset|]13|][event.audit.property|[dsEdit.modbus.bit|]0|][event.audit.property|[dsEdit.modbus.registerCount|]0|][event.audit.property|[dsEdit.modbus.charset|]ASCII|][event.audit.property|[dsEdit.modbus.settableOverride|][common.true|]][event.audit.property|[dsEdit.modbus.multiplier|]0.001526|][event.audit.property|[dsEdit.modbus.additive|]0.0|]]');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flexProjects`
--

DROP TABLE IF EXISTS `flexProjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flexProjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `xmlConfig` varchar(16384) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flexProjects`
--

LOCK TABLES `flexProjects` WRITE;
/*!40000 ALTER TABLE `flexProjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `flexProjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `historyAlarms`
--

DROP TABLE IF EXISTS `historyAlarms`;
/*!50001 DROP VIEW IF EXISTS `historyAlarms`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `historyAlarms` AS SELECT
 1 AS `activeTime`,
  1 AS `inactiveTime`,
  1 AS `acknowledgeTime`,
  1 AS `level`,
  1 AS `name` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `liveAlarms`
--

DROP TABLE IF EXISTS `liveAlarms`;
/*!50001 DROP VIEW IF EXISTS `liveAlarms`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `liveAlarms` AS SELECT
 1 AS `id`,
  1 AS `activation-time`,
  1 AS `inactivation-time`,
  1 AS `level`,
  1 AS `name`,
  1 AS `dataPointId` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `mailingListInactive`
--

DROP TABLE IF EXISTS `mailingListInactive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mailingListInactive` (
  `mailingListId` int(11) NOT NULL,
  `inactiveInterval` int(11) NOT NULL,
  KEY `mailingListInactiveFk1` (`mailingListId`),
  CONSTRAINT `mailingListInactiveFk1` FOREIGN KEY (`mailingListId`) REFERENCES `mailingLists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailingListInactive`
--

LOCK TABLES `mailingListInactive` WRITE;
/*!40000 ALTER TABLE `mailingListInactive` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailingListInactive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mailingListMembers`
--

DROP TABLE IF EXISTS `mailingListMembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mailingListMembers` (
  `mailingListId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  KEY `mailingListMembersFk1` (`mailingListId`),
  CONSTRAINT `mailingListMembersFk1` FOREIGN KEY (`mailingListId`) REFERENCES `mailingLists` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailingListMembers`
--

LOCK TABLES `mailingListMembers` WRITE;
/*!40000 ALTER TABLE `mailingListMembers` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailingListMembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mailingLists`
--

DROP TABLE IF EXISTS `mailingLists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mailingLists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(40) NOT NULL,
  `cronPattern` varchar(100) DEFAULT NULL COMMENT 'cron pattern',
  `collectInactiveEmails` binary(1) DEFAULT '0' COMMENT 'Collect inactive emails and send when activated',
  `dailyLimitSentEmails` binary(1) DEFAULT '0' COMMENT 'Daily limit sent emails',
  `dailyLimitSentEmailsNumber` int(11) DEFAULT 0 COMMENT 'Daily limit sent emails number',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mailingListsUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailingLists`
--

LOCK TABLES `mailingLists` WRITE;
/*!40000 ALTER TABLE `mailingLists` DISABLE KEYS */;
/*!40000 ALTER TABLE `mailingLists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenanceEvents`
--

DROP TABLE IF EXISTS `maintenanceEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenanceEvents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `dataSourceId` int(11) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `scheduleType` int(11) NOT NULL,
  `disabled` char(1) NOT NULL,
  `activeYear` int(11) DEFAULT NULL,
  `activeMonth` int(11) DEFAULT NULL,
  `activeDay` int(11) DEFAULT NULL,
  `activeHour` int(11) DEFAULT NULL,
  `activeMinute` int(11) DEFAULT NULL,
  `activeSecond` int(11) DEFAULT NULL,
  `activeCron` varchar(25) DEFAULT NULL,
  `inactiveYear` int(11) DEFAULT NULL,
  `inactiveMonth` int(11) DEFAULT NULL,
  `inactiveDay` int(11) DEFAULT NULL,
  `inactiveHour` int(11) DEFAULT NULL,
  `inactiveMinute` int(11) DEFAULT NULL,
  `inactiveSecond` int(11) DEFAULT NULL,
  `inactiveCron` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `maintenanceEventsUn1` (`xid`),
  KEY `maintenanceEventsFk1` (`dataSourceId`),
  CONSTRAINT `maintenanceEventsFk1` FOREIGN KEY (`dataSourceId`) REFERENCES `dataSources` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenanceEvents`
--

LOCK TABLES `maintenanceEvents` WRITE;
/*!40000 ALTER TABLE `maintenanceEvents` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenanceEvents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mangoViewUsers`
--

DROP TABLE IF EXISTS `mangoViewUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mangoViewUsers` (
  `mangoViewId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `accessType` int(11) NOT NULL,
  PRIMARY KEY (`mangoViewId`,`userId`),
  KEY `mangoViewUsersFk2` (`userId`),
  CONSTRAINT `mangoViewUsersFk1` FOREIGN KEY (`mangoViewId`) REFERENCES `mangoViews` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mangoViewUsersFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mangoViewUsers`
--

LOCK TABLES `mangoViewUsers` WRITE;
/*!40000 ALTER TABLE `mangoViewUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `mangoViewUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mangoViews`
--

DROP TABLE IF EXISTS `mangoViews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mangoViews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `background` varchar(255) DEFAULT NULL,
  `userId` int(11) NOT NULL,
  `anonymousAccess` int(11) NOT NULL,
  `data` longblob NOT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `modification_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `mangoViewsUn1` (`xid`),
  KEY `mangoViewsFk1` (`userId`),
  CONSTRAINT `mangoViewsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mangoViews`
--

LOCK TABLES `mangoViews` WRITE;
/*!40000 ALTER TABLE `mangoViews` DISABLE KEYS */;
INSERT INTO `mangoViews` VALUES (1,'GV_910998','TenEastView1','uploads/1.png',4,0,'¨Ì\0sr\0com.serotonin.mango.view.Viewˇˇˇˇˇˇˇˇ\0I\0anonymousAccessI\0idI\0userIdL\0backgroundFilenamet\0Ljava/lang/String;L\0nameq\0~\0L\0viewComponentst\0Ljava/util/List;L\0	viewUsersq\0~\0L\0xidq\0~\0xpw\0\0\0sr\0)java.util.concurrent.CopyOnWriteArrayListx]ü’F´ê√\0\0xpw\0\0\0sr\02com.serotonin.mango.view.component.ScriptComponentˇˇˇˇˇˇˇˇ\0L\0scriptq\0~\0xr\01com.serotonin.mango.view.component.PointComponentˇˇˇˇˇˇˇˇ\0Z\0displayControlsZ\0settableOverrideZ\0validZ\0visibleL\0bkgdColorOverrideq\0~\0L\0	dataPointt\0$Lcom/serotonin/mango/vo/DataPointVO;L\0nameOverrideq\0~\0xr\00com.serotonin.mango.view.component.ViewComponentˇˇˇˇˇˇˇˇ\0I\0indexI\0xI\0yI\0zL\0idSuffixq\0~\0L\0styleq\0~\0xpw\0\0\0\0\0\0\0\0\0ˇ\0\0@\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xw&\0\0\0\0return(value.toFixed(1) + \"%\");xsq\0~\0w\0\0\0\0\0\0\0\0\0ä\0\0^\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xw,\0\0\0\0%return(value.toFixed(1) + \" kMol/h\");xsq\0~\0w\0\0\0\0\0\0\0\0\0\0‹\0\0_\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xw,\0\0\0\0%return(value.toFixed(1) + \" kMol/h\");xsq\0~\0w\0\0\0\0\0\0\0\0\0\0ë\0\0?\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xw&\0\0\0\0return(value.toFixed(1) + \"%\");xsq\0~\0w\0\0\0\0\0\0\0\0\0\0‹\0\0\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xw,\0\0\0\0%return(value.toFixed(1) + \" kMol/h\");xsq\0~\0w\0\0\0\0\0\0\0\0\0\0ê\0\0\0È\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xw&\0\0\0\0return(value.toFixed(1) + \"%\");xsq\0~\0w\0\0\0\0\0\0\0\0\0µ\0\0H\0\0\0xw\0\0\0\0\0\0\n\0\0\0\0\0xw2\0\0\0\0+return(\"Level: \" + value.toFixed(1) + \"%\");xsq\0~\0w\0\0\0\0\0\0\0\0\0£\0\01\0\0\0xw\0\0\0\0\0\0	\0\0\0\0\0xw8\0\0\0\01return(\"Pressure: \" + value.toFixed(1) + \" kPa\");xsq\0~\0w\0\0\0\0\0\0	\0\0\0ç\0\0\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xw,\0\0\0\0%return(value.toFixed(1) + \" kMol/h\");xsq\0~\0w\0\0\0\0\0\0\n\0\0\0¯\0\0\0Ì\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xw&\0\0\0\0return(value.toFixed(1) + \"%\");xsr\00com.serotonin.mango.view.component.HtmlComponentˇˇˇˇˇˇˇˇ\0L\0contentq\0~\0xq\0~\0	w\0\0\0\0\0\0\0\0\0r\0\0\0\0\0xw\0\0\0\0Purgexsq\0~\0w\0\0\0\0\0\0\0\0\0p\0\0t\0\0\0xw\0\0\0\0Productxsq\0~\0w\0\0\0\0\0\0\r\0\0\0\0$\0\0\0\0\0xw\0\0\0\0Feed2xsq\0~\0w\0\0\0\0\0\0\0\0\0\0&\0\0v\0\0\0xw\0\0\0\0Feed1xsr\0-br.org.scadabr.view.component.ButtonComponentˇˇˇˇˇˇˇˇ\0I\0heightI\0widthL\0whenOffLabelq\0~\0L\0whenOnLabelq\0~\0xq\0~\0w\0\0\0\0\0\0\0\0\0Ï\0\0\0Ç\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xz\0\0£\0\0\0úvar s = \'\';if (value)  s += \"<input type=\'button\' class=\'simpleRenderer\' value=\'RUNNING\' onclick=\'mango.view.setPoint(\"+ point.id +\",\"+ pointComponent.id +\", false);return false;\' style=\'background-color:;\'/>\"; else s += \"<input type=\'button\' class=\'simpleRenderer\' value=\'STOPPED\' onclick=\'mango.view.setPoint(\"+ point.id +\",\"+ pointComponent.id +\", true);return true;\' style=\'background-color:;\'/>\";  return s;xz\0\0ø\0\0\0úvar s = \'\';if (value)  s += \"<input type=\'button\' class=\'simpleRenderer\' value=\'RUNNING\' onclick=\'mango.view.setPoint(\"+ point.id +\",\"+ pointComponent.id +\", false);return false;\' style=\'background-color:;\'/>\"; else s += \"<input type=\'button\' class=\'simpleRenderer\' value=\'STOPPED\' onclick=\'mango.view.setPoint(\"+ point.id +\",\"+ pointComponent.id +\", true);return true;\' style=\'background-color:;\'/>\";  return s;\0RUNNING\0STOPPED\0\0\0\0\0\0\0\0xsr\09com.serotonin.mango.view.component.BinaryGraphicComponentˇˇˇˇˇˇˇˇ\0I\0oneImageI\0	zeroImagexr\04com.serotonin.mango.view.component.ImageSetComponentˇˇˇˇˇˇˇˇ\0Z\0displayTextL\0imageSett\0#Lcom/serotonin/mango/view/ImageSet;xq\0~\0w\0\0\0\0\0\0\0\0\0Ú\0\0\0I\0\0\0xw\0\0\0\0\0\0\0\0\0\0\0xw\0\0\0\0Leds48\0xw\0\0\0\0\0\0\0\0\0xsq\0~\0w\0\0\0\0\0\0\0\0\0\0l\0\0\0i\0\0\0xw\0\0\0\0\0\0\0Manual Mode\0\0xz\0\0Ë\0\0\0·var s = \'\';if (value)  s += \"<input type=\'button\' class=\'simpleRenderer\' value=\'MANUAL MODE: ON\' onclick=\'mango.view.setPoint(\"+ point.id +\",\"+ pointComponent.id +\", false);return false;\' style=\'width:120px; height:20px; background-color:;\'/>\"; else s += \"<input type=\'button\' class=\'simpleRenderer\' value=\'MANUAL MODE: OFF\' onclick=\'mango.view.setPoint(\"+ point.id +\",\"+ pointComponent.id +\", true);return true;\' style=\'width:120px; height:20px; background-color:;\'/>\";  return s;xz\0\0\0\0\0·var s = \'\';if (value)  s += \"<input type=\'button\' class=\'simpleRenderer\' value=\'MANUAL MODE: ON\' onclick=\'mango.view.setPoint(\"+ point.id +\",\"+ pointComponent.id +\", false);return false;\' style=\'width:120px; height:20px; background-color:;\'/>\"; else s += \"<input type=\'button\' class=\'simpleRenderer\' value=\'MANUAL MODE: OFF\' onclick=\'mango.view.setPoint(\"+ point.id +\",\"+ pointComponent.id +\", true);return true;\' style=\'width:120px; height:20px; background-color:;\'/>\";  return s;\0MANUAL MODE: ON\0MANUAL MODE: OFF\0\0\0x\0\0\0xsr\07com.serotonin.mango.view.component.SimplePointComponentˇˇˇˇˇˇˇˇ\0Z\0displayPointNameL\0styleAttributeq\0~\0xq\0~\0w\0\0\0\0\0\0\0\0\0\0~\0\0\0Ã\0\0\0xw\0\0\0\0\0\0\0\0\0\0xw\0\0\0\0\0xsq\0~\0 w\0\0\0\0\0\0\0\0\0‡\0\0\0–\0\0\0xw\0\0\0\0\0\0\0\0\0\0xw\0\0\0\0\0xsq\0~\0 w\0\0\0\0\0\0\0\0\0\0~\0\0õ\0\0\0xw\0\0\0\0\0\0\0\0\0\0xw\0\0\0\0\0xsq\0~\0 w\0\0\0\0\0\0\0\0\0÷\0\0ù\0\0\0xw\0\0\0\0\0\0\0\0\0\0xw\0\0\0\0\0xxx',640,480,'2026-06-22 15:34:28');
/*!40000 ALTER TABLE `mangoViews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multi_changes_history`
--

DROP TABLE IF EXISTS `multi_changes_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `multi_changes_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `viewAndComponentIdentification` varchar(50) NOT NULL,
  `interpretedState` varchar(50) NOT NULL,
  `ts` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multi_changes_history`
--

LOCK TABLES `multi_changes_history` WRITE;
/*!40000 ALTER TABLE `multi_changes_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `multi_changes_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plcAlarms`
--

DROP TABLE IF EXISTS `plcAlarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `plcAlarms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dataPointId` int(11) NOT NULL,
  `dataPointXid` varchar(50) DEFAULT NULL,
  `dataPointType` varchar(45) DEFAULT NULL,
  `dataPointName` varchar(45) DEFAULT NULL,
  `activeTime` bigint(20) DEFAULT 0,
  `inactiveTime` bigint(20) DEFAULT 0,
  `acknowledgeTime` bigint(20) DEFAULT 0,
  `level` tinyint(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dataPointId` (`dataPointId`,`inactiveTime`),
  CONSTRAINT `plcAlarms_ibfk_1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plcAlarms`
--

LOCK TABLES `plcAlarms` WRITE;
/*!40000 ALTER TABLE `plcAlarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `plcAlarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pointEventDetectors`
--

DROP TABLE IF EXISTS `pointEventDetectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pointEventDetectors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `dataPointId` int(11) NOT NULL,
  `detectorType` int(11) NOT NULL,
  `alarmLevel` int(11) NOT NULL,
  `stateLimit` double DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `durationType` int(11) DEFAULT NULL,
  `binaryState` char(1) DEFAULT NULL,
  `multistateState` int(11) DEFAULT NULL,
  `changeCount` int(11) DEFAULT NULL,
  `alphanumericState` varchar(128) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pointEventDetectorsUn1` (`xid`,`dataPointId`),
  KEY `pointEventDetectorsFk1` (`dataPointId`),
  CONSTRAINT `pointEventDetectorsFk1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pointEventDetectors`
--

LOCK TABLES `pointEventDetectors` WRITE;
/*!40000 ALTER TABLE `pointEventDetectors` DISABLE KEYS */;
/*!40000 ALTER TABLE `pointEventDetectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pointHierarchy`
--

DROP TABLE IF EXISTS `pointHierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pointHierarchy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `xid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_xid_point_hierarchy` (`xid`),
  KEY `idx_xid_point_hierarchy` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pointHierarchy`
--

LOCK TABLES `pointHierarchy` WRITE;
/*!40000 ALTER TABLE `pointHierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `pointHierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pointLinks`
--

DROP TABLE IF EXISTS `pointLinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pointLinks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `sourcePointId` int(11) NOT NULL,
  `targetPointId` int(11) NOT NULL,
  `script` longtext DEFAULT NULL,
  `eventType` int(11) NOT NULL,
  `disabled` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pointLinksUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pointLinks`
--

LOCK TABLES `pointLinks` WRITE;
/*!40000 ALTER TABLE `pointLinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `pointLinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pointValueAnnotations`
--

DROP TABLE IF EXISTS `pointValueAnnotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pointValueAnnotations` (
  `pointValueId` bigint(20) NOT NULL,
  `textPointValueShort` varchar(128) DEFAULT NULL,
  `textPointValueLong` longtext DEFAULT NULL,
  `sourceType` smallint(6) DEFAULT NULL,
  `sourceId` int(11) DEFAULT NULL,
  KEY `pointValueAnnotationsFk1` (`pointValueId`),
  CONSTRAINT `pointValueAnnotationsFk1` FOREIGN KEY (`pointValueId`) REFERENCES `pointValues` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pointValueAnnotations`
--

LOCK TABLES `pointValueAnnotations` WRITE;
/*!40000 ALTER TABLE `pointValueAnnotations` DISABLE KEYS */;
/*!40000 ALTER TABLE `pointValueAnnotations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pointValues`
--

DROP TABLE IF EXISTS `pointValues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pointValues` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dataPointId` int(11) NOT NULL,
  `dataType` int(11) NOT NULL,
  `pointValue` double DEFAULT NULL,
  `ts` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pointValuesIdx1` (`ts`,`dataPointId`),
  KEY `pointValuesIdx2` (`dataPointId`,`ts`),
  CONSTRAINT `pointValuesFk1` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=968 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pointValues`
--

LOCK TABLES `pointValues` WRITE;
/*!40000 ALTER TABLE `pointValues` DISABLE KEYS */;
INSERT INTO `pointValues` VALUES (1,1,3,100.000000677,1784728481359),(2,2,3,94.6044104978,1784728481359),(3,3,3,642.1716,1784728481359),(4,4,3,201.1138836,1784728481359),(5,5,3,0,1784728481359),(6,6,3,0,1784728481359),(7,7,3,0,1784728481359),(8,8,3,0,1784728481359),(9,9,3,2699.35759134,1784728481359),(10,10,3,44.0619519272,1784728481359),(11,11,3,47.6707106302,1784728481359),(12,12,3,0.7751583176,1784728481359),(13,13,3,51.5510799248,1784728481359),(14,14,1,1,1784728481359),(15,15,1,0,1784728481359),(16,16,3,0,1784728481359),(17,17,3,0,1784728481359),(18,18,3,100.00641,1784728481359),(19,19,3,100.00641,1784728481359),(20,1,3,100.000000677,1784728483359),(21,2,3,99.0585190196,1784728483359),(22,3,3,642.1716,1784728483359),(23,4,3,210.39899727,1784728483359),(24,7,3,28.711375795200002,1784728483359),(25,8,3,514.413,1784728483359),(26,9,3,2694.9141641700003,1784728483359),(27,10,3,44.0421151986,1784728483359),(28,11,3,47.6707106302,1784728483359),(29,12,3,0.7751583176,1784728483359),(30,13,3,51.5510799248,1784728483359),(31,18,3,100.00641,1784728483359),(32,19,3,100.00641,1784728483359),(33,2,3,100.000000677,1784728485359),(34,4,3,212.58866663999999,1784728485359),(35,7,3,0,1784728485359),(36,8,3,0,1784728485359),(37,9,3,2698.7716449000004,1784728485359),(38,10,3,44.02227847,1784728485359),(39,4,3,212.50474203,1784728487359),(40,7,3,78.12619264,1784728487359),(41,8,3,1400.499,1784728487359),(42,9,3,2695.74425496,1784728487359),(43,10,3,43.999389937000004,1784728487359),(44,2,3,99.282826643,1784728489359),(45,4,3,211.10091219,1784728489359),(46,7,3,0,1784728489359),(47,8,3,0,1784728489359),(48,9,3,2699.65056456,1784728489359),(49,10,3,43.978027306200005,1784728489359),(50,2,3,96.490425617,1784728491359),(51,4,3,204.92100909,1784728491359),(52,9,3,2693.59578468,1784728491359),(53,10,3,43.9551387732,1784728491359),(54,2,3,92.25452110980001,1784728493359),(55,4,3,196.16233161,1784728493359),(56,9,3,2699.6993934300003,1784728493359),(57,10,3,43.9368279468,1784728493359),(58,2,3,86.5323878598,1784728495359),(59,4,3,183.77963688,1784728495359),(60,9,3,2693.79110016,1784728495359),(61,10,3,43.918517120400004,1784728495359),(62,2,3,79.5590148058,1784728497359),(63,4,3,169.16149572,1784728497359),(64,9,3,2699.89470891,1784728497359),(65,10,3,43.9047840006,1784728497359),(66,2,3,71.5480282558,1784728499359),(67,4,3,151.98746871,1784728499359),(68,9,3,2694.81650643,1784728499359),(69,10,3,43.894102685200004,1784728499359),(70,2,3,62.8168158674,1784728501359),(71,4,3,133.60034961,1784728501359),(72,7,3,5.857938545800001,1784728501359),(73,8,3,105.1335,1784728501359),(74,9,3,2701.01777292,1784728501359),(75,10,3,43.8864731742,1784728501359),(76,2,3,53.6919207114,1784728503359),(77,4,3,114.10695156,1784728503359),(78,7,3,0,1784728503359),(79,8,3,0,1784728503359),(80,9,3,2697.06263445,1784728503359),(81,10,3,43.884947272000005,1784728503359),(82,2,3,44.5197225872,1784728505359),(83,4,3,94.67458959,1784728505359),(84,7,3,95.704585984,1784728505359),(85,8,3,1716.9975,1784728505359),(86,9,3,2701.26191727,1784728505359),(87,10,3,43.8864731742,1784728505359),(88,2,3,35.6389717832,1784728507359),(89,4,3,75.73051626,1784728507359),(90,7,3,0,1784728507359),(91,8,3,0,1784728507359),(92,9,3,2696.62317462,1784728507359),(93,10,3,43.8910508808,1784728507359),(94,2,3,27.3807890768,1784728509359),(95,4,3,58.22079081,1784728509359),(96,7,3,100.000000677,1784728509359),(97,8,3,1793.888,1784728509359),(98,9,3,2700.9201151800003,1784728509359),(99,10,3,43.9017321962,1784728509359),(100,2,3,20.0854506586,1784728511359),(101,4,3,42.68710845,1784728511359),(102,7,3,0,1784728511359),(103,8,3,0,1784728511359),(104,9,3,2698.4786716800004,1784728511359),(105,10,3,43.9169912182,1784728511359),(106,2,3,13.9955749784,1784728513359),(107,4,3,29.73220047,1784728513359),(108,7,3,61.522850801800004,1784728513359),(109,8,3,1102.8799999999999,1784728513359),(110,9,3,2697.40443654,1784728513359),(111,10,3,43.9337761424,1784728513359),(112,2,3,9.3568322904,1784728515359),(113,4,3,19.89776208,1784728515359),(114,7,3,0,1784728515359),(115,8,3,0,1784728515359),(116,9,3,2701.31074614,1784728515359),(117,10,3,43.953612871000004,1784728515359),(118,2,3,6.3950561202000005,1784728517359),(119,4,3,13.5805278,1784728517359),(120,9,3,2694.2793888600004,1784728517359),(121,10,3,43.9749755018,1784728517359),(122,2,3,5.18806748,1784728519359),(123,4,3,11.03227146,1784728519359),(124,9,3,2700.67597083,1784728519359),(125,10,3,43.9963381326,1784728519359),(126,2,3,5.7526512940000005,1784728521359),(127,4,3,12.22247502,1784728521359),(128,9,3,2696.62317462,1784728521359),(129,10,3,44.0207525678,1784728521359),(130,2,3,8.0994888776,1784728523359),(131,4,3,17.22743358,1784728523359),(132,7,3,56.639963761800004,1784728523359),(133,8,3,1016.2905,1784728523359),(134,9,3,2701.7013771,1784728523359),(135,10,3,44.0421151986,1784728523359),(136,2,3,12.2026398934,1784728525359),(137,4,3,25.92507498,1784728525359),(138,7,3,0,1784728525359),(139,8,3,0,1784728525359),(140,9,3,2697.40443654,1784728525359),(141,10,3,44.0634778294,1784728525359),(142,2,3,17.8774701752,1784728527359),(143,4,3,38.00258931,1784728527359),(144,7,3,78.1246667378,1784728527359),(145,8,3,1401.0785,1784728527359),(146,9,3,2699.5529068200003,1784728527359),(147,10,3,44.081788655800004,1784728527359),(148,2,3,24.925612437,1784728529359),(149,4,3,52.98694695,1784728529359),(150,7,3,0,1784728529359),(151,8,3,0,1784728529359),(152,9,3,2699.6993934300003,1784728529359),(153,10,3,44.0970476778,1784728529359),(154,2,3,33.1029223268,1784728531359),(155,4,3,70.29830514,1784728531359),(156,9,3,2694.18173112,1784728531359),(157,10,3,44.1092548954,1784728531359),(158,2,3,42.1057453068,1784728533359),(159,4,3,89.52467034,1784728533359),(160,9,3,2700.4806553500002,1784728533359),(161,10,3,44.116884406400004,1784728533359),(162,2,3,51.5800720666,1784728535359),(163,4,3,109.59028164,1784728535359),(164,9,3,2696.47668801,1784728535359),(165,10,3,44.1199362108,1784728535359),(166,2,3,61.208514948600005,1784728537359),(167,4,3,130.18995864,1784728537359),(168,7,3,47.852292992,1784728537359),(169,8,3,858.6664999999999,1784728537359),(170,9,3,2701.7990348400003,1784728537359),(171,10,3,44.118410308600005,1784728537359),(172,2,3,70.588235772,1784728539359),(173,4,3,149.98090758,1784728539359),(174,7,3,0,1784728539359),(175,8,3,0,1784728539359),(176,9,3,2696.62317462,1784728539359),(177,10,3,44.1123066998,1784728539359),(178,2,3,79.362173422,1784728541359),(179,4,3,168.79527923999999,1784728541359),(180,7,3,65.4291604338,1784728541359),(181,8,3,1174.067,1784728541359),(182,9,3,2700.8712863100004,1784728541359),(183,10,3,44.1016253844,1784728541359),(184,2,3,87.190051708,1784728543359),(185,4,3,185.28265035,1784728543359),(186,7,3,0,1784728543359),(187,8,3,0,1784728543359),(188,9,3,2697.4532654100003,1784728543359),(189,10,3,44.0878922646,1784728543359),(190,2,3,93.7773715054,1784728545359),(191,4,3,199.40487336,1784728545359),(192,7,3,83.985657088,1784728545359),(193,8,3,1506.578,1784728545359),(194,9,3,2699.06461812,1784728545359),(195,10,3,44.069581438200004,1784728545359),(196,2,3,98.88609207100001,1784728547359),(197,4,3,210.18537099,1784728547359),(198,7,3,0,1784728547359),(199,8,3,0,1784728547359),(200,9,3,2698.5275005500002,1784728547359),(201,10,3,44.0497447096,1784728547359),(202,2,3,100.000000677,1784728549359),(203,4,3,212.45896497,1784728549359),(204,7,3,65.4276345316,1784728549359),(205,8,3,1172.7555,1784728549359),(206,9,3,2696.47668801,1784728549359),(207,10,3,44.029907981,1784728549359),(208,4,3,212.6344437,1784728551359),(209,7,3,0,1784728551359),(210,8,3,0,1784728551359),(211,9,3,2700.5783130900004,1784728551359),(212,10,3,44.007019448,1784728551359),(213,2,3,99.664302193,1784728553359),(214,4,3,211.68838446,1784728553359),(215,9,3,2694.23055999,1784728553359),(216,10,3,43.9856568172,1784728553359),(217,2,3,98.016327817,1784728555359),(218,4,3,208.43058369,1784728555359),(219,9,3,2700.2853398700004,1784728555359),(220,10,3,43.964294186400004,1784728555359),(221,2,3,94.07492243440001,1784728557359),(222,4,3,199.76346033,1784728557359),(223,9,3,2692.3750629300002,1784728557359),(224,10,3,43.9444574578,1784728557359),(225,2,3,89.6910054138,1784728559359),(226,4,3,190.66908441,1784728559359),(227,9,3,2698.42984281,1784728559359),(228,10,3,43.9276725336,1784728559359),(229,2,3,82.4429699638,1784728561359),(230,4,3,175.12777254,1784728561359),(231,7,3,62.890059173000004,1784728561359),(232,8,3,1127.036,1784728561359),(233,9,3,2695.8419127,1784728561359),(234,10,3,43.9093617072,1784728561359),(235,2,3,75.7442593058,1784728563359),(236,4,3,161.02843805999998,1784728563359),(237,7,3,0,1784728563359),(238,8,3,0,1784728563359),(239,9,3,2698.57632942,1784728563359),(240,10,3,43.8986803918,1784728563359),(241,2,3,67.3212791618,1784728565359),(242,4,3,143.02279446,1784728565359),(243,9,3,2696.13488592,1784728565359),(244,10,3,43.8879990764,1784728565359),(245,2,3,58.3154043774,1784728567359),(246,4,3,124.04820309,1784728567359),(247,7,3,23.4363318898,1784728567359),(248,8,3,420.59499999999997,1784728567359),(249,9,3,2701.84786371,1784728567359),(250,10,3,43.884947272000005,1784728567359),(251,2,3,49.0684370454,1784728569359),(252,4,3,104.25725415,1784728569359),(253,7,3,0,1784728569359),(254,8,3,0,1784728569359),(255,9,3,2696.2325436600004,1784728569359),(256,10,3,43.883421369800004,1784728569359),(257,2,3,39.911497943200004,1784728571359),(258,4,3,84.89355777,1784728571359),(259,7,3,42.969405952,1784728571359),(260,8,3,771.0705,1784728571359),(261,9,3,2702.1896658,1784728571359),(262,10,3,43.8879990764,1784728571359),(263,2,3,31.2260626208,1784728573359),(264,4,3,66.32333043,1784728573359),(265,7,3,0,1784728573359),(266,8,3,0,1784728573359),(267,9,3,2694.5723620800004,1784728573359),(268,10,3,43.8971544896,1784728573359),(269,2,3,23.3356223446,1784728575359),(270,4,3,49.62996255,1784728575359),(271,7,3,2.9282063218000003,1784728575359),(272,8,3,52.5515,1784728575359),(273,9,3,2700.8712863100004,1784728575359),(274,10,3,43.907835805000005,1784728575359),(275,2,3,16.5133136084,1784728577359),(276,4,3,35.06522796,1784728577359),(277,7,3,0,1784728577359),(278,8,3,0,1784728577359),(279,9,3,2693.05866711,1784728577359),(280,10,3,43.9246207292,1784728577359),(281,2,3,11.0185397862,1784728579359),(282,4,3,23.4225957,1784728579359),(283,9,3,2699.4064202100003,1784728579359),(284,10,3,43.942931555600005,1784728579359),(285,2,3,7.1412222960000005,1784728581359),(286,4,3,15.15983637,1784728581359),(287,7,3,32.616159525,1784728581359),(288,8,3,584.2885,1784728581359),(289,9,3,2692.9121805,1784728581359),(290,10,3,43.964294186400004,1784728581359),(291,2,3,5.0186923358,1784728583359),(292,4,3,10.66605498,1784728583359),(293,7,3,0,1784728583359),(294,8,3,0,1784728583359),(295,9,3,2698.2833562,1784728583359),(296,10,3,43.9856568172,1784728583359),(297,2,3,4.7440299398,1784728585359),(298,4,3,10.07858271,1784728585359),(299,7,3,100.000000677,1784728585359),(300,8,3,1792.363,1784728585359),(301,9,3,2694.4258754700004,1784728585359),(302,10,3,44.011597154600004,1784728585359),(303,2,3,6.3599603696,1784728587359),(304,4,3,13.51949172,1784728587359),(305,7,3,0,1784728587359),(306,8,3,0,1784728587359),(307,9,3,2698.2833562,1784728587359),(308,10,3,44.0329597854,1784728587359),(309,2,3,9.7154193074,1784728589359),(310,4,3,20.63782455,1784728589359),(311,7,3,100.000000677,1784728589359),(312,8,3,1792.607,1784728589359),(313,9,3,2696.5743457500002,1784728589359),(314,10,3,44.0558483184,1784728589359),(315,2,3,14.796673633400001,1784728591359),(316,4,3,31.44884022,1784728591359),(317,7,3,0,1784728591359),(318,8,3,0,1784728591359),(319,9,3,2698.5275005500002,1784728591359),(320,10,3,44.0741591448,1784728591359),(321,2,3,21.387045235200002,1784728593359),(322,4,3,45.44136156,1784728593359),(323,7,3,100.000000677,1784728593359),(324,8,3,1792.668,1784728593359),(325,9,3,2699.01578925,1784728593359),(326,10,3,44.090944069,1784728593359),(327,2,3,29.274433707,1784728595359),(328,4,3,62.21865405,1784728595359),(329,7,3,0,1784728595359),(330,8,3,0,1784728595359),(331,9,3,2697.3067788000003,1784728595359),(332,10,3,44.106203091000005,1784728595359),(333,2,3,38.1689176308,1784728597359),(334,4,3,81.14746836,1784728597359),(335,7,3,100.000000677,1784728597359),(336,8,3,1793.5829999999999,1784728597359),(337,9,3,2701.40840388,1784728597359),(338,10,3,44.1153585042,1784728597359),(339,2,3,47.704280478600005,1784728599359),(340,4,3,101.36566986,1784728599359),(341,7,3,0,1784728599359),(342,8,3,0,1784728599359),(343,9,3,2695.9395704400004,1784728599359),(344,10,3,44.121462113,1784728599359),(345,2,3,57.5463496686,1784728601359),(346,4,3,122.40785844,1784728601359),(347,7,3,48.8288704,1784728601359),(348,8,3,876.2345,1784728601359),(349,9,3,2702.14083693,1784728601359),(350,10,3,44.1229880152,1784728601359),(351,2,3,67.32433096620001,1784728603359),(352,4,3,142.99990593,1784728603359),(353,7,3,0,1784728603359),(354,8,3,0,1784728603359),(355,9,3,2694.5723620800004,1784728603359),(356,10,3,44.118410308600005,1784728603359),(357,2,3,76.6170753642,1784728605359),(358,4,3,162.95107458,1784728605359),(359,7,3,1.953154816,1784728605359),(360,8,3,35.0445,1784728605359),(361,9,3,2700.7736285700003,1784728605359),(362,10,3,44.1107807976,1784728605359),(363,2,3,85.1316096402,1784728607359),(364,4,3,180.78886896,1784728607359),(365,7,3,0,1784728607359),(366,8,3,0,1784728607359),(367,9,3,2693.1074959800003,1784728607359),(368,10,3,44.09857358,1784728607359),(369,2,3,92.46967332,1784728609359),(370,4,3,196.63536123,1784728609359),(371,9,3,2699.8458800400003,1784728609359),(372,10,3,44.081788655800004,1784728609359),(373,2,3,98.44663223740001,1784728611359),(374,4,3,209.03331498,1784728611359),(375,7,3,14.0627146752,1784728611359),(376,8,3,251.8995,1784728611359),(377,9,3,2694.4258754700004,1784728611359),(378,10,3,44.0634778294,1784728611359),(379,2,3,100.000000677,1784728613359),(380,4,3,212.58866663999999,1784728613359),(381,7,3,0,1784728613359),(382,8,3,0,1784728613359),(383,9,3,2698.4786716800004,1784728613359),(384,10,3,44.0405892964,1784728613359),(385,4,3,212.45133546,1784728615359),(386,7,3,60.936904357,1784728615359),(387,8,3,1091.6865,1784728615359),(388,9,3,2698.0392118500004,1784728615359),(389,10,3,44.0207525678,1784728615359),(390,4,3,212.53526007,1784728617359),(391,7,3,0,1784728617359),(392,8,3,0,1784728617359),(393,9,3,2697.06263445,1784728617359),(394,10,3,43.9963381326,1784728617359),(395,2,3,99.19127251100001,1784728619359),(396,4,3,210.92543346,1784728619359),(397,7,3,73.2433056,1784728619359),(398,8,3,1313.9705,1784728619359),(399,9,3,2701.75020597,1784728619359),(400,10,3,43.976501404000004,1784728619359),(401,2,3,96.627756815,1784728621359),(402,4,3,205.28722557,1784728621359),(403,7,3,0,1784728621359),(404,8,3,0,1784728621359),(405,9,3,2695.8419127,1784728621359),(406,10,3,43.953612871000004,1784728621359),(407,2,3,92.3765932858,1784728623359),(408,4,3,196.50565956,1784728623359),(409,7,3,24.4144352,1784728623359),(410,8,3,438.102,1784728623359),(411,9,3,2701.89669258,1784728623359),(412,10,3,43.9353020446,1784728623359),(413,2,3,86.6086829698,1784728625359),(414,4,3,183.93985659,1784728625359),(415,7,3,0,1784728625359),(416,8,3,0,1784728625359),(417,9,3,2693.9864156400004,1784728625359),(418,10,3,43.9169912182,1784728625359),(419,2,3,79.5742738278,1784728627359),(420,4,3,169.22253179999998,1784728627359),(421,9,3,2700.09002439,1784728627359),(422,10,3,43.9032580984,1784728627359),(423,2,3,71.4717331458,1784728629359),(424,4,3,151.78147194,1784728629359),(425,9,3,2693.64461355,1784728629359),(426,10,3,43.8910508808,1784728629359),(427,2,3,62.632181701200004,1784728631359),(428,4,3,133.18072656,1784728631359),(429,9,3,2699.79705117,1784728631359),(430,10,3,43.884947272000005,1784728631359),(431,2,3,53.4004733912,1784728633359),(432,4,3,113.38214811,1784728633359),(433,7,3,2.3437857792,1784728633359),(434,8,3,41.967999999999996,1784728633359),(435,9,3,2692.71686502,1784728633359),(436,10,3,43.8818954676,1784728633359),(437,2,3,44.058900122800004,1784728635359),(438,4,3,93.66749427,1784728635359),(439,7,3,0,1784728635359),(440,8,3,0,1784728635359),(441,9,3,2698.86930264,1784728635359),(442,10,3,43.884947272000005,1784728635359),(443,2,3,36.1699857488,1784728637359),(444,4,3,76.83679521,1784728637359),(445,7,3,97.070268453,1784728637359),(446,8,3,1739.6895,1784728637359),(447,9,3,2697.50209428,1784728637359),(448,10,3,43.8895249786,1784728637359),(449,2,3,26.6926071846,1784728639359),(450,4,3,56.73303636,1784728639359),(451,7,3,0,1784728639359),(452,8,3,0,1784728639359),(453,9,3,2697.3067788000003,1784728639359),(454,10,3,43.900206294,1784728639359),(455,2,3,19.2751965904,1784728641359),(456,4,3,40.97809821,1784728641359),(457,7,3,100.000000677,1784728641359),(458,8,3,1793.5525,1784728641359),(459,9,3,2701.2130884000003,1784728641359),(460,10,3,43.9139394138,1784728641359),(461,2,3,13.0952926804,1784728643359),(462,4,3,27.82482297,1784728643359),(463,7,3,0,1784728643359),(464,8,3,0,1784728643359),(465,9,3,2696.7208323600003,1784728643359),(466,10,3,43.9322502402,1784728643359),(467,2,3,8.377203078,1784728645359),(468,4,3,17.81490585,1784728645359),(469,7,3,96.6796374898,1784728645359),(470,8,3,1734.5349999999999,1784728645359),(471,9,3,2699.6993934300003,1784728645359),(472,10,3,43.953612871000004,1784728645359),(473,2,3,5.3238727758,1784728647359),(474,4,3,11.30693382,1784728647359),(475,7,3,0,1784728647359),(476,8,3,0,1784728647359),(477,9,3,2696.6720034900004,1784728647359),(478,10,3,43.9749755018,1784728647359),(479,2,3,4.0695811674,1784728649359),(480,4,3,8.65186434,1784728649359),(481,7,3,93.74990526580001,1784728649359),(482,8,3,1682.1665,1784728649359),(483,9,3,2701.16425953,1784728649359),(484,10,3,43.999389937000004,1784728649359),(485,2,3,4.6433203946,1784728651359),(486,4,3,9.86495643,1784728651359),(487,7,3,0,1784728651359),(488,8,3,0,1784728651359),(489,9,3,2696.03722818,1784728651359),(490,10,3,44.0207525678,1784728651359),(491,2,3,7.0832380124,1784728653359),(492,4,3,15.06065274,1784728653359),(493,7,3,52.735180032,1784728653359),(494,8,3,946.3539999999999,1784728653359),(495,9,3,2702.0920080600004,1784728653359),(496,10,3,44.0436411008,1784728653359),(497,2,3,11.309987106400001,1784728655359),(498,4,3,24.02532699,1784728655359),(499,7,3,0,1784728655359),(500,8,3,0,1784728655359),(501,9,3,2695.3536240000003,1784728655359),(502,10,3,44.0650037316,1784728655359),(503,2,3,17.1374076082,1784728657359),(504,4,3,36.44616927,1784728657359),(505,7,3,19.53154816,1784728657359),(506,8,3,350.4755,1784728657359),(507,9,3,2701.6525482300003,1784728657359),(508,10,3,44.083314558000005,1784728657359),(509,2,3,24.368658134,1784728659359),(510,4,3,51.76622535,1784728659359),(511,7,3,0,1784728659359),(512,8,3,0,1784728659359),(513,9,3,2694.67001982,1784728659359),(514,10,3,44.09857358,1784728659359),(515,2,3,33.8735029378,1784728661359),(516,4,3,72.05309244,1784728661359),(517,7,3,25.3894867058,1784728661359),(518,8,3,455.609,1784728661359),(519,9,3,2701.6525482300003,1784728661359),(520,10,3,44.1123066998,1784728661359),(521,2,3,42.0218206858,1784728663359),(522,4,3,89.25000797999999,1784728663359),(523,7,3,0,1784728663359),(524,8,3,0,1784728663359),(525,9,3,2693.8399290300003,1784728663359),(526,10,3,44.1199362108,1784728663359),(527,2,3,53.0220496456,1784728665359),(528,4,3,112.76415779999999,1784728665359),(529,7,3,1.953154816,1784728665359),(530,8,3,35.0445,1784728665359),(531,9,3,2700.7736285700003,1784728665359),(532,10,3,44.1229880152,1784728665359),(533,2,3,61.673915119600004,1784728667359),(534,4,3,130.96053915,1784728667359),(535,7,3,0,1784728667359),(536,8,3,0,1784728667359),(537,9,3,2692.86335163,1784728667359),(538,10,3,44.121462113,1784728667359),(539,2,3,72.48798401100001,1784728669359),(540,4,3,154.12373151,1784728669359),(541,9,3,2699.4064202100003,1784728669359),(542,10,3,44.1153585042,1784728669359),(543,2,3,80.36163936300001,1784728671359),(544,4,3,170.64925017,1784728671359),(545,7,3,35.5474176512,1784728671359),(546,8,3,636.8095,1784728671359),(547,9,3,2694.5723620800004,1784728671359),(548,10,3,44.106203091000005,1784728671359),(549,2,3,89.37972136500001,1784728673359),(550,4,3,190.00531704,1784728673359),(551,7,3,0,1784728673359),(552,8,3,0,1784728673359),(553,9,3,2698.42984281,1784728673359),(554,10,3,44.090944069,1784728673359),(555,2,3,96.0570693922,1784728675359),(556,4,3,204.07413348,1784728675359),(557,7,3,96.093691045,1784728675359),(558,8,3,1722.3045,1784728675359),(559,9,3,2697.50209428,1784728675359),(560,10,3,44.0741591448,1784728675359),(561,2,3,100.000000677,1784728677359),(562,4,3,212.55051909,1784728677359),(563,7,3,0,1784728677359),(564,8,3,0,1784728677359),(565,9,3,2697.5997520200003,1784728677359),(566,10,3,44.0512706118,1784728677359),(567,4,3,212.56577811,1784728679359),(568,7,3,100.000000677,1784728679359),(569,8,3,1793.3084999999999,1784728679359),(570,9,3,2700.236511,1784728679359),(571,10,3,44.029907981,1784728679359),(572,4,3,212.49711252,1784728681359),(573,7,3,0,1784728681359),(574,8,3,0,1784728681359),(575,9,3,2696.3790302700004,1784728681359),(576,10,3,44.0100712524,1784728681359),(577,2,3,99.679561215,1784728683359),(578,4,3,211.95541731,1784728683359),(579,7,3,70.31357337600001,1784728683359),(580,8,3,1261.3885,1784728683359),(581,9,3,2701.3595750100003,1784728683359),(582,10,3,43.9856568172,1784728683359),(583,2,3,98.00106879500001,1784728685359),(584,4,3,208.25510496,1784728685359),(585,7,3,0,1784728685359),(586,8,3,0,1784728685359),(587,9,3,2696.47668801,1784728685359),(588,10,3,43.965820088600005,1784728685359),(589,2,3,94.5494780186,1784728687359),(590,4,3,201.04521800999999,1784728687359),(591,7,3,73.2433056,1784728687359),(592,8,3,1313.8485,1784728687359),(593,9,3,2701.16425953,1784728687359),(594,10,3,43.9444574578,1784728687359),(595,2,3,89.5078971498,1784728689359),(596,4,3,190.21894332,1784728689359),(597,7,3,0,1784728689359),(598,8,3,0,1784728689359),(599,9,3,2696.7208323600003,1784728689359),(600,10,3,43.9261466314,1784728689359),(601,2,3,83.0533308438,1784728691359),(602,4,3,176.59263846,1784728691359),(603,7,3,83.0075537778,1784728691359),(604,8,3,1489.01,1784728691359),(605,9,3,2700.82245744,1784728691359),(606,10,3,43.9093617072,1784728691359),(607,2,3,75.4238198438,1784728693359),(608,4,3,160.27311656999998,1784728693359),(609,7,3,0,1784728693359),(610,8,3,0,1784728693359),(611,9,3,2697.06263445,1784728693359),(612,10,3,43.8971544896,1784728693359),(613,2,3,66.9382777096,1784728695359),(614,4,3,142.35139758,1784728695359),(615,7,3,83.00907968,1784728695359),(616,8,3,1489.2845,1784728695359),(617,9,3,2701.45723275,1784728695359),(618,10,3,43.8879990764,1784728695359),(619,2,3,57.856107815200005,1784728697359),(620,4,3,122.94192414,1784728697359),(621,7,3,0,1784728697359),(622,8,3,0,1784728697359),(623,9,3,2696.91614784,1784728697359),(624,10,3,43.883421369800004,1784728697359),(625,2,3,48.578622439200004,1784728699359),(626,4,3,103.31119491,1784728699359),(627,7,3,82.032502272,1784728699359),(628,8,3,1471.869,1784728699359),(629,9,3,2701.7990348400003,1784728699359),(630,2,3,39.4048984128,1784728701359),(631,4,3,83.73387225,1784728701359),(632,7,3,0,1784728701359),(633,8,3,0,1784728701359),(634,9,3,2697.0138055800003,1784728701359),(635,10,3,43.8879990764,1784728701359),(636,2,3,30.7362480146,1784728703359),(637,4,3,65.36201217,1784728703359),(638,7,3,72.2652022898,1784728703359),(639,8,3,1296.555,1784728703359),(640,9,3,2701.5060616200003,1784728703359),(641,10,3,43.895628587400005,1784728703359),(642,2,3,22.8305487164,1784728705359),(643,4,3,48.508424579999996,1784728705359),(644,7,3,0,1784728705359),(645,8,3,0,1784728705359),(646,9,3,2696.3790302700004,1784728705359),(647,10,3,43.907835805000005,1784728705359),(648,2,3,16.0234990022,1784728707359),(649,4,3,34.08102117,1784728707359),(650,7,3,77.149615232,1784728707359),(651,8,3,1384.334,1784728707359),(652,9,3,2701.89669258,1784728707359),(653,10,3,43.923094827,1784728707359),(654,2,3,9.964141366,1784728709359),(655,4,3,21.17189025,1784728709359),(656,7,3,0,1784728709359),(657,8,3,0,1784728709359),(658,9,3,2696.3302014,1784728709359),(659,10,3,43.942931555600005,1784728709359),(660,2,3,6.2546731178,1784728711359),(661,4,3,13.29823593,1784728711359),(662,7,3,76.1715119218,1784728711359),(663,8,3,1366.583,1784728711359),(664,9,3,2701.3595750100003,1784728711359),(665,10,3,43.965820088600005,1784728711359),(666,2,3,4.2999923996,1784728713359),(667,4,3,9.13252347,1784728713359),(668,7,3,0,1784728713359),(669,8,3,0,1784728713359),(670,9,3,2696.5255168800004,1784728713359),(671,10,3,43.9871827194,1784728713359),(672,2,3,4.1382467664,1784728715359),(673,4,3,8.80445454,1784728715359),(674,7,3,83.98413118580001,1784728715359),(675,8,3,1506.883,1784728715359),(676,9,3,2701.7013771,1784728715359),(677,10,3,44.0100712524,1784728715359),(678,2,3,5.8457313282,1784728717359),(679,4,3,12.42084228,1784728717359),(680,7,3,0,1784728717359),(681,8,3,0,1784728717359),(682,9,3,2697.35560767,1784728717359),(683,10,3,44.034485687600004,1784728717359),(684,2,3,9.369039508,1784728719359),(685,4,3,19.92065061,1784728719359),(686,7,3,100.000000677,1784728719359),(687,8,3,1793.7965,1784728719359),(688,9,3,2700.8712863100004,1784728719359),(689,10,3,44.0558483184,1784728719359),(690,2,3,14.601358151800001,1784728721359),(691,4,3,31.02921717,1784728721359),(692,7,3,0,1784728721359),(693,8,3,0,1784728721359),(694,9,3,2697.40443654,1784728721359),(695,10,3,44.0772109492,1784728721359),(696,2,3,21.3595789956,1784728723359),(697,4,3,45.41847303,1784728723359),(698,7,3,100.000000677,1784728723359),(699,8,3,1793.888,1784728723359),(700,9,3,2701.0666017900003,1784728723359),(701,10,3,44.0924699712,1784728723359),(702,2,3,29.3385215994,1784728725359),(703,4,3,62.34835572,1784728725359),(704,7,3,0,1784728725359),(705,8,3,0,1784728725359),(706,9,3,2697.64858089,1784728725359),(707,10,3,44.1077289932,1784728725359),(708,2,3,38.3093006332,1784728727359),(709,4,3,81.44501925,1784728727359),(710,7,3,94.7249567716,1784728727359),(711,8,3,1699.0635,1784728727359),(712,9,3,2700.38299761,1784728727359),(713,10,3,44.116884406400004,1784728727359),(714,2,3,47.890440547000004,1784728729359),(715,4,3,101.78529291,1784728729359),(716,7,3,0,1784728729359),(717,8,3,0,1784728729359),(718,9,3,2698.1856984600004,1784728729359),(719,10,3,44.1229880152,1784728729359),(720,2,3,57.763027781000005,1784728731359),(721,4,3,122.74355688,1784728731359),(722,7,3,84.9607085938,1784728731359),(723,8,3,1523.0785,1784728731359),(724,9,3,2697.7462386300003,1784728731359),(725,2,3,67.5410090786,1784728733359),(726,4,3,143.5873782,1784728733359),(727,7,3,0,1784728733359),(728,8,3,0,1784728733359),(729,9,3,2698.91813151,1784728733359),(730,10,3,44.1199362108,1784728733359),(731,2,3,76.8490124986,1784728735359),(732,4,3,163.18758939,1784728735359),(733,7,3,8.1971466184,1784728735359),(734,8,3,146.8575,1784728735359),(735,9,3,2693.8399290300003,1784728735359),(736,10,3,44.1107807976,1784728735359),(737,2,3,85.3330287306,1784728737359),(738,4,3,181.41448878,1784728737359),(739,7,3,0,1784728737359),(740,8,3,0,1784728737359),(741,9,3,2698.86930264,1784728737359),(742,10,3,44.09857358,1784728737359),(743,2,3,92.6558333884,1784728739359),(744,4,3,196.7650629,1784728739359),(745,7,3,13.0815595606,1784728739359),(746,8,3,234.362,1784728739359),(747,9,3,2693.9864156400004,1784728739359),(748,10,3,44.0802627536,1784728739359),(749,2,3,98.5107201298,1784728741359),(750,4,3,209.42241999,1784728741359),(751,7,3,0,1784728741359),(752,8,3,0,1784728741359),(753,9,3,2698.8204737700003,1784728741359),(754,10,3,44.0619519272,1784728741359),(755,2,3,100.000000677,1784728743359),(756,4,3,212.35978134,1784728743359),(757,7,3,11.128404744600001,1784728743359),(758,8,3,199.34799999999998,1784728743359),(759,9,3,2693.93758677,1784728743359),(760,10,3,44.0390633942,1784728743359),(761,4,3,212.59629615,1784728745359),(762,7,3,0,1784728745359),(763,8,3,0,1784728745359),(764,9,3,2698.86930264,1784728745359),(765,10,3,44.0177007634,1784728745359),(766,2,3,99.969482633,1784728747359),(767,4,3,212.30637477,1784728747359),(768,7,3,9.1752499286,1784728747359),(769,8,3,164.3645,1784728747359),(770,9,3,2694.1329022500004,1784728747359),(771,10,3,43.9948122304,1784728747359),(772,2,3,98.901351093,1784728749359),(773,4,3,210.2692956,1784728749359),(774,7,3,0,1784728749359),(775,8,3,0,1784728749359),(776,9,3,2699.2599336000003,1784728749359),(777,10,3,43.9734495996,1784728749359),(778,2,3,96.10895006700001,1784728751359),(779,4,3,204.13516956,1784728751359),(780,7,3,54.100862501,1784728751359),(781,8,3,969.412,1784728751359),(782,9,3,2693.9864156400004,1784728751359),(783,10,3,43.9520869688,1784728751359),(784,2,3,91.64416022980001,1784728753359),(785,4,3,194.83479687,1784728753359),(786,7,3,0,1784728753359),(787,8,3,0,1784728753359),(788,9,3,2699.1134469900003,1784728753359),(789,10,3,43.9337761424,1784728753359),(790,2,3,85.7389187158,1784728755359),(791,4,3,182.13166272,1784728755359),(792,7,3,66.7948429028,1784728755359),(793,8,3,1197.064,1784728755359),(794,9,3,2694.3282177300002,1784728755359),(795,10,3,43.915465316,1784728755359),(796,2,3,78.5671783758,1784728757359),(797,4,3,166.98708537,1784728757359),(798,7,3,0,1784728757359),(799,8,3,0,1784728757359),(800,9,3,2697.7462386300003,1784728757359),(801,10,3,43.9017321962,1784728757359),(802,2,3,70.4341196498,1784728759359),(803,4,3,149.69861571,1784728759359),(804,7,3,100.000000677,1784728759359),(805,8,3,1793.0339999999999,1784728759359),(806,9,3,2696.3790302700004,1784728759359),(807,10,3,43.8910508808,1784728759359),(808,2,3,61.5793091832,1784728761359),(809,4,3,130.89950307,1784728761359),(810,7,3,0,1784728761359),(811,8,3,0,1784728761359),(812,9,3,2698.4786716800004,1784728761359),(813,10,3,43.8864731742,1784728761359),(814,2,3,52.3933779392,1784728763359),(815,4,3,111.32218041,1784728763359),(816,7,3,88.28107178100001,1784728763359),(817,8,3,1582.4315,1784728763359),(818,9,3,2697.06263445,1784728763359),(819,10,3,43.883421369800004,1784728763359),(820,2,3,43.205920793000004,1784728765359),(821,4,3,91.8593004,1784728765359),(822,7,3,0,1784728765359),(823,8,3,0,1784728765359),(824,9,3,2699.4064202100003,1784728765359),(825,10,3,43.8864731742,1784728765359),(826,2,3,34.370947055,1784728767359),(827,4,3,73.0144107,1784728767359),(828,7,3,11.7174029938,1784728767359),(829,8,3,210.023,1784728767359),(830,9,3,2695.9395704400004,1784728767359),(831,10,3,43.892576783,1784728767359),(832,2,3,26.234836524600002,1784728769359),(833,4,3,55.79460663,1784728769359),(834,7,3,35.156786688000004,1784728769359),(835,8,3,630.8315,1784728769359),(836,9,3,2701.7013771,1784728769359),(837,10,3,43.9047840006,1784728769359),(838,2,3,19.0463112604,1784728771359),(839,4,3,40.45166202,1784728771359),(840,7,3,0,1784728771359),(841,8,3,0,1784728771359),(842,9,3,2694.7188486900004,1784728771359),(843,10,3,43.918517120400004,1784728771359),(844,2,3,13.170061888200001,1784728773359),(845,4,3,28.00793121,1784728773359),(846,7,3,21.484702976,1784728773359),(847,8,3,385.52,1784728773359),(848,9,3,2701.75020597,1784728773359),(849,10,3,43.9368279468,1784728773359),(850,2,3,8.8059815962,1784728775359),(851,4,3,18.70755852,1784728775359),(852,7,3,0,1784728775359),(853,8,3,0,1784728775359),(854,9,3,2696.18371479,1784728775359),(855,10,3,43.9551387732,1784728775359),(856,2,3,6.118867822,1784728777359),(857,4,3,13.00831455,1784728777359),(858,7,3,62.500954112,1784728777359),(859,8,3,1121.3935,1784728777359),(860,9,3,2701.3595750100003,1784728777359),(861,10,3,43.978027306200005,1784728777359),(862,2,3,5.2170596218,1784728779359),(863,4,3,11.08567803,1784728779359),(864,7,3,0,1784728779359),(865,8,3,0,1784728779359),(866,9,3,2697.4532654100003,1784728779359),(867,10,3,44.000915839200005,1784728779359),(868,2,3,6.1463340616,1784728781359),(869,4,3,13.05409161,1784728781359),(870,7,3,74.21835710580001,1784728781359),(871,8,3,1330.471,1784728781359),(872,9,3,2697.25794993,1784728781359),(873,10,3,44.023804372200004,1784728781359),(874,2,3,8.891432119400001,1784728783359),(875,4,3,18.90592578,1784728783359),(876,7,3,0,1784728783359),(877,8,3,0,1784728783359),(878,9,3,2700.04119552,1784728783359),(879,10,3,44.045167003,1784728783359),(880,2,3,13.2860304554,1784728785359),(881,4,3,28.22155749,1784728785359),(882,9,3,2694.9141641700003,1784728785359),(883,10,3,44.0650037316,1784728785359),(884,2,3,19.2355231332,1784728787359),(885,4,3,40.90943262,1784728787359),(886,7,3,21.484702976,1784728787359),(887,8,3,385.52,1784728787359),(888,9,3,2701.7990348400003,1784728787359),(889,10,3,44.0848404602,1784728787359),(890,2,3,27.534905199,1784728789359),(891,4,3,58.5183417,1784728789359),(892,7,3,0,1784728789359),(893,8,3,0,1784728789359),(894,9,3,2697.3067788000003,1784728789359),(895,10,3,44.1000994822,1784728789359),(896,2,3,35.9258413968,1784728791359),(897,4,3,76.3713951,1784728791359),(898,7,3,100.000000677,1784728791359),(899,8,3,1793.5525,1784728791359),(900,9,3,2699.6993934300003,1784728791359),(901,10,3,44.1092548954,1784728791359),(902,2,3,44.9897004648,1784728793359),(903,4,3,95.62827834,1784728793359),(904,7,3,0,1784728793359),(905,8,3,0,1784728793359),(906,9,3,2698.3810139400002,1784728793359),(907,10,3,44.1153585042,1784728793359),(908,2,3,54.431983278400004,1784728795359),(909,4,3,115.60996503,1784728795359),(910,7,3,65.4245827272,1784728795359),(911,8,3,1172.3285,1784728795359),(912,9,3,2694.5723620800004,1784728795359),(913,10,3,44.118410308600005,1784728795359),(914,2,3,63.907835940400005,1784728797359),(915,4,3,135.85105506,1784728797359),(916,7,3,0,1784728797359),(917,8,3,0,1784728797359),(918,9,3,2698.5275005500002,1784728797359),(919,10,3,44.1153585042,1784728797359),(920,2,3,74.128328876,1784728799359),(921,4,3,157.51886346,1784728799359),(922,9,3,2696.91614784,1784728799359),(923,10,3,44.1077289932,1784728799359),(924,2,3,82.47501391,1784728801359),(925,4,3,175.39480539,1784728801359),(926,7,3,81.0543989618,1784728801359),(927,8,3,1454.1789999999999,1784728801359),(928,9,3,2701.01777292,1784728801359),(929,10,3,44.0970476778,1784728801359),(930,2,3,89.75356740400001,1784728803359),(931,4,3,190.76063853,1784728803359),(932,7,3,0,1784728803359),(933,8,3,0,1784728803359),(934,9,3,2697.7462386300003,1784728803359),(935,10,3,44.081788655800004,1784728803359),(936,2,3,95.7747774852,1784728805359),(937,4,3,203.5553268,1784728805359),(938,7,3,67.3807893476,1784728805359),(939,8,3,1208.166,1784728805359),(940,9,3,2698.0392118500004,1784728805359),(941,10,3,44.0634778294,1784728805359),(942,2,3,100.000000677,1784728807359),(943,4,3,212.68785026999998,1784728807359),(944,7,3,24.412909297800002,1784728807359),(945,8,3,438.041,1784728807359),(946,9,3,2701.45723275,1784728807359),(947,10,3,44.0421151986,1784728807359),(948,4,3,212.52763056,1784728809359),(949,7,3,0,1784728809359),(950,8,3,0,1784728809359),(951,9,3,2697.40443654,1784728809359),(952,10,3,44.0207525678,1784728809359),(953,4,3,212.59629615,1784728811359),(954,7,3,100.000000677,1784728811359),(955,8,3,1793.4914999999999,1784728811359),(956,9,3,2699.45524908,1784728811359),(957,10,3,43.999389937000004,1784728811359),(958,2,3,99.023423269,1784728813359),(959,4,3,210.52106943,1784728813359),(960,7,3,0,1784728813359),(961,8,3,0,1784728813359),(962,9,3,2699.16227586,1784728813359),(963,10,3,43.976501404000004,1784728813359),(964,2,3,96.307317353,1784728815359),(965,4,3,204.59294016,1784728815359),(966,9,3,2695.40245287,1784728815359),(967,10,3,43.953612871000004,1784728815359);
/*!40000 ALTER TABLE `pointValues` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`scada`@`%`*/ /*!50003 TRIGGER tri_notify_faults_or_alarms AFTER INSERT ON pointValues 
FOR EACH ROW CALL prc_alarms_notify(new.dataPointId, new.ts, new.pointValue) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `publishersUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportInstanceData`
--

DROP TABLE IF EXISTS `reportInstanceData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportInstanceData` (
  `pointValueId` bigint(20) NOT NULL,
  `reportInstancePointId` int(11) NOT NULL,
  `pointValue` double DEFAULT NULL,
  `ts` bigint(20) NOT NULL,
  PRIMARY KEY (`pointValueId`,`reportInstancePointId`),
  KEY `reportInstanceDataFk1` (`reportInstancePointId`),
  CONSTRAINT `reportInstanceDataFk1` FOREIGN KEY (`reportInstancePointId`) REFERENCES `reportInstancePoints` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportInstanceData`
--

LOCK TABLES `reportInstanceData` WRITE;
/*!40000 ALTER TABLE `reportInstanceData` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstanceData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportInstanceDataAnnotations`
--

DROP TABLE IF EXISTS `reportInstanceDataAnnotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportInstanceDataAnnotations` (
  `pointValueId` bigint(20) NOT NULL,
  `reportInstancePointId` int(11) NOT NULL,
  `textPointValueShort` varchar(128) DEFAULT NULL,
  `textPointValueLong` longtext DEFAULT NULL,
  `sourceValue` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`pointValueId`,`reportInstancePointId`),
  CONSTRAINT `reportInstanceDataAnnotationsFk1` FOREIGN KEY (`pointValueId`, `reportInstancePointId`) REFERENCES `reportInstanceData` (`pointValueId`, `reportInstancePointId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportInstanceDataAnnotations`
--

LOCK TABLES `reportInstanceDataAnnotations` WRITE;
/*!40000 ALTER TABLE `reportInstanceDataAnnotations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstanceDataAnnotations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportInstanceEvents`
--

DROP TABLE IF EXISTS `reportInstanceEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportInstanceEvents` (
  `eventId` int(11) NOT NULL,
  `reportInstanceId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `typeRef1` int(11) NOT NULL,
  `typeRef2` int(11) NOT NULL,
  `activeTs` bigint(20) NOT NULL,
  `rtnApplicable` char(1) NOT NULL,
  `rtnTs` bigint(20) DEFAULT NULL,
  `rtnCause` int(11) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `message` longtext DEFAULT NULL,
  `ackTs` bigint(20) DEFAULT NULL,
  `ackUsername` varchar(40) DEFAULT NULL,
  `alternateAckSource` int(11) DEFAULT NULL,
  PRIMARY KEY (`eventId`,`reportInstanceId`),
  KEY `reportInstanceEventsFk1` (`reportInstanceId`),
  CONSTRAINT `reportInstanceEventsFk1` FOREIGN KEY (`reportInstanceId`) REFERENCES `reportInstances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportInstanceEvents`
--

LOCK TABLES `reportInstanceEvents` WRITE;
/*!40000 ALTER TABLE `reportInstanceEvents` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstanceEvents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportInstancePoints`
--

DROP TABLE IF EXISTS `reportInstancePoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportInstancePoints` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reportInstanceId` int(11) NOT NULL,
  `dataSourceName` varchar(40) NOT NULL,
  `pointName` varchar(100) NOT NULL,
  `dataType` int(11) NOT NULL,
  `startValue` varchar(4096) DEFAULT NULL,
  `textRenderer` longblob DEFAULT NULL,
  `colour` varchar(6) DEFAULT NULL,
  `consolidatedChart` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reportInstancePointsFk1` (`reportInstanceId`),
  CONSTRAINT `reportInstancePointsFk1` FOREIGN KEY (`reportInstanceId`) REFERENCES `reportInstances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportInstancePoints`
--

LOCK TABLES `reportInstancePoints` WRITE;
/*!40000 ALTER TABLE `reportInstancePoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstancePoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportInstanceUserComments`
--

DROP TABLE IF EXISTS `reportInstanceUserComments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportInstanceUserComments` (
  `reportInstanceId` int(11) NOT NULL,
  `username` varchar(40) DEFAULT NULL,
  `commentType` int(11) NOT NULL,
  `typeKey` int(11) NOT NULL,
  `ts` bigint(20) NOT NULL,
  `commentText` varchar(1024) NOT NULL,
  KEY `reportInstanceUserCommentsFk1` (`reportInstanceId`),
  CONSTRAINT `reportInstanceUserCommentsFk1` FOREIGN KEY (`reportInstanceId`) REFERENCES `reportInstances` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportInstanceUserComments`
--

LOCK TABLES `reportInstanceUserComments` WRITE;
/*!40000 ALTER TABLE `reportInstanceUserComments` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstanceUserComments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportInstances`
--

DROP TABLE IF EXISTS `reportInstances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportInstances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `includeEvents` int(11) NOT NULL,
  `includeUserComments` char(1) NOT NULL,
  `reportStartTime` bigint(20) NOT NULL,
  `reportEndTime` bigint(20) NOT NULL,
  `runStartTime` bigint(20) DEFAULT NULL,
  `runEndTime` bigint(20) DEFAULT NULL,
  `recordCount` int(11) DEFAULT NULL,
  `preventPurge` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reportInstancesFk1` (`userId`),
  CONSTRAINT `reportInstancesFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportInstances`
--

LOCK TABLES `reportInstances` WRITE;
/*!40000 ALTER TABLE `reportInstances` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportInstances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `data` longblob NOT NULL,
  `xid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reportsFk1` (`userId`),
  CONSTRAINT `reportsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduledEvents`
--

DROP TABLE IF EXISTS `scheduledEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduledEvents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `alarmLevel` int(11) NOT NULL,
  `scheduleType` int(11) NOT NULL,
  `returnToNormal` char(1) NOT NULL,
  `disabled` char(1) NOT NULL,
  `activeYear` int(11) DEFAULT NULL,
  `activeMonth` int(11) DEFAULT NULL,
  `activeDay` int(11) DEFAULT NULL,
  `activeHour` int(11) DEFAULT NULL,
  `activeMinute` int(11) DEFAULT NULL,
  `activeSecond` int(11) DEFAULT NULL,
  `activeCron` varchar(25) DEFAULT NULL,
  `inactiveYear` int(11) DEFAULT NULL,
  `inactiveMonth` int(11) DEFAULT NULL,
  `inactiveDay` int(11) DEFAULT NULL,
  `inactiveHour` int(11) DEFAULT NULL,
  `inactiveMinute` int(11) DEFAULT NULL,
  `inactiveSecond` int(11) DEFAULT NULL,
  `inactiveCron` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `scheduledEventsUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduledEvents`
--

LOCK TABLES `scheduledEvents` WRITE;
/*!40000 ALTER TABLE `scheduledEvents` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduledEvents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduledExecuteInactiveEvent`
--

DROP TABLE IF EXISTS `scheduledExecuteInactiveEvent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduledExecuteInactiveEvent` (
  `mailingListId` int(11) NOT NULL,
  `sourceEventId` int(11) NOT NULL,
  `eventHandlerId` int(11) NOT NULL,
  UNIQUE KEY `mailingListId` (`mailingListId`,`sourceEventId`,`eventHandlerId`),
  KEY `sourceEventId` (`sourceEventId`),
  KEY `eventHandlerId` (`eventHandlerId`),
  CONSTRAINT `scheduledExecuteInactiveEvent_ibfk_1` FOREIGN KEY (`sourceEventId`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `scheduledExecuteInactiveEvent_ibfk_2` FOREIGN KEY (`mailingListId`) REFERENCES `mailingLists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `scheduledExecuteInactiveEvent_ibfk_3` FOREIGN KEY (`eventHandlerId`) REFERENCES `eventHandlers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduledExecuteInactiveEvent`
--

LOCK TABLES `scheduledExecuteInactiveEvent` WRITE;
/*!40000 ALTER TABLE `scheduledExecuteInactiveEvent` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduledExecuteInactiveEvent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_version` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT current_timestamp(),
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `schema_version_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_version`
--

LOCK TABLES `schema_version` WRITE;
/*!40000 ALTER TABLE `schema_version` DISABLE KEYS */;
INSERT INTO `schema_version` VALUES (1,'1','<< Flyway Baseline >>','BASELINE','<< Flyway Baseline >>',NULL,'scada','2026-07-22 02:35:33',0,1),(2,'1.1','ViewsHierarchy','JDBC','org.scada_lts.dao.migration.mysql.V1_1__ViewsHierarchy',NULL,'scada','2026-07-22 02:35:33',108,1),(3,'1.2','SetViewSizeProperties','JDBC','org.scada_lts.dao.migration.mysql.V1_2__SetViewSizeProperties',NULL,'scada','2026-07-22 02:35:33',26,1),(4,'1.3','SetXidPointHierarchy','JDBC','org.scada_lts.dao.migration.mysql.V1_3__SetXidPointHierarchy',NULL,'scada','2026-07-22 02:35:33',94,1),(5,'2.0','CMP history','JDBC','org.scada_lts.dao.migration.mysql.V2_0__CMP_history',NULL,'scada','2026-07-22 02:35:33',33,1),(6,'2.3','FaultsAndAlarms','JDBC','org.scada_lts.dao.migration.mysql.V2_3__FaultsAndAlarms',NULL,'scada','2026-07-22 02:35:33',154,1),(7,'2.4','','JDBC','org.scada_lts.dao.migration.mysql.V2_4__',NULL,'scada','2026-07-22 02:35:34',30,1),(8,'2.5','ScheduledExecuteInactiveEvent','JDBC','org.scada_lts.dao.migration.mysql.V2_5__ScheduledExecuteInactiveEvent',NULL,'scada','2026-07-22 02:35:34',128,1),(9,'2.6','','JDBC','org.scada_lts.dao.migration.mysql.V2_6__',NULL,'scada','2026-07-22 02:35:34',39,1),(10,'2.6.5.0','ZIndexForViewComponent','JDBC','org.scada_lts.dao.migration.mysql.V2_6_5_0__ZIndexForViewComponent',NULL,'scada','2026-07-22 02:35:34',1,1),(11,'2.7.0.1','UserParameters','JDBC','org.scada_lts.dao.migration.mysql.V2_7_0_1__UserParameters',NULL,'scada','2026-07-22 02:35:34',26,1),(12,'2.7.0.2','FixViewPermissions','JDBC','org.scada_lts.dao.migration.mysql.V2_7_0_2__FixViewPermissions',NULL,'scada','2026-07-22 02:35:34',15,1),(13,'2.7.0.3','AnonymousUser','JDBC','org.scada_lts.dao.migration.mysql.V2_7_0_3__AnonymousUser',NULL,'scada','2026-07-22 02:35:34',4,1),(14,'2.7.0.4','ExtendedDelayForMetaDatapoints','JDBC','org.scada_lts.dao.migration.mysql.V2_7_0_4__ExtendedDelayForMetaDatapoints',NULL,'scada','2026-07-22 02:35:34',2,1),(15,'2.7.0.4.1','CorrectProcedurePrcAlarmsNotify','JDBC','org.scada_lts.dao.migration.mysql.V2_7_0_4_1__CorrectProcedurePrcAlarmsNotify',NULL,'scada','2026-07-22 02:35:34',15,1),(16,'2.7.0.4.2','MultiChangeHistory','JDBC','org.scada_lts.dao.migration.mysql.V2_7_0_4_2__MultiChangeHistory',NULL,'scada','2026-07-22 02:35:34',28,1),(17,'2.7.0.5','SynopticPanel','JDBC','org.scada_lts.dao.migration.mysql.V2_7_0_5__SynopticPanel',NULL,'scada','2026-07-22 02:35:34',17,1),(18,'2.7.1.0','UserNames','JDBC','org.scada_lts.dao.migration.mysql.V2_7_1_0__UserNames',NULL,'scada','2026-07-22 02:35:34',24,1),(19,'2.7.1.1','HttpRetriever','JDBC','org.scada_lts.dao.migration.mysql.V2_7_1_1__HttpRetriever',NULL,'scada','2026-07-22 02:35:34',2,1),(20,'2.7.1.2','PurgeLimitStrategyDatapointProperty','JDBC','org.scada_lts.dao.migration.mysql.V2_7_1_2__PurgeLimitStrategyDatapointProperty',NULL,'scada','2026-07-22 02:35:34',1,1),(21,'2.7.1.3','ExportImportReport','JDBC','org.scada_lts.dao.migration.mysql.V2_7_1_3__ExportImportReport',NULL,'scada','2026-07-22 02:35:34',28,1),(22,'2.7.2.1','MqttPointLocatorUpdateDataPointXid','JDBC','org.scada_lts.dao.migration.mysql.V2_7_2_1__MqttPointLocatorUpdateDataPointXid',NULL,'scada','2026-07-22 02:35:34',1,1),(23,'2.7.3.0','SqlDataSourceUpdate','JDBC','org.scada_lts.dao.migration.mysql.V2_7_3_0__SqlDataSourceUpdate',NULL,'scada','2026-07-22 02:35:34',1,1),(24,'2.7.4.1','AddSoapServicesUser','JDBC','org.scada_lts.dao.migration.mysql.V2_7_4_1__AddSoapServicesUser',NULL,'scada','2026-07-22 02:35:34',4,1),(25,'2.7.5.3','AddLangToUser','JDBC','org.scada_lts.dao.migration.mysql.V2_7_5_3__AddLangToUser',NULL,'scada','2026-07-22 02:35:34',25,1),(26,'2.7.5.3.1','AddHttpdsUser','JDBC','org.scada_lts.dao.migration.mysql.V2_7_5_3_1__AddHttpdsUser',NULL,'scada','2026-07-22 02:35:34',4,1),(27,'2.7.5.3.2','AddFullScreenToUser','JDBC','org.scada_lts.dao.migration.mysql.V2_7_5_3_2__AddFullScreenToUser',NULL,'scada','2026-07-22 02:35:34',47,1),(28,'2.7.5.4.1','UpdateAbsoluteToRelativeUrlInLinkComponent','JDBC','org.scada_lts.dao.migration.mysql.V2_7_5_4_1__UpdateAbsoluteToRelativeUrlInLinkComponent',NULL,'scada','2026-07-22 02:35:34',1,1),(29,'2.7.6.1','ChangeLengthLimitForSettingName','JDBC','org.scada_lts.dao.migration.mysql.V2_7_6_1__ChangeLengthLimitForSettingName',NULL,'scada','2026-07-22 02:35:34',24,1),(30,'2.7.7.1','SqlDataSourceLimit','JDBC','org.scada_lts.dao.migration.mysql.V2_7_7_1__SqlDataSourceLimit',NULL,'scada','2026-07-22 02:35:34',1,1);
/*!40000 ALTER TABLE `schema_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `scripts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `xid` varchar(50) NOT NULL,
  `name` varchar(40) NOT NULL,
  `script` varchar(16384) NOT NULL,
  `data` longblob NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `scriptsUn1` (`xid`),
  KEY `scriptsFk1` (`userId`),
  CONSTRAINT `scriptsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `synopticPanels`
--

DROP TABLE IF EXISTS `synopticPanels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `synopticPanels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `vectorImage` text DEFAULT NULL,
  `componentData` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `synopticPanels`
--

LOCK TABLES `synopticPanels` WRITE;
/*!40000 ALTER TABLE `synopticPanels` DISABLE KEYS */;
/*!40000 ALTER TABLE `synopticPanels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemSettings`
--

DROP TABLE IF EXISTS `systemSettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `systemSettings` (
  `settingName` varchar(255) NOT NULL,
  `settingValue` longtext DEFAULT NULL,
  PRIMARY KEY (`settingName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemSettings`
--

LOCK TABLES `systemSettings` WRITE;
/*!40000 ALTER TABLE `systemSettings` DISABLE KEYS */;
INSERT INTO `systemSettings` VALUES ('servletContextPath','');
/*!40000 ALTER TABLE `systemSettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatesDetectors`
--

DROP TABLE IF EXISTS `templatesDetectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `templatesDetectors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `detectorType` int(11) NOT NULL,
  `alarmLevel` int(11) NOT NULL,
  `stateLimit` float DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `durationType` int(11) DEFAULT NULL,
  `binaryState` char(1) DEFAULT NULL,
  `multistateState` int(11) DEFAULT NULL,
  `changeCount` int(11) DEFAULT NULL,
  `alphanumericState` varchar(128) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `threshold` double DEFAULT NULL,
  `eventDetectorTemplateId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatesDetectorsFk1` (`eventDetectorTemplateId`),
  CONSTRAINT `templatesDetectorsFk1` FOREIGN KEY (`eventDetectorTemplateId`) REFERENCES `eventDetectorTemplates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatesDetectors`
--

LOCK TABLES `templatesDetectors` WRITE;
/*!40000 ALTER TABLE `templatesDetectors` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatesDetectors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userComments`
--

DROP TABLE IF EXISTS `userComments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `userComments` (
  `userId` int(11) DEFAULT NULL,
  `commentType` int(11) NOT NULL,
  `typeKey` int(11) NOT NULL,
  `ts` bigint(20) NOT NULL,
  `commentText` varchar(1024) NOT NULL,
  KEY `userCommentsFk1` (`userId`),
  CONSTRAINT `userCommentsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userComments`
--

LOCK TABLES `userComments` WRITE;
/*!40000 ALTER TABLE `userComments` DISABLE KEYS */;
/*!40000 ALTER TABLE `userComments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userEvents`
--

DROP TABLE IF EXISTS `userEvents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `userEvents` (
  `eventId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `silenced` char(1) NOT NULL,
  PRIMARY KEY (`eventId`,`userId`),
  KEY `userEventsFk2` (`userId`),
  CONSTRAINT `userEventsFk1` FOREIGN KEY (`eventId`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userEventsFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userEvents`
--

LOCK TABLES `userEvents` WRITE;
/*!40000 ALTER TABLE `userEvents` DISABLE KEYS */;
INSERT INTO `userEvents` VALUES (1,4,'N'),(2,4,'N'),(3,4,'N'),(4,4,'N'),(5,4,'N');
/*!40000 ALTER TABLE `userEvents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `admin` char(1) NOT NULL,
  `disabled` char(1) NOT NULL,
  `lastLogin` bigint(20) DEFAULT NULL,
  `selectedWatchList` int(11) DEFAULT NULL,
  `homeUrl` varchar(255) DEFAULT NULL,
  `receiveAlarmEmails` int(11) NOT NULL,
  `receiveOwnAuditEvents` char(1) NOT NULL,
  `hideMenu` tinyint(1) DEFAULT 0,
  `theme` varchar(255) DEFAULT 'DEFAULT',
  `firstName` varchar(255) DEFAULT '',
  `lastName` varchar(255) DEFAULT '',
  `lang` varchar(10) DEFAULT 'en',
  `enableFullScreen` tinyint(1) DEFAULT 0,
  `hideShortcutDisableFullScreen` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'admin','0DPiKuNIrrVmD8IUCuw1hQxNqZc=','admin@example.com','','Y','N',1784728444802,NULL,'/views.shtm#',0,'0',0,'DEFAULT','','','en',0,0),(5,'anonymous-user','CpL6syMBNMym6t2YmDJbmyrmeZg=','anonymous@mail.com','','N','Y',NULL,NULL,'',0,'N',0,'DEFAULT','','','en',0,0),(6,'soap-services','2SkKRrabStlFmaoIfVmqeJ17zIs=','soap-services@mail.com','','N','Y',NULL,NULL,'',0,'N',0,'DEFAULT','','','en',0,0),(7,'httpds-basic','hZvP2jlFXX95l2MGyfpJEBQwc3U=','null@null.com','','N','Y',NULL,NULL,'',0,'N',0,'DEFAULT','','','en',0,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usersProfiles`
--

DROP TABLE IF EXISTS `usersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usersProfiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usersProfilesUn1` (`xid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usersProfiles`
--

LOCK TABLES `usersProfiles` WRITE;
/*!40000 ALTER TABLE `usersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `usersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usersUsersProfiles`
--

DROP TABLE IF EXISTS `usersUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usersUsersProfiles` (
  `userProfileId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  KEY `usersUsersProfilesFk1` (`userProfileId`),
  KEY `usersUsersProfilesFk2` (`userId`),
  CONSTRAINT `usersUsersProfilesFk1` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usersUsersProfilesFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usersUsersProfiles`
--

LOCK TABLES `usersUsersProfiles` WRITE;
/*!40000 ALTER TABLE `usersUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `usersUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `values_multi_changes_history`
--

DROP TABLE IF EXISTS `values_multi_changes_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `values_multi_changes_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `multiChangesHistoryId` int(11) DEFAULT NULL,
  `valueId` bigint(20) DEFAULT NULL,
  `value` varchar(50) NOT NULL,
  `dataPointId` int(11) DEFAULT NULL,
  `ts` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_multiChangesHistoryId` (`multiChangesHistoryId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `values_multi_changes_history`
--

LOCK TABLES `values_multi_changes_history` WRITE;
/*!40000 ALTER TABLE `values_multi_changes_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `values_multi_changes_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viewUsersProfiles`
--

DROP TABLE IF EXISTS `viewUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `viewUsersProfiles` (
  `viewId` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  `permission` int(11) NOT NULL,
  KEY `viewUsersProfilesFk1` (`viewId`),
  KEY `viewUsersProfilesFk2` (`userProfileId`),
  CONSTRAINT `viewUsersProfilesFk1` FOREIGN KEY (`viewId`) REFERENCES `mangoViews` (`id`) ON DELETE CASCADE,
  CONSTRAINT `viewUsersProfilesFk2` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viewUsersProfiles`
--

LOCK TABLES `viewUsersProfiles` WRITE;
/*!40000 ALTER TABLE `viewUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `viewUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `views_category_views_hierarchy`
--

DROP TABLE IF EXISTS `views_category_views_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `views_category_views_hierarchy` (
  `view_id` int(11) NOT NULL,
  `folder_views_hierarchy_id` int(11) NOT NULL,
  PRIMARY KEY (`view_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `views_category_views_hierarchy`
--

LOCK TABLES `views_category_views_hierarchy` WRITE;
/*!40000 ALTER TABLE `views_category_views_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `views_category_views_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchListPoints`
--

DROP TABLE IF EXISTS `watchListPoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `watchListPoints` (
  `watchListId` int(11) NOT NULL,
  `dataPointId` int(11) NOT NULL,
  `sortOrder` int(11) NOT NULL,
  KEY `watchListPointsFk1` (`watchListId`),
  KEY `watchListPointsFk2` (`dataPointId`),
  CONSTRAINT `watchListPointsFk1` FOREIGN KEY (`watchListId`) REFERENCES `watchLists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `watchListPointsFk2` FOREIGN KEY (`dataPointId`) REFERENCES `dataPoints` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchListPoints`
--

LOCK TABLES `watchListPoints` WRITE;
/*!40000 ALTER TABLE `watchListPoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchListPoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchListUsers`
--

DROP TABLE IF EXISTS `watchListUsers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `watchListUsers` (
  `watchListId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `accessType` int(11) NOT NULL,
  PRIMARY KEY (`watchListId`,`userId`),
  KEY `watchListUsersFk2` (`userId`),
  CONSTRAINT `watchListUsersFk1` FOREIGN KEY (`watchListId`) REFERENCES `watchLists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `watchListUsersFk2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchListUsers`
--

LOCK TABLES `watchListUsers` WRITE;
/*!40000 ALTER TABLE `watchListUsers` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchListUsers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchListUsersProfiles`
--

DROP TABLE IF EXISTS `watchListUsersProfiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `watchListUsersProfiles` (
  `watchlistId` int(11) NOT NULL,
  `userProfileId` int(11) NOT NULL,
  `permission` int(11) NOT NULL,
  KEY `watchListUsersProfilesFk1` (`watchlistId`),
  KEY `watchListUsersProfilesFk2` (`userProfileId`),
  CONSTRAINT `watchListUsersProfilesFk1` FOREIGN KEY (`watchlistId`) REFERENCES `watchLists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `watchListUsersProfilesFk2` FOREIGN KEY (`userProfileId`) REFERENCES `usersProfiles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchListUsersProfiles`
--

LOCK TABLES `watchListUsersProfiles` WRITE;
/*!40000 ALTER TABLE `watchListUsersProfiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchListUsersProfiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchLists`
--

DROP TABLE IF EXISTS `watchLists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `watchLists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `xid` varchar(50) NOT NULL,
  `userId` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `watchListsUn1` (`xid`),
  KEY `watchListsFk1` (`userId`),
  CONSTRAINT `watchListsFk1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchLists`
--

LOCK TABLES `watchLists` WRITE;
/*!40000 ALTER TABLE `watchLists` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchLists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `historyAlarms`
--

/*!50001 DROP VIEW IF EXISTS `historyAlarms`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scada`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `historyAlarms` AS select `func_fromats_date`(`plcAlarms`.`activeTime`) AS `activeTime`,`func_fromats_date`(`plcAlarms`.`inactiveTime`) AS `inactiveTime`,`func_fromats_date`(`plcAlarms`.`acknowledgeTime`) AS `acknowledgeTime`,`plcAlarms`.`level` AS `level`,`plcAlarms`.`dataPointName` AS `name` from `plcAlarms` order by `plcAlarms`.`inactiveTime` = 0 desc,`func_fromats_date`(`plcAlarms`.`inactiveTime`) desc,`plcAlarms`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `liveAlarms`
--

/*!50001 DROP VIEW IF EXISTS `liveAlarms`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`scada`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `liveAlarms` AS select `plcAlarms`.`id` AS `id`,`func_fromats_date`(`plcAlarms`.`activeTime`) AS `activation-time`,`func_fromats_date`(`plcAlarms`.`inactiveTime`) AS `inactivation-time`,`plcAlarms`.`dataPointType` AS `level`,`plcAlarms`.`dataPointName` AS `name`,`plcAlarms`.`dataPointId` AS `dataPointId` from `plcAlarms` where `plcAlarms`.`acknowledgeTime` = 0 and (`plcAlarms`.`inactiveTime` = 0 or `plcAlarms`.`inactiveTime` > unix_timestamp(current_timestamp() - interval 24 hour) * 1000) order by `plcAlarms`.`inactiveTime` = 0 desc,`plcAlarms`.`activeTime` desc,`plcAlarms`.`inactiveTime` desc,`plcAlarms`.`id` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-22 14:00:17
