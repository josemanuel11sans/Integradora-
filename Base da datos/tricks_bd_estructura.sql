-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tricks
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tricks
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tricks` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `tricks` ;

-- -----------------------------------------------------
-- Table `tricks`.`divisiones_academicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`divisiones_academicas` (
  `id_division` INT NOT NULL AUTO_INCREMENT,
  `nombre_division` VARCHAR(61) NOT NULL,
  `coordinador_division` VARCHAR(45) NULL DEFAULT NULL,
  `siglas` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_division`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tricks`.`grupos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`grupos` (
  `id_grupo` INT NOT NULL AUTO_INCREMENT,
  `nombre_grupo` VARCHAR(100) NOT NULL,
  `divisiones_academicas_id_division` INT NOT NULL,
  PRIMARY KEY (`id_grupo`),
  INDEX `fk_grupos_divisiones_academicas1_idx` (`divisiones_academicas_id_division` ASC) VISIBLE,
  CONSTRAINT `fk_grupos_divisiones_academicas1`
    FOREIGN KEY (`divisiones_academicas_id_division`)
    REFERENCES `tricks`.`divisiones_academicas` (`id_division`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tricks`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`estado` (
  `id_estado` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tricks`.`tipousuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`tipousuario` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `tpoUsuarioRol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tricks`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NULL DEFAULT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `mail` VARCHAR(50) NOT NULL,
  `contrasena` VARCHAR(255) NOT NULL,
  `id_estado` INT NULL DEFAULT NULL,
  `id_rol` INT NULL DEFAULT NULL,
  `asistencias_id_asistencia` INT NULL DEFAULT NULL,
  `grupos_id_grupo` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `id_estado` (`id_estado` ASC) VISIBLE,
  INDEX `id_rol` (`id_rol` ASC) VISIBLE,
  INDEX `fk_usuarios_grupos1_idx` (`grupos_id_grupo` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_grupos1`
    FOREIGN KEY (`grupos_id_grupo`)
    REFERENCES `tricks`.`grupos` (`id_grupo`),
  CONSTRAINT `usuarios_ibfk_1`
    FOREIGN KEY (`id_estado`)
    REFERENCES `tricks`.`estado` (`id_estado`),
  CONSTRAINT `usuarios_ibfk_2`
    FOREIGN KEY (`id_rol`)
    REFERENCES `tricks`.`tipousuario` (`id_rol`))
ENGINE = InnoDB
AUTO_INCREMENT = 148
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tricks`.`asistencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`asistencias` (
  `id_asistencia` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL DEFAULT NULL,
  `presente` VARCHAR(10) NULL DEFAULT NULL,
  `usuarios_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_asistencia`),
  INDEX `fk_asistencias_usuarios1_idx` (`usuarios_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_asistencias_usuarios1`
    FOREIGN KEY (`usuarios_id_usuario`)
    REFERENCES `tricks`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tricks`.`aspirante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`aspirante` (
  `folio_aspirante` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `curp` VARCHAR(25) NOT NULL,
  `estado_id_estado` INT NOT NULL,
  `fecha_nac` DATETIME NOT NULL,
  PRIMARY KEY (`folio_aspirante`),
  INDEX `fk_aspirante_estado1_idx` (`estado_id_estado` ASC) VISIBLE,
  CONSTRAINT `fk_aspirante_estado1`
    FOREIGN KEY (`estado_id_estado`)
    REFERENCES `tricks`.`estado` (`id_estado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tricks`.`calificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`calificaciones` (
  `id_calificacion` INT NOT NULL AUTO_INCREMENT,
  `calificacion` FLOAT NULL DEFAULT NULL,
  `aspirante_folio_aspirante` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_calificacion`),
  INDEX `fk_calificaciones_aspirante1_idx` (`aspirante_folio_aspirante` ASC) VISIBLE,
  CONSTRAINT `fk_calificaciones_aspirante1`
    FOREIGN KEY (`aspirante_folio_aspirante`)
    REFERENCES `tricks`.`aspirante` (`folio_aspirante`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tricks`.`carreras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`carreras` (
  `id_carrera` INT NOT NULL AUTO_INCREMENT,
  `nombre_carrera` VARCHAR(100) NOT NULL,
  `divisiones_academicas_id_division` INT NOT NULL,
  PRIMARY KEY (`id_carrera`),
  INDEX `fk_carreras_divisiones_academicas1_idx` (`divisiones_academicas_id_division` ASC) VISIBLE,
  CONSTRAINT `fk_carreras_divisiones_academicas1`
    FOREIGN KEY (`divisiones_academicas_id_division`)
    REFERENCES `tricks`.`divisiones_academicas` (`id_division`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tricks`.`cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tricks`.`cursos` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_docente` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_curso`),
  INDEX `id_docente` (`id_docente` ASC) VISIBLE,
  CONSTRAINT `cursos_ibfk_1`
    FOREIGN KEY (`id_docente`)
    REFERENCES `tricks`.`usuarios` (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `tricks` ;

-- -----------------------------------------------------
-- procedure verUsuarios
-- -----------------------------------------------------

DELIMITER $$
USE `tricks`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verUsuarios`(
    IN new_id_rol INT  -- Parámetro de entrada para el nuevo id_rol
)
BEGIN
    SELECT u.id_usuario, CONCAT(u.nombre, ' ', u.apellido) AS nombre_completo, u.contrasena, u.mail, e.estado
	FROM usuarios u
	INNER JOIN estado e ON e.id_estado = u.id_estado
	WHERE u.id_rol = new_id_rol
	GROUP BY u.id_usuario
	ORDER BY u.id_usuario ASC;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
