CREATE TABLE `Palestras` (
  `ID` int NOT NULL,
  `EventoID` int NOT NULL,
  `PalestranteID` int NOT NULL,
  `Título` varchar(45) NOT NULL,
  `Horário` datetime NOT NULL,
  PRIMARY KEY (`ID`,`EventoID`,`PalestranteID`),
  KEY `fk_Palestras_Eventos1_idx` (`EventoID`),
  KEY `fk_Palestras_Palestrantes1_idx` (`PalestranteID`),
  CONSTRAINT `fk_Palestras_Eventos1` FOREIGN KEY (`EventoID`) REFERENCES `Eventos` (`ID`),
  CONSTRAINT `fk_Palestras_Palestrantes1` FOREIGN KEY (`PalestranteID`) REFERENCES `Palestrantes` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
