CREATE DATABASE  IF NOT EXISTS `hotel` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `hotel`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hotel
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.28-MariaDB

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
-- Table structure for table `agencia`
--

DROP TABLE IF EXISTS `agencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agencia` (
  `idAgencia` int(11) NOT NULL AUTO_INCREMENT,
  `nomeAgencia` varchar(45) DEFAULT NULL,
  `contatoGeral` varchar(45) DEFAULT NULL,
  `nomeRepresentante` varchar(45) DEFAULT NULL,
  `telefoneRepresentante` varchar(45) DEFAULT NULL,
  `comissaoAgencia` double DEFAULT NULL,
  PRIMARY KEY (`idAgencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agencia`
--

LOCK TABLES `agencia` WRITE;
/*!40000 ALTER TABLE `agencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `agencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agenciametodo`
--

DROP TABLE IF EXISTS `agenciametodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agenciametodo` (
  `Agencia_idAgencia` int(11) NOT NULL,
  `MetodoReserva_idMetodo` int(11) NOT NULL,
  PRIMARY KEY (`Agencia_idAgencia`,`MetodoReserva_idMetodo`),
  KEY `fk_Agencia_has_MetodoReserva_MetodoReserva1_idx` (`MetodoReserva_idMetodo`),
  KEY `fk_Agencia_has_MetodoReserva_Agencia1_idx` (`Agencia_idAgencia`),
  CONSTRAINT `fk_Agencia_has_MetodoReserva_Agencia1` FOREIGN KEY (`Agencia_idAgencia`) REFERENCES `agencia` (`idAgencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agencia_has_MetodoReserva_MetodoReserva1` FOREIGN KEY (`MetodoReserva_idMetodo`) REFERENCES `metodoreserva` (`idMetodo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agenciametodo`
--

LOCK TABLES `agenciametodo` WRITE;
/*!40000 ALTER TABLE `agenciametodo` DISABLE KEYS */;
/*!40000 ALTER TABLE `agenciametodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `primeiroNome` varchar(60) NOT NULL,
  `nomeDoMeio` varchar(60) DEFAULT NULL,
  `ultimoNome` varchar(45) NOT NULL,
  `contribuinte` varchar(45) DEFAULT NULL,
  `CC` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT NULL,
  `genero` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'maria','luana','rizard','cccc','cc','maria@gmail.com','3434234234',NULL,NULL,NULL),(2,'julia','pc','picoito','aaaa',NULL,'julia@outlook.com',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento` (
  `idDepartamento` int(11) NOT NULL,
  `idChefe` int(11) DEFAULT NULL,
  `nomeDepartamento` varchar(45) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  PRIMARY KEY (`idDepartamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES (1,1,'Receção','sauhsiudsad');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `idFuncionario` int(11) NOT NULL AUTO_INCREMENT,
  `idDepartamento` int(11) NOT NULL,
  `primeiroNome` varchar(60) NOT NULL,
  `nomeDoMeio` varchar(60) DEFAULT NULL,
  `ultimoNome` varchar(45) NOT NULL,
  `contribuinte` varchar(45) DEFAULT NULL,
  `CC` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `salario` double DEFAULT NULL,
  `dataEntrada` timestamp NULL DEFAULT NULL,
  `dataSaida` timestamp NULL DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`,`idDepartamento`),
  KEY `fk_Funcionario_Departamento1_idx` (`idDepartamento`),
  CONSTRAINT `fk_Funcionario_Departamento1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,1,'Hanna ','Beatriz','Paiva','cccc','aaaa','ssss',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospede`
--

DROP TABLE IF EXISTS `hospede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospede` (
  `idHospede` int(11) NOT NULL AUTO_INCREMENT,
  `primeiroNome` varchar(60) NOT NULL,
  `nomeDoMeio` varchar(60) DEFAULT NULL,
  `ultimoNome` varchar(45) NOT NULL,
  `CC` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idHospede`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospede`
--

LOCK TABLES `hospede` WRITE;
/*!40000 ALTER TABLE `hospede` DISABLE KEYS */;
/*!40000 ALTER TABLE `hospede` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodoreserva`
--

DROP TABLE IF EXISTS `metodoreserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodoreserva` (
  `idMetodo` int(11) NOT NULL,
  `nomeMetodo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMetodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodoreserva`
--

LOCK TABLES `metodoreserva` WRITE;
/*!40000 ALTER TABLE `metodoreserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `metodoreserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `idPagamento` int(11) NOT NULL,
  `valorTotal` double DEFAULT NULL,
  `metodoPagamento` varchar(45) DEFAULT NULL,
  `tarifaReembolsavel` tinyint(4) DEFAULT NULL,
  `dataPagamento` timestamp NULL DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `status` enum('pago','não pago') DEFAULT NULL,
  `idReserva` int(11) NOT NULL,
  PRIMARY KEY (`idPagamento`),
  KEY `fk_Pagamento_Reserva1_idx` (`idReserva`),
  CONSTRAINT `fk_Pagamento_Reserva1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preco`
--

DROP TABLE IF EXISTS `preco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preco` (
  `idTarifa` int(11) NOT NULL,
  `idReserva` int(11) NOT NULL,
  `precoManual` double DEFAULT NULL,
  PRIMARY KEY (`idTarifa`,`idReserva`),
  KEY `fk_Tarifa_has_Reserva_Reserva1_idx` (`idReserva`),
  KEY `fk_Tarifa_has_Reserva_Tarifa1_idx` (`idTarifa`),
  CONSTRAINT `fk_Tarifa_has_Reserva_Reserva1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarifa_has_Reserva_Tarifa1` FOREIGN KEY (`idTarifa`) REFERENCES `tarifa` (`idTarifa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preco`
--

LOCK TABLES `preco` WRITE;
/*!40000 ALTER TABLE `preco` DISABLE KEYS */;
/*!40000 ALTER TABLE `preco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quarto`
--

DROP TABLE IF EXISTS `quarto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quarto` (
  `idQuarto` int(11) NOT NULL,
  `numQuarto` varchar(10) DEFAULT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `andar` tinyint(4) DEFAULT NULL,
  `tipologia` varchar(45) DEFAULT NULL,
  `qtdCamaCasal` varchar(45) DEFAULT NULL,
  `qtdCamaSolteiro` varchar(45) DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT NULL,
  `estaDisponivel` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idQuarto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quarto`
--

LOCK TABLES `quarto` WRITE;
/*!40000 ALTER TABLE `quarto` DISABLE KEYS */;
/*!40000 ALTER TABLE `quarto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `idReserva` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente` int(11) NOT NULL,
  `dataEntrada` date DEFAULT NULL,
  `dataSaida` date DEFAULT NULL,
  `numAdultos` tinyint(4) DEFAULT NULL,
  `numCriancas` tinyint(4) DEFAULT NULL,
  `numBebes` tinyint(4) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `tipologiaContratada` varchar(45) DEFAULT NULL,
  `Agencia_has_MetodoReserva_Agencia_idAgencia` int(11) NOT NULL,
  `Agencia_has_MetodoReserva_MetodoReserva_idMetodo` int(11) NOT NULL,
  PRIMARY KEY (`idReserva`),
  KEY `fk_Reserva_Cliente1_idx` (`idCliente`),
  KEY `fk_Reserva_Agencia_has_MetodoReserva1_idx` (`Agencia_has_MetodoReserva_Agencia_idAgencia`,`Agencia_has_MetodoReserva_MetodoReserva_idMetodo`),
  CONSTRAINT `fk_Reserva_Agencia_has_MetodoReserva1` FOREIGN KEY (`Agencia_has_MetodoReserva_Agencia_idAgencia`, `Agencia_has_MetodoReserva_MetodoReserva_idMetodo`) REFERENCES `agenciametodo` (`Agencia_idAgencia`, `MetodoReserva_idMetodo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Cliente1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservahospede`
--

DROP TABLE IF EXISTS `reservahospede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservahospede` (
  `ReservaQuarto_idQuarto` int(11) NOT NULL,
  `ReservaQuarto_idReserva` int(11) NOT NULL,
  `Hospede_idHospede` int(11) NOT NULL,
  PRIMARY KEY (`ReservaQuarto_idQuarto`,`ReservaQuarto_idReserva`,`Hospede_idHospede`),
  KEY `fk_ReservaQuarto_has_Hospede_Hospede1_idx` (`Hospede_idHospede`),
  KEY `fk_ReservaQuarto_has_Hospede_ReservaQuarto1_idx` (`ReservaQuarto_idQuarto`,`ReservaQuarto_idReserva`),
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_Hospede1` FOREIGN KEY (`Hospede_idHospede`) REFERENCES `hospede` (`idHospede`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_ReservaQuarto1` FOREIGN KEY (`ReservaQuarto_idQuarto`, `ReservaQuarto_idReserva`) REFERENCES `reservaquarto` (`idQuarto`, `idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservahospede`
--

LOCK TABLES `reservahospede` WRITE;
/*!40000 ALTER TABLE `reservahospede` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservahospede` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservaquarto`
--

DROP TABLE IF EXISTS `reservaquarto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservaquarto` (
  `idQuarto` int(11) NOT NULL,
  `idReserva` int(11) NOT NULL,
  `observacoes` text DEFAULT NULL,
  PRIMARY KEY (`idQuarto`,`idReserva`),
  KEY `fk_Quarto_has_Reserva_Reserva1_idx` (`idReserva`),
  KEY `fk_Quarto_has_Reserva_Quarto_idx` (`idQuarto`),
  CONSTRAINT `fk_Quarto_has_Reserva_Quarto` FOREIGN KEY (`idQuarto`) REFERENCES `quarto` (`idQuarto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quarto_has_Reserva_Reserva1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservaquarto`
--

LOCK TABLES `reservaquarto` WRITE;
/*!40000 ALTER TABLE `reservaquarto` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservaquarto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servico`
--

DROP TABLE IF EXISTS `servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servico` (
  `idServico` int(11) NOT NULL AUTO_INCREMENT,
  `nomeServico` varchar(45) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `idDepartamento` int(11) NOT NULL,
  PRIMARY KEY (`idServico`),
  KEY `fk_Servico_Departamento1_idx` (`idDepartamento`),
  CONSTRAINT `fk_Servico_Departamento1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico`
--

LOCK TABLES `servico` WRITE;
/*!40000 ALTER TABLE `servico` DISABLE KEYS */;
/*!40000 ALTER TABLE `servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicoprestado`
--

DROP TABLE IF EXISTS `servicoprestado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicoprestado` (
  `idReserva` int(11) NOT NULL,
  `idServico` int(11) NOT NULL,
  `detalhes` text DEFAULT NULL,
  `dataHora` datetime DEFAULT NULL,
  `Funcionario_idFuncionario` int(11) NOT NULL,
  `Funcionario_idDepartamento` int(11) NOT NULL,
  PRIMARY KEY (`idReserva`,`idServico`),
  KEY `fk_Reserva_has_Servico_Servico1_idx` (`idServico`),
  KEY `fk_Reserva_has_Servico_Reserva1_idx` (`idReserva`),
  KEY `fk_ServicoPrestado_Funcionario1_idx` (`Funcionario_idFuncionario`,`Funcionario_idDepartamento`),
  CONSTRAINT `fk_Reserva_has_Servico_Reserva1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_has_Servico_Servico1` FOREIGN KEY (`idServico`) REFERENCES `servico` (`idServico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServicoPrestado_Funcionario1` FOREIGN KEY (`Funcionario_idFuncionario`, `Funcionario_idDepartamento`) REFERENCES `funcionario` (`idFuncionario`, `idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicoprestado`
--

LOCK TABLES `servicoprestado` WRITE;
/*!40000 ALTER TABLE `servicoprestado` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicoprestado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarifa`
--

DROP TABLE IF EXISTS `tarifa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarifa` (
  `idTarifa` int(11) NOT NULL AUTO_INCREMENT,
  `dataInicio` date DEFAULT NULL,
  `dataFim` date DEFAULT NULL,
  `precoNoiteAdulto` double DEFAULT NULL,
  `precoNoiteCrianca` double DEFAULT NULL,
  `tipologia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTarifa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarifa`
--

LOCK TABLES `tarifa` WRITE;
/*!40000 ALTER TABLE `tarifa` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarifa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hotel'
--

--
-- Dumping routines for database 'hotel'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-25  0:28:35
