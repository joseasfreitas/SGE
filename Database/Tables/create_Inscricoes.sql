CREATE TABLE `Inscricoes` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EventoID` int NOT NULL,
  `ParticipanteID` int NOT NULL,
  `DataInscrição` date NOT NULL,
  PRIMARY KEY (`ID`,`EventoID`,`ParticipanteID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`),
  KEY `fk_Inscrições_Eventos_idx` (`EventoID`),
  KEY `fk_Inscrições_Participantes1_idx` (`ParticipanteID`),
  CONSTRAINT `fk_Inscrições_Eventos` FOREIGN KEY (`EventoID`) REFERENCES `Eventos` (`ID`),
  CONSTRAINT `fk_Inscrições_Participantes1` FOREIGN KEY (`ParticipanteID`) REFERENCES `Participantes` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
