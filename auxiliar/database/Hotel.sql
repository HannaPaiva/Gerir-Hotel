-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hotel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hotel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotel` DEFAULT CHARACTER SET utf8 ;
USE `hotel` ;

-- -----------------------------------------------------
-- Table `hotel`.`agencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`agencia` (
  `idAgencia` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeAgencia` VARCHAR(45) NULL DEFAULT NULL,
  `contatoGeral` VARCHAR(45) NULL DEFAULT NULL,
  `nomeRepresentante` VARCHAR(45) NULL DEFAULT NULL,
  `telefoneRepresentante` VARCHAR(45) NULL DEFAULT NULL,
  `comissaoAgencia` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`idAgencia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- A despejar estrutura da base de dados para xys_store
CREATE DATABASE IF NOT EXISTS `xys_store` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `xys_store`;
-- -----------------------------------------------------
-- Table `hotel`.`metodoreserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`metodoreserva` (
  `idMetodo` INT(11) NOT NULL,
  `nomeMetodo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idMetodo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`agenciametodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`agenciametodo` (
  `Agencia_idAgencia` INT(11) NOT NULL,
  `MetodoReserva_idMetodo` INT(11) NOT NULL,
  PRIMARY KEY (`Agencia_idAgencia`, `MetodoReserva_idMetodo`),
  INDEX `fk_Agencia_has_MetodoReserva_MetodoReserva1_idx` (`MetodoReserva_idMetodo` ASC) VISIBLE,
  INDEX `fk_Agencia_has_MetodoReserva_Agencia1_idx` (`Agencia_idAgencia` ASC) VISIBLE,
  CONSTRAINT `fk_Agencia_has_MetodoReserva_Agencia1`
    FOREIGN KEY (`Agencia_idAgencia`)
    REFERENCES `hotel`.`agencia` (`idAgencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agencia_has_MetodoReserva_MetodoReserva1`
    FOREIGN KEY (`MetodoReserva_idMetodo`)
    REFERENCES `hotel`.`metodoreserva` (`idMetodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`cliente` (
  `idCliente` INT(11) NOT NULL AUTO_INCREMENT,
  `primeiroNome` VARCHAR(60) NOT NULL,
  `nomeDoMeio` VARCHAR(60) NULL DEFAULT NULL,
  `ultimoNome` VARCHAR(45) NOT NULL,
  `contribuinte` VARCHAR(45) NULL DEFAULT NULL,
  `CC` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `telefone` VARCHAR(45) NULL DEFAULT NULL,
  `dataNascimento` DATE NULL DEFAULT NULL,
  `ativo` TINYINT(4) NULL DEFAULT NULL,
  `genero` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`departamento` (
  `idDepartamento` INT(11) NOT NULL,
  `idChefe` INT(11) NULL DEFAULT NULL,
  `nomeDepartamento` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idDepartamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`funcionario` (
  `idFuncionario` INT(11) NOT NULL AUTO_INCREMENT,
  `idDepartamento` INT(11) NOT NULL,
  `primeiroNome` VARCHAR(60) NOT NULL,
  `nomeDoMeio` VARCHAR(60) NULL DEFAULT NULL,
  `ultimoNome` VARCHAR(45) NOT NULL,
  `contribuinte` VARCHAR(45) NULL DEFAULT NULL,
  `CC` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `telefone` VARCHAR(45) NULL DEFAULT NULL,
  `dataNascimento` DATE NULL DEFAULT NULL,
  `endereco` VARCHAR(150) NULL DEFAULT NULL,
  `salario` DOUBLE NULL DEFAULT NULL,
  `dataEntrada` TIMESTAMP NULL DEFAULT NULL,
  `dataSaida` TIMESTAMP NULL DEFAULT NULL,
  `status` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`idFuncionario`, `idDepartamento`),
  INDEX `fk_Funcionario_Departamento1_idx` (`idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Funcionario_Departamento1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `hotel`.`departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`hospede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`hospede` (
  `idHospede` INT(11) NOT NULL AUTO_INCREMENT,
  `primeiroNome` VARCHAR(60) NOT NULL,
  `nomeDoMeio` VARCHAR(60) NULL DEFAULT NULL,
  `ultimoNome` VARCHAR(45) NOT NULL,
  `CC` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `telefone` VARCHAR(45) NULL DEFAULT NULL,
  `dataNascimento` DATE NULL DEFAULT NULL,
  `ativo` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`idHospede`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`reserva` (
  `idReserva` INT(11) NOT NULL AUTO_INCREMENT,
  `idCliente` INT(11) NOT NULL,
  `dataEntrada` DATE NULL DEFAULT NULL,
  `dataSaida` DATE NULL DEFAULT NULL,
  `numAdultos` TINYINT(4) NULL DEFAULT NULL,
  `numCriancas` TINYINT(4) NULL DEFAULT NULL,
  `numBebes` TINYINT(4) NULL DEFAULT NULL,
  `observacoes` TEXT NULL DEFAULT NULL,
  `tipologiaContratada` VARCHAR(45) NULL DEFAULT NULL,
  `Agencia_has_MetodoReserva_Agencia_idAgencia` INT(11) NOT NULL,
  `Agencia_has_MetodoReserva_MetodoReserva_idMetodo` INT(11) NOT NULL,
  PRIMARY KEY (`idReserva`),
  INDEX `fk_Reserva_Cliente1_idx` (`idCliente` ASC) VISIBLE,
  INDEX `fk_Reserva_Agencia_has_MetodoReserva1_idx` (`Agencia_has_MetodoReserva_Agencia_idAgencia` ASC, `Agencia_has_MetodoReserva_MetodoReserva_idMetodo` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_Agencia_has_MetodoReserva1`
    FOREIGN KEY (`Agencia_has_MetodoReserva_Agencia_idAgencia` , `Agencia_has_MetodoReserva_MetodoReserva_idMetodo`)
    REFERENCES `hotel`.`agenciametodo` (`Agencia_idAgencia` , `MetodoReserva_idMetodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `hotel`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`pagamento` (
  `idPagamento` INT(11) NOT NULL,
  `valorTotal` DOUBLE NULL DEFAULT NULL,
  `metodoPagamento` VARCHAR(45) NULL DEFAULT NULL,
  `tarifaReembolsavel` TINYINT(4) NULL DEFAULT NULL,
  `dataPagamento` TIMESTAMP NULL DEFAULT NULL,
  `observacoes` TEXT NULL DEFAULT NULL,
  `status` ENUM('pago', 'não pago') NULL DEFAULT NULL,
  `idReserva` INT(11) NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_Reserva1_idx` (`idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Reserva1`
    FOREIGN KEY (`idReserva`)
    REFERENCES `hotel`.`reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`quarto` (
  `idQuarto` INT(11) NOT NULL,
  `numQuarto` VARCHAR(10) NULL DEFAULT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  `andar` TINYINT(4) NULL DEFAULT NULL,
  `tipologia` VARCHAR(45) NULL DEFAULT NULL,
  `qtdCamaCasal` VARCHAR(45) NULL DEFAULT NULL,
  `qtdCamaSolteiro` VARCHAR(45) NULL DEFAULT NULL,
  `ativo` TINYINT(4) NULL DEFAULT NULL,
  `estaDisponivel` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`idQuarto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`reservaquarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`reservaquarto` (
  `idQuarto` INT(11) NOT NULL,
  `data` DATE NOT NULL,
  `idReserva` INT(11) NULL,
  `precoAdulto` DOUBLE NOT NULL,
  `precoCrianca` DOUBLE NOT NULL,
  `precoBebe` DOUBLE NOT NULL,
  PRIMARY KEY (`idQuarto`, `data`),
  INDEX `fk_Quarto_has_Reserva_Reserva1_idx` (`idReserva` ASC) VISIBLE,
  INDEX `fk_Quarto_has_Reserva_Quarto_idx` (`idQuarto` ASC) VISIBLE,
  CONSTRAINT `fk_Quarto_has_Reserva_Quarto`
    FOREIGN KEY (`idQuarto`)
    REFERENCES `hotel`.`quarto` (`idQuarto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Quarto_has_Reserva_Reserva1`
    FOREIGN KEY (`idReserva`)
    REFERENCES `hotel`.`reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`reservahospede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`reservahospede` (
  `ReservaQuarto_idQuarto` INT(11) NOT NULL,
  `ReservaQuarto_idReserva` INT(11) NOT NULL,
  `Hospede_idHospede` INT(11) NOT NULL,
  PRIMARY KEY (`ReservaQuarto_idQuarto`, `ReservaQuarto_idReserva`, `Hospede_idHospede`),
  INDEX `fk_ReservaQuarto_has_Hospede_Hospede1_idx` (`Hospede_idHospede` ASC) VISIBLE,
  INDEX `fk_ReservaQuarto_has_Hospede_ReservaQuarto1_idx` (`ReservaQuarto_idQuarto` ASC, `ReservaQuarto_idReserva` ASC) VISIBLE,
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_Hospede1`
    FOREIGN KEY (`Hospede_idHospede`)
    REFERENCES `hotel`.`hospede` (`idHospede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ReservaQuarto_has_Hospede_ReservaQuarto1`
    FOREIGN KEY (`ReservaQuarto_idQuarto` , `ReservaQuarto_idReserva`)
    REFERENCES `hotel`.`reservaquarto` (`idQuarto` , `idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`servico` (
  `idServico` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeServico` VARCHAR(45) NULL DEFAULT NULL,
  `preco` DOUBLE NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `idDepartamento` INT(11) NOT NULL,
  PRIMARY KEY (`idServico`),
  INDEX `fk_Servico_Departamento1_idx` (`idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_Departamento1`
    FOREIGN KEY (`idDepartamento`)
    REFERENCES `hotel`.`departamento` (`idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hotel`.`servicoprestado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hotel`.`servicoprestado` (
  `idReserva` INT(11) NOT NULL,
  `idServico` INT(11) NOT NULL,
  `detalhes` TEXT NULL DEFAULT NULL,
  `dataHora` DATETIME NULL DEFAULT NULL,
  `Funcionario_idFuncionario` INT(11) NOT NULL,
  `Funcionario_idDepartamento` INT(11) NOT NULL,
  PRIMARY KEY (`idReserva`, `idServico`),
  INDEX `fk_Reserva_has_Servico_Servico1_idx` (`idServico` ASC) VISIBLE,
  INDEX `fk_Reserva_has_Servico_Reserva1_idx` (`idReserva` ASC) VISIBLE,
  INDEX `fk_ServicoPrestado_Funcionario1_idx` (`Funcionario_idFuncionario` ASC, `Funcionario_idDepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_has_Servico_Reserva1`
    FOREIGN KEY (`idReserva`)
    REFERENCES `hotel`.`reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_has_Servico_Servico1`
    FOREIGN KEY (`idServico`)
    REFERENCES `hotel`.`servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ServicoPrestado_Funcionario1`
    FOREIGN KEY (`Funcionario_idFuncionario` , `Funcionario_idDepartamento`)
    REFERENCES `hotel`.`funcionario` (`idFuncionario` , `idDepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
