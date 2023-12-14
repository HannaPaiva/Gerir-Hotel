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


-- -----------------------------------------------------
-- Table `Hotel`.`Quarto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel`.`Quarto` (
  `numQuarto` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NULL,
  `andar` TINYINT NULL,
  `tipologia` VARCHAR(45) NULL,
  `qtdCamaCasal` VARCHAR(45) NULL,
  `qtdCamaSolteiro` VARCHAR(45) NULL,
  `ativo` TINYINT NULL,
  `estaDisponivel` TINYINT NULL,
  PRIMARY KEY (`numQuarto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`Agencia`
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
