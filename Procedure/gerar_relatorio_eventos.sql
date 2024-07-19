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
