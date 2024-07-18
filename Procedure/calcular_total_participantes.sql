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

