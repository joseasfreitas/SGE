CREATE DATABASE  IF NOT EXISTS `SGE` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `SGE`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 52.3.33.81    Database: SGE
-- ------------------------------------------------------
-- Server version	8.0.37-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Eventos`
--

DROP TABLE IF EXISTS `Eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Eventos` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `Data` date NOT NULL,
  `Local` varchar(45) NOT NULL,
  `Capacidade` int NOT NULL,
  `CapacidadeRestante` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Eventos`
--

LOCK TABLES `Eventos` WRITE;
/*!40000 ALTER TABLE `Eventos` DISABLE KEYS */;
INSERT INTO `Eventos` VALUES (1,'Conferência Internacional de Tecnologia','2024-08-15','Centro de Convenções',500,498),(2,'Simpósio de Marketing Digital','2024-09-20','Auditório Principal',200,199),(3,'Workshop de Inovação e Empreendedorismo','2024-10-10','Sala 1',100,99),(4,'Fórum de Design e Criatividade','2024-11-05','Auditório B',300,299),(5,'Palestra sobre Inteligência Artificial','2024-09-01','Sala VIP',50,49),(6,'Curso Avançado de Gestão de Projetos','2024-08-25','Sala 2',80,79),(7,'Convenção de Fotografia Profissional','2024-10-15','Centro de Convenções',400,399),(8,'Workshop de Medicina Moderna','2024-09-12','Auditório Principal',150,149),(9,'Congresso de Educação','2024-11-20','Sala 3',120,119),(10,'Encontro Nacional de Tecnologia','2024-12-05','Auditório C',250,250);
/*!40000 ALTER TABLE `Eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Funcionarios`
--

DROP TABLE IF EXISTS `Funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Funcionarios` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `Posição` varchar(45) NOT NULL,
  `Salário` decimal(10,0) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Funcionarios`
--

LOCK TABLES `Funcionarios` WRITE;
/*!40000 ALTER TABLE `Funcionarios` DISABLE KEYS */;
INSERT INTO `Funcionarios` VALUES (1,'Aline Rodrigues','Coordenador de Eventos',5000),(2,'Gustavo Oliveira','Analista de Marketing',3500),(3,'Carolina Santos','Desenvolvedor Web',4000),(4,'Roberto Costa','Gerente de Projetos',6000),(5,'Vanessa Pereira','Designer Gráfico',3800),(6,'Fábio Lima','Enfermeira',4500),(7,'Marina Almeida','Professor',3800),(8,'Thiago Vieira','Analista de Sistemas',4200),(9,'Jéssica Silva','Pesquisador',4800),(10,'Bruno Martins','Consultor Educacional',5200);
/*!40000 ALTER TABLE `Funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inscricoes`
--

DROP TABLE IF EXISTS `Inscricoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inscricoes`
--

LOCK TABLES `Inscricoes` WRITE;
/*!40000 ALTER TABLE `Inscricoes` DISABLE KEYS */;
INSERT INTO `Inscricoes` VALUES (98,1,1,'2024-08-10'),(99,1,2,'2024-08-12'),(100,2,3,'2024-09-18'),(101,3,4,'2024-09-25'),(102,4,5,'2024-10-01'),(103,5,6,'2024-08-20'),(104,6,7,'2024-08-28'),(105,7,8,'2024-09-05'),(106,8,9,'2024-09-10'),(107,9,10,'2024-10-18');
/*!40000 ALTER TABLE `Inscricoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `impedir_inscricao_lotada` BEFORE INSERT ON `Inscricoes` FOR EACH ROW BEGIN
    DECLARE capacidade_total INT;
    DECLARE capacidade_inscritos INT;
    
    SELECT Capacidade INTO capacidade_total
    FROM Eventos
    WHERE ID = NEW.EventoID;
    
    SELECT COUNT(*) INTO capacidade_inscritos
    FROM Inscricoes
    WHERE EventoID = NEW.EventoID;
    
    IF capacidade_inscritos >= capacidade_total THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não é possível fazer inscrição. O evento está lotado.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `atualizar_capacidade_restante_insert` AFTER INSERT ON `Inscricoes` FOR EACH ROW BEGIN
    DECLARE capacidade_atual INT;
    DECLARE inscritos_count INT;
    
    SELECT Capacidade INTO capacidade_atual
    FROM Eventos
    WHERE ID = NEW.EventoID;

    SELECT COUNT(*) INTO inscritos_count
    FROM Inscricoes
    WHERE EventoID = NEW.EventoID;

    UPDATE Eventos
    SET CapacidadeRestante = capacidade_atual - inscritos_count
    WHERE ID = NEW.EventoID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `atualizar_capacidade_restante_delete` AFTER DELETE ON `Inscricoes` FOR EACH ROW BEGIN
    DECLARE capacidade_atual INT;
    DECLARE inscritos_count INT;
    
    SELECT Capacidade INTO capacidade_atual
    FROM Eventos
    WHERE ID = OLD.EventoID;

    SELECT COUNT(*) INTO inscritos_count
    FROM Inscricoes
    WHERE EventoID = OLD.EventoID;

    UPDATE Eventos
    SET CapacidadeRestante = capacidade_atual - inscritos_count
    WHERE ID = OLD.EventoID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Palestrantes`
--

DROP TABLE IF EXISTS `Palestrantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Palestrantes` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `Especialidade` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Palestrantes`
--

LOCK TABLES `Palestrantes` WRITE;
/*!40000 ALTER TABLE `Palestrantes` DISABLE KEYS */;
INSERT INTO `Palestrantes` VALUES (1,'Luciana Oliveira','Inteligência Artificial'),(2,'Fernando Souza','Marketing Digital'),(3,'Camila Silva','Empreendedorismo'),(4,'Guilherme Costa','Design Gráfico'),(5,'Patricia Almeida','Gestão de Projetos'),(6,'Ricardo Lima','Fotografia'),(7,'Laura Vieira','Medicina'),(8,'Pedro Santos','Educação'),(9,'Ana Paula Silva','Tecnologia da Informação'),(10,'Marcos Oliveira','Inovação');
/*!40000 ALTER TABLE `Palestrantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Palestras`
--

DROP TABLE IF EXISTS `Palestras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Palestras`
--

LOCK TABLES `Palestras` WRITE;
/*!40000 ALTER TABLE `Palestras` DISABLE KEYS */;
INSERT INTO `Palestras` VALUES (1,1,1,'Avanços em IA','2024-08-15 10:00:00'),(2,2,2,'Estratégias de Marketing Digital','2024-09-20 14:30:00'),(3,3,3,'Inovação e Empreendedorismo','2024-10-10 11:00:00'),(4,4,4,'Design e Criatividade','2024-11-05 15:00:00'),(5,5,5,'Fotografia Profissional','2024-09-01 16:00:00'),(6,6,6,'Gestão Eficiente de Projetos','2024-08-25 09:30:00'),(7,7,7,'Avanços na Medicina Moderna','2024-10-15 13:45:00'),(8,8,8,'Técnicas Avançadas de Fotografia','2024-09-12 11:30:00'),(9,9,9,'Novas Fronteiras na Educação','2024-11-20 10:15:00'),(10,10,10,'Tecnologia e Educação','2024-12-05 14:00:00');
/*!40000 ALTER TABLE `Palestras` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `remover_palestra_funcionarios` AFTER DELETE ON `Palestras` FOR EACH ROW BEGIN
    DELETE FROM PalestrasFuncionarios
    WHERE Palestras_ID = OLD.ID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PalestrasFuncionarios`
--

DROP TABLE IF EXISTS `PalestrasFuncionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PalestrasFuncionarios` (
  `Palestras_ID` int NOT NULL,
  `Funcionarios_ID` int NOT NULL,
  PRIMARY KEY (`Funcionarios_ID`),
  KEY `fk_table1_Palestras1_idx` (`Palestras_ID`),
  CONSTRAINT `fk_table1_Funcionário1` FOREIGN KEY (`Funcionarios_ID`) REFERENCES `Funcionarios` (`ID`),
  CONSTRAINT `fk_table1_Palestras1` FOREIGN KEY (`Palestras_ID`) REFERENCES `Palestras` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PalestrasFuncionarios`
--

LOCK TABLES `PalestrasFuncionarios` WRITE;
/*!40000 ALTER TABLE `PalestrasFuncionarios` DISABLE KEYS */;
INSERT INTO `PalestrasFuncionarios` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `PalestrasFuncionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Participantes`
--

DROP TABLE IF EXISTS `Participantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Participantes` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Telefone` char(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Participantes`
--

LOCK TABLES `Participantes` WRITE;
/*!40000 ALTER TABLE `Participantes` DISABLE KEYS */;
INSERT INTO `Participantes` VALUES (1,'Carlos Silva','carlos.silva@example.com','(11) 9999-8888'),(2,'Patrícia Oliveira','patricia.oliveira@example.com','(22) 9876-5432'),(3,'Felipe Santos','felipe.santos@example.com','(33) 1234-5678'),(4,'Mariana Costa','mariana.costa@example.com','(44) 8765-4321'),(5,'José Pereira','jose.pereira@example.com','(55) 1111-2222'),(6,'Amanda Lima','amanda.lima@example.com','(66) 3333-4444'),(7,'Gabriela Martins','gabriela.martins@example.com','(77) 5555-6666'),(8,'Rafael Vieira','rafael.vieira@example.com','(88) 7777-8888'),(9,'Juliano Almeida','juliano.almeida@example.com','(99) 9999-0000'),(10,'Renata Rodrigues','renata.rodrigues@example.com','(00) 1234-5678');
/*!40000 ALTER TABLE `Participantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'SGE'
--

--
-- Dumping routines for database 'SGE'
--
/*!50003 DROP PROCEDURE IF EXISTS `atualizar_participante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `atualizar_participante`(
    IN p_ParticipanteID INT,
    IN p_Nome VARCHAR(45),
    IN p_Email VARCHAR(45),
    IN p_Telefone CHAR(20)
)
BEGIN
    DECLARE participante_existe INT;

    SELECT COUNT(*) INTO participante_existe
    FROM Participantes
    WHERE ID = p_ParticipanteID;

    IF participante_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Participante não encontrado';
    ELSE
        UPDATE Participantes
        SET Nome = p_Nome,
            Email = p_Email,
            Telefone = p_Telefone
        WHERE ID = p_ParticipanteID;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `calcular_total_participantes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `calcular_total_participantes`(IN p_EventoID INT)
BEGIN
    IF p_EventoID IS NOT NULL THEN
        IF (SELECT COUNT(*) FROM Eventos WHERE ID = p_EventoID) = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Evento não encontrado';
        END IF;
        SELECT COUNT(*) AS TotalParticipantes
        FROM Inscricoes
        WHERE EventoID = p_EventoID;
    ELSE
        SELECT 
            e.ID AS EventoID,
            e.Nome AS NomeEvento,
            e.Data AS DataEvento,
            IFNULL((
                SELECT COUNT(*)
                FROM Inscricoes i
                WHERE i.EventoID = e.ID
            ), 0) AS TotalParticipantes
        FROM 
            Eventos e;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `gerar_relatorio_eventos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `gerar_relatorio_eventos`(IN data_inicio DATE, IN data_fim DATE)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE evento_id INT;
    DECLARE evento_nome VARCHAR(45);
    DECLARE evento_data DATE;
    DECLARE participantes_count INT;
    
    DECLARE evento_cursor CURSOR FOR
        SELECT ID, Nome, Data
        FROM Eventos
        WHERE Data BETWEEN data_inicio AND data_fim;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN evento_cursor;
    read_loop: LOOP
        FETCH evento_cursor INTO evento_id, evento_nome, evento_data;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT COUNT(*) INTO participantes_count
        FROM Inscricoes
        WHERE EventoID = evento_id;

        SELECT evento_id AS EventoID, evento_nome AS NomeEvento, evento_data AS DataEvento, participantes_count AS Participantes;
    END LOOP;
    CLOSE evento_cursor;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_inscricao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `registrar_inscricao`(
    IN p_EventoID INT,
    IN p_ParticipanteID INT
)
BEGIN
    DECLARE capacidade INT;
    DECLARE inscritos INT;
    DECLARE participante_existe INT;

    SELECT Capacidade INTO capacidade
    FROM Eventos
    WHERE ID = p_EventoID;

    IF NOT EXISTS (SELECT 1 FROM Eventos WHERE ID = p_EventoID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Evento não encontrado';
    END IF;

    SELECT Capacidade - COUNT(*) INTO capacidade
    FROM Inscricoes
    WHERE EventoID = p_EventoID;

    IF capacidade <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Capacidade do evento esgotada';
    END IF;

    SELECT COUNT(*) INTO participante_existe
    FROM Inscricoes
    WHERE EventoID = p_EventoID AND ParticipanteID = p_ParticipanteID;

    IF participante_existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Participante já inscrito no evento';
    END IF;

    INSERT INTO Inscricoes (EventoID, ParticipanteID, DataInscrição)
    VALUES (p_EventoID, p_ParticipanteID, CURDATE());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-18  9:39:29
