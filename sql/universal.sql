
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for q4u
-- ----------------------------
DROP TABLE IF EXISTS `q4u`;
CREATE TABLE `q4u` (
  `vn` varchar(20) DEFAULT NULL,
  `hn` varchar(20) DEFAULT NULL,
  `date_serv` date DEFAULT NULL,
  `time_serv` time DEFAULT NULL,
  `clinic_code` varchar(10) DEFAULT NULL,
  `clinic_name` varchar(50) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `first_name` varchar(150) DEFAULT NULL,
  `last_name` varchar(150) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `his_queue` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of q4u
-- ----------------------------
BEGIN;
INSERT INTO `q4u` VALUES ('9999999999999', '0000000', '2020-01-01', '10:51:33', '014', 'ห้องตรวจโรค', 'นาง', 'สะมัย', 'เสมอ', '2020-01-01', '2', NULL);
COMMIT;

-- ----------------------------
-- Table structure for q4u_patient
-- ----------------------------
DROP TABLE IF EXISTS `q4u_patient`;
CREATE TABLE `q4u_patient` (
  `cid` varchar(20) DEFAULT NULL,
  `hn` varchar(20) DEFAULT NULL,
  `first_name` varchar(150) DEFAULT NULL,
  `last_name` varchar(150) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `birthdate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of q4u_patient
-- ----------------------------
BEGIN;
INSERT INTO `q4u_patient` VALUES ('99999999999999', '0000000', 'สะมัย', 'เสมอ', 'นาง', '2', '2020-01-01');
COMMIT;
SET FOREIGN_KEY_CHECKS = 1;
