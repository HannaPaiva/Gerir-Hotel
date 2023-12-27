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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.cliente: ~6 rows (aproximadamente)
INSERT INTO `cliente` (`idCliente`, `primeiroNome`, `nomeDoMeio`, `UltimoNome`, `contribuinte`, `CC`, `email`, `telefone`, `dataNascimento`, `ativo`, `genero`) VALUES
	(1, 'Mariaaaaaaa', 'Amada', 'Carmo', 'cccc', 'cc', 'maria@gmail.com', '3434234234', '2003-07-05', 1, 'f'),
	(2, 'juliaa', 'pc do', 'picoito', 'aaaa', 'None', 'julia@outlook.com', 'None', '2003-06-07', 1, 'm'),
	(6, 'afonso', 'marques', 'moedas', '12243423', '3423434', 'dsfsdfs', 'sdfsdf', '2003-09-08', 1, 'm'),
	(11, 'maria', 'luana', 'rizard', 'cccc', 'cc', 'maria@gmail.com', '3434234234', '0000-00-00', 1, 'f'),
	(13, 'fran', '', '', '', '', '', '', '0000-00-00', 1, 'm'),
	(16, 'luciana', 'dos santos', 'sousa', '123', '123', '123', '123', '2023-12-22', 1, 'f');

-- A despejar estrutura para tabela hotel.departamento
CREATE TABLE IF NOT EXISTS `departamento` (
  `idDepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `idChefe` int(11) DEFAULT NULL,
  `nomeDepartamento` varchar(45) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  PRIMARY KEY (`idDepartamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.departamento: ~4 rows (aproximadamente)
INSERT INTO `departamento` (`idDepartamento`, `idChefe`, `nomeDepartamento`, `descricao`) VALUES
	(0, 10, 'Marketing', '123'),
	(1, 8, 'Receção', 'Parte responsável pela receção de clientes do hotel'),
	(2, 9, 'Restauração', 'Parte de comida e bebida do Hotel'),
	(3, 7, 'Lavandaria', 'Responsável pelas roupas dos funcionários, roupas de cama e toalhas dos clientes');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

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

-- A despejar estrutura para tabela hotel.metodoreserva
CREATE TABLE IF NOT EXISTS `metodoreserva` (
  `idMetodo` int(11) NOT NULL,
  `nomeMetodo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMetodo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.metodoreserva: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.pagamento
CREATE TABLE IF NOT EXISTS `pagamento` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.quarto: ~0 rows (aproximadamente)
INSERT INTO `quarto` (`numQuarto`, `descricao`, `andar`, `tipologia`, `qtdCamaCasal`, `qtdCamaSolteiro`, `ativo`, `estaDisponivel`) VALUES
	(1, 'quarto bonito', 1, 't1', '2', '1', 1, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.servico: ~1 rows (aproximadamente)
INSERT INTO `servico` (`idServico`, `nomeServico`, `preco`, `descricao`, `idDepartamento`) VALUES
	(1, 'serviço de quarto - Room Service', 124, 'Quaisquer entregas feitas ao quarto do cliente', 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.tarifa: ~0 rows (aproximadamente)
INSERT INTO `tarifa` (`idTarifa`, `data`, `precoNoiteAdulto`, `precoNoiteCrianca`, `numQuarto`) VALUES
	(1, '2023-12-13', 100, 50, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
