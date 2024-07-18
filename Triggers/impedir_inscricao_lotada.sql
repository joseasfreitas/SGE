-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS impedir_inscricao_lotada;

DELIMITER //

-- Create the trigger to prevent registration when event capacity is full
CREATE TRIGGER impedir_inscricao_lotada
BEFORE INSERT ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE capacidade_total INT;        -- Declare variable to hold total event capacity
    DECLARE capacidade_inscritos INT;    -- Declare variable to count current registrations
    
    -- Retrieve the total capacity of the event based on the new registration
    SELECT Capacidade INTO capacidade_total
    FROM Eventos
    WHERE ID = NEW.EventoID;
    
    -- Count the current number of registrations for the event
    SELECT COUNT(*) INTO capacidade_inscritos
    FROM Inscricoes
    WHERE EventoID = NEW.EventoID;
    
    -- Check if there is space for one more registration
    IF capacidade_inscritos >= capacidade_total THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não é possível fazer inscrição. O evento está lotado.';
    END IF;
END //

DELIMITER ;

