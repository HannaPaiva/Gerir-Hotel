-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Hotel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Hotel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hotel` DEFAULT CHARACTER SET utf8 ;
USE `Hotel` ;

-- -----------------------------------------------------
-- Table `Hotel`.`Departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Departamento` (
  `idDepartamento` INT NOT NULL,
  `idChefe` INT NULL,
  `nomeDepartamento` VARCHAR(45) NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`idDepartamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `primeiroNome` VARCHAR(60) NOT NULL,
  `nomeDoMeio` VARCHAR(60) NULL,
  `UltimoNome` VARCHAR(45) NOT NULL,
  `contribuinte` VARCHAR(45) NULL,
  `CC` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `dataNascimento` DATE NULL,
  `endereco` VARCHAR(150) NULL,
  `salario` DOUBLE NULL,
  `dataEntrada` TIMESTAMP NULL,
  `dataSaida` TIMESTAMP NULL,
  `status` TINYINT NULL,
  `idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idFuncionario`),
  INDEX `fk_Funcionario_Departamento1_idx` (`idDepartamento` ASC) ,
  CONSTRAINT `fk_Funcionario_Departamento1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `Hotel`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `primeiroNome` VARCHAR(60) NOT NULL,
  `nomeDoMeio` VARCHAR(60) NULL,
  `UltimoNome` VARCHAR(45) NOT NULL,
  `contribuinte` VARCHAR(45) NULL,
  `CC` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `dataNascimento` DATE NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;

-- A despejar estrutura para tabela hotel.agenciametodo
CREATE TABLE IF NOT EXISTS `agenciametodo` (
  `Agencia_idAgencia` int(11) NOT NULL,
  `MetodoReserva_idMetodo` int(11) NOT NULL,
  PRIMARY KEY (`Agencia_idAgencia`,`MetodoReserva_idMetodo`),
  KEY `fk_Agencia_has_MetodoReserva_MetodoReserva1_idx` (`MetodoReserva_idMetodo`),
  KEY `fk_Agencia_has_MetodoReserva_Agencia1_idx` (`Agencia_idAgencia`),
  CONSTRAINT `fk_Agencia_has_MetodoReserva_Agencia1` FOREIGN KEY (`Agencia_idAgencia`) REFERENCES `agencia` (`idAgencia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agencia_has_MetodoReserva_MetodoReserva1` FOREIGN KEY (`MetodoReserva_idMetodo`) REFERENCES `metodoreserva` (`idMetodo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- -----------------------------------------------------
-- Table `Hotel`.`Hospede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Hospede` (
  `idHospede` INT NOT NULL AUTO_INCREMENT,
  `primeiroNome` VARCHAR(60) NOT NULL,
  `nomeDoMeio` VARCHAR(60) NULL,
  `UltimoNome` VARCHAR(45) NOT NULL,
  `CC` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `dataNascimento` DATE NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`idHospede`))
ENGINE = InnoDB;

<<<<<<< HEAD
-- A despejar estrutura para tabela hotel.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.cliente: ~6 rows (aproximadamente)
INSERT INTO `cliente` (`idCliente`, `primeiroNome`, `nomeDoMeio`, `ultimoNome`, `contribuinte`, `CC`, `email`, `telefone`, `dataNascimento`, `ativo`, `genero`) VALUES
	(1, 'Maria', 'Amada', 'Carmo', 'cccc', 'cc', 'maria@gmail.com', '3434234234', '2003-07-05', 1, 'm'),
	(2, 'juliaa', 'pc do', 'picoito', 'aaaa', 'None', 'julia@outlook.com', 'None', '0000-00-00', 1, 'm'),
	(6, 'afonso', 'marques', 'moedas', '12243423', '3423434', 'dsfsdfs', 'sdfsdf', '2003-09-08', 1, NULL),
	(11, 'mariaaaaaaaaaa', 'luana', 'rizard', 'cccc', 'cc', 'maria@gmail.com', '3434234234', '0000-00-00', 1, 'm'),
	(13, 'fran', '', '', '', '', '', '', '0000-00-00', 1, 'm'),
	(14, 'Miguel', 'Joaquim', 'Freitas', '123538473', 'hbf74hf747f', 'miguelasd@gmail.com', '67583940', '2010-06-16', 1, 'm');

-- A despejar estrutura para tabela hotel.departamento
CREATE TABLE IF NOT EXISTS `departamento` (
  `idDepartamento` int(11) NOT NULL,
  `idChefe` int(11) DEFAULT NULL,
  `nomeDepartamento` varchar(45) DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  PRIMARY KEY (`idDepartamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
=======

-- -----------------------------------------------------
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Agencia` (
  `idAgencia` INT NOT NULL AUTO_INCREMENT,
  `nomeAgencia` VARCHAR(45) NULL,
  `contatoGeral` VARCHAR(45) NULL,
  `nomeRepresentante` VARCHAR(45) NULL,
  `telefoneRepresentante` VARCHAR(45) NULL,
  `comissaoAgencia` DOUBLE NULL,
  PRIMARY KEY (`idAgencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`MetodoReserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`MetodoReserva` (
  `idMetodo` INT NOT NULL,
  `nomeMetodo` VARCHAR(45) NULL,
  PRIMARY KEY (`idMetodo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`agenciaMetodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`agenciaMetodo` (
  `idAgencia` INT NOT NULL,
  `idMetodo` INT NOT NULL,
  PRIMARY KEY (`idAgencia`, `idMetodo`),
  INDEX `fk_Agencia_has_MetodoReserva_MetodoReserva1_idx` (`idMetodo` ASC) ,
  INDEX `fk_Agencia_has_MetodoReserva_Agencia1_idx` (`idAgencia` ASC) ,
  CONSTRAINT `fk_Agencia_has_MetodoReserva_Agencia1`
    FOREIGN KEY (`idAgencia`)
    REFERENCES `Hotel`.`Agencia` (`idAgencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agencia_has_MetodoReserva_MetodoReserva1`
    FOREIGN KEY (`idMetodo`)
    REFERENCES `Hotel`.`MetodoReserva` (`idMetodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

<<<<<<< HEAD
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

-- A despejar estrutura para tabela hotel.preco
CREATE TABLE IF NOT EXISTS `preco` (
  `idPreco` int(11) NOT NULL AUTO_INCREMENT,
  `idTarifa` int(11) NOT NULL,
  `idReserva` int(11) NOT NULL,
  `precoManual` double DEFAULT NULL,
  PRIMARY KEY (`idPreco`) USING BTREE,
  KEY `fk_Tarifa_has_Reserva_Reserva1_idx` (`idReserva`),
  KEY `fk_Tarifa_has_Reserva_Tarifa1_idx` (`idTarifa`),
  CONSTRAINT `fk_Tarifa_has_Reserva_Reserva1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarifa_has_Reserva_Tarifa1` FOREIGN KEY (`idTarifa`) REFERENCES `tarifa` (`idTarifa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- A despejar dados para tabela hotel.preco: ~0 rows (aproximadamente)

-- A despejar estrutura para tabela hotel.quarto
CREATE TABLE IF NOT EXISTS `quarto` (
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

-- A despejar dados para tabela hotel.quarto: ~1 rows (aproximadamente)
INSERT INTO `quarto` (`idQuarto`, `numQuarto`, `descricao`, `andar`, `tipologia`, `qtdCamaCasal`, `qtdCamaSolteiro`, `ativo`, `estaDisponivel`) VALUES
	(20, '1', 'grande', 2, 'grande', '2', '1', 1, 1);

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
  `Agencia_has_MetodoReserva_Agencia_idAgencia` int(11) NOT NULL,
  `Agencia_has_MetodoReserva_MetodoReserva_idMetodo` int(11) NOT NULL,
  PRIMARY KEY (`idReserva`),
  KEY `fk_Reserva_Cliente1_idx` (`idCliente`),
  KEY `fk_Reserva_Agencia_has_MetodoReserva1_idx` (`Agencia_has_MetodoReserva_Agencia_idAgencia`,`Agencia_has_MetodoReserva_MetodoReserva_idMetodo`),
  CONSTRAINT `fk_Reserva_Agencia_has_MetodoReserva1` FOREIGN KEY (`Agencia_has_MetodoReserva_Agencia_idAgencia`, `Agencia_has_MetodoReserva_MetodoReserva_idMetodo`) REFERENCES `agenciametodo` (`Agencia_idAgencia`, `MetodoReserva_idMetodo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Cliente1` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
=======

-- -----------------------------------------------------
-- Table `Hotel`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Reserva` (
  `idReserva` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `dataEntrada` DATE NULL,
  `dataSaida` DATE NULL,
  `numAdultos` TINYINT NULL,
  `numCriancas` TINYINT NULL,
  `numBebes` TINYINT NULL,
  `observacoes` TEXT NULL,
  `tipologiaContratada` VARCHAR(45) NULL,
  `idAgencia` INT NOT NULL,
  `idMetodo` INT NOT NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_Reserva_Cliente1_idx` (`idCliente` ASC) ,
  INDEX `fk_Reserva_Agencia_has_MetodoReserva1_idx` (`idAgencia` ASC, `idMetodo` ASC) ,
  CONSTRAINT `fk_Reserva_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Hotel`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Agencia_has_MetodoReserva1`
    FOREIGN KEY (`idAgencia` , `idMetodo`)
    REFERENCES `Hotel`.`agenciaMetodo` (`idAgencia` , `idMetodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
>>>>>>> b5bdbfed1001726e152f3f5fa400d131230cb32b


<<<<<<< HEAD
-- A despejar estrutura para tabela hotel.reservahospede
CREATE TABLE IF NOT EXISTS `reservahospede` (
  `ReservaQuarto_idQuarto` int(11) NOT NULL,
  `ReservaQuarto_idReserva` int(11) NOT NULL,
  `Hospede_idHospede` int(11) NOT NULL,
  PRIMARY KEY (`ReservaQuarto_idQuarto`,`ReservaQuarto_idReserva`,`Hospede_idHospede`),
  KEY `fk_ReservaQuarto_has_Hospede_Hospede1_idx` (`Hospede_idHospede`),
  KEY `fk_ReservaQuarto_has_Hospede_ReservaQuarto1_idx` (`ReservaQuarto_idQuarto`,`ReservaQuarto_idReserva`),
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_Hospede1` FOREIGN KEY (`Hospede_idHospede`) REFERENCES `hospede` (`idHospede`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_ReservaQuarto1` FOREIGN KEY (`ReservaQuarto_idQuarto`, `ReservaQuarto_idReserva`) REFERENCES `reservaquarto` (`idQuarto`, `idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
=======
-- -----------------------------------------------------
-- Table `Hotel`.`ReservaQuarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`ReservaQuarto` (
  `numQuarto` INT NOT NULL,
  `idReserva` INT NOT NULL,
  `observacoes` TEXT NULL,
  PRIMARY KEY (`numQuarto`, `idReserva`),
  INDEX `fk_Quarto_has_Reserva_Reserva1_idx` (`idReserva` ASC) ,
  INDEX `fk_Quarto_has_Reserva_Quarto_idx` (`numQuarto` ASC) ,
  CONSTRAINT `fk_Quarto_has_Reserva_Quarto`
    FOREIGN KEY (`numQuarto`)
    REFERENCES `Hotel`.`Quarto` (`numQuarto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quarto_has_Reserva_Reserva1`
    FOREIGN KEY (`idReserva`)
    REFERENCES `Hotel`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
>>>>>>> b5bdbfed1001726e152f3f5fa400d131230cb32b


<<<<<<< HEAD
-- A despejar estrutura para tabela hotel.reservaquarto
CREATE TABLE IF NOT EXISTS `reservaquarto` (
  `idQuarto` int(11) NOT NULL,
  `idReserva` int(11) NOT NULL,
  `observacoes` text DEFAULT NULL,
  PRIMARY KEY (`idQuarto`,`idReserva`),
  KEY `fk_Quarto_has_Reserva_Reserva1_idx` (`idReserva`),
  KEY `fk_Quarto_has_Reserva_Quarto_idx` (`idQuarto`),
  CONSTRAINT `fk_Quarto_has_Reserva_Quarto` FOREIGN KEY (`idQuarto`) REFERENCES `quarto` (`idQuarto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quarto_has_Reserva_Reserva1` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
=======
-- -----------------------------------------------------
-- Table `Hotel`.`Tarifa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Tarifa` (
  `idTarifa` INT NOT NULL AUTO_INCREMENT,
  `dataInicio` DATE NULL,
  `dataFim` DATE NULL,
  `precoNoiteAdulto` DOUBLE NULL,
  `precoNoiteCrianca` DOUBLE NULL,
  `numQuarto` INT NOT NULL,
  PRIMARY KEY (`idTarifa`),
  INDEX `fk_Tarifa_Quarto1_idx` (`numQuarto` ASC) ,
  CONSTRAINT `fk_Tarifa_Quarto1`
    FOREIGN KEY (`numQuarto`)
    REFERENCES `Hotel`.`Quarto` (`numQuarto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
>>>>>>> b5bdbfed1001726e152f3f5fa400d131230cb32b


-- -----------------------------------------------------
-- Table `Hotel`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Pagamento` (
  `idPagamento` INT NOT NULL,
  `valorTotal` DOUBLE NULL,
  `metodoPagamento` VARCHAR(45) NULL,
  `tarifaReembolsavel` TINYINT NULL,
  `dataPagamento` TIMESTAMP NULL,
  `observacoes` TEXT NULL,
  `status` ENUM('pago', 'não pago') NULL,
  `idReserva` INT NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_Reserva1_idx` (`idReserva` ASC) ,
  CONSTRAINT `fk_Pagamento_Reserva1`
    FOREIGN KEY (`idReserva`)
    REFERENCES `Hotel`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Servico` (
  `idServico` INT NOT NULL AUTO_INCREMENT,
  `nomeServico` VARCHAR(45) NULL,
  `preco` DOUBLE NULL,
  `descricao` TEXT NULL,
  `idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idServico`),
  INDEX `fk_Servico_Departamento1_idx` (`idDepartamento` ASC) ,
  CONSTRAINT `fk_Servico_Departamento1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `Hotel`.`Departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


<<<<<<< HEAD
-- A despejar estrutura para tabela hotel.servicoprestado
CREATE TABLE IF NOT EXISTS `servicoprestado` (
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
=======
-- -----------------------------------------------------
-- Table `Hotel`.`ServicoPrestado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`ServicoPrestado` (
  `idServico` INT NOT NULL,
  `detalhes` TEXT NULL,
  `dataHora` DATETIME NULL,
  `idFuncionario` INT NOT NULL,
  `idDepartamento` INT NOT NULL,
  PRIMARY KEY (`idServico`),
  INDEX `fk_Reserva_has_Servico_Servico1_idx` (`idServico` ASC) ,
  INDEX `fk_ServicoPrestado_Funcionario1_idx` (`idFuncionario` ASC, `idDepartamento` ASC) ,
  CONSTRAINT `fk_Reserva_has_Servico_Servico1`
    FOREIGN KEY (`idServico`)
    REFERENCES `Hotel`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServicoPrestado_Funcionario1`
    FOREIGN KEY (`idFuncionario`)
    REFERENCES `Hotel`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
>>>>>>> b5bdbfed1001726e152f3f5fa400d131230cb32b


-- -----------------------------------------------------
-- Table `Hotel`.`ReservaHospede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`ReservaHospede` (
  `numQuarto` INT NOT NULL,
  `idReserva` INT NOT NULL,
  `idHospede` INT NOT NULL,
  PRIMARY KEY (`numQuarto`, `idReserva`, `idHospede`),
  INDEX `fk_ReservaQuarto_has_Hospede_Hospede1_idx` (`idHospede` ASC) ,
  INDEX `fk_ReservaQuarto_has_Hospede_ReservaQuarto1_idx` (`numQuarto` ASC, `idReserva` ASC) ,
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_ReservaQuarto1`
    FOREIGN KEY (`numQuarto` , `idReserva`)
    REFERENCES `Hotel`.`ReservaQuarto` (`numQuarto` , `idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_Hospede1`
    FOREIGN KEY (`idHospede`)
    REFERENCES `Hotel`.`Hospede` (`idHospede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`Diaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Diaria` (
  `idTarifa` INT NOT NULL,
  `idReserva` INT NOT NULL,
  PRIMARY KEY (`idTarifa`, `idReserva`),
  INDEX `fk_Tarifa_has_Reserva_Reserva1_idx` (`idReserva` ASC) ,
  INDEX `fk_Tarifa_has_Reserva_Tarifa1_idx` (`idTarifa` ASC) ,
  CONSTRAINT `fk_Tarifa_has_Reserva_Tarifa1`
    FOREIGN KEY (`idTarifa`)
    REFERENCES `Hotel`.`Tarifa` (`idTarifa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarifa_has_Reserva_Reserva1`
    FOREIGN KEY (`idReserva`)
    REFERENCES `Hotel`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
