CREATE TABLE `Palestrantes` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `Especialidade` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
