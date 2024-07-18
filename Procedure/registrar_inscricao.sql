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

