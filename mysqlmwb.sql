-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Faltas_Estudiantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Faltas_Estudiantes` (
  `id_FaltasEstudiantes` INT NOT NULL,
  `Faltas` ENUM('leves', 'graves') NOT NULL,
  PRIMARY KEY (`id_FaltasEstudiantes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Asistencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Asistencia` (
  `id_Asistencia` INT NOT NULL,
  `asistencia_Diaria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_Asistencia`),
  CONSTRAINT `fk_asistencia`
    FOREIGN KEY (`id_Asistencia`)
    REFERENCES `mydb`.`Faltas_Estudiantes` (`id_FaltasEstudiantes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Incripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Incripciones` (
  `id_Incripciones` INT NOT NULL,
  `Nom_alumno` VARCHAR(45) NOT NULL,
  `Inscripcion` TEXT(200) NOT NULL,
  `Estado` ENUM('Aprobado', 'No aprobado') NOT NULL,
  PRIMARY KEY (`id_Incripciones`),
  CONSTRAINT `fk_inscripciones`
    FOREIGN KEY (`id_Incripciones`)
    REFERENCES `mydb`.`Asistencia` (`id_Asistencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ofertas_Incripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ofertas_Incripciones` (
  `id_OfertasIncripciones` INT NOT NULL,
  `Fecha_Inicio` DATE NOT NULL,
  `Fecha_Fin` DATE NOT NULL,
  `Cursos_ofertados` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_OfertasIncripciones`),
  CONSTRAINT `fk_Ofertas_Incripciones`
    FOREIGN KEY (`id_OfertasIncripciones`)
    REFERENCES `mydb`.`Incripciones` (`id_Incripciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Grados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Grados` (
  `id_Grados` INT NOT NULL,
  `Grados_Institucion` INT NOT NULL,
  PRIMARY KEY (`id_Grados`),
  CONSTRAINT `fk_grados`
    FOREIGN KEY (`id_Grados`)
    REFERENCES `mydb`.`Ofertas_Incripciones` (`id_OfertasIncripciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alumnos` (
  `Docu_identificacion` INT NOT NULL,
  `Nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `Fecha_ingreso` DATE NOT NULL,
  `Grado` INT NOT NULL,
  `estado_grado` ENUM('Aprobado', 'no aprobado') NOT NULL,
  PRIMARY KEY (`Docu_identificacion`),
  CONSTRAINT `fk_alumnos`
    FOREIGN KEY (`Docu_identificacion`)
    REFERENCES `mydb`.`Grados` (`id_Grados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
