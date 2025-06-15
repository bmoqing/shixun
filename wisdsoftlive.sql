/*
 Navicat Premium Data Transfer

 Source Server         : 淼哥服务器
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : 123.57.209.8:3306
 Source Schema         : wisdsoftlive

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 14/01/2021 19:47:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码 ',
  `mail` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `user_id` int(11) NOT NULL COMMENT 'user表学号外键，外键可以为空',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of account
-- ----------------------------

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, '123', '123', NULL, NULL);

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'banner名称',
  `img` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'banner路径',
  `type` int(2) NULL DEFAULT NULL COMMENT '是否启用，1：启用，0：禁用',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES (2, 'e213123', '/images/b5820e6b-673a-4213-ae8e-d82eb9349175.jpg', 1, NULL, NULL);
INSERT INTO `banner` VALUES (4, '饿23123', '/images/d8e80493-12ce-4ccb-b3f5-b5fc9061a7fa.jpg', 0, NULL, NULL);
INSERT INTO `banner` VALUES (5, '344rwe', '/images/f58ad4a5-7d69-46d0-ac2f-ddf28c47cd62.jpg', 0, NULL, NULL);

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程名称',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程介绍',
  `type` int(1) NOT NULL COMMENT '是否收费，0：免费，1：收费',
  `status` int(2) NULL DEFAULT NULL COMMENT '是否为直播课已发布状态: 0: 未发布, 1: 发布',
  `old_money` decimal(10, 2) NOT NULL COMMENT '折前价格',
  `in_money` decimal(10, 2) NOT NULL COMMENT '校内收费金额，免费为0',
  `out_money` decimal(10, 2) NOT NULL COMMENT '校外收费金额，免费为0(折扣价)',
  `section_number` int(11) NULL DEFAULT NULL COMMENT '课程节数',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'ssm', 'ssm框架', 1, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (4, 'ssm1', 'ssm框架', 1, 1, 52200.00, 25.20, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (6, 'ssm2', 'ssm框架奥术大师多爱江山大富科技拉萨的会计法律框架撒谎付款计划', 1, 1, 100.00, 200.00, 300.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (8, 'ssm3', 'ssm框架', 0, 1, 100.00, 200.00, 300.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (10, 'ssm5', 'ssm框架', 0, 1, 100.00, 200.00, 300.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (12, 'ssm7', 'ssm框架2', 1, 1, 100.00, 200.00, 300.00, 12, NULL, NULL);
INSERT INTO `course` VALUES (13, 'ssm8', 'ssm框架', 0, 1, 100.00, 200.00, 300.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (14, 'ssm9', 'ssm框架', 0, 1, 100.00, 200.00, 300.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (18, 'ajax', 'ajax', 0, 1, 200.00, 100.00, 150.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (19, 'jquery', 'jquery', 1, 1, 123.00, 456.00, 789.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (30, '这些橙V', '阿斯蒂芬', 0, 1, 200.00, 369.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (31, '大师傅', '阿斯蒂芬', 1, 1, 120.00, 120.00, 123.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (32, 'jklasd ', 'asdkhfkj', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (33, '我擦嘞', '我擦嘞', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (34, '线程VB', '初步形成', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (35, '阿斯蒂芬森岛帆高', '线程VB', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (36, '家属看到了', '请勿诶人', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (37, '自行车女模', '奥德赛', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (38, '在哪下车vkl', '就当是', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (39, '阿斯蒂芬', '这些橙V', 1, 1, 369.00, 27999.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (41, '这些橙V去啊啊啊', 'asd', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (43, 'ssa', 'sdg', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (44, 'qws', 'dfg', 0, 0, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (45, '测试', '测试', 1, 1, 230.00, 456.00, 789.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (46, 'linux', 'linux基础linux基础linux基础linux基础linux基础linux基础linux基础', 1, 1, 123.00, 456.00, 789.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (47, '刷新测试', '刷新测试', 1, 1, 200.00, 100.00, 150.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (48, '线程AA', '线程AA', 0, 1, 0.00, 0.00, 0.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (49, 'redis精品课程', '此课程讲解redis高级部分', 1, 1, 6999.00, 4950.00, 5500.00, NULL, NULL, NULL);
INSERT INTO `course` VALUES (50, 'maven精品', 'maven精品课程', 0, 1, 0.00, 0.00, 0.00, 14, NULL, NULL);

-- ----------------------------
-- Table structure for detailmoney
-- ----------------------------
DROP TABLE IF EXISTS `detailmoney`;
CREATE TABLE `detailmoney`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(1) NOT NULL COMMENT '明细类型，0：支出，1：收入',
  `money` decimal(11, 2) NOT NULL COMMENT '操作金额',
  `time` datetime(6) NOT NULL COMMENT '交易时间',
  `u_id` int(11) NOT NULL COMMENT '用户外键',
  `t_id` int(5) NOT NULL COMMENT '教师外键',
  `c_id` int(5) NOT NULL COMMENT '课程外键',
  `c_type` int(2) NOT NULL COMMENT '课程状态，0：直播，1：视频，2：无关',
  `detail` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作用途',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 84 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of detailmoney
-- ----------------------------
INSERT INTO `detailmoney` VALUES (1, 1, 100.00, '2020-11-21 16:19:03.000000', 1, 0, 1, 0, '购买课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (2, 0, 200.00, '2020-11-13 16:32:24.000000', 0, 1, 8, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (3, 1, 1000.00, '2020-11-19 16:19:03.000000', 1, 0, 4, 0, '购买课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (4, 0, 200.00, '2020-11-07 16:32:24.000000', 0, 2, 12, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (5, 1, 600.00, '2020-11-26 16:19:03.000000', 1, 0, 6, 0, '购买课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (6, 0, 205.00, '2020-11-19 16:32:24.000000', 0, 3, 14, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (7, 1, 60.00, '2020-11-03 16:19:03.000000', 1, 0, 8, 0, '购买课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (8, 0, 99.00, '2021-03-12 16:32:24.000000', 0, 1, 19, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (9, 1, 123.00, '2020-10-07 16:19:03.000000', 1, 0, 1, 1, '购买课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (10, 0, 99.00, '2021-02-04 16:32:24.000000', 0, 2, 8, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (11, 1, 100.00, '2021-01-11 16:19:03.000000', 1, 0, 4, 1, '购买课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (12, 0, 156.00, '2021-03-24 16:32:24.000000', 0, 3, 12, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (13, 1, 34.00, '2020-03-10 16:19:03.000000', 1, 0, 6, 1, '购买课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (14, 0, 49.00, '2020-04-07 16:32:24.000000', 0, 1, 14, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (15, 1, 56.00, '2021-06-24 16:19:03.000000', 1, 0, 8, 1, '购买课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (16, 0, 89.00, '2021-08-20 16:32:24.000000', 0, 2, 19, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (17, 0, 123.00, '2020-12-01 09:27:07.000000', 0, 3, 0, 1, '安慰', NULL, NULL);
INSERT INTO `detailmoney` VALUES (18, 0, 100.00, '2020-12-02 16:46:20.000000', 0, 1, 0, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (19, 0, 50.00, '2020-12-02 17:08:57.000000', 0, 2, 0, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (20, 0, 10.00, '2020-12-02 17:15:55.000000', 0, 3, 0, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (21, 0, 0.00, '2020-12-02 19:08:15.000000', 0, 1, 0, 1, '发工资', NULL, NULL);
INSERT INTO `detailmoney` VALUES (22, 0, 200.00, '2020-12-28 22:39:12.000000', 0, 6, 0, 1, '测试', NULL, NULL);
INSERT INTO `detailmoney` VALUES (23, 0, 2000.00, '2020-12-28 22:43:13.000000', 0, 6, 0, 1, '测试2', NULL, NULL);
INSERT INTO `detailmoney` VALUES (24, 0, 123.00, '2020-12-28 22:43:45.000000', 0, 6, 0, 1, '测试3', NULL, NULL);
INSERT INTO `detailmoney` VALUES (25, 1, 654.00, '2020-12-28 22:45:49.000000', 0, 6, 0, 1, '哈哈', NULL, NULL);
INSERT INTO `detailmoney` VALUES (26, 0, 999.00, '2020-12-28 22:48:50.000000', 0, 6, 0, 1, '999', NULL, NULL);
INSERT INTO `detailmoney` VALUES (27, 0, 888.00, '2020-12-28 22:50:27.000000', 0, 2, 0, 1, '添加测试', NULL, NULL);
INSERT INTO `detailmoney` VALUES (28, 0, 675.00, '2020-12-28 22:55:15.000000', 0, 2, 0, 1, '继续测试', NULL, NULL);
INSERT INTO `detailmoney` VALUES (29, 0, 456.00, '2020-12-28 22:56:43.000000', 0, 3, 0, 1, '还是测试', NULL, NULL);
INSERT INTO `detailmoney` VALUES (30, 1, 7777777.00, '2020-12-28 23:22:48.000000', 0, 3, 0, 1, '777777', NULL, NULL);
INSERT INTO `detailmoney` VALUES (31, 1, 5000.00, '2020-12-31 11:45:58.000000', 0, 6, 0, 2, '外部支援', NULL, NULL);
INSERT INTO `detailmoney` VALUES (36, 1, 4950.00, '2021-01-02 22:30:16.000000', 1, 3, 49, 0, '用户imliuhaoyu@qq.com于2021-01-02 22:30:16花费4950.00元购买了直播课程: redis精品课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (37, 1, 0.00, '2021-01-02 22:30:16.000000', 1, 3, 49, 1, '用户imliuhaoyu@qq.com于2021-01-02 22:30:16花费0.00元购买了视频课程: redis精品课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (38, 1, 4950.10, '2021-01-02 22:31:24.000000', 2, 3, 49, 1, '用户1416322667@qq.com于2021-01-02 22:31:24花费4950.00元购买了视频课程: redis精品课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (42, 1, 4950.00, '2021-01-03 11:54:40.000000', 1, 3, 49, 0, '用户imliuhaoyu@qq.com于2021-01-03 11:54:40支付 ¥4950.00元购买了直播课程: redis精品课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (44, 0, 100.00, '2021-01-03 18:03:23.000000', 0, 1, 0, 2, '发工资 -- 免费课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (45, 0, 100.00, '2021-01-03 18:04:57.000000', 0, 1, 0, 2, '发工资 -- 收费课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (46, 0, 10.00, '2021-01-03 18:06:15.000000', 0, 2, 0, 2, '发工资 -- 免费课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (47, 0, 100.00, '2021-01-03 18:07:04.000000', 0, 3, 0, 2, '发工资 -- 免费课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (48, 0, 100.00, '2021-01-03 18:07:31.000000', 0, 6, 0, 2, '发工资 -- 免费课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (49, 0, 100.00, '2021-01-03 18:09:40.000000', 0, 2, 0, 2, '发工资 -- 收费课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (50, 0, 100.00, '2021-01-03 18:09:44.000000', 0, 3, 0, 2, '发工资 -- 收费课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (56, 1, 4950.00, '2021-01-04 11:49:52.000000', 1, 3, 49, 0, '用户imliuhaoyu@qq.com于2021-01-04 11:49:52 支付¥4950.00元购买了直播课程: redis精品课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (58, 1, 4950.00, '2021-01-04 11:50:09.000000', 1, 3, 49, 0, '用户imliuhaoyu@qq.com于2021-01-04 11:50:09 支付¥4950.00元购买了直播课程: redis精品课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (61, 1, 1633.50, '2021-01-11 20:56:18.000000', 2, 3, 49, 1, '用户1416322667@qq.com于2021-01-11 20:56:18 支付¥1633.50元购买了视频课程: redis精品课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (62, 1, 100.00, '2021-01-11 21:23:34.000000', 2, 2, 18, 0, '用户1416322667@qq.com于2021-01-11 21:23:34 支付¥100.00元购买了直播课程: ajax', NULL, NULL);
INSERT INTO `detailmoney` VALUES (63, 1, 0.00, '2021-01-11 21:23:34.000000', 2, 2, 18, 1, '用户1416322667@qq.com于2021-01-11 21:23:34 支付¥ 0.00元购买了直播课程: ajax', NULL, NULL);
INSERT INTO `detailmoney` VALUES (64, 1, 100.00, '2021-01-11 21:38:52.000000', 2, 2, 18, 0, '用户1416322667@qq.com于2021-01-11 21:38:52 支付¥100.00元购买了直播课程: ajax', NULL, NULL);
INSERT INTO `detailmoney` VALUES (65, 1, 0.00, '2021-01-11 21:38:52.000000', 2, 2, 18, 1, '用户1416322667@qq.com于2021-01-11 21:38:52 支付¥ 0.00元购买了直播课程: ajax', NULL, NULL);
INSERT INTO `detailmoney` VALUES (66, 1, 99.00, '2021-01-13 16:59:10.000000', 2, 3, 10, 1, '用户1416322667@qq.com于2021-01-13 16:59:10 支付¥99.00元购买了视频课程: ssm5', NULL, NULL);
INSERT INTO `detailmoney` VALUES (67, 1, 99.00, '2021-01-13 17:15:48.000000', 2, 3, 10, 1, '用户1416322667@qq.com于2021-01-13 17:15:48 支付¥99.00元购买了视频课程: ssm5', NULL, NULL);
INSERT INTO `detailmoney` VALUES (68, 1, 66.00, '2021-01-13 17:20:38.000000', 9, 3, 10, 1, '用户2547620130@qq.com于2021-01-13 17:20:38 支付¥66.00元购买了视频课程: ssm5', NULL, NULL);
INSERT INTO `detailmoney` VALUES (69, 1, 300.00, '2021-01-13 17:43:40.000000', 2, 3, 10, 0, '用户1416322667@qq.com于2021-01-13 17:43:40 支付¥300.00元购买了直播课程: ssm5', NULL, NULL);
INSERT INTO `detailmoney` VALUES (70, 1, 0.00, '2021-01-13 17:53:20.000000', 2, 3, 39, 0, '用户1416322667@qq.com于2021-01-13 17:53:20 支付¥0.00元购买了直播课程: 阿斯蒂芬', NULL, NULL);
INSERT INTO `detailmoney` VALUES (71, 1, 0.00, '2021-01-13 17:53:20.000000', 2, 3, 39, 1, '用户1416322667@qq.com于2021-01-13 17:53:20 支付¥ 0.00元购买了视频课程: 阿斯蒂芬', NULL, NULL);
INSERT INTO `detailmoney` VALUES (72, 1, 789.00, '2021-01-13 18:00:56.000000', 2, 6, 46, 0, '用户1416322667@qq.com于2021-01-13 18:00:56 支付¥789.00元购买了直播课程: linux', NULL, NULL);
INSERT INTO `detailmoney` VALUES (73, 1, 0.00, '2021-01-13 18:00:56.000000', 2, 6, 46, 1, '用户1416322667@qq.com于2021-01-13 18:00:56 支付¥ 0.00元购买了视频课程: linux', NULL, NULL);
INSERT INTO `detailmoney` VALUES (74, 1, 1815.00, '2021-01-13 18:03:34.000000', 9, 3, 49, 1, '用户2547620130@qq.com于2021-01-13 18:03:34 支付¥1815.00元购买了视频课程: redis精品课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (75, 1, 0.00, '2021-01-13 18:10:46.000000', 9, 3, 39, 0, '用户2547620130@qq.com于2021-01-13 18:10:46 支付¥0.00元购买了直播课程: 阿斯蒂芬', NULL, NULL);
INSERT INTO `detailmoney` VALUES (76, 1, 0.00, '2021-01-13 18:10:46.000000', 9, 3, 39, 1, '用户2547620130@qq.com于2021-01-13 18:10:46 支付¥ 0.00元购买了视频课程: 阿斯蒂芬', NULL, NULL);
INSERT INTO `detailmoney` VALUES (77, 1, 100.00, '2021-01-13 19:07:29.000000', 1, 2, 18, 0, '用户1285663661@qq.com于2021-01-13 19:07:29 支付¥100.00元购买了直播课程: ajax', NULL, NULL);
INSERT INTO `detailmoney` VALUES (78, 1, 0.00, '2021-01-13 19:07:29.000000', 1, 2, 18, 1, '用户1285663661@qq.com于2021-01-13 19:07:29 支付¥ 0.00元购买了视频课程: ajax', NULL, NULL);
INSERT INTO `detailmoney` VALUES (79, 1, 150.00, '2021-01-13 19:09:39.000000', 9, 2, 18, 0, '用户2547620130@qq.com于2021-01-13 19:09:39 支付¥150.00元购买了直播课程: ajax', NULL, NULL);
INSERT INTO `detailmoney` VALUES (80, 1, 0.00, '2021-01-13 19:09:39.000000', 9, 2, 18, 1, '用户2547620130@qq.com于2021-01-13 19:09:39 支付¥ 0.00元购买了视频课程: ajax', NULL, NULL);
INSERT INTO `detailmoney` VALUES (81, 1, 1815.00, '2021-01-13 19:12:19.000000', 4, 3, 49, 1, '用户14163226672@qq.com于2021-01-13 19:12:19 支付¥1815.00元购买了视频课程: redis精品课程', NULL, NULL);
INSERT INTO `detailmoney` VALUES (82, 1, 260.37, '2021-01-13 19:12:59.000000', 4, 6, 46, 1, '用户14163226672@qq.com于2021-01-13 19:12:59 支付¥260.37元购买了视频课程: linux', NULL, NULL);
INSERT INTO `detailmoney` VALUES (83, 1, 789.00, '2021-01-13 19:13:27.000000', 4, 6, 46, 0, '用户14163226672@qq.com于2021-01-13 19:13:27 支付¥789.00元购买了直播课程: linux', NULL, NULL);

-- ----------------------------
-- Table structure for idnumber
-- ----------------------------
DROP TABLE IF EXISTS `idnumber`;
CREATE TABLE `idnumber`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of idnumber
-- ----------------------------
INSERT INTO `idnumber` VALUES (1, '18080902259');
INSERT INTO `idnumber` VALUES (2, '18080902260');

-- ----------------------------
-- Table structure for livecourse
-- ----------------------------
DROP TABLE IF EXISTS `livecourse`;
CREATE TABLE `livecourse`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `t_id` int(11) NOT NULL COMMENT '教师id外键',
  `c_id` int(11) NOT NULL COMMENT '课程id外键',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面图路径',
  `qq` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'QQ群号',
  `end_time` date NOT NULL COMMENT '截止报名时间',
  `person_number` int(11) NOT NULL COMMENT '课程报名人数: 免费课程默认为零',
  `status` int(1) NOT NULL COMMENT '激活状态, 若超过报名日期则为1, 可报名为0',
  `type` int(2) NOT NULL COMMENT '课程是否结束，0：已结束，1：未结束',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of livecourse
-- ----------------------------
INSERT INTO `livecourse` VALUES (1, 1, 1, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2020-12-01', 20, 0, 1);
INSERT INTO `livecourse` VALUES (2, 2, 4, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2020-12-02', 31, 1, 1);
INSERT INTO `livecourse` VALUES (3, 3, 35, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2020-12-03', 50, 1, 1);
INSERT INTO `livecourse` VALUES (9, 3, 10, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2021-01-29', 4, 0, 1);
INSERT INTO `livecourse` VALUES (10, 2, 18, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2021-01-30', 4, 0, 1);
INSERT INTO `livecourse` VALUES (11, 1, 30, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2021-01-09', 0, 1, 1);
INSERT INTO `livecourse` VALUES (14, 3, 38, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2021-01-02', 0, 1, 1);
INSERT INTO `livecourse` VALUES (18, 0, 14, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2021-01-08', 0, 1, 1);
INSERT INTO `livecourse` VALUES (21, 3, 33, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '2927452196', '2020-12-09', 0, 0, 1);
INSERT INTO `livecourse` VALUES (22, 1, 34, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '2927452196', '2020-12-20', 0, 0, 1);
INSERT INTO `livecourse` VALUES (23, 2, 36, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '2927452196', '2021-01-09', 0, 1, 1);
INSERT INTO `livecourse` VALUES (24, 1, 37, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '2927452196', '2021-01-08', 0, 1, 1);
INSERT INTO `livecourse` VALUES (25, 3, 39, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '2927452196', '2021-01-31', 2, 0, 1);
INSERT INTO `livecourse` VALUES (26, 3, 41, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2020-12-10', 0, 0, 1);
INSERT INTO `livecourse` VALUES (27, 6, 19, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '2927452196', '2020-12-11', 0, 0, 1);
INSERT INTO `livecourse` VALUES (28, 1, 45, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '2927452196', '2021-01-07', 0, 0, 1);
INSERT INTO `livecourse` VALUES (29, 6, 46, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2021-01-31', 4, 0, 1);
INSERT INTO `livecourse` VALUES (30, 3, 13, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123456489', '2020-12-09', 0, 0, 1);
INSERT INTO `livecourse` VALUES (31, 3, 12, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123456', '2020-12-25', 0, 0, 1);
INSERT INTO `livecourse` VALUES (32, 6, 8, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123456789', '2020-12-26', 0, 0, 1);
INSERT INTO `livecourse` VALUES (33, 2, 6, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '987654321', '2021-01-13', 0, 0, 1);
INSERT INTO `livecourse` VALUES (34, 3, 48, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '2927452196', '2020-12-31', 0, 1, 1);
INSERT INTO `livecourse` VALUES (35, 6, 47, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '2927452196', '2020-12-31', 0, 1, 1);
INSERT INTO `livecourse` VALUES (36, 1, 32, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '1416322667', '2021-01-09', 0, 1, 1);
INSERT INTO `livecourse` VALUES (37, 3, 49, '/images/adb7f689-ee88-42a6-815d-85cb9fe7db7a.jpg', '1416322667', '2021-01-09', 11, 1, 0);
INSERT INTO `livecourse` VALUES (38, 3, 43, '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '14163222667', '2021-01-09', 0, 1, 1);
INSERT INTO `livecourse` VALUES (40, 3, 50, NULL, '111', '2021-01-30', 0, 0, 1);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告内容',
  `state` int(2) NOT NULL COMMENT '是否发布，0：未发布，1：发布',
  `time` date NOT NULL COMMENT '公告发布日期',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (32, 'demoData', 'demoData', 1, '2020-11-19', NULL, NULL);
INSERT INTO `notice` VALUES (33, 'demoData', '<p><img src=\"http://localhost:8080/images/48adf731-cd54-41cb-a41d-6f0af4e951b5.jpg\" alt=\"\" width=\"360\" height=\"360\" />demoData</p>', 1, '2020-11-19', NULL, NULL);
INSERT INTO `notice` VALUES (35, 'demoData', 'demoData', 1, '2020-11-19', NULL, NULL);
INSERT INTO `notice` VALUES (41, '测试标题', 'asdawdasdsdasd', 1, '2020-11-20', NULL, NULL);
INSERT INTO `notice` VALUES (42, '测试二122123123', '<p>123123123萨达萨达萨达萨达萨达</p>', 1, '2020-11-28', NULL, NULL);
INSERT INTO `notice` VALUES (43, '测试三', '<p><strong>撒大苏打撒旦</strong></p>\n<p><strong>&lsquo;sadsad</strong>&nbsp; &nbsp;<span style=\"color: #e67e23;\">qw去问驱蚊器为<img src=\"http://localhost:8080/images/b469ae26-9402-42f9-8081-bde09a918ced.jpg\" alt=\"\" width=\"200\" height=\"356\" /></span></p>', 1, '2020-11-20', NULL, NULL);
INSERT INTO `notice` VALUES (45, '测试3', '<p style=\"text-align: center;\">剧中</p>\n<p style=\"text-align: center;\">&nbsp; &nbsp; &nbsp; &nbsp;小标题</p>\n<p>大撒大撒大苏打&nbsp; &nbsp;<span style=\"color: #e03e2d;\">2额额2额2饿我去恶趣味驱蚊器我<span style=\"color: #000000;\">&nbsp;<strong> &nbsp;asdasdasd&nbsp; &nbsp; &nbsp;</strong></span></span></p>\n<p><span style=\"color: #e03e2d;\"><span style=\"color: #000000;\"><strong><img src=\"http://localhost:8080/images/cfdff044-1053-4bfe-be34-d3bbffc24cf4.jpg\" alt=\"\" width=\"200\" height=\"133\" /></strong></span></span></p>', 1, '2020-11-26', NULL, NULL);
INSERT INTO `notice` VALUES (46, '测试', '<p>无内容</p>', 1, '2020-11-26', NULL, NULL);
INSERT INTO `notice` VALUES (47, '测试二', '<p>委屈恶趣味</p>', 1, '2020-11-26', NULL, NULL);
INSERT INTO `notice` VALUES (48, '撒大苏打', '<p>2312312</p>', 1, '2020-11-26', NULL, NULL);
INSERT INTO `notice` VALUES (49, '123123', '<p>123213123</p>\n<p><img src=\"http://localhost:8080/images/c9efebd6-0d96-4c85-a04b-519569b27e26.jpg\" alt=\"\" width=\"201\" height=\"201\" /></p>', 1, '2020-12-04', NULL, NULL);
INSERT INTO `notice` VALUES (50, '1231312', '<p>12312312</p>', 1, '2020-12-29', NULL, NULL);
INSERT INTO `notice` VALUES (51, '啊丢撒旦', '<p>1231231231231123</p>', 1, '2020-12-30', NULL, NULL);
INSERT INTO `notice` VALUES (52, '3123123', '<p>1231231</p>', 1, '2020-12-31', NULL, NULL);
INSERT INTO `notice` VALUES (53, '12312312', '<p>12312321312</p>', 1, '2020-12-30', NULL, NULL);
INSERT INTO `notice` VALUES (54, '123213123', '<p>2131231232132</p>', 1, '2020-12-31', NULL, NULL);
INSERT INTO `notice` VALUES (55, '守护者”公益计划 永恒之森 奥恩 慈善皮肤', '<p><span style=\"color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">2019年，在拳头十周年的周年庆上，拳头宣布了一项名为&ldquo;拳头游戏社会影响基金&rdquo;的新计划，这个非营利组织将会成为拳头围绕全球社会影响进行集体助力的引擎，以保障全世界范围内慈善项目的有序推进。而在同一年，&ldquo;守护者&rdquo;公益计划正式启动，黎明使者卡尔玛也成为了拳头游戏社会影响基金会的首款慈善皮肤。</span></p>\n<p><span style=\"color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\"><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://shp.qpic.cn/cfwebcap/0/e6c4ab652f2e46cdad087ca2c7e0bf9e/0/?width=1164&amp;height=709\" alt=\"\" width=\"545\" height=\"332\" /></span></p>\n<p><span style=\"color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">而2020年12月11日，&ldquo;守护者&rdquo;公益计划再度开启，永恒之森奥恩将作为慈善皮肤正式上线。与黎明使者 卡尔玛一样，永恒之森 奥恩以及其相关图标、表情和炫彩礼包收入(扣除税收后)的100%将会被全部捐出至Impact Assets新成立的拳头游戏社会影响基金会并用于慈善事业。收入款将100%进行捐赠的商品列表包括：</span></p>\n<p><span style=\"color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\"><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://shp.qpic.cn/cfwebcap/0/1ae9622997baffec9a6f0a81a79ff4e0/0/?width=1202&amp;height=708\" alt=\"\" width=\"550\" height=\"324\" /></span></p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">● 永恒之森 奥恩 皮肤，7900点券</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">● 永恒之森 奥恩 炫彩皮肤，每款2500点券</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">● 永恒之森 奥恩 生命绽放版(含图标+边框组合)，9900点券</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">● 永恒之森 奥恩 炫彩礼包(含皮肤+图标边框+7款炫彩) 27400点券</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">● 永恒之森 奥恩 坚韧信念礼包(含皮肤+图标边框+3款表情+7款炫彩) 41400点券</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">● &lsquo;傻孩子!&rsquo;表情(3000点券)</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">● &lsquo;行吧!&rsquo;表情(仅在坚韧信念礼包中销售)</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">● &lsquo;不死之王!&rsquo;表情(仅在坚韧信念礼包中销售)</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">*以上所有道具销售收入将捐赠用于慈善事业，其中中国大陆地区所筹善款将全部用于中国大陆地区慈善事业。</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">对于希望奉献更多爱心的召唤师，我们今次亦提供了永恒之森奥恩 生命绽放版、永恒之森 奥恩 坚韧信念礼包等选项，以便愿意奉献更多爱心的召唤师有一个更适合自身的途径去捐赠，并给予召唤师特殊的皮肤产品。同时，我们亦保留79元的限定皮肤永恒之森 奥恩供召唤师选择。你的点滴善行，将为需要帮助的人摆脱困境，带来希望!</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff; text-align: center;\"><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"https://shp.qpic.cn/cfwebcap/0/f8c4f374f021982bf626945f2e534352/0/?width=1240&amp;height=420\" alt=\"\" width=\"617\" height=\"209\" />(傻孩子！表情现已全球同步更新，表情更新将不会影响该表情收入的捐赠)</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">&ldquo;守护者&rdquo;公益计划 永恒之森奥恩将于2020年12月11日10:00&mdash;2021年1月12日9:59期间限时购买。之后永恒之森 奥恩皮肤及其相关内容在此次筹款活动结束后将无法直接购买。</p>\n<p style=\"-webkit-tap-highlight-color: rgba(0, 0, 0, 0); outline: 0px; margin: 0px; line-height: 26px; padding-bottom: 25px; color: #333333; font-family: 微软雅黑; font-size: 14px; background-color: #ffffff;\">英雄联盟感谢每一位召唤师的付出，期待未来我们继续携手前行。</p>', 1, '2021-01-01', NULL, NULL);

-- ----------------------------
-- Table structure for personal
-- ----------------------------
DROP TABLE IF EXISTS `personal`;
CREATE TABLE `personal`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '私人定制内容',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of personal
-- ----------------------------

-- ----------------------------
-- Table structure for portrait
-- ----------------------------
DROP TABLE IF EXISTS `portrait`;
CREATE TABLE `portrait`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片名称',
  `img` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片路径',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of portrait
-- ----------------------------
INSERT INTO `portrait` VALUES (12, '超人', '/images/780f8830-1dd5-47d1-894c-fb9634d1c5fe.jpg', NULL, NULL);
INSERT INTO `portrait` VALUES (13, '路飞', '/images/ae19288c-6c7d-4f22-aace-ec0e83eb4b0c.jpg', NULL, NULL);
INSERT INTO `portrait` VALUES (14, '尔康', '/images/ddbf4e98-8ef7-4d9c-9aea-11817777cc56.jpg', NULL, NULL);
INSERT INTO `portrait` VALUES (15, '奥特曼', '/images/4856e31e-e7df-4e33-923b-e00ebd1d544b.jpg', NULL, NULL);
INSERT INTO `portrait` VALUES (16, '派大星', '/images/07b50f05-6763-4409-a4e0-dd3dd9e95814.jpg', NULL, NULL);
INSERT INTO `portrait` VALUES (17, '小丸子', '/images/46f1fdd9-5ef3-420b-bdf2-126b42d5254e.jpg', NULL, NULL);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '教师名称',
  `free_money` decimal(11, 2) NOT NULL COMMENT '免费课程应发金额',
  `charge_money` decimal(11, 2) NULL DEFAULT NULL COMMENT '收费课程应发金额',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (1, '刘浩宇', 0.00, 5898.75, NULL, NULL);
INSERT INTO `teacher` VALUES (2, '田洪振', 0.00, 2856.75, NULL, NULL);
INSERT INTO `teacher` VALUES (3, '王思淼', 68.00, 280.19, NULL, NULL);
INSERT INTO `teacher` VALUES (6, '刘浩宇2', 0.00, 889.00, NULL, '1');

-- ----------------------------
-- Table structure for totalmoney
-- ----------------------------
DROP TABLE IF EXISTS `totalmoney`;
CREATE TABLE `totalmoney`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sum_money` decimal(11, 2) NOT NULL COMMENT '总计收入，累计总收入，不会清零',
  `surplus_money` decimal(11, 2) NOT NULL COMMENT '剩余金额',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of totalmoney
-- ----------------------------
INSERT INTO `totalmoney` VALUES (1, 45399.48, 390.00, NULL, NULL);

-- ----------------------------
-- Table structure for ulpower
-- ----------------------------
DROP TABLE IF EXISTS `ulpower`;
CREATE TABLE `ulpower`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` int(11) NOT NULL COMMENT '用户id的外键',
  `c_id` int(5) NOT NULL COMMENT '直播课的课程id的外键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ulpower
-- ----------------------------
INSERT INTO `ulpower` VALUES (1, 1, 1);
INSERT INTO `ulpower` VALUES (2, 1, 4);
INSERT INTO `ulpower` VALUES (3, 1, 6);
INSERT INTO `ulpower` VALUES (4, 1, 8);
INSERT INTO `ulpower` VALUES (5, 2, 1);
INSERT INTO `ulpower` VALUES (6, 2, 6);
INSERT INTO `ulpower` VALUES (8, 1, 46);
INSERT INTO `ulpower` VALUES (14, 1, 49);
INSERT INTO `ulpower` VALUES (21, 2, 18);
INSERT INTO `ulpower` VALUES (22, 2, 10);
INSERT INTO `ulpower` VALUES (23, 2, 39);
INSERT INTO `ulpower` VALUES (24, 2, 46);
INSERT INTO `ulpower` VALUES (25, 9, 39);
INSERT INTO `ulpower` VALUES (26, 1, 18);
INSERT INTO `ulpower` VALUES (27, 9, 18);
INSERT INTO `ulpower` VALUES (28, 4, 46);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学号',
  `img` int(3) NOT NULL COMMENT '头像外键',
  `type` int(2) NOT NULL COMMENT '是否为学校人员，0：是，1：否',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '帅逼', '1285663661@qq.com', '123456', '18080902260', 15, 0, NULL, NULL);
INSERT INTO `user` VALUES (2, '李四', '1416322667@qq.com', '123456', '18080902259', 16, 0, NULL, NULL);
INSERT INTO `user` VALUES (3, '王五', '14163226671@qq.com', '123456', '123456', 12, 1, NULL, NULL);
INSERT INTO `user` VALUES (4, '赵六', '14163226672@qq.com', '123456', '456489', 13, 1, NULL, NULL);
INSERT INTO `user` VALUES (9, 'aaa', '2547620130@qq.com', '123456', NULL, 15, 1, NULL, NULL);

-- ----------------------------
-- Table structure for uvpower
-- ----------------------------
DROP TABLE IF EXISTS `uvpower`;
CREATE TABLE `uvpower`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `u_id` int(5) NULL DEFAULT NULL COMMENT '用户id',
  `c_id` int(5) NULL DEFAULT NULL COMMENT '视频的课程的id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of uvpower
-- ----------------------------
INSERT INTO `uvpower` VALUES (1, 1, 1);
INSERT INTO `uvpower` VALUES (2, 1, 4);
INSERT INTO `uvpower` VALUES (3, 1, 6);
INSERT INTO `uvpower` VALUES (4, 1, 8);
INSERT INTO `uvpower` VALUES (6, 1, 46);
INSERT INTO `uvpower` VALUES (9, 1, 47);
INSERT INTO `uvpower` VALUES (18, 1, 49);
INSERT INTO `uvpower` VALUES (19, 2, 1);
INSERT INTO `uvpower` VALUES (29, 2, 18);
INSERT INTO `uvpower` VALUES (30, 2, 18);
INSERT INTO `uvpower` VALUES (31, 2, 10);
INSERT INTO `uvpower` VALUES (32, 2, 10);
INSERT INTO `uvpower` VALUES (34, 2, 39);
INSERT INTO `uvpower` VALUES (35, 2, 46);
INSERT INTO `uvpower` VALUES (36, 9, 49);
INSERT INTO `uvpower` VALUES (37, 9, 39);
INSERT INTO `uvpower` VALUES (38, 1, 18);
INSERT INTO `uvpower` VALUES (39, 9, 18);
INSERT INTO `uvpower` VALUES (40, 4, 49);
INSERT INTO `uvpower` VALUES (41, 4, 46);

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `t_id` int(20) NOT NULL COMMENT '教师外键',
  `course_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '课程节数（编号）自增',
  `img_top` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '封面图',
  `url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '视频链接，json（标题路径）',
  `c_id` int(2) NOT NULL COMMENT '课程外键',
  `remark1` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列1',
  `remark2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备用列2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES (19, 1, 'adsa', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', 'https://www.runoob.com/try/demo_source/movie.mp4', 1, NULL, NULL);
INSERT INTO `video` VALUES (20, 1, 'asd', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', 'https://cdn.theguardian.tv/webM/2015/07/20/150716YesMen_synd_768k_vp8.webm', 1, NULL, NULL);
INSERT INTO `video` VALUES (21, 1, '123123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123123', 1, NULL, NULL);
INSERT INTO `video` VALUES (22, 1, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 1, NULL, NULL);
INSERT INTO `video` VALUES (23, 2, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 1, NULL, NULL);
INSERT INTO `video` VALUES (24, 2, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 1, NULL, NULL);
INSERT INTO `video` VALUES (25, 3, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 1, NULL, NULL);
INSERT INTO `video` VALUES (26, 3, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 1, NULL, NULL);
INSERT INTO `video` VALUES (27, 3, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 6, NULL, NULL);
INSERT INTO `video` VALUES (28, 6, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 8, NULL, NULL);
INSERT INTO `video` VALUES (29, 6, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 1, NULL, NULL);
INSERT INTO `video` VALUES (30, 6, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 1, NULL, NULL);
INSERT INTO `video` VALUES (31, 6, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 1, NULL, NULL);
INSERT INTO `video` VALUES (32, 6, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 8, NULL, NULL);
INSERT INTO `video` VALUES (33, 6, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 8, NULL, NULL);
INSERT INTO `video` VALUES (34, 1, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 10, NULL, NULL);
INSERT INTO `video` VALUES (35, 1, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 10, NULL, NULL);
INSERT INTO `video` VALUES (36, 1, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 10, NULL, NULL);
INSERT INTO `video` VALUES (37, 1, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 12, NULL, NULL);
INSERT INTO `video` VALUES (38, 1, '123', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123asd111111111111111111111111', 12, NULL, NULL);
INSERT INTO `video` VALUES (41, 1, 'asd', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', 'asd', 12, NULL, NULL);
INSERT INTO `video` VALUES (42, 1, 'eqweqw', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', 'qweqw', 12, NULL, NULL);
INSERT INTO `video` VALUES (46, 1, '764564', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '64564654', 12, NULL, NULL);
INSERT INTO `video` VALUES (47, 1, '45654', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '54656', 12, NULL, NULL);
INSERT INTO `video` VALUES (48, 1, 'wqrreqwe', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', 'fgsffsds', 12, NULL, NULL);
INSERT INTO `video` VALUES (49, 1, 'qwrqwe', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', 'qweqweq', 13, NULL, NULL);
INSERT INTO `video` VALUES (50, 1, '0379', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123456', 14, NULL, NULL);
INSERT INTO `video` VALUES (51, 1, '0379', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123456', 14, NULL, NULL);
INSERT INTO `video` VALUES (52, 1, '964', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', 'asd.com', 12, NULL, NULL);
INSERT INTO `video` VALUES (53, 1, '111', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123456', 14, NULL, NULL);
INSERT INTO `video` VALUES (54, 3, '001', '/images/d5a71e50-318b-489e-b396-ca1bd3ab1a15.png', '123456', 46, NULL, NULL);
INSERT INTO `video` VALUES (55, 2, '123', '/images/7cb446de-42ce-4548-9359-ae971e3d228a.jpg', '23123', 49, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
