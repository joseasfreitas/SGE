# Procedures

## Procedure: atualizar_participante

The following SQL statement drops the `atualizar_participante` procedure if it exists and then creates a new one. 
This stored procedure updates a participant's information in the `Participantes` table based on the provided participant ID (`p_ParticipanteID`), name (`p_Nome`), email (`p_Email`), and phone number (`p_Telefone`).

```sql
-- Drop the procedure if it already exists
Drop Procedure if exists atualizar_participante

DELIMITER //

-- Create a procedure to update participant details based on participant ID
CREATE PROCEDURE atualizar_participante(
    IN p_ParticipanteID INT, -- Input parameter: Participant ID to update
    IN p_Nome VARCHAR(45),-- Input parameter: New name for the participant
    IN p_Email VARCHAR(45), -- Input parameter: New email for the participant
    IN p_Telefone CHAR(20) -- Input parameter: New phone number for the participant
)
BEGIN
    DECLARE participante_existe INT; -- Declare variable to check if participant exists
    
    -- Check if the participant exists in the Participantes table
    SELECT COUNT(*) INTO participante_existe
    FROM Participantes
    WHERE ID = p_ParticipanteID;

    -- If participant does not exist, signal an error
    IF participante_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Participante não encontrado'; -- Error message for participant not found
    ELSE
        -- Update participant details if participant exists
        UPDATE Participantes
        SET Nome = p_Nome,  -- Update participant's name
            Email = p_Email, -- Update participant's email
            Telefone = p_Telefone -- Update participant's phone number
        WHERE ID = p_ParticipanteID; -- Update based on participant ID
    END IF;
END //

DELIMITER ;
```

## Procedure: calcular_total_participantes

The following SQL statement drops the `calcular_total_participantes` procedure if it exists and then creates a new one.
This stored procedure calculates the total number of participants for a given event or for all events if EventoID = NULL is provided.

```sql
-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS calcular_total_participantes;

DELIMITER //

-- Create a procedure to calculate the total number of participants for an event
CREATE PROCEDURE calcular_total_participantes(IN p_EventoID INT)  -- Input parameter: Evento ID
BEGIN
    -- Check if the input Evento ID is not NULL
    IF p_EventoID IS NOT NULL THEN
        -- Check if the Evento ID exists in the Eventos table
        IF (SELECT COUNT(*) FROM Eventos WHERE ID = p_EventoID) = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Evento não encontrado';  -- Signal an error if event not found
        END IF;
        
        -- Select and return the total number of participants for the specified event
        SELECT COUNT(*) AS TotalParticipantes
        FROM Inscricoes
        WHERE EventoID = p_EventoID;
        
    ELSE
        -- If Evento ID is NULL, select all events along with their total participants count
        SELECT 
            e.ID AS EventoID,     -- Event ID
            e.Nome AS NomeEvento, -- Event name
            e.Data AS DataEvento, -- Event date
            IFNULL((
                SELECT COUNT(*)
                FROM Inscricoes i
                WHERE i.EventoID = e.ID
            ), 0) AS TotalParticipantes -- Total participants for the event (or 0 if none)
        FROM 
            Eventos e; -- List all events from Evento table
    END IF;
END //

DELIMITER ;

```

## Procedure: gerar_relatorio_eventos

The following SQL statement drops the `gerar_relatorio_eventos` procedure if it exists and then creates a new one. 
This stored procedure generates a report of events and the number of participants for each event within a specified date range.

```sql
-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS gerar_relatorio_eventos;

DELIMITER //

-- Create a procedure to generate a report of events within a specified date range
CREATE PROCEDURE gerar_relatorio_eventos(IN data_inicio DATE, IN data_fim DATE)
BEGIN
    DECLARE done INT DEFAULT FALSE;  -- Flag to check if cursor fetching is complete
    DECLARE evento_id INT;           -- Declare variable to store Evento ID
    DECLARE evento_nome VARCHAR(45); -- Declare variable to store Evento name
    DECLARE evento_data DATE;        -- Declare variable to store Evento date
    DECLARE participantes_count INT; -- Declare variable to store number of participants
    DECLARE evento_cursor CURSOR FOR -- Declare cursor to iterate through events
        SELECT ID, Nome, Data        -- Select events within the specified date range
        FROM Eventos
        WHERE Data BETWEEN data_inicio AND data_fim;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;  -- Handler for cursor end

    -- Create a temporary table to store the results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_eventos_report (
        EventoID INT,
        NomeEvento VARCHAR(45),
        DataEvento DATE,
        Participantes INT
    );

    -- Open the cursor to start fetching
    OPEN evento_cursor;  
    read_loop: LOOP
        FETCH evento_cursor INTO evento_id, evento_nome, evento_data;  -- Fetch event details into variables
        IF done THEN
            LEAVE read_loop;  -- Exit loop if no more events are found
        END IF;
        
        -- Count the number of participants for the current event
        SELECT COUNT(*) INTO participantes_count
        FROM Inscricoes
        WHERE EventoID = evento_id;
        
        -- Insert event details along with participant count into the temporary table
        INSERT INTO temp_eventos_report (EventoID, NomeEvento, DataEvento, Participantes)
        VALUES (evento_id, evento_nome, evento_data, participantes_count);
    END LOOP;
    
    -- Close the cursor after fetching is complete
    CLOSE evento_cursor;  

    -- Select the accumulated results from the temporary table
    SELECT * FROM temp_eventos_report;

    -- Drop the temporary table
    DROP TEMPORARY TABLE temp_eventos_report;
END //

DELIMITER ;
```

## Procedure: registrar_inscricao

The following SQL statement drops the `registrar_inscricao` procedure if it exists and then creates a new one. 
This stored procedure registers a participant for an event, checking for available capacity and ensuring the participant is not already registered.

```sql
-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS registrar_inscricao;

DELIMITER //

-- Create a procedure to register a participant for an event
CREATE PROCEDURE registrar_inscricao(
    IN p_EventoID INT,        -- Input parameter: Evento ID for registration
    IN p_ParticipanteID INT   -- Input parameter: Participante ID for registration
)
BEGIN
    DECLARE capacidade INT;              -- Declare variable to hold event capacity
    DECLARE inscritos INT;               -- Declare variable to count registrations
    DECLARE participante_existe INT;     -- Declare variable to check if participant is already registered
    
    -- Retrieve the total capacity of the event
    SELECT Capacidade INTO capacidade
    FROM Eventos
    WHERE ID = p_EventoID;
    
    -- Check if the event exists; if not, raise an error
    IF NOT EXISTS (SELECT 1 FROM Eventos WHERE ID = p_EventoID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Evento não encontrado';
    END IF;
    
    -- Calculate remaining capacity by subtracting current registrations from total capacity
    SELECT Capacidade - COUNT(*) INTO capacidade
    FROM Inscricoes
    WHERE EventoID = p_EventoID;

    -- If remaining capacity is zero or negative, raise an error
    IF capacidade <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Capacidade do evento esgotada';
    END IF;

    -- Check if the participant is already registered for the event; if yes, raise an error
    SELECT COUNT(*) INTO participante_existe
    FROM Inscricoes
    WHERE EventoID = p_EventoID AND ParticipanteID = p_ParticipanteID;

    IF participante_existe > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Participante já inscrito no evento';
    END IF;

    -- Insert registration into Inscricoes table with current date
    INSERT INTO Inscricoes (EventoID, ParticipanteID, DataInscrição)
    VALUES (p_EventoID, p_ParticipanteID, CURDATE());
END //

DELIMITER ;
```
