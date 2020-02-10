/*
Navicat MySQL Data Transfer

Source Server         : *****
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : web_shop

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2020-02-10 18:48:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for administrators
-- ----------------------------
DROP TABLE IF EXISTS `administrators`;
CREATE TABLE `administrators` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pwd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of administrators
-- ----------------------------
INSERT INTO `administrators` VALUES ('1', 'admin', '63814a82384f9faca8bcca0f08d86eb9');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `goods_id` int(11) NOT NULL,
  `goods_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thumb_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `buy_count` int(11) DEFAULT NULL,
  `is_pay` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `counts` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('136590526', '【花花公子正品】皮带男士休闲自动扣皮带商务百搭自动扣学生腰带', 'http://t00img.yangkeduo.com/t10img/images/2018-06-22/2fa2b2b9b6423fa01b5a769110d20afb.jpeg', '1380', '1', '0', '8', '50');
INSERT INTO `cart` VALUES ('344112935', '蓝牙耳机通用所有手机', 'http://t00img.yangkeduo.com/t03img/images/2018-05-05/690f068dfbf940e9a22f71132766bcd1.jpeg', '990', '3', '0', '8', '50');
INSERT INTO `cart` VALUES ('48367210', '【天然竹浆本色品质纸巾】丝飘抽纸餐巾纸', 'http://t00img.yangkeduo.com/t07img/images/2018-05-27/38a24fafe5166b7e236a01ddf1ec7a04.jpeg', '990', '3', '0', '5', '60');
INSERT INTO `cart` VALUES ('621723438', '青春励志文学', 'http://t00img.yangkeduo.com/t09img/images/2018-07-20/a6eb38f1b52054d149a0dcbf9539ebf2.jpeg', '955', '4', '0', '5', '50');
INSERT INTO `cart` VALUES ('55984768', '华为 荣耀9青春版', 'http://t00img.yangkeduo.com/goods/images/2018-08-24/d57f9e6c4c04568324775079cc8ab386.jpeg', '80500', '1', '0', '5', '50');
INSERT INTO `cart` VALUES ('1031855', '甜曲紫米面包550g', 'http://t00img.yangkeduo.com/goods/images/2018-08-30/1093ac9bfaa77304a8c3f25d4bfcb743.jpeg', '990', '5', '0', '5', '50');
INSERT INTO `cart` VALUES ('621723438', '青春励志文学', 'http://t00img.yangkeduo.com/t09img/images/2018-07-20/a6eb38f1b52054d149a0dcbf9539ebf2.jpeg', '955', '1', '0', '9', '50');
INSERT INTO `cart` VALUES ('7657775', '【曹大姐】五香熟牛肉200克无淀粉无添加', 'http://t00img.yangkeduo.com/t08img/images/2018-05-23/2a78ac1b4c151168ceddbb73920cdaef.jpeg', '1390', '3', '0', '9', '50');
INSERT INTO `cart` VALUES ('2316452', '男士修身弹力小脚裤 品质保证', 'http://t00img.yangkeduo.com/t11img/images/2018-07-15/6982d3a77481e146e9fb81dc31d3a546.jpeg', '2800', '1', '0', '9', '50');
INSERT INTO `cart` VALUES ('2316452', '男士修身弹力小脚裤 品质保证', 'http://t00img.yangkeduo.com/t11img/images/2018-07-15/6982d3a77481e146e9fb81dc31d3a546.jpeg', '2800', '1', '0', '5', '50');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `cate_id` int(11) NOT NULL,
  `cate_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cate_icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cate_counts` int(11) DEFAULT NULL,
  PRIMARY KEY (`cate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '图书、音像', 'el-icon-reading', '2');
INSERT INTO `category` VALUES ('2', '家居生活', 'el-icon-box', '19');
INSERT INTO `category` VALUES ('3', '服饰、箱包', 'el-icon-present', '20');
INSERT INTO `category` VALUES ('4', '电子产品', 'el-icon-mobile-phone', '9');
INSERT INTO `category` VALUES ('5', '美食宝典', 'el-icon-ice-cream', '17');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL,
  `comment_detail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_rating` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES ('1', '136590526', 'good', '5', '5');
INSERT INTO `comments` VALUES ('16', '136590526', 'nice', '5', '5');
INSERT INTO `comments` VALUES ('17', '136590526', 'bad', '1', '8');
INSERT INTO `comments` VALUES ('20', '65676090', 'success', '5', '5');
INSERT INTO `comments` VALUES ('21', '65676090', 'error', '5', '5');
INSERT INTO `comments` VALUES ('22', '6225284', '不好用', '2', '5');
INSERT INTO `comments` VALUES ('23', '6225284', '还可以', '4', '5');
INSERT INTO `comments` VALUES ('24', '8836407', '好吃', '5', '5');
INSERT INTO `comments` VALUES ('25', '621723438', '强烈推荐', '5', '5');
INSERT INTO `comments` VALUES ('26', '621723438', '毒鸡汤', '2', '9');

-- ----------------------------
-- Table structure for homecasual
-- ----------------------------
DROP TABLE IF EXISTS `homecasual`;
CREATE TABLE `homecasual` (
  `id` int(11) NOT NULL,
  `imgurl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `detail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of homecasual
-- ----------------------------
INSERT INTO `homecasual` VALUES ('1', 'http://localhost:3000/images/home/s1.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6153');
INSERT INTO `homecasual` VALUES ('2', 'http://localhost:3000/images/home/s2.png', 'http://mobile.yangkeduo.com/promotion_op.html?type=12&id=228');
INSERT INTO `homecasual` VALUES ('3', 'http://localhost:3000/images/home/s3.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6242');
INSERT INTO `homecasual` VALUES ('4', 'http://localhost:3000/images/home/s4.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6153');
INSERT INTO `homecasual` VALUES ('5', 'http://localhost:3000/images/home/s5.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6230');
INSERT INTO `homecasual` VALUES ('6', 'http://localhost:3000/images/home/s6.png', 'http://mobile.yangkeduo.com/promotion_op.html?type=12&id=190');
INSERT INTO `homecasual` VALUES ('7', 'http://localhost:3000/images/home/s7.png', 'http://mobile.yangkeduo.com/promotion_op.html?type=12&id=229');
INSERT INTO `homecasual` VALUES ('8', 'http://localhost:3000/images/home/s8.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6153');
INSERT INTO `homecasual` VALUES ('9', 'http://localhost:3000/images/home/s9.png', 'http://mobile.yangkeduo.com/subject.html?subject_id=6242');

-- ----------------------------
-- Table structure for recommend
-- ----------------------------
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend` (
  `goods_id` bigint(20) NOT NULL,
  `goods_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `short_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thumb_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `hd_thumb_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `normal_price` int(11) DEFAULT NULL,
  `market_price` int(11) DEFAULT NULL,
  `sales_tip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `counts` int(11) DEFAULT NULL,
  `comments_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of recommend
-- ----------------------------
INSERT INTO `recommend` VALUES ('1031855', '【甜曲】紫米面包550g/2200g黑米夹心奶酪蛋糕减脂早餐营养代餐', '甜曲紫米面包550g', 'http://t00img.yangkeduo.com/goods/images/2018-08-30/1093ac9bfaa77304a8c3f25d4bfcb743.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-30/41793c7556c00d972886f53de1bd58f5.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-30/177c3a7ebdffad8a008976988322ba8f.jpeg', '990', '1680', '6950', '已售10万+件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('2316452', '秋季牛仔裤男青年修身弹力小脚裤2018新款韩版潮流男士小直筒长裤', '男士修身弹力小脚裤 品质保证', 'http://t00img.yangkeduo.com/t11img/images/2018-07-15/6982d3a77481e146e9fb81dc31d3a546.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-07-15/aa4c5248112bdc08cc2faec10b1ad2a7.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-06-25/667b2fcd41a6a1450cc29aac5bb8507f.jpeg', '2800', '3200', '26900', '已售2万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('6096094', '【金贤】防风不锈钢8/16/20/30/40夹袜架晾袜衣架内衣夹晾晒架', '不锈钢加粗防风袜架可晒毛巾衣架晾晒衣夹', 'http://t00img.yangkeduo.com/t07img/images/2018-05-16/f6bbac2f073efed1b2aa7b6b1dfeb95f.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-05-16/f2171b871216528c66388163024bb5fc.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-23/ed5a60f13860e5f52c21a97125c8f72a.jpeg', '490', '790', '5500', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('6225284', '【50只装】蓝泡泡马桶清洁剂洁厕宝洁厕剂洗卫生间尿垢杀菌洁厕灵', '50个洁厕宝选装', 'http://omsproductionimg.yangkeduo.com/images/2018-01-04/00df2e6c08388e023a813d25f8c04825.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2018-01-04/52e6e647972439a498cc56e5b920bc81.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-23/6b585866513b27e5921352c931bfa917.jpeg', '921', '1290', '2000', '已售10万+件', '2', '50', '2');
INSERT INTO `recommend` VALUES ('6747539', '久民磨刀神器磨菜刀磨剪刀多功能磨刀器家用磨刀石厨房用品小工具', '磨刀神器5秒快速磨菜刀磨剪刀多功能', 'http://t00img.yangkeduo.com/t02img/images/2018-05-29/98041a372a4d16c17f23a3863b8da038.jpeg', 'http://t00img.yangkeduo.com/t11img/images/2018-05-29/dd18cf918d01aefd7e357eeaa28d1442.jpeg', 'http://t00img.yangkeduo.com/t03img/images/2018-06-19/f2a07e3c2e7904561ff51edf0117e869.jpeg', '850', '1200', '3800', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('7292301', '【一洗白】碧雅洁薰衣草香氛洗衣液 持久留香低泡易漂 家庭装', '10/5/2斤洗衣液组合装', 'http://t00img.yangkeduo.com/goods/images/2018-08-31/f01698bbf68951299134e57cea04a6df.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-31/9e21bd51c712bb20f7e2e71c4e9b6253.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-31/a63104e9d0b650a3d2ee16d327a67a15.jpeg', '690', '990', '9900', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('7451457', '【车安驰】汽车表板蜡仪表盘蜡内饰蜡塑料件翻新上光保养液体蜡腊', '汽车内饰翻新', 'http://t00img.yangkeduo.com/goods/images/2018-09-03/baf571b64cab639a768b34ba8f523db3.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-03/f69def6bfc1e8ce2f465afbf1bd7cae0.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-04-11/64b21c92e31fafdb3589b3ea1461508b.jpeg', '990', '1990', '9360', '已售10万+件', '4', '50', '0');
INSERT INTO `recommend` VALUES ('7657775', '【曹大姐】五香熟牛肉200g/400g/3.2斤礼盒装无淀粉熟食下酒菜', '【曹大姐】五香熟牛肉200克无淀粉无添加', 'http://t00img.yangkeduo.com/t08img/images/2018-05-23/2a78ac1b4c151168ceddbb73920cdaef.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-05-23/8ed65c8ec9bb7e996d9050a307edb8cc.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-03-09/7549b857a65b32de5924b044d1c6c760.jpeg', '1390', '1990', '16900', '已售8万件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('7780946', '10支-50支成人儿童衣架成人家用加粗衣架衣挂衣撑子防滑晾衣架', '成人儿童加粗衣架子', 'http://omsproductionimg.yangkeduo.com/images/2017-11-03/f246257588f19bc05942016f17930ca9.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-11-03/010c949b1b70b73f4441e9a377aaf8bd.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-03-13/91dd25b14013abf8e749de035d23a5a5.jpeg', '405', '800', '3490', '已售5万件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('8491943', '【买一送七】天才电话手表男女智能手表触屏定位防水儿童手表手机', '智能电话手表触屏定位防水儿童学生手表手机', 'http://t00img.yangkeduo.com/goods/images/2018-08-11/94fb78446ec182a287c4115a54849efe.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-11/af6928d63d45342d289aaf0e53bd8ed3.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-11/4a22b8378371a8efd6ee95e3326932f7.jpeg', '5800', '6800', '26800', '已售2万件', '4', '50', '0');
INSERT INTO `recommend` VALUES ('8836407', '【买一送一】买2斤送2斤飞业爆浆麻薯干吃汤圆零食小吃糕点心400g', '1000g爆浆麻薯多规格', 'http://t00img.yangkeduo.com/goods/images/2018-08-01/c17c2b2c862fb8a231565941ababd145.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-01/0fc75856ec4319da959a50bf2dd4f7d5.jpeg', 'http://t00img.yangkeduo.com/t03img/images/2018-05-17/4d989c8d2f7af53c1de70b0e32640d8f.jpeg', '850', '1080', '2990', '已售10万+件', '5', '50', '1');
INSERT INTO `recommend` VALUES ('9692939', '【现做现发】苏式月饼老式酥皮五仁月饼多口味多规格250g/2000g', '苏式酥皮月饼多口味', 'http://omsproductionimg.yangkeduo.com/images/2017-09-04/4aefe363fa75fd7bf827b65807f4500f.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-09-04/5b0a2069ff6aca5fd25d158f81c13039.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-24/4ea20537b4628e5a40447cb086e39750.jpeg', '598', '730', '3599', '已售10万+件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('9948390', '【阿玛依】ins网红四件套 亲肤棉卡通床上用品学生床单被套三件套', 'ins网红亲肤磨毛床上用品四件套', 'http://t00img.yangkeduo.com/goods/images/2018-08-26/9edc0a90bbb56c6c2d3160f37fdcca0b.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-26/fdc627f0f3895356f75235ca5490b7da.jpeg', 'http://t00img.yangkeduo.com/t11img/images/2018-05-23/56b04110f8907a71e5f29ee92168ca93.jpeg', '3390', '6100', '58800', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('10519372', '8册专注力训练儿童智力开发书2-6岁幼儿益智游戏书找不同思维训练', '专注力游戏书', 'http://t00img.yangkeduo.com/t05img/images/2018-06-21/db850903d0e78944dc68b6cb92a58ed5.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-06-21/f39609e97b16487951cacfaa349619e6.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-06-12/29c1a24e3ba385d6fa08d8312bdb269f.jpeg', '990', '1180', '5120', '已售3万件', '1', '50', '0');
INSERT INTO `recommend` VALUES ('14213769', '【2份送一斤枣】宁夏枸杞枸杞子滋补红枸杞头茬苟杞子500/250/50g', '宁夏枸杞500g', 'http://omsproductionimg.yangkeduo.com/images/2018-05-26/215e734664aeeec25db3bc7ab90ff893.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2018-05-26/4e037a3abb20b8bd9816a0e5cf8bebbd.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-06-25/16b63fa711ecee9aef7d74424e219283.jpeg', '500', '680', '8800', '已售10万+件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('34732343', '【送开果器】广西百香果5斤2/3斤12个大果60-80g中40-60g新鲜水果', '广西百香果大果5/3/2斤装', 'http://t00img.yangkeduo.com/t07img/images/2018-06-15/4be7ef8e56b40bd8086cef7ef1b30f81.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-06-15/d4b9d0cc9528381fc9ddbd34bb8a4a34.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-07-09/9fcad55f1f373fc7cfad8c2fd771dd49.jpeg', '1290', '1590', '1790', '已售63万件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('48367210', '【天然竹浆本色品质纸巾】丝飘抽纸餐巾纸面纸妇婴适用卫生纸批发', '【天然竹浆本色品质纸巾】丝飘抽纸餐巾纸', 'http://t00img.yangkeduo.com/t07img/images/2018-05-27/38a24fafe5166b7e236a01ddf1ec7a04.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-05-27/672d9e4bf34e8faa83054460446bcbe3.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-03-11/81675d6ce75437c9a490d5f233df4141.jpeg', '990', '1490', '6690', '已售10万+件', '2', '60', '0');
INSERT INTO `recommend` VALUES ('50783155', '【南极人】肤色加绒加厚打底裤女光腿神器秋冬外穿保暖裤子连体裤', '加绒加厚打底踩脚裤保暖一体裤连裤袜', 'http://t00img.yangkeduo.com/t01img/images/2018-06-01/4d0c2a4168c2c8ea2053b1ba44e342cf.jpeg', 'http://t00img.yangkeduo.com/t01img/images/2018-06-01/1a984c0b71d4b3f5dd3e9a4a38a2429c.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-10/6db1b848614c4b8730c0ad5507c7637f.jpeg', '1990', '4990', '9900', '已售10万+件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('54853852', '大口袋新款个性牛仔裤女哈伦裤显瘦小脚长裤宽松休闲垮裤大码胖mm', '【大口袋】哈伦牛仔裤女胖MM大码萝卜垮裤', 'http://t00img.yangkeduo.com/t02img/images/2018-06-13/74a5f72e12c721734ad4ad336b7a4955.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-06-13/7441b1a6bdaac1713b70e7017935522a.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-02-14/320be003e9c459d84b03f72237c5f2b2.jpeg', '3990', '8900', '29800', '已售3万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('55009139', '秋季运动休闲男鞋子韩版潮流帆布小白板鞋百搭内增高夏季跑步潮鞋', '韩版潮流内增高网鞋男', 'http://t00img.yangkeduo.com/t11img/images/2018-05-26/a301bd77fe70aa284e90b440bd82c0ec.jpeg', 'http://t00img.yangkeduo.com/t03img/images/2018-05-26/143ada7bcba873d2071a16222c8e68c6.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-02-07/da678439178197585038e88066da6883.jpeg', '3500', '5500', '35900', '已售10万+件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('55984768', '华为 荣耀9青春版 全面屏四摄 全网通4G智能指纹手机 华为9青春版', '华为 荣耀9青春版', 'http://t00img.yangkeduo.com/goods/images/2018-08-24/d57f9e6c4c04568324775079cc8ab386.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-24/38ac3c070da5bd1313b0c9786cc5c417.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-12-21/d8605ac847d59bbb7c03e657f912df0a.jpeg', '80500', '80800', '129900', '已售1万件', '4', '50', '0');
INSERT INTO `recommend` VALUES ('56042191', '中秋广式蛋黄莲蓉月饼12个500g/6个/3个散装多口味可选/800g礼盒', '广式蛋黄月饼6个/12个可选多口味', 'http://t00img.yangkeduo.com/goods/images/2018-09-02/2275030cf433ecca18c54eb47bd3e91d.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-02/ae74303d081f5e38ec7cf8e8a2e7490d.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-09-20/4a3d46c9c4b5a0469afd7add0a558075.jpeg', '660', '990', '9900', '已售10万+件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('56060042', '手撕素肉100包素牛肉素牛排素食豆干小吃豆制品香辣麻辣休闲零食', '手撕素肉17-100包', 'http://t00img.yangkeduo.com/goods/images/2018-07-22/8ee9da3843ac19ee9c54a7a3a4697d23.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-22/0aa3e616cf6312b5ccb8e47b7f897141.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-26/c36da96f2bde3aa27cedbe9b9191d266.jpeg', '990', '1090', '7900', '已售11万件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('58131537', '反季清仓大码羽绒服女士短款学生韩版可爱修身轻薄款宽松学生外套', '白鸭绒羽绒服女短款', 'http://t00img.yangkeduo.com/t10img/images/2018-07-13/cb5dbdc3ebc674ca6a54d52b7bd78dac.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-07-13/2cd3462538d6219c93cf837fb7ab185b.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-08-18/4f301b2e2e87408723c59f6280095c29.jpeg', '4900', '8990', '39900', '已售4万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('59306445', '女童春秋装外套中长款两面穿风衣外套韩版中大童小女孩衣服3-15岁', '女童春秋装外套中长款两面穿风衣外套', 'http://t00img.yangkeduo.com/t03img/images/2018-06-11/4f682dff42003a72e5bc1918b6cf3c17.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-06-11/89ba323331445a252bbf0626978a0486.jpeg', 'http://t00img.yangkeduo.com/t08img/images/2018-03-24/6f03d1dff66a4555ce26771ba4e661cb.jpeg', '1990', '2990', '25500', '已售7万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('63894890', '【每天现做】五仁月饼1000g 500g多味零食糕点独立包装多规格可选', '手工五仁黑芝麻月饼', 'http://t00img.yangkeduo.com/goods/images/2018-08-15/98cf355a4c15538b906a6d79e36e1c4f.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-15/7a939ee1ec4562e81568ad5dffef8a66.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-05-25/b2bb35efb07173160aef2e5a3867e422.jpeg', '950', '1090', '3990', '已售10万+件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('65676090', 'USB可充电电子称体重秤精准家用健康秤人体秤成人减肥称重计器准', '体重秤精准家用健康秤人体秤成人减肥称重计', 'http://t00img.yangkeduo.com/t07img/images/2018-06-15/eccb3df7c0c6f180ebd0ec3fe755dae8.jpeg', 'http://t00img.yangkeduo.com/t08img/images/2018-06-15/b47b12272db838b8c72eb4b9a938aaac.jpeg', 'http://t00img.yangkeduo.com/t08img/images/2018-04-18/fc603bad27947c7adcdf1baae828cb34.jpeg', '1240', '3500', '16800', '已售10万+件', '2', '50', '2');
INSERT INTO `recommend` VALUES ('68725206', '老北京布鞋男鞋单鞋春秋季男士休闲防臭透气帆布鞋中老年爸爸鞋子', '超耐磨防滑商务休闲鞋', 'http://t00img.yangkeduo.com/t01img/images/2018-03-16/dd9808ae24dff26636595b83deacdad3.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-04-16/1cd1e0e0dcfc40510cde2c786d431017.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-03/ed4584725c895237ea2929b81a250607.jpeg', '990', '2990', '6800', '已售10万+件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('71626520', '【精装泡沫箱】广西红心木瓜8斤/5斤 单果400-1500g 新鲜水果', '广西红心木瓜5斤/8斤清甜新鲜水果木瓜', 'http://t00img.yangkeduo.com/t09img/images/2018-06-03/685e6f63dbfd372316efaf8579d2b524.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-06-03/62b8daef311570dd6af813b0806d24dd.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-06-03/8b9ba274d34c022053e6b4daceb7c1de.jpeg', '1590', '1890', '2700', '已售10万+件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('73318400', '【搓澡神器】承诺洗澡刷长柄浴刷搓背刷搓澡刷软毛洗澡刷搓背神器', '承诺升级款洗澡刷浴刷洗浴搓背刷长柄搓澡刷', 'http://omsproductionimg.yangkeduo.com/images/2018-06-15/f8c700654070b1215435b990a4d6e30e.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2018-06-15/1991b1568cac46fcb8cc56c3431d1993.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-10-29/b52afaddb84c46ac6551a072692b42b0.jpeg', '990', '1290', '6900', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('75594360', '牛筋底春季老北京布鞋 男 休闲鞋工作鞋黑布鞋透气防滑运动鞋', '牛筋底黑布鞋', 'http://t00img.yangkeduo.com/t10img/images/2018-06-05/fd96a7a24ae1ac6f18b26e48d30676cf.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-06-05/a1d3badb9114252db836de215387a6d5.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-07-13/1d70421e5e8485e39cff7c06da56631c.jpeg', '980', '1690', '1790', '已售10万+件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('88041009', '小黑裙香水洗发水护发素沐浴露套装持久留香女控油去屑止痒家庭装', '小黑裙洗发水护发素沐浴露三件套装正品男女', 'http://t00img.yangkeduo.com/t04img/images/2018-05-24/ed880a2649e17914a924f3f4bf89b00b.jpeg', 'http://t00img.yangkeduo.com/t08img/images/2018-05-24/a0245e792950a61b6022f821d9a976b0.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-06-27/65bc426358e301a96cffd4ffa5383ec6.jpeg', '1450', '1650', '5900', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('93803460', '女童牛仔裤中大童高腰裤潮儿童裤子春秋款束脚裤学生小脚宽松长裤', '女童牛仔裤', 'http://t00img.yangkeduo.com/t03img/images/2018-06-10/1a1b69385e811b315fa51513b8e846d6.jpeg', 'http://t00img.yangkeduo.com/t01img/images/2018-06-10/8fd1f6304fc4aeb050a453624a46547b.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-04/bf467cf7227aca2592b60c19d493ece0.jpeg', '2900', '3200', '19900', '已售4万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('94353420', '【小晓帅】童装中大童弹力牛仔裤春秋款童裤男童装长裤子韩版修身', '中大童弹力牛仔裤', 'http://t00img.yangkeduo.com/t07img/images/2018-07-18/378c6965d6333cedcef697eadf1d5487.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-07-18/45f30a9c054482564ec5d2265ba01697.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-18/57cfbc1d42639d4b8d9960fe8c31213c.jpeg', '2360', '4990', '16800', '已售6万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('101758846', '【冰薇儿】高腰弹力大码胖mm牛仔裤女长裤春秋季松紧腰九分显瘦', '七分九分长裤可选26-40码', 'http://t00img.yangkeduo.com/goods/images/2018-08-07/8af1aade86ac71055c6de10f9c089ce9.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-07/aefad6b3f63045e5f2a4caa40fd9818b.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-12-18/15c2f12dc4be7d6bc84fd33d59a6ef01.jpeg', '3960', '5200', '6900', '已售10万+件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('118241846', '湖南特产豆腐乳酱香辣霉豆腐农家自制超辣麻辣味下饭菜850g', '湖南特产瓦罐霉豆腐850g', 'http://t00img.yangkeduo.com/t10img/images/2018-06-30/3be2054f6c97eaecbd82b25eb0a09ba3.jpeg', 'http://t00img.yangkeduo.com/t03img/images/2018-06-30/eadbefbbb7a958d9d277920a21307238.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-10-13/d4e000de29a2db3dc24622e2682a24bb.jpeg', '2980', '3480', '5500', '已售1万件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('136590526', '【花花公子正品】皮带男士休闲自动扣皮带商务百搭自动扣学生腰带', '皮带男', 'http://t00img.yangkeduo.com/t10img/images/2018-06-22/2fa2b2b9b6423fa01b5a769110d20afb.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-06-22/45cee30308baa4995bc4686720423705.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-01/68b91521e1a01573e101b15abcae9793.jpeg', '1380', '4990', '14900', '已售10万+件', '3', '50', '3');
INSERT INTO `recommend` VALUES ('169295119', '【戒烟神器】正品电子烟仿真香烟大烟雾水果味烟油男女清肺蒸汽烟', '【戒烟神器】仿真香烟电子烟套装多口味可选', 'http://omsproductionimg.yangkeduo.com/images/2018-01-14/05bb5251f30076115253eeaca5d6ad1e.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2018-01-14/3ff694d98f06f1db6978b7fbe83d16a4.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-06/16689ceb93d0e167097f16452e7106d2.jpeg', '2980', '3680', '5900', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('178134109', '【爱斯麦】黑色牛仔裤女高腰春秋大码显瘦学生弹力紧身小脚长裤子', '爱斯麦正品黑色紧身牛仔小脚铅笔裤子', 'http://t00img.yangkeduo.com/t09img/images/2018-02-26/f1e9a209a2e2eb62df3a9ec36f1bcd74.jpeg', 'http://t00img.yangkeduo.com/t01img/images/2018-02-26/52d6a1c1c23dc89cd451fbf362f896c3.jpeg', 'http://omsproductionimg.yangkeduo.com/images/2017-11-06/c493dc4c067481beaa3d153cc943f146.png', '3990', '4990', '10800', '已售4万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('228942174', '【爆卖5600万包】采琪采本色抽纸批发母婴可用竹纤维面巾纸整箱装', '采琪采本色抽纸', 'http://t00img.yangkeduo.com/goods/images/2018-09-02/73592e733476de44c2e193a2c9c292e8.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-02/9d2fadb5b9ac0ba847f361248ad15494.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-31/b94868b99fbe4bef85c58e83f1e4e8fd.jpeg', '990', '1390', '3990', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('344112935', '【连续听歌32小时】【买一送三】蓝牙耳机通用所有手机{待机70天}', '蓝牙耳机通用所有手机', 'http://t00img.yangkeduo.com/t03img/images/2018-05-05/690f068dfbf940e9a22f71132766bcd1.jpeg', 'http://t00img.yangkeduo.com/t03img/images/2018-05-05/5175ccf0a7b569aea93396c2b2ad697d.jpeg', 'http://t00img.yangkeduo.com/t11img/images/2018-06-19/cd59c6af23ef22afd5baa8f86b6fbc9b.jpeg', '990', '1300', '19900', '已售8万件', '4', '50', '0');
INSERT INTO `recommend` VALUES ('482053513', '媛萱美女童套装2018新款春装小孩衣服童装春秋装大童运动三件套', '中大童印花刺绣三件套（马甲+卫衣+裤子）', 'http://t00img.yangkeduo.com/goods/images/2018-08-03/de99ad14155622603d996a7b807a366d.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-03/69425cc7135b2ba75c099ff23724ded1.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-03-26/744cc6062d93a415fa5012c6c0e65e3d.jpeg', '4980', '7900', '27900', '已售2万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('554370312', '噢爸兔【超值20/40装】不锈钢清洁球厨房用品铁丝洗碗刷子钢丝球', '20个不锈钢钢丝球', 'http://t00img.yangkeduo.com/t10img/images/2018-05-14/8c1ffe73f416e7293f9cf9a172f1563d.jpeg', 'http://t00img.yangkeduo.com/t01img/images/2018-05-14/9ff4f3612bd095e0d769a38b1ee32b65.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-05-03/c454d9a35960004d644e3ff9b1a16f3a.jpeg', '486', '1550', '1990', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('586250323', '亏本特卖| Apple苹果iphone6 6plus 移动联通电信4G 6p/6二手手机', '二手苹果6系列手机', 'http://t00img.yangkeduo.com/t03img/images/2018-06-21/1ffc1b12d6d6511ca021ff4101f8c05b.jpeg', 'http://t00img.yangkeduo.com/t01img/images/2018-06-21/7fd4c2ee6e53e1ad7ab8e323c1e03d25.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-05-22/2f4e4fcc3362b8730d4a89b6ad3d3aa1.jpeg', '71800', '74800', '369900', '已售3275件', '4', '50', '0');
INSERT INTO `recommend` VALUES ('590417883', '【3秒去油污】油烟净厨房油污净 地板马桶清洁剂 【多场景可用】', '只需3秒去油污', 'http://t00img.yangkeduo.com/goods/images/2018-09-12/099db0601e0c0d8a154eefd0b98f185e.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-12/30d8d7a0ad6324419436fcd8fb5ecc0c.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-12/d91497c08d5455fd09405fe8553f5abc.jpeg', '690', '1000', '5000', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('621723438', '正版包邮 别在吃苦的年纪选择安逸 青春励志文学畅销排行榜书籍', '青春励志文学', 'http://t00img.yangkeduo.com/t09img/images/2018-07-20/a6eb38f1b52054d149a0dcbf9539ebf2.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-20/1cd421b6d97de18dcfb0d3f7e6e5de94.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-20/671c3d632d8a08804d754d423f3d1f11.jpeg', '955', '1280', '13380', '已售1000+件', '1', '50', '2');
INSERT INTO `recommend` VALUES ('626593225', '【亏本 买一送一】斗嘴食间锅巴208g/400g手工老襄阳麻辣二阳零食', '【斗嘴食间】锅巴208g送同款208g', 'http://t00img.yangkeduo.com/t07img/images/2018-07-01/10df32209d5f2f117d37e809f3986ccf.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-07-01/f707607f1ce19b8bcdb3682af9c88d51.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-07-10/7080de753cfc72201e67191f2f5383d4.jpeg', '850', '1090', '3999', '已售10万+件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('659359942', '【防油污】防油防潮厨房贴你和TA厨房贴墙纸铝箔纸自粘壁纸耐高温', '防油厨房贴壁纸', 'http://t00img.yangkeduo.com/t11img/images/2018-06-14/97dc2e90577f3d99b74e1283bfd61da3.jpeg', 'http://t00img.yangkeduo.com/t04img/images/2018-06-14/c4275e1311450df9d34df69ecc2731a3.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-22/ae0aef0f366813879bcf811610d40005.jpeg', '666', '10800', '28800', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('676035553', '湖南特产双娇辣条批发整箱大刀肉面筋零食小吃麻辣辣片150g多规格', '经典小时候的味道辣些年辣条大刀肉', 'http://t00img.yangkeduo.com/goods/images/2018-08-17/91498f5402af975c4dcd711d214d40d3.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-17/7ad3d2295fa7eea185dc07b10df1dd1f.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-08/b9ccfdb67d3480a83786b63814fc4be9.jpeg', '457', '650', '5800', '已售10万+件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('692909163', '2斤新疆四色葡萄干黑加仑红香妃树上黄绿宝石混装四色缤纷葡萄干', '1000g新疆特产混装四色葡萄干', 'http://t00img.yangkeduo.com/goods/images/2018-09-05/a5ad06899fc1d9ca89280d9d285db3f1.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-05/0af1bdd3b2220743626855bb6d859cdf.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-03-14/f39381065db0c2eb6b8dfa4696b9dc05.jpeg', '1689', '2490', '4900', '已售5万件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('724403210', '【10-19修甲修脚套装】指甲剪指甲钳锉刀粉刺针鼻毛剪掏耳勺皮推', '金装指甲剪', 'http://t00img.yangkeduo.com/t02img/images/2018-06-14/239b65c2ca1fafd344459918302fc1c1.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-06-14/c3f3b9d44f9a55a483b4b939bbb4a9dd.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-05-14/463e2b59fb9385576fb6cac6250fb6f4.jpeg', '610', '790', '2800', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('726060346', 'DATASS苹果数据线7Plus手机6s加长5s快充充电线iPhone6充电器线X', '苹果数据线', 'http://t00img.yangkeduo.com/t09img/images/2018-06-18/da30bb7f94c425a89f049e326ac81726.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-12/f7f317044e5881caf3e025d7ea2d0f99.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-10/5211143d22f4328931632fc03407b0fb.jpeg', '490', '590', '1990', '已售10万+件', '4', '50', '0');
INSERT INTO `recommend` VALUES ('745340365', '【真皮 软牛皮】透步皮鞋男夏季男鞋驾车鞋男士凉鞋商务休闲鞋子', '透步正品皮鞋男真皮', 'http://t00img.yangkeduo.com/goods/images/2018-08-02/d826717c8c519cc275a8eb764843413d.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-02/6522620b12f472e52c09ad2fd0d7c43a.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-04-16/2b4f92a7e7c7047d0fa8c7295f7b2c62.jpeg', '4720', '9900', '88800', '已售10万+件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('787864129', '【渔大人】寿司海苔大片套餐紫菜包饭多套餐可选', '【2018寿司海苔】寿司包饭专用多规格', 'http://t00img.yangkeduo.com/goods/images/2018-07-29/a2ac42bcbe7ad74d239c1183722d6320.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-29/74ce1f8136f9e1f61634d2137ab28fd9.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-06-12/c649793769fb2b477c7f68b457ca16dc.jpeg', '552', '1200', '4900', '已售10万+件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('844359129', '加大加厚旋转拖把桶墩布桶加强杆+钢盘+钢篮地拖把桶拖布桶好神拖', '加大加厚旋转拖把出口外贸优选品质厂家直销', 'http://t00img.yangkeduo.com/goods/images/2018-08-07/539840948347cee1f6073ff67e983da6.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-07/29f7bae076e9b106928f05174c91af02.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-06-08/67cd5333f0a6ac2e763feab5a2eb8d17.jpeg', '3590', '3890', '19900', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('852030706', '南极人正品【买5送5共10双】男士袜子中筒袜短筒袜四季棉质男袋装', '南极人袜子', 'http://t00img.yangkeduo.com/t03img/images/2018-03-30/a9acd1b4c9205515c9d817672721ce20.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-03-30/aaa81c3e30f306164bb24ce50fea70fd.jpeg', 'http://t00img.yangkeduo.com/t11img/images/2018-04-17/d89f9f2218e739fb936321882d77f13f.jpeg', '1290', '1890', '3900', '已售10万+件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('863231799', '【爆款推荐】华为p20手机 全面屏徕卡三摄拍照华为手机正品pro', '华为p20手机 p20Pro', 'http://t00img.yangkeduo.com/goods/images/2018-09-02/53d5e139519255ba880480ea8ec553e3.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-02/c2a0deff15467cc7b5fe5f28c3170559.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-04-19/51f2570747b64b42cf20a8fcd0bb948e.jpeg', '273800', '276900', '539000', '已售1239件', '4', '50', '0');
INSERT INTO `recommend` VALUES ('863726260', '【18年新货】新疆特产吐鲁番葡萄干无核无籽零食500g2斤半斤可选', '新疆吐鲁番无籽葡萄干', 'http://t00img.yangkeduo.com/goods/images/2018-08-30/b29a782b676541760f96a906506c9f64.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-30/27c806d7a283f8184096d93f76f3aac0.jpeg', 'http://t00img.yangkeduo.com/t05img/images/2018-03-29/4662f2d2f126959d32443a1ad28f6081.jpeg', '980', '1290', '10000', '已售2万件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('875385046', '智能手表手机插卡儿童电话手表中小学生天才微聊成人防水定位防丢', '智能手表手机可插卡打电话防水定位音乐拍照', 'http://t00img.yangkeduo.com/goods/images/2018-09-07/56a694631f035eadd83f7dffc8b2c170.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-12/7adb65531ef71184f7e703ac5e28999a.jpeg', 'http://t00img.yangkeduo.com/t01img/images/2018-07-12/98e04ba5e26ee6212162d5d8548624a5.jpeg', '2850', '3500', '6501', '已售10万+件', '4', '50', '0');
INSERT INTO `recommend` VALUES ('882888828', '亏本冲量厂家直销破损补发抽屉化妆品收纳盒桌面置物饰品收纳盒架', '桌面化妆品收纳盒', 'http://t00img.yangkeduo.com/t07img/images/2018-06-06/43526c71d4e9266b070ebf0c26ae0817.jpeg', 'http://t00img.yangkeduo.com/t07img/images/2018-06-06/d6adb7a168fbcf37fc56832a6cd106c4.jpeg', 'http://t00img.yangkeduo.com/t02img/images/2018-03-31/ab85553637fdddcc295cec711a4a0913.jpeg', '760', '990', '3880', '已售10万+件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('949987702', '【全新正品】华为 畅享8Plus 全网通4G手机 旗舰店正品 畅想8plus', '华为 畅享8Plus', 'http://t00img.yangkeduo.com/t02img/images/2018-06-21/c32cecd7ca629c6f8df7d271a88472e2.jpeg', 'http://t00img.yangkeduo.com/t03img/images/2018-06-21/97cacf16358cd3d1c7136d216a81137e.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-04-06/a4a6577dc60b5df16edf238a0e1cd243.jpeg', '117500', '117800', '169900', '已售1万件', '4', '50', '0');
INSERT INTO `recommend` VALUES ('976604348', '【底价清仓】顺馨 新疆吐鲁番四色葡萄干混装1000g', '新疆葡萄干', 'http://t00img.yangkeduo.com/t01img/images/2018-05-19/28b7862685cf52a055316a499995fc9c.jpeg', 'http://t00img.yangkeduo.com/t10img/images/2018-05-19/4332646b1171f2c7352a864585e0bf36.jpeg', 'http://t00img.yangkeduo.com/t09img/images/2018-07-12/8854d14fb9ca09bb2f39099fe8894593.jpeg', '1720', '2079', '3000', '已售6万件', '5', '50', '0');
INSERT INTO `recommend` VALUES ('2351564694', '多层环保饺子盒冰箱收纳盒大号速冻馄饨盒海鲜水果蔬菜保鲜盒', '多层环保饺子盒冰箱保鲜收纳盒', 'http://t00img.yangkeduo.com/goods/images/2018-07-24/5a080f37a493d75f9e49b39f2a908e38.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-07-24/4a726b21574206f83c37d1c4f68b4856.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-02/88b3127aea77f4b2281213f74cd2578e.jpeg', '590', '690', '4800', '已售1万件', '2', '50', '0');
INSERT INTO `recommend` VALUES ('2459679200', '【花花公子贵宾正品】潮休闲运动鞋学生跑步鞋男单鞋子轻便透气', '花花公子贵宾飞织男鞋', 'http://t00img.yangkeduo.com/goods/images/2018-08-15/e0ba59e1f28566155b45b164de9372a9.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-15/54fe60fbb8e2f79f6e8d0d919909f2dd.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-21/384a84088457fe98b3d451b169440b69.jpeg', '2690', '6990', '12900', '已售10万+件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('2491622905', '童装女童秋装套装2018新款春秋季小女孩洋气儿童时髦运动三件套', '女童春秋装套装2018新款儿童三件套', 'http://t00img.yangkeduo.com/goods/images/2018-09-09/96d93f3c3739a6e910f9d11bcad37298.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-09-09/f1a8e44dfc8249a164bfbeafcd0dad25.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-13/07b2f91dc858621176bcc473e97293f0.jpeg', '5680', '7500', '18800', '已售1万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('2570072250', '【花花公子贵宾,晋江冷粘鞋】美国品牌透气防臭飞织大码男运动鞋', '花花公子贵宾男鞋', 'http://t00img.yangkeduo.com/goods/images/2018-08-26/bb75e1d2f253061024ad43c1ef52b908.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-26/2c5c90fc139d0b3f562e50d98a3afa6f.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-26/c4b8dce28810d4ebedae438158ed4f0c.jpeg', '4990', '19900', '20000', '已售2万件', '3', '50', '0');
INSERT INTO `recommend` VALUES ('2635286942', '俏丽苏格子长袖衬衣女2018秋新款韩版宽松外套打底衫女士衬衫上衣', '新款韩版百搭女装打底衫女士衬衫上衣', 'http://t00img.yangkeduo.com/goods/images/2018-08-17/571add96718caf017b5eef9b7a6a788c.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-17/091d8f7dbfad772ab2843351516a364d.jpeg', 'http://t00img.yangkeduo.com/goods/images/2018-08-27/f3947b680054d0f30cf6ba45bc70cf93.jpeg', '2980', '4500', '15800', '已售10万+件', '3', '50', '0');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_pwd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_sex` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_birthday` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_sign` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_nickname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('5', '13666666666', null, '13666666666', '女', '福州', '2000-01-01', '买买买！！！', '', 'http://localhost:3000/avatar_uploads/avatar_default.jpg');
INSERT INTO `user_info` VALUES ('8', '15666666666', null, '15666666666', '女', '', '', '', '莫得感情的机器人', 'http://localhost:3000/avatar_uploads/avatar_default.jpg');
INSERT INTO `user_info` VALUES ('9', '来来来', 'a163a36c731d1ac664841b6d196a05e3', '18666666666', '男', '', '', '', 'HS', 'http://localhost:3000/avatar_uploads/upload_5a67435fbb680332a6a3aa62014f5aa2.jpg');
