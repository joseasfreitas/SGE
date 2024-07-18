-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SGE
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `SGE` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `SGE` ;

-- -----------------------------------------------------
-- Table `SGE`.`Eventos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGE`.`Eventos` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Data` DATE NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  `Capacidade` INT NOT NULL,
  `CapacidadeRestante` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `SGE`.`Funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGE`.`Funcionarios` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Posição` VARCHAR(45) NOT NULL,
  `Salário` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `SGE`.`Participantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGE`.`Participantes` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Telefone` CHAR(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `SGE`.`Inscricoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGE`.`Inscricoes` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `EventoID` INT NOT NULL,
  `ParticipanteID` INT NOT NULL,
  `DataInscrição` DATE NOT NULL,
  PRIMARY KEY (`ID`, `EventoID`, `ParticipanteID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_Inscrições_Eventos_idx` (`EventoID` ASC) VISIBLE,
  INDEX `fk_Inscrições_Participantes1_idx` (`ParticipanteID` ASC) VISIBLE,
  CONSTRAINT `fk_Inscrições_Eventos`
    FOREIGN KEY (`EventoID`)
    REFERENCES `SGE`.`Eventos` (`ID`),
  CONSTRAINT `fk_Inscrições_Participantes1`
    FOREIGN KEY (`ParticipanteID`)
    REFERENCES `SGE`.`Participantes` (`ID`))
ENGINE = InnoDB
AUTO_INCREMENT = 98
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `SGE`.`Palestrantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGE`.`Palestrantes` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `SGE`.`Palestras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGE`.`Palestras` (
  `ID` INT NOT NULL,
  `EventoID` INT NOT NULL,
  `PalestranteID` INT NOT NULL,
  `Título` VARCHAR(45) NOT NULL,
  `Horário` DATETIME NOT NULL,
  PRIMARY KEY (`ID`, `EventoID`, `PalestranteID`),
  INDEX `fk_Palestras_Eventos1_idx` (`EventoID` ASC) VISIBLE,
  INDEX `fk_Palestras_Palestrantes1_idx` (`PalestranteID` ASC) VISIBLE,
  CONSTRAINT `fk_Palestras_Eventos1`
    FOREIGN KEY (`EventoID`)
    REFERENCES `SGE`.`Eventos` (`ID`),
  CONSTRAINT `fk_Palestras_Palestrantes1`
    FOREIGN KEY (`PalestranteID`)
    REFERENCES `SGE`.`Palestrantes` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `SGE`.`PalestrasFuncionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SGE`.`PalestrasFuncionarios` (
  `Palestras_ID` INT NOT NULL,
  `Funcionarios_ID` INT NOT NULL,
  PRIMARY KEY (`Funcionarios_ID`),
  INDEX `fk_table1_Palestras1_idx` (`Palestras_ID` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Funcionário1`
    FOREIGN KEY (`Funcionarios_ID`)
    REFERENCES `SGE`.`Funcionarios` (`ID`),
  CONSTRAINT `fk_table1_Palestras1`
    FOREIGN KEY (`Palestras_ID`)
    REFERENCES `SGE`.`Palestras` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
