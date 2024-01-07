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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.agencia: ~0 rows (aproximadamente)
INSERT INTO `agencia` (`idAgencia`, `nomeAgencia`, `contatoGeral`, `nomeRepresentante`, `telefoneRepresentante`, `comissaoAgencia`) VALUES
	(1, 'Hotel', '15213454', 'Pedro Cardoso', '124312312', 100);

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

-- A despejar dados para tabela hotel.agenciametodo: ~2 rows (aproximadamente)
INSERT INTO `agenciametodo` (`idAgencia`, `idMetodo`) VALUES
	(1, 1),
	(1, 2);

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
  `genero` enum('m','f','o') DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.cliente: ~5 rows (aproximadamente)
INSERT INTO `cliente` (`idCliente`, `primeiroNome`, `nomeDoMeio`, `UltimoNome`, `contribuinte`, `CC`, `email`, `telefone`, `dataNascimento`, `ativo`, `genero`) VALUES
	(1, 'Jurema', 'Maia', 'IZURA', '123123123', '123123123', '12131213', '12312131213', '2003-08-05', 1, NULL),
	(2, 'Francisco', '', 'Picoito', '1231213123', '123121123', '12121213', '1231213', '2004-04-08', 1, 'm'),
	(3, 'Luciana', '', 'Gimenez', '123', '123', '123', '123', '2003-01-07', 1, 'f'),
	(4, 'potato', 'batata', 'patata', '234567', '345678', 'dfg@rth', '23489', '2024-01-16', 1, 'm'),
	(5, 'DUMMY', '', 'DUMMY', '123', '123', '123', '123', '2003-11-11', 1, 'm');

-- A despejar estrutura para tabela hotel.departamento
CREATE TABLE IF NOT EXISTS `departamento` (
  `idDepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `idChefe` int(11) DEFAULT NULL,
  `nomeDepartamento` varchar(45) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  PRIMARY KEY (`idDepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.departamento: ~2 rows (aproximadamente)
INSERT INTO `departamento` (`idDepartamento`, `idChefe`, `nomeDepartamento`, `descricao`) VALUES
	(1, 1, 'restauracao', '123'),
	(2, 3, 'Batata', '123');

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
  `genero` enum('m','f','o') DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`),
  KEY `fk_Funcionario_Departamento1_idx` (`idDepartamento`),
  CONSTRAINT `fk_Funcionario_Departamento1` FOREIGN KEY (`idDepartamento`) REFERENCES `departamento` (`idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.funcionario: ~3 rows (aproximadamente)
INSERT INTO `funcionario` (`idFuncionario`, `primeiroNome`, `nomeDoMeio`, `UltimoNome`, `contribuinte`, `CC`, `email`, `telefone`, `dataNascimento`, `endereco`, `salario`, `dataEntrada`, `dataSaida`, `status`, `idDepartamento`, `genero`) VALUES
	(1, 'PEDRO ', 'ALL MIGHTY', 'CARDOSO', '123123', '123123123', '123123123@123.PT', '123123132', '0000-00-00', NULL, NULL, NULL, NULL, 1, 1, 'm'),
	(2, '', '', '', '', '', '', '', '0000-00-00', NULL, NULL, NULL, NULL, 1, 2, 'm'),
	(3, 'batata', 'mister', 'patata', '12321', '123213', '', '1233', '2024-01-10', NULL, NULL, NULL, NULL, 1, 2, 'o');

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

-- A despejar estrutura para procedimento hotel.InserirReserva
DELIMITER //
CREATE PROCEDURE `InserirReserva`(
    IN p_idCliente INT,
    IN p_dataEntrada DATE,
    IN p_dataSaida DATE,
    IN p_numAdultos TINYINT,
    IN p_numCriancas TINYINT,
    IN p_numBebes TINYINT,
    IN p_observacoes TEXT,
    IN p_tipologiaContratada VARCHAR(45),
    IN p_idAgencia INT,
    IN p_idMetodo INT,
    IN p_numQuarto INT
)
BEGIN
    DECLARE roomOccupied INT;

    -- Verificar se o quarto está ocupado na data especificada
    SELECT COUNT(*)
    INTO roomOccupied
    FROM reservaquarto rq
    INNER JOIN reserva r ON rq.idReserva = r.idReserva
    WHERE rq.numQuarto = p_numQuarto
        AND (
            (p_dataEntrada BETWEEN r.dataEntrada AND r.dataSaida)
            OR (p_dataSaida BETWEEN r.dataEntrada AND r.dataSaida)
            OR (p_dataEntrada <= r.dataEntrada AND p_dataSaida >= r.dataSaida)
        );

    -- Se o quarto estiver ocupado, retorna 500
    IF roomOccupied > 0 THEN
        SELECT 500 AS status;
    ELSE
        -- Se o quarto estiver disponível, insere a reserva e retorna 200
        INSERT INTO reserva (idCliente, dataEntrada, dataSaida, numAdultos, numCriancas, numBebes, observacoes, tipologiaContratada, idAgencia, idMetodo)
        VALUES (p_idCliente, p_dataEntrada, p_dataSaida, p_numAdultos, p_numCriancas, p_numBebes, p_observacoes, p_tipologiaContratada, p_idAgencia, p_idMetodo);

        SET @lastReservaID = LAST_INSERT_ID();

        INSERT INTO reservaquarto (numQuarto, idReserva, observacoes)
        VALUES (p_numQuarto, @lastReservaID, p_observacoes);

        SELECT 200 AS status;
    END IF;
END//
DELIMITER ;

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

-- A despejar dados para tabela hotel.metodoreserva: ~2 rows (aproximadamente)
INSERT INTO `metodoreserva` (`idMetodo`, `nomeMetodo`) VALUES
	(1, 'direto'),
	(2, 'online');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.pagamento: ~2 rows (aproximadamente)
INSERT INTO `pagamento` (`idPagamento`, `valorTotal`, `metodoPagamento`, `tarifaReembolsavel`, `dataPagamento`, `observacoes`, `status`, `idReserva`) VALUES
	(1, 124, '123', 123, '2023-09-01 23:00:00', '1123', 'não pago', 48),
	(3, 123, '123', 123, '2023-09-02 04:00:00', '', 'pago', 55);

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.quarto: ~2 rows (aproximadamente)
INSERT INTO `quarto` (`numQuarto`, `descricao`, `andar`, `tipologia`, `qtdCamaCasal`, `qtdCamaSolteiro`, `ativo`, `estaDisponivel`) VALUES
	(1, 't1 top', 1, 't2', '1', '1', 1, 1),
	(2, 't2 top', 2, 't2', '1', '1', 1, 1),
	(15, 'Quarto próximo as escadas, ala sul', 1, 't1', '1', '1', 1, 1),
	(25, 't3, Quarto próximo ao elevador', 2, 't3', '2', '2', 1, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.reserva: ~10 rows (aproximadamente)
INSERT INTO `reserva` (`idReserva`, `idCliente`, `dataEntrada`, `dataSaida`, `numAdultos`, `numCriancas`, `numBebes`, `observacoes`, `tipologiaContratada`, `idAgencia`, `idMetodo`) VALUES
	(36, 2, '2024-01-03', '2024-01-05', 1, 1, 1, 'adsdasd', 't2', 1, 1),
	(47, 3, '2025-06-04', '2025-06-19', 0, 0, 0, '', 't2', 1, 1),
	(48, 3, '2024-03-26', '2024-03-26', 1, 1, 1, 'aaaaa', 't2', 1, 1),
	(49, 3, '2024-02-28', '2024-03-08', 123, 123, 123, 'zzzzz', 't2', 1, 1),
	(50, 3, '2024-01-12', '2024-01-26', 12, 12, 12, '', 't2', 1, 1),
	(55, 2, '2024-03-30', '2024-03-30', 123, 0, 0, 'kkk', 't3', 1, 1),
	(56, 1, '2024-12-23', '2024-12-26', 2, 1, 0, 'Reserva paAAAA', 't2', 1, 1),
	(62, 5, '2024-02-12', '2024-02-12', 123, 123, 123, '123123123', 't2', 1, 1),
	(63, 5, '2024-01-07', '2024-01-07', 1, 1, 0, 'reserva de emergencia do ThreeGroup', 't1', 1, 1),
	(64, 5, '2024-01-07', '2024-01-07', 0, 0, 0, '', 't3', 1, 1),
	(65, 1, '2024-01-07', '2024-01-07', 1, 0, 1, '', 't2', 1, 1);

-- A despejar estrutura para tabela hotel.reservaquarto
CREATE TABLE IF NOT EXISTS `reservaquarto` (
  `observacoes` text DEFAULT NULL,
  `idreservaquarto` int(11) NOT NULL AUTO_INCREMENT,
  `numQuarto` int(11) DEFAULT NULL,
  `idReserva` int(11) DEFAULT NULL,
  PRIMARY KEY (`idreservaquarto`),
  KEY `numQuarto_1` (`numQuarto`),
  KEY `idReserva_1` (`idReserva`),
  CONSTRAINT `idReserva_1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `numQuarto_1` FOREIGN KEY (`numQuarto`) REFERENCES `quarto` (`numQuarto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.reservaquarto: ~8 rows (aproximadamente)
INSERT INTO `reservaquarto` (`observacoes`, `idreservaquarto`, `numQuarto`, `idReserva`) VALUES
	('adsdasd', 12, 2, 36),
	('', 23, 1, 47),
	('aaaaa', 24, 1, 48),
	('zzzzz', 25, 2, 49),
	('', 26, 1, 50),
	('kkk', 31, 25, 55),
	('Reserva paAAAA', 32, 1, 56),
	('123123123', 38, 2, 62),
	('reserva de emergencia do ThreeGroup', 39, 15, 63),
	('', 40, 25, 64),
	('', 41, 1, 65);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.tarifa: ~35 rows (aproximadamente)
INSERT INTO `tarifa` (`idTarifa`, `data`, `precoNoiteAdulto`, `precoNoiteCrianca`, `numQuarto`) VALUES
	(30, '2024-01-10', 134, 123, 1),
	(31, '2024-01-11', 134, 123, 1),
	(32, '2024-01-12', 134, 123, 1),
	(33, '2024-01-13', 134, 123, 1),
	(34, '2024-01-14', 134, 123, 1),
	(35, '2024-01-15', 134, 123, 1),
	(36, '2024-01-16', 134, 123, 1),
	(37, '2024-01-17', 123, 123, 1),
	(38, '2024-01-18', 123, 123, 1),
	(39, '2024-01-19', 123, 123, 1),
	(40, '2024-01-20', 123, 123, 1),
	(41, '2024-01-21', 123, 123, 1),
	(42, '2024-01-22', 123, 123, 1),
	(43, '2024-01-23', 123, 123, 1),
	(44, '2024-01-24', 123, 123, 1),
	(45, '2024-01-25', 123, 123, 1),
	(46, '2024-01-26', 123, 123, 1),
	(47, '2024-01-27', 123, 123, 1),
	(48, '2024-01-28', 123, 123, 1),
	(49, '2024-01-29', 123, 123, 1),
	(50, '2024-01-30', 123, 123, 1),
	(51, '2024-01-31', 123, 123, 1),
	(52, '2024-02-01', 123, 123, 1),
	(53, '2024-02-02', 123, 123, 1),
	(54, '2024-02-03', 123, 123, 1),
	(55, '2024-02-04', 123, 123, 1),
	(56, '2024-02-05', 123, 123, 1),
	(57, '2024-02-06', 123, 123, 1),
	(58, '2024-02-07', 123, 123, 1),
	(59, '2024-02-08', 123, 123, 1),
	(60, '2024-02-09', 123, 123, 1),
	(61, '2024-02-10', 123, 123, 1),
	(62, '2024-02-11', 123, 123, 1),
	(63, '2024-02-12', 123, 123, 1),
	(64, '2024-02-13', 123, 123, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
