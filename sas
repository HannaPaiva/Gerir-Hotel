-- MySQL Workbench Synchronization
-- Generated: 2023-12-13 17:13
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: hapaiva

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `hotel`.`Tarifa` 
DROP FOREIGN KEY `numQuarto`;

ALTER TABLE `hotel`.`agenciaMetodo` 
DROP FOREIGN KEY `fk_Agencia_has_MetodoReserva_Agencia1`,
DROP FOREIGN KEY `fk_Agencia_has_MetodoReserva_MetodoReserva1`;

ALTER TABLE `hotel`.`ReservaHospede` 
DROP FOREIGN KEY `fk_ReservaQuarto_has_Hospede_Hospede1`;

ALTER TABLE `hotel`.`Quarto` 
DROP COLUMN `numQuarto`,
CHANGE COLUMN `idQuarto` `numQuarto` INT(11) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `hotel`.`Reserva` 
DROP COLUMN `Agencia_has_MetodoReserva_MetodoReserva_idMetodo`,
DROP COLUMN `Agencia_has_MetodoReserva_Agencia_idAgencia`,
ADD COLUMN `idAgencia` INT(11) NOT NULL AFTER `tipologiaContratada`,
ADD COLUMN `idMetodo` INT(11) NOT NULL AFTER `idAgencia`,
DROP INDEX `fk_Reserva_Agencia_has_MetodoReserva1_idx` ,
ADD INDEX `fk_Reserva_Agencia_has_MetodoReserva1_idx` (`idAgencia` ASC, `idMetodo` ASC) ;
;

ALTER TABLE `hotel`.`Tarifa` 
DROP COLUMN `tipologia`,
DROP COLUMN `data`,
ADD COLUMN `dataInicio` DATE NULL DEFAULT NULL AFTER `idTarifa`,
ADD COLUMN `dataFim` DATE NULL DEFAULT NULL AFTER `dataInicio`,
CHANGE COLUMN `numQuarto` `numQuarto` INT(11) NOT NULL ,
ADD INDEX `fk_Tarifa_Quarto1_idx` (`numQuarto` ASC) ,
DROP INDEX `numQuarto` ;
;

ALTER TABLE `hotel`.`ServicoPrestado` 
DROP COLUMN `Funcionario_idDepartamento`,
DROP COLUMN `Funcionario_idFuncionario`,
DROP COLUMN `idReserva`,
ADD COLUMN `idFuncionario` INT(11) NOT NULL AFTER `dataHora`,
ADD COLUMN `idDepartamento` INT(11) NOT NULL AFTER `idFuncionario`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`idServico`),
DROP INDEX `fk_ServicoPrestado_Funcionario1_idx` ,
ADD INDEX `fk_ServicoPrestado_Funcionario1_idx` (`idFuncionario` ASC, `idDepartamento` ASC) ,
DROP INDEX `fk_Reserva_has_Servico_Reserva1_idx` ;
;

ALTER TABLE `hotel`.`agenciaMetodo` 
DROP COLUMN `MetodoReserva_idMetodo`,
DROP COLUMN `Agencia_idAgencia`,
ADD COLUMN `idAgencia` INT(11) NOT NULL FIRST,
ADD COLUMN `idMetodo` INT(11) NOT NULL AFTER `idAgencia`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`idAgencia`, `idMetodo`),
DROP INDEX `fk_Agencia_has_MetodoReserva_MetodoReserva1_idx` ,
ADD INDEX `fk_Agencia_has_MetodoReserva_MetodoReserva1_idx` (`idMetodo` ASC) ,
DROP INDEX `fk_Agencia_has_MetodoReserva_Agencia1_idx` ,
ADD INDEX `fk_Agencia_has_MetodoReserva_Agencia1_idx` (`idAgencia` ASC) ;
;

ALTER TABLE `hotel`.`ReservaHospede` 
DROP COLUMN `Hospede_idHospede`,
DROP COLUMN `ReservaQuarto_idReserva`,
DROP COLUMN `ReservaQuarto_idQuarto`,
ADD COLUMN `numQuarto` INT(11) NOT NULL FIRST,
ADD COLUMN `idReserva` INT(11) NOT NULL AFTER `numQuarto`,
ADD COLUMN `idHospede` INT(11) NOT NULL AFTER `idReserva`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`numQuarto`, `idReserva`, `idHospede`),
DROP INDEX `fk_ReservaQuarto_has_Hospede_Hospede1_idx` ,
ADD INDEX `fk_ReservaQuarto_has_Hospede_Hospede1_idx` (`idHospede` ASC) ,
DROP INDEX `fk_ReservaQuarto_has_Hospede_ReservaQuarto1_idx` ,
ADD INDEX `fk_ReservaQuarto_has_Hospede_ReservaQuarto1_idx` (`numQuarto` ASC, `idReserva` ASC) ;
;

CREATE TABLE IF NOT EXISTS `hotel`.`Diaria` (
  `idTarifa` INT(11) NOT NULL,
  `idReserva` INT(11) NOT NULL,
  PRIMARY KEY (`idTarifa`, `idReserva`),
  INDEX `fk_Tarifa_has_Reserva_Reserva1_idx` (`idReserva` ASC) ,
  INDEX `fk_Tarifa_has_Reserva_Tarifa1_idx` (`idTarifa` ASC) ,
  CONSTRAINT `fk_Tarifa_has_Reserva_Tarifa1`
    FOREIGN KEY (`idTarifa`)
    REFERENCES `hotel`.`Tarifa` (`idTarifa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarifa_has_Reserva_Reserva1`
    FOREIGN KEY (`idReserva`)
    REFERENCES `hotel`.`Reserva` (`idReserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `hotel`.`preco` ;

ALTER TABLE `hotel`.`Funcionario` 
ADD CONSTRAINT `fk_Funcionario_Departamento1`
  FOREIGN KEY (`idDepartamento`)
  REFERENCES `hotel`.`Departamento` (`idDepartamento`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `hotel`.`Reserva` 
ADD CONSTRAINT `fk_Reserva_Agencia_has_MetodoReserva1`
  FOREIGN KEY (`idAgencia` , `idMetodo`)
  REFERENCES `hotel`.`agenciaMetodo` (`idAgencia` , `idMetodo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `hotel`.`Tarifa` 
ADD CONSTRAINT `fk_Tarifa_Quarto1`
  FOREIGN KEY (`numQuarto`)
  REFERENCES `hotel`.`Quarto` (`numQuarto`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `hotel`.`ServicoPrestado` 
ADD CONSTRAINT `fk_ServicoPrestado_Funcionario1`
  FOREIGN KEY (`idFuncionario`)
  REFERENCES `hotel`.`Funcionario` (`idFuncionario`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `hotel`.`agenciaMetodo` 
ADD CONSTRAINT `fk_Agencia_has_MetodoReserva_Agencia1`
  FOREIGN KEY (`idAgencia`)
  REFERENCES `hotel`.`Agencia` (`idAgencia`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Agencia_has_MetodoReserva_MetodoReserva1`
  FOREIGN KEY (`idMetodo`)
  REFERENCES `hotel`.`MetodoReserva` (`idMetodo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `hotel`.`ReservaHospede` 
DROP FOREIGN KEY `fk_ReservaQuarto_has_Hospede_ReservaQuarto1`;

ALTER TABLE `hotel`.`ReservaHospede` ADD CONSTRAINT `fk_ReservaQuarto_has_Hospede_ReservaQuarto1`
  FOREIGN KEY (`numQuarto` , `idReserva`)
  REFERENCES `hotel`.`ReservaQuarto` (`idQuarto` , `idReserva`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ReservaQuarto_has_Hospede_Hospede1`
  FOREIGN KEY (`idHospede`)
  REFERENCES `hotel`.`Hospede` (`idHospede`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
