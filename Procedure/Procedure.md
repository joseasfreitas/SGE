# Procedures

## Procedure: atualizar_participante

The following SQL statement drops the `atualizar_participante` procedure if it exists and then creates a new one. 
This stored procedure updates a participant's information in the `Participantes` table based on the provided participant ID (`p_ParticipanteID`), name (`p_Nome`), email (`p_Email`), and phone number (`p_Telefone`).

```sql
DROP PROCEDURE IF EXISTS atualizar_participante;

DELIMITER //

CREATE PROCEDURE atualizar_participante(
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
END //

DELIMITER ;
```

## Procedure: calcular_total_participantes

The following SQL statement drops the `calcular_total_participantes` procedure if it exists and then creates a new one.
This stored procedure calculates the total number of participants for a given event or for all events if EventoID = NULL is provided.

```sql
DROP PROCEDURE IF EXISTS calcular_total_participantes;

DELIMITER //

CREATE PROCEDURE calcular_total_participantes(IN p_EventoID INT)
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
END //

DELIMITER ;
```

## Procedure: gerar_relatorio_eventos

The following SQL statement drops the `gerar_relatorio_eventos` procedure if it exists and then creates a new one. 
This stored procedure generates a report of events and the number of participants for each event within a specified date range.

```sql
DROP PROCEDURE IF EXISTS gerar_relatorio_eventos;

DELIMITER //

CREATE PROCEDURE gerar_relatorio_eventos(IN data_inicio DATE, IN data_fim DATE)
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
END //

DELIMITER ;
```

## Procedure: registrar_inscricao

The following SQL statement drops the `registrar_inscricao` procedure if it exists and then creates a new one. 
This stored procedure registers a participant for an event, checking for available capacity and ensuring the participant is not already registered.

```sql
DROP PROCEDURE IF EXISTS registrar_inscricao;

DELIMITER //

CREATE PROCEDURE registrar_inscricao(
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
END //

DELIMITER ;
```
