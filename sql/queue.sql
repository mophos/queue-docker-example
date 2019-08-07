/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3307
 Source Server Type    : MySQL
 Source Server Version : 100313
 Source Host           : localhost:3307
 Source Schema         : queue

 Target Server Type    : MySQL
 Target Server Version : 100313
 File Encoding         : 65001

 Date: 17/04/2019 21:17:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for q4u_departments
-- ----------------------------
DROP TABLE IF EXISTS `q4u_departments`;
CREATE TABLE `q4u_departments` (
  `department_id` int(6) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of q4u_departments
-- ----------------------------
BEGIN;
INSERT INTO `q4u_departments` VALUES (1, 'ศัลยกรรม');
INSERT INTO `q4u_departments` VALUES (2, 'สูติกรรม นรีเวช');
INSERT INTO `q4u_departments` VALUES (3, 'ทันตกรรม');
INSERT INTO `q4u_departments` VALUES (4, 'กายภาพบำบัด');
INSERT INTO `q4u_departments` VALUES (5, 'แพทย์แผนไทย');
INSERT INTO `q4u_departments` VALUES (6, 'คลินิคโรคเรื้อรัง');
INSERT INTO `q4u_departments` VALUES (7, 'เวชกรรมชุมชน');
INSERT INTO `q4u_departments` VALUES (8, 'ตรวจโรคทั่วไป');
COMMIT;

-- ----------------------------
-- Table structure for q4u_person
-- ----------------------------
DROP TABLE IF EXISTS `q4u_person`;
CREATE TABLE `q4u_person` (
  `hn` varchar(15) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `remark` text DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sex` char(1) DEFAULT NULL,
  PRIMARY KEY (`hn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for q4u_priorities
-- ----------------------------
DROP TABLE IF EXISTS `q4u_priorities`;
CREATE TABLE `q4u_priorities` (
  `priority_id` int(3) NOT NULL AUTO_INCREMENT,
  `priority_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `priority_prefix` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `priority_color` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `priority_order` int(11) DEFAULT '1',
  PRIMARY KEY (`priority_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of q4u_priorities
-- ----------------------------
BEGIN;
INSERT INTO `q4u_priorities` VALUES (1, 'ปกติ', '1', NULL,1);
INSERT INTO `q4u_priorities` VALUES (2, 'URGENT', 'O', NULL,2);
INSERT INTO `q4u_priorities` VALUES (3, 'EMERGENCY', '3', NULL,3);
INSERT INTO `q4u_priorities` VALUES (4, 'VIP', '4', NULL,4);
INSERT INTO `q4u_priorities` VALUES (5, '70 ปีขึ้นไป', '5', NULL,5);
INSERT INTO `q4u_priorities` VALUES (6, 'ผู้นำศาสนา พระ', '6', NULL,6);
INSERT INTO `q4u_priorities` VALUES (7, 'รถนั่ง-รถนอน', '7', NULL,7);
INSERT INTO `q4u_priorities` VALUES (8, 'เจ้าหน้าที่', '8', NULL,8);
COMMIT;

-- ----------------------------
-- Table structure for q4u_provider_types
-- ----------------------------
DROP TABLE IF EXISTS `q4u_provider_types`;
CREATE TABLE `q4u_provider_types` (
  `provider_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_type_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT 'รหัสประเภทผู้ให้บริการ',
  PRIMARY KEY (`provider_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for q4u_queue
-- ----------------------------
DROP TABLE IF EXISTS `q4u_queue`;
CREATE TABLE `q4u_queue` (
  `queue_id` int(12) NOT NULL AUTO_INCREMENT,
  `hn` varchar(15) NOT NULL,
  `vn` varchar(16) NOT NULL,
  `service_point_id` int(3) NOT NULL,
  `priority_id` int(3) DEFAULT NULL,
  `room_id` int(2) DEFAULT NULL COMMENT 'ช่องบริการ',
  `date_serv` date NOT NULL COMMENT 'วันที่รับบริการ',
  `time_serv` time DEFAULT NULL,
  `queue_number` varchar(10) NOT NULL COMMENT 'หมายเลขQ',
  `queue_running` int(6) DEFAULT 0,
  `his_queue` varchar(6) DEFAULT NULL COMMENT 'หมายเลขQ(Hosxp)',
  `queue_status_id` int(1) DEFAULT NULL COMMENT 'สถานะQ',
  `mark_pending` enum('N','Y') DEFAULT 'N' COMMENT 'N=Not pending Y=pending',
  `remark` text DEFAULT NULL COMMENT 'หมายเหตุรับบริการ',
  `date_create` datetime NOT NULL COMMENT 'เวลาสร้างQ',
  `date_update` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'เวลาปรับปรุ่งQ',
  `pending_to_service_point_id` int(3) DEFAULT NULL COMMENT 'แผนกที่ถูกส่งคิวต่อ',
  `is_interview` char(1) DEFAULT 'N',
  `is_completed` char(1) DEFAULT 'N',
  `queue_interview` int(11) DEFAULT NULL COMMENT 'ลำดับคิวในการซักประวัติ',
  `is_cancel` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`queue_id`) USING BTREE,
  UNIQUE KEY `q4u_queue_un` (`queue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for q4u_queue_detail
-- ----------------------------
DROP TABLE IF EXISTS `q4u_queue_detail`;
CREATE TABLE `q4u_queue_detail` (
  `service_point_id` int(3) NOT NULL,
  `date_serv` date NOT NULL,
  `last_queue` int(11) DEFAULT NULL,
  `room_id` int(3) NOT NULL,
  `queue_id` int(11) DEFAULT NULL,
  `update_date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`service_point_id`,`date_serv`,`room_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for q4u_queue_group_detail
-- ----------------------------
DROP TABLE IF EXISTS `q4u_queue_group_detail`;
CREATE TABLE `q4u_queue_group_detail` (
  `service_point_id` int(3) NOT NULL,
  `date_serv` date NOT NULL,
  `last_queue` int(11) DEFAULT NULL,
  `room_id` int(3) NOT NULL,
  `queue_id` int(11) NOT NULL,
  `update_date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `queue_running` int(6) NOT NULL,
  PRIMARY KEY (`service_point_id`,`date_serv`,`room_id`,`queue_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for q4u_queue_number
-- ----------------------------
DROP TABLE IF EXISTS `q4u_queue_number`;
CREATE TABLE `q4u_queue_number` (
  `service_point_id` int(3) NOT NULL,
  `date_serv` date NOT NULL,
  `current_queue` int(11) DEFAULT 0,
  `update_date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `priority_id` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for q4u_queue_status
-- ----------------------------
DROP TABLE IF EXISTS `q4u_queue_status`;
CREATE TABLE `q4u_queue_status` (
  `queue_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `queue_status_name` varchar(20) DEFAULT NULL,
  `queue_status_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`queue_status_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of q4u_queue_status
-- ----------------------------
BEGIN;
INSERT INTO `q4u_queue_status` VALUES (1, 'waiting', 'รอตรวจ');
INSERT INTO `q4u_queue_status` VALUES (2, 'cancel', 'ยกเลิการให้บริการ');
INSERT INTO `q4u_queue_status` VALUES (3, 'skip', 'ข้าม(เรียกแล้วไม่มา)');
INSERT INTO `q4u_queue_status` VALUES (4, 'transfer', 'ส่งตรวจต่อ');
INSERT INTO `q4u_queue_status` VALUES (5, 'consult', 'รอกลับมาตรวจให้(เช่นส่ง lab)');
INSERT INTO `q4u_queue_status` VALUES (9, 'serviced', 'ให้บริการเรียบร้อย');
COMMIT;

-- ----------------------------
-- Table structure for q4u_service_point_prefix
-- ----------------------------
DROP TABLE IF EXISTS `q4u_service_point_prefix`;
CREATE TABLE `q4u_service_point_prefix` (
  `service_point_id` int(3) NOT NULL COMMENT 'รหัสจุดบริการ',
  `prefix` char(1) NOT NULL COMMENT 'อักษรย่อ(แต่ละแผนก)',
  `service_point_status_id` int(3) DEFAULT 1 COMMENT '0=ไม่ใช้งาน 1=ใช้าน ',
  PRIMARY KEY (`service_point_id`,`prefix`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of q4u_service_point_prefix
-- ----------------------------
BEGIN;
INSERT INTO `q4u_service_point_prefix` VALUES (1, 'A', 1);
INSERT INTO `q4u_service_point_prefix` VALUES (2, 'B', 1);
INSERT INTO `q4u_service_point_prefix` VALUES (3, 'C', 1);
INSERT INTO `q4u_service_point_prefix` VALUES (4, 'D', 1);
COMMIT;

-- ----------------------------
-- Table structure for q4u_service_points
-- ----------------------------
DROP TABLE IF EXISTS `q4u_service_points`;
CREATE TABLE `q4u_service_points` (
  `service_point_id` int(3) NOT NULL AUTO_INCREMENT,
  `service_point_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'ชื่อจุดบริการ',
  `service_point_abbr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'ชื่อย่อจุดบริการ',
  `local_code` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'รหัสที่ใช้ภายในสถานพยาบาล',
  `standard43_code` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'รหัส clinic ตามมาตรฐาน 43 แฟ้ม',
  `service_point_type_id` int(3) DEFAULT NULL COMMENT 'รหัสประเภทจุดบริการ',
  `topic` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'publisher ของ mqtt (กรณี h4udb hdc+topic_h4u)',
  `prefix` char(1) DEFAULT NULL,
  `department_id` int(3) DEFAULT NULL COMMENT 'แผนก',
  `kios` char(1) DEFAULT 'N',
  `use_old_queue` enum('Y','N') DEFAULT 'N',
  `group_compare` enum('Y','N') DEFAULT 'N' COMMENT 'เชื่อมคิวกลุ่มกับตารางคิว Y=แก้ไขตารางคิว N=ไม่แก้ไขตารางคิว',
  `priority_queue_running` enum('Y','N') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'N' COMMENT 'ออกเลขคิวตามประเภทผู้ป่วย',
  `sound_id` int(11) DEFAULT NULL COMMENT 'รหัสเสียงเรียก',
  `sound_speed` decimal(3,2) DEFAULT NULL COMMENT 'ความเร็วเสียงเรียก',
  PRIMARY KEY (`service_point_id`),
  UNIQUE KEY `service_point_un_point_name` (`service_point_name`),
  UNIQUE KEY `idx_topic` (`topic`),
  UNIQUE KEY `idx_prefix` (`prefix`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of q4u_service_points
-- ----------------------------
BEGIN;
INSERT INTO `q4u_service_points` VALUES (1, 'แผนกทันตกรรม', 'DENT', '40100', NULL, NULL, '8525716030', '1', 3, 'Y', 'N', 'N', 'N', NULL, NULL);
INSERT INTO `q4u_service_points` VALUES (2, 'เวชปฏิบัติทั่วไป', 'HHC', '10100', NULL, NULL, '1966378946', '2', 7, 'Y', 'N', 'N', 'N', NULL, NULL);
INSERT INTO `q4u_service_points` VALUES (3, 'กายภาพบำบัด', 'TMM', '041', NULL, NULL, '1377780021', 'E', 4, 'Y', 'Y', 'N', 'Y', NULL, NULL);
INSERT INTO `q4u_service_points` VALUES (4, 'แพทย์แผนไทย', 'TMT', 'E0100', NULL, NULL, '6945080335', '4', NULL, 'N', 'N', 'N', 'N', NULL, NULL);
INSERT INTO `q4u_service_points` VALUES (6, 'ตรวจโรคทั่วไป', 'OPD', '014', NULL, NULL, '5229659326', 'M', 8, 'Y', 'N', 'N', 'Y', 1, NULL);
INSERT INTO `q4u_service_points` VALUES (7, 'ทันตกรรม', 'DENT', '005', NULL, NULL, '5262672696', 'D', 3, 'Y', 'Y', 'N', 'N', NULL, NULL);
INSERT INTO `q4u_service_points` VALUES (9, 'ห้อง LAB', NULL, '007', NULL, NULL, '6097994418', 'L', 8, 'Y', 'Y', 'N', 'N', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for q4u_service_rooms
-- ----------------------------
DROP TABLE IF EXISTS `q4u_service_rooms`;
CREATE TABLE `q4u_service_rooms` (
  `service_point_id` int(3) NOT NULL COMMENT 'รหัสจุดบริการ',
  `room_number` int(2) NOT NULL COMMENT 'หมายเลขห้องตรวจ',
  `room_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'ชื่อห้องตรวจ',
  `room_id` int(6) NOT NULL AUTO_INCREMENT,
  `sound_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`room_id`) USING BTREE,
  UNIQUE KEY `service_rooms_un` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of q4u_service_rooms
-- ----------------------------
BEGIN;
INSERT INTO `q4u_service_rooms` VALUES (1, 1, 'ทันตกรรมพิเศษ 1', 2,NULL);
INSERT INTO `q4u_service_rooms` VALUES (1, 2, 'ทันตกรรมพิเศษ 2', 4,NULL);
INSERT INTO `q4u_service_rooms` VALUES (1, 3, 'ทันตกรรมนอกเวลา', 5,NULL);
INSERT INTO `q4u_service_rooms` VALUES (2, 1, 'ห้องตรวจเด็ก 1', 6,NULL);
INSERT INTO `q4u_service_rooms` VALUES (2, 2, 'ห้องตรวจเด็ก 2', 7,NULL);
INSERT INTO `q4u_service_rooms` VALUES (2, 3, 'ห้องตรวจเด็ก 3', 8,NULL);
INSERT INTO `q4u_service_rooms` VALUES (3, 1, 'ห้องตรวจ 1', 16,NULL);
INSERT INTO `q4u_service_rooms` VALUES (3, 2, 'ห้องตรวจ 2', 17,NULL);
INSERT INTO `q4u_service_rooms` VALUES (4, 1, 'แผนไทย 1', 11,NULL);
INSERT INTO `q4u_service_rooms` VALUES (4, 2, 'แผนไทยนอกเวลา', 15,NULL);
INSERT INTO `q4u_service_rooms` VALUES (5, 1, 'ห้องตรวจโรค 1 ', 13,NULL);
INSERT INTO `q4u_service_rooms` VALUES (6, 1, 'ห้องตรวจ 1', 18,NULL);
INSERT INTO `q4u_service_rooms` VALUES (6, 2, 'ห้องตรวจโรค 2', 14,NULL);
INSERT INTO `q4u_service_rooms` VALUES (6, 3, 'ห้องตรวจ 3', 19,NULL);
INSERT INTO `q4u_service_rooms` VALUES (7, 1, 'ทันตกรรมทั่วไป', 20,NULL);
INSERT INTO `q4u_service_rooms` VALUES (7, 2, 'ทันกรรมนอกเวลา', 21,NULL);
INSERT INTO `q4u_service_rooms` VALUES (8, 2, 'xxx', 22,NULL);
COMMIT;

-- ----------------------------
-- Table structure for q4u_sounds
-- ----------------------------
DROP TABLE IF EXISTS `q4u_sounds`;
CREATE TABLE `q4u_sounds` (
  `sound_id` int(11) NOT NULL AUTO_INCREMENT,
  `sound_name` varchar(255) DEFAULT NULL,
  `sound_file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sound_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of q4u_sounds
-- ----------------------------
BEGIN;
INSERT INTO `q4u_sounds` VALUES (1, ' ที่ช่องบริการ', 'channel.mp3');
INSERT INTO `q4u_sounds` VALUES (2, 'ที่โต๊ะคัดกรอง', 'screen-table.mp3');
INSERT INTO `q4u_sounds` VALUES (3, 'ที่จุดคัดกรอง', 'screen-point.mp3');
INSERT INTO `q4u_sounds` VALUES (4, 'ที่จุดซักประวัติ', 'interview-point.mp3');
INSERT INTO `q4u_sounds` VALUES (5, 'ที่โต๊ะซักประวัติ', 'interview-table.mp3');
INSERT INTO `q4u_sounds` VALUES (6, 'ที่ช่องการเงิน', 'cashier.mp3');
INSERT INTO `q4u_sounds` VALUES (7, 'ที่ช่องจ่ายเงิน', 'pay-cashier.mp3');
INSERT INTO `q4u_sounds` VALUES (8, 'ที่ห้องจ่ายยา', 'pay-drug.mp3');
INSERT INTO `q4u_sounds` VALUES (9, 'ที่ห้องรับยา', 'receive-drug.mp3');
INSERT INTO `q4u_sounds` VALUES (10, 'ที่โต๊ะ', 'table.mp3');
INSERT INTO `q4u_sounds` VALUES (11, 'ที่เคาเตอร์', 'couter.mp3');
INSERT INTO `q4u_sounds` VALUES (12, 'ที่ห้องตรวจ', 'doctor_room.mp3');
COMMIT;

-- ----------------------------
-- Table structure for q4u_system
-- ----------------------------
DROP TABLE IF EXISTS `q4u_system`;
CREATE TABLE `q4u_system` (
  `hoscode` varchar(50) NOT NULL,
  `hosname` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`hoscode`),
  UNIQUE KEY `idx_hoscode` (`hoscode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of q4u_system
-- ----------------------------
BEGIN;
INSERT INTO `q4u_system` VALUES ('11053', 'โรงพยาบาลกันทรวิชัย');
COMMIT;

-- ----------------------------
-- Table structure for q4u_tokens
-- ----------------------------
DROP TABLE IF EXISTS `q4u_tokens`;
CREATE TABLE `q4u_tokens` (
  `token` text DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `expired_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for q4u_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `q4u_user_roles`;
CREATE TABLE `q4u_user_roles` (
  `user_id` int(11) NOT NULL,
  `service_point_id` int(4) NOT NULL,
  `is_active` int(1) DEFAULT 1 COMMENT '0=ยกเลิก 1=ใช้งาน',
  PRIMARY KEY (`user_id`,`service_point_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for q4u_user_service_points
-- ----------------------------
DROP TABLE IF EXISTS `q4u_user_service_points`;
CREATE TABLE `q4u_user_service_points` (
  `user_service_point_id` int(6) NOT NULL AUTO_INCREMENT,
  `user_id` int(3) NOT NULL,
  `service_point_id` int(3) NOT NULL,
  PRIMARY KEY (`user_id`,`service_point_id`),
  UNIQUE KEY `use_service_point_id` (`user_service_point_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of q4u_user_service_points
-- ----------------------------
BEGIN;
INSERT INTO `q4u_user_service_points` VALUES (22, 2, 2);
INSERT INTO `q4u_user_service_points` VALUES (23, 2, 1);
INSERT INTO `q4u_user_service_points` VALUES (24, 2, 9);
INSERT INTO `q4u_user_service_points` VALUES (25, 2, 6);
INSERT INTO `q4u_user_service_points` VALUES (26, 1, 8);
INSERT INTO `q4u_user_service_points` VALUES (27, 1, 3);
INSERT INTO `q4u_user_service_points` VALUES (28, 1, 6);
INSERT INTO `q4u_user_service_points` VALUES (29, 1, 7);
INSERT INTO `q4u_user_service_points` VALUES (30, 1, 2);
INSERT INTO `q4u_user_service_points` VALUES (31, 1, 1);
INSERT INTO `q4u_user_service_points` VALUES (32, 1, 4);
INSERT INTO `q4u_user_service_points` VALUES (33, 1, 9);
COMMIT;

-- ----------------------------
-- Table structure for q4u_users
-- ----------------------------
DROP TABLE IF EXISTS `q4u_users`;
CREATE TABLE `q4u_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(256) DEFAULT NULL,
  `is_active` char(1) DEFAULT 'Y',
  `user_type` enum('ADMIN','MEMBER','KIOSK') DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `idx_username` (`username`),
  KEY `idx_password` (`password`),
  KEY `idx_is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of q4u_users
-- ----------------------------
BEGIN;
INSERT INTO `q4u_users` VALUES (1, 'สถิตย์ เรียนพิศ', 'satit', 'e10adc3949ba59abbe56e057f20f883e', 'Y', 'ADMIN');
INSERT INTO `q4u_users` VALUES (2, 'พิชญาภา เรียนพิศ', 'nurse', 'e10adc3949ba59abbe56e057f20f883e', 'Y', 'MEMBER');
INSERT INTO `q4u_users` VALUES (3, 'kiosk', 'kiosk', 'e10adc3949ba59abbe56e057f20f883e', 'Y', 'KIOSK');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
