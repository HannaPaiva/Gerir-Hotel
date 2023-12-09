-- --------------------------------------------------------
-- Anfitrião:                    127.0.0.1
-- Versão do servidor:           10.4.28-MariaDB - mariadb.org binary distribution
-- SO do servidor:               Win64
-- HeidiSQL Versão:              12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- A despejar estrutura da base de dados para xys_store
CREATE DATABASE IF NOT EXISTS `xys_store` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `xys_store`;

-- A despejar estrutura para tabela xys_store.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `address` varchar(300) DEFAULT NULL,
  `identity_card` varchar(45) DEFAULT NULL,
  `date_of_creation` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela xys_store.customers: ~2 rows (aproximadamente)
INSERT INTO `customers` (`id`, `name`, `last_name`, `date_of_birth`, `address`, `identity_card`, `date_of_creation`) VALUES
	(1, 'Maria', 'Santos', '2000-02-20', 'rua bla bla bla', 'aaaaaaaa', '2023-12-20'),
	(2, 'Luan', 'do Carmo', '2003-12-02', 'wwwwwwwww', 'aaaaaaaa', '2023-12-02');

-- A despejar estrutura para tabela xys_store.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id_customer` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `details` varchar(45) DEFAULT NULL,
  `carrier` varchar(45) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `full_price` double DEFAULT NULL,
  PRIMARY KEY (`id_customer`,`id_product`),
  KEY `fk_customers_has_products_products1_idx` (`id_product`),
  KEY `fk_customers_has_products_customers_idx` (`id_customer`),
  CONSTRAINT `fk_customers_has_products_customers` FOREIGN KEY (`id_customer`) REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_has_products_products1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id_product`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela xys_store.orders: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela xys_store.products
CREATE TABLE IF NOT EXISTS `products` (
  `id_product` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `supplier` varchar(45) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id_product`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela xys_store.products: ~2 rows (aproximadamente)
INSERT INTO `products` (`id_product`, `name`, `price`, `supplier`, `description`) VALUES
	(1, 'casaco', 10, 'SHEIN', 'casaco preto de bolinhas'),
	(2, 'sapato', 40, 'NIKE', 'Sapato top confia');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
