CREATE TABLE  `entrenamiento` (
    `entrenamientoID` INT PRIMARY KEY AUTO_INCREMENT,
    `tipo_entrenamiento` VARCHAR(10) CHECK (tipo_entrenamiento IN ('fisico', 'tecnico')),
    `ubicacion` VARCHAR(100) DEFAULT NULL,
    `fecha_realizacion` DATE DEFAULT NULL
    );