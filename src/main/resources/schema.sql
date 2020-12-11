-- Adminer 4.3.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `group_variants`;
CREATE TABLE `group_variants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variant_name` varchar(255) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_group_variant_product_group` (`group_id`),
  CONSTRAINT `FK_group_variant_product_group` FOREIGN KEY (`group_id`) REFERENCES `product_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `group_variants` (`id`, `variant_name`, `group_id`) VALUES
(1,	'Blue',	1),
(2,	'White',	1);

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `created` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `total_price` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` varchar(255) DEFAULT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_order_item_group_variant` (`product_variant_id`),
  KEY `FK_order_items_order` (`order_id`),
  KEY `FK_order_item_product` (`product_id`),
  CONSTRAINT `FK_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FK_order_item_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FK_order_item_group_variant` FOREIGN KEY (`product_variant_id`) REFERENCES `group_variants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` varchar(5) DEFAULT NULL,
  `description` text,
  `created` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_product_product_group` (`group_id`),
  KEY `FK_product_user` (`user_id`),
  CONSTRAINT `FK_product_product_group` FOREIGN KEY (`group_id`) REFERENCES `product_groups` (`id`),
  CONSTRAINT `FK_product_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `products` (`id`, `name`, `price`, `description`, `created`, `group_id`, `user_id`) VALUES
(6,	'Shirt',	'24',	NULL,	'2017-05-02 15:58:11',	13,	1),
(7,	'Sweat Shirt',	'60',	NULL,	'2017-05-02 15:58:18',	13,	1),
(8,	'Flag',	'24',	NULL,	'2017-05-02 16:05:46',	1,	1),
(9,	'Golf V',	'20000',	NULL,	'2017-04-19 15:53:40',	1,	1);

DROP TABLE IF EXISTS `product_groups`;
CREATE TABLE `product_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` varchar(255) DEFAULT NULL,
  `group_name` varchar(255) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `product_groups` (`id`, `created`, `group_name`, `price`) VALUES
(1,	'2017-04-19 12:47:33',	'Vehicles',	''),
(13,	'2017-05-02 10:30:22',	'Clothes',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access_token` varchar(255) DEFAULT NULL,
  `created` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_user_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `users` (`id`, `access_token`, `created`, `email`, `name`, `password`) VALUES
(1,	NULL,	NULL,	'b',	'Boris Trivic',	'$2a$04$WdK723i7N7Gql8VeziMjvOudXQzSg43ahCIVK83aB1sZ91X0zkFqq'),
(2,	NULL,	NULL,	'user',	'Test User',	'$2a$04$6awb3tKYlsw6uyay5.Rv1.nAiw/Tp3N5GjVtckRhqaUI64.Gp43gO');

-- 2017-05-02 14:08:31
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int not NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

ALTER TABLE `order_items`
CHANGE `order_id` `order_id` int(11) NOT NULL AFTER `product_variant_id`,
CHANGE `product_id` `product_id` int(11) NOT NULL AFTER `order_id`;

ALTER TABLE `group_variants`
CHANGE `variant_name` `variant_name` varchar(255) COLLATE 'utf8_general_ci' NOT NULL AFTER `id`,
CHANGE `group_id` `group_id` int(11) NOT NULL AFTER `variant_name`;

------
update `orders` set created = "2017-06-03 00:00:00";
ALTER TABLE `orders`
CHANGE `created` `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `comment`,
CHANGE `name` `name` varchar(255) COLLATE 'utf8_general_ci' NOT NULL AFTER `created`;

-----

update product_groups set created = '2017-06-03 00:00:00';
ALTER TABLE `product_groups`
CHANGE `created` `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `id`,
CHANGE `group_name` `group_name` varchar(255) COLLATE 'utf8_general_ci' NOT NULL AFTER `created`;

-----
ALTER TABLE `users`
CHANGE `email` `email` varchar(255) COLLATE 'utf8_general_ci' NOT NULL AFTER `created`,
CHANGE `name` `name` varchar(255) COLLATE 'utf8_general_ci' NOT NULL AFTER `email`;