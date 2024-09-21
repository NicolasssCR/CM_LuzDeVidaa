-- -----------------------------------------------------
-- Deshabilitar temporalmente las restricciones de claves foráneas
-- -----------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------
-- Eliminar las tablas si existen para evitar conflictos
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Citas`;
DROP TABLE IF EXISTS `mydb`.`HorarioCitas`;
DROP TABLE IF EXISTS `mydb`.`MedicoConsultorio`;
DROP TABLE IF EXISTS `mydb`.`Agenda`;
DROP TABLE IF EXISTS `mydb`.`Medicos`;
DROP TABLE IF EXISTS `mydb`.`Consultorios`;
DROP TABLE IF EXISTS `mydb`.`Pacientes`;

-- -----------------------------------------------------
-- Crear tabla Pacientes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pacientes` (
  `ID_Paciente` INT NOT NULL,
  `Nombre_Paciente` VARCHAR(20) NULL,
  `Apellido_Paciente` VARCHAR(20) NULL,
  `FechaNac_Paciente` DATE NULL,
  `Genero_Paciente` VARCHAR(15) NULL,
  `Direccion_Paciente` VARCHAR(30) NULL,
  `Telefono_Paciente` VARCHAR(10) NULL,
  `Email_Paciente` VARCHAR(40) NULL,
  PRIMARY KEY (`ID_Paciente`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Crear tabla Consultorios
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consultorios` (
  `ID_Consultorios` BIGINT NOT NULL,
  `Nombre_Consultorios` VARCHAR(40) NULL,
  `Ubicacion_Consultorios` VARCHAR(25) NULL,
  `HoraAtencion_Consultorios` VARCHAR(20) NULL,
  PRIMARY KEY (`ID_Consultorios`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Crear tabla Medicos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medicos` (
  `ID_Medicos` INT NOT NULL,
  `Nombre_Medicos` VARCHAR(20) NULL,
  `Apellido_Medicos` VARCHAR(20) NULL,
  `Especialidad_Medicos` VARCHAR(30) NULL,
  `HoraAtencion_Medicos` VARCHAR(20) NULL,
  PRIMARY KEY (`ID_Medicos`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Crear tabla MedicoConsultorio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MedicoConsultorio` (
  `ID_MedicoConsultorio` INT NOT NULL,
  `ID_Medicos` INT NULL,
  `ID_Consultorios` BIGINT NULL,
  PRIMARY KEY (`ID_MedicoConsultorio`),
  CONSTRAINT `fk_MedicoConsultorio_Consultorios`
    FOREIGN KEY (`ID_Consultorios`)
    REFERENCES `mydb`.`Consultorios` (`ID_Consultorios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Crear tabla Agenda
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Agenda` (
  `ID_Agenda` INT NOT NULL,
  `Fecha_Agenda` DATE NULL,
  `HoraInicio_Agenda` VARCHAR(15) NULL,
  `HoraFin_Agenda` VARCHAR(15) NULL,
  `ID_Medicos` INT NULL,
  PRIMARY KEY (`ID_Agenda`),
  CONSTRAINT `fk_Agenda_Medicos`
    FOREIGN KEY (`ID_Medicos`)
    REFERENCES `mydb`.`Medicos` (`ID_Medicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Crear tabla HorarioCitas asegurando que ID_Citas es único
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HorarioCitas` (
  `ID_HorarioCitas` INT NOT NULL,
  `ID_Paciente` INT NULL,
  `ID_Citas` BIGINT NOT NULL,
  `FechaHora_Citas` VARCHAR(45) NULL,
  `Motivo_Citas` VARCHAR(200) NULL,
  `Resultado_HorarioCitas` VARCHAR(300) NULL,
  PRIMARY KEY (`ID_HorarioCitas`),
  UNIQUE (`ID_Citas`), -- Asegura que los valores sean únicos para la referencia
  CONSTRAINT `fk_HorarioCitas_Pacientes`
    FOREIGN KEY (`ID_Paciente`)
    REFERENCES `mydb`.`Pacientes` (`ID_Paciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Crear tabla Citas con la clave foránea correcta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Citas` (
  `ID_Citas` BIGINT NOT NULL,
  `ID_Paciente` INT NULL,
  `ID_Medicos` INT NULL,
  `FechaHora_Citas` VARCHAR(45) NULL,
  `Motivo_Citas` VARCHAR(200) NULL,
  `Estado_Citas` VARCHAR(20) NULL,
  `ID_Consultorios` BIGINT NULL,
  PRIMARY KEY (`ID_Citas`),
  CONSTRAINT `fk_Citas_HorarioCitas1`
    FOREIGN KEY (`ID_Citas`)
    REFERENCES `mydb`.`HorarioCitas` (`ID_Citas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Citas_Pacientes`
    FOREIGN KEY (`ID_Paciente`)
    REFERENCES `mydb`.`Pacientes` (`ID_Paciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Citas_Medicos`
    FOREIGN KEY (`ID_Medicos`)
    REFERENCES `mydb`.`Medicos` (`ID_Medicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Citas_Consultorios`
    FOREIGN KEY (`ID_Consultorios`)
    REFERENCES `mydb`.`Consultorios` (`ID_Consultorios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Restaurar las restricciones de claves foráneas
-- -----------------------------------------------------
