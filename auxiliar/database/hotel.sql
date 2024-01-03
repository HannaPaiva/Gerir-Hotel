-- --------------------------------------------------------
-- Anfitrião:                    127.0.0.1
-- Versão do servidor:           10.4.32-MariaDB - mariadb.org binary distribution
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


-- A despejar estrutura da base de dados para hotel
CREATE DATABASE IF NOT EXISTS `hotel` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `hotel`;

-- A despejar estrutura para tabela hotel.agencia
CREATE TABLE IF NOT EXISTS `agencia` (
  `idAgencia` int(11) NOT NULL AUTO_INCREMENT,
  `nomeAgencia` varchar(45) DEFAULT NULL,
  `contatoGeral` varchar(45) DEFAULT NULL,
  `nomeRepresentante` varchar(45) DEFAULT NULL,
  `telefoneRepresentante` varchar(45) DEFAULT NULL,
  `comissaoAgencia` double DEFAULT NULL,
  PRIMARY KEY (`idAgencia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.agencia: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.agenciametodo
CREATE TABLE IF NOT EXISTS `agenciametodo` (
  `idAgencia` int(11) NOT NULL,
  `idMetodo` int(11) NOT NULL,
  PRIMARY KEY (`idAgencia`,`idMetodo`),
  KEY `fk_Agencia_has_MetodoReserva_MetodoReserva1_idx` (`idMetodo`),
  KEY `fk_Agencia_has_MetodoReserva_Agencia1_idx` (`idAgencia`),
  CONSTRAINT `fk_Agencia_has_MetodoReserva_Agencia1` FOREIGN KEY (`idAgencia`) REFERENCES `agencia` (`idAgencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agencia_has_MetodoReserva_MetodoReserva1` FOREIGN KEY (`idMetodo`) REFERENCES `metodoreserva` (`idMetodo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.agenciametodo: ~0 rows (aproximadamente)

-- A despejar estrutura para procedimento hotel.apagar_tarifas
DELIMITER //
CREATE PROCEDURE `apagar_tarifas`(
    IN data_inicio DATE,
    IN data_fim DATE,
    IN num_quarto INT
)
BEGIN
    DELETE FROM tarifa
    WHERE data BETWEEN data_inicio AND data_fim
    AND numQuarto = num_quarto;
END//
DELIMITER ;

-- A despejar estrutura para tabela hotel.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `idCliente` int(11) NOT NULL AUTO_INCREMENT,
  `primeiroNome` varchar(60) NOT NULL,
  `nomeDoMeio` varchar(60) DEFAULT NULL,
  `UltimoNome` varchar(45) NOT NULL,
  `contribuinte` varchar(45) DEFAULT NULL,
  `CC` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT NULL,
   `genero` ENUM('m', 'f', 'o') DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.cliente: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.departamento
CREATE TABLE IF NOT EXISTS `departamento` (
  `idDepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `idChefe` int(11) DEFAULT NULL,
  `nomeDepartamento` varchar(45) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  PRIMARY KEY (`idDepartamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.departamento: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.diaria
CREATE TABLE IF NOT EXISTS `diaria` (
  `idTarifa` int(11) NOT NULL,
  `idReserva` int(11) NOT NULL,
  PRIMARY KEY (`idTarifa`,`idReserva`),
  KEY `fk_Tarifa_has_Reserva_Reserva1_idx` (`idReserva`),
  KEY `fk_Tarifa_has_Reserva_Tarifa1_idx` (`idTarifa`),
  CONSTRAINT `fk_Tarifa_has_Reserva_Reserva1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarifa_has_Reserva_Tarifa1` FOREIGN KEY (`idTarifa`) REFERENCES `tarifa` (`idTarifa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.diaria: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.funcionario
CREATE TABLE IF NOT EXISTS `funcionario` (
  `idFuncionario` int(11) NOT NULL AUTO_INCREMENT,
  `primeiroNome` varchar(60) NOT NULL,
  `nomeDoMeio` varchar(60) DEFAULT NULL,
  `UltimoNome` varchar(45) NOT NULL,
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
  `idDepartamento` int(11) NOT NULL,
  `genero` ENUM('m', 'f', 'o') DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`),
  KEY `fk_Funcionario_Departamento1_idx` (`idDepartamento`),
  CONSTRAINT `fk_Funcionario_Departamento1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.funcionario: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.hospede
CREATE TABLE IF NOT EXISTS `hospede` (
  `idHospede` int(11) NOT NULL AUTO_INCREMENT,
  `primeiroNome` varchar(60) NOT NULL,
  `nomeDoMeio` varchar(60) DEFAULT NULL,
  `UltimoNome` varchar(45) NOT NULL,
  `CC` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idHospede`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.hospede: ~0 rows (aproximadamente)

-- A despejar estrutura para procedimento hotel.inserir_tarifas
DELIMITER //
CREATE PROCEDURE `inserir_tarifas`(
    IN data_inicio DATE,
    IN data_fim DATE,
    IN preco_noite_adulto DOUBLE,
    IN preco_noite_crianca DOUBLE,
    IN num_quarto INT
)
BEGIN
    WHILE data_inicio <= data_fim DO
        IF EXISTS (SELECT 1 FROM tarifa WHERE data = data_inicio AND numQuarto = num_quarto) THEN
            UPDATE tarifa
            SET precoNoiteAdulto = preco_noite_adulto,
                precoNoiteCrianca = preco_noite_crianca
            WHERE data = data_inicio AND numQuarto = num_quarto;
        ELSE
            INSERT INTO tarifa (data, precoNoiteAdulto, precoNoiteCrianca, numQuarto)
            VALUES (data_inicio, preco_noite_adulto, preco_noite_crianca, num_quarto);
        END IF;

        SET data_inicio = DATE_ADD(data_inicio, INTERVAL 1 DAY);
    END WHILE;
END//
DELIMITER ;

-- A despejar estrutura para tabela hotel.metodoreserva
CREATE TABLE IF NOT EXISTS `metodoreserva` (
  `idMetodo` int(11) NOT NULL,
  `nomeMetodo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMetodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.metodoreserva: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.pagamento
CREATE TABLE IF NOT EXISTS `pagamento` (
  `idPagamento` int(11) NOT NULL AUTO_INCREMENT,
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

-- A despejar dados para tabela hotel.pagamento: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.quarto
CREATE TABLE IF NOT EXISTS `quarto` (
  `numQuarto` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) DEFAULT NULL,
  `andar` tinyint(4) DEFAULT NULL,
  `tipologia` varchar(45) DEFAULT NULL,
  `qtdCamaCasal` varchar(45) DEFAULT NULL,
  `qtdCamaSolteiro` varchar(45) DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT NULL,
  `estaDisponivel` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`numQuarto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.quarto: ~2 rows (aproximadamente)
INSERT INTO `quarto` (`numQuarto`, `descricao`, `andar`, `tipologia`, `qtdCamaCasal`, `qtdCamaSolteiro`, `ativo`, `estaDisponivel`) VALUES
	(1, '111', 1, 't2', '1', '1', 1, 1),
	(2, 't2 top', 2, 't2', '1', '1', 1, 1);

-- A despejar estrutura para tabela hotel.reserva
CREATE TABLE IF NOT EXISTS `reserva` (
  `idReserva` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente` int(11) NOT NULL,
  `dataEntrada` date DEFAULT NULL,
  `dataSaida` date DEFAULT NULL,
  `numAdultos` tinyint(4) DEFAULT NULL,
  `numCriancas` tinyint(4) DEFAULT NULL,
  `numBebes` tinyint(4) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `tipologiaContratada` varchar(45) DEFAULT NULL,
  `idAgencia` int(11) NOT NULL,
  `idMetodo` int(11) NOT NULL,
  PRIMARY KEY (`idReserva`),
  KEY `fk_Reserva_Cliente1_idx` (`idCliente`),
  KEY `fk_Reserva_Agencia_has_MetodoReserva1_idx` (`idAgencia`,`idMetodo`),
  CONSTRAINT `fk_Reserva_Agencia_has_MetodoReserva1` FOREIGN KEY (`idAgencia`, `idMetodo`) REFERENCES `agenciametodo` (`idAgencia`, `idMetodo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Cliente1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.reserva: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.reservahospede
CREATE TABLE IF NOT EXISTS `reservahospede` (
  `numQuarto` int(11) NOT NULL,
  `idReserva` int(11) NOT NULL,
  `idHospede` int(11) NOT NULL,
  PRIMARY KEY (`numQuarto`,`idReserva`,`idHospede`),
  KEY `fk_ReservaQuarto_has_Hospede_Hospede1_idx` (`idHospede`),
  KEY `fk_ReservaQuarto_has_Hospede_ReservaQuarto1_idx` (`numQuarto`,`idReserva`),
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_Hospede1` FOREIGN KEY (`idHospede`) REFERENCES `hospede` (`idHospede`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_ReservaQuarto1` FOREIGN KEY (`numQuarto`, `idReserva`) REFERENCES `reservaquarto` (`numQuarto`, `idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.reservahospede: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.reservaquarto
CREATE TABLE IF NOT EXISTS `reservaquarto` (
  `numQuarto` int(11) NOT NULL,
  `idReserva` int(11) NOT NULL,
  `observacoes` text DEFAULT NULL,
  PRIMARY KEY (`numQuarto`,`idReserva`),
  KEY `fk_Quarto_has_Reserva_Reserva1_idx` (`idReserva`),
  KEY `fk_Quarto_has_Reserva_Quarto_idx` (`numQuarto`),
  CONSTRAINT `fk_Quarto_has_Reserva_Quarto` FOREIGN KEY (`numQuarto`) REFERENCES `quarto` (`numQuarto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quarto_has_Reserva_Reserva1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.reservaquarto: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.servico
CREATE TABLE IF NOT EXISTS `servico` (
  `idServico` int(11) NOT NULL AUTO_INCREMENT,
  `nomeServico` varchar(45) DEFAULT NULL,
  `preco` double DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `idDepartamento` int(11) NOT NULL,
  PRIMARY KEY (`idServico`),
  KEY `fk_Servico_Departamento1_idx` (`idDepartamento`),
  CONSTRAINT `fk_Servico_Departamento1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.servico: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.servicoprestado
CREATE TABLE IF NOT EXISTS `servicoprestado` (
  `idServico` int(11) NOT NULL,
  `detalhes` text DEFAULT NULL,
  `dataHora` datetime DEFAULT NULL,
  `idFuncionario` int(11) NOT NULL,
  `idDepartamento` int(11) NOT NULL,
  PRIMARY KEY (`idServico`),
  KEY `fk_Reserva_has_Servico_Servico1_idx` (`idServico`),
  KEY `fk_ServicoPrestado_Funcionario1_idx` (`idFuncionario`,`idDepartamento`),
  CONSTRAINT `fk_Reserva_has_Servico_Servico1` FOREIGN KEY (`idServico`) REFERENCES `servico` (`idServico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServicoPrestado_Funcionario1` FOREIGN KEY (`idFuncionario`) REFERENCES `funcionario` (`idFuncionario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.servicoprestado: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.tarifa
CREATE TABLE IF NOT EXISTS `tarifa` (
  `idTarifa` int(11) NOT NULL AUTO_INCREMENT,
  `data` date DEFAULT NULL,
  `precoNoiteAdulto` double DEFAULT NULL,
  `precoNoiteCrianca` double DEFAULT NULL,
  `numQuarto` int(11) NOT NULL,
  PRIMARY KEY (`idTarifa`),
  KEY `fk_Tarifa_Quarto1_idx` (`numQuarto`),
  CONSTRAINT `fk_Tarifa_Quarto1` FOREIGN KEY (`numQuarto`) REFERENCES `quarto` (`numQuarto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.tarifa: ~18 rows (aproximadamente)
INSERT INTO `tarifa` (`idTarifa`, `data`, `precoNoiteAdulto`, `precoNoiteCrianca`, `numQuarto`) VALUES
	(12, '2024-01-11', 1000, 500, 1),
	(13, '2024-01-02', 160, 70, 2),
	(14, '2024-01-03', 160, 70, 2),
	(15, '2024-01-04', 160, 70, 2),
	(16, '2024-01-05', 160, 70, 2),
	(17, '2024-01-06', 160, 70, 2),
	(18, '2024-01-07', 160, 70, 2),
	(19, '2024-01-08', 160, 70, 2),
	(20, '2024-01-09', 160, 70, 2),
	(21, '2024-01-10', 160, 70, 2),
	(22, '2024-01-11', 160, 70, 2),
	(23, '2024-01-12', 15, 12, 1),
	(24, '2024-01-13', 15, 12, 1),
	(25, '2024-01-14', 15, 12, 1),
	(26, '2024-01-15', 15, 12, 1),
	(27, '2024-01-16', 15, 12, 1),
	(28, '2024-01-17', 15, 12, 1),
	(29, '2024-01-18', 15, 12, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
