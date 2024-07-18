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

