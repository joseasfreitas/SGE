CREATE TABLE `PalestrasFuncionarios` (
  `Palestras_ID` int NOT NULL,
  `Funcionarios_ID` int NOT NULL,
  PRIMARY KEY (`Funcionarios_ID`),
  KEY `fk_table1_Palestras1_idx` (`Palestras_ID`),
  CONSTRAINT `fk_table1_Funcionário1` FOREIGN KEY (`Funcionarios_ID`) REFERENCES `Funcionarios` (`ID`),
  CONSTRAINT `fk_table1_Palestras1` FOREIGN KEY (`Palestras_ID`) REFERENCES `Palestras` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
