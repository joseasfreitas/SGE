-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS atualizar_capacidade_restante_insert;

DELIMITER //

-- Create the trigger to update CapacidadeRestante after insert in Inscricoes table
CREATE TRIGGER atualizar_capacidade_restante_insert
AFTER INSERT ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE capacidade_atual INT;     -- Declare variable to hold current event capacity
    DECLARE inscritos_count INT;      -- Declare variable to count registrations for the event
    
    -- Retrieve the current capacity of the event based on the new registration
    SELECT Capacidade INTO capacidade_atual
    FROM Eventos
    WHERE ID = NEW.EventoID;

    -- Count the number of registrations for the event after the new insertion
    SELECT COUNT(*) INTO inscritos_count
    FROM Inscricoes
    WHERE EventoID = NEW.EventoID;

    -- Update the remaining capacity for the event after the new registration
    UPDATE Eventos
    SET CapacidadeRestante = capacidade_atual - inscritos_count
    WHERE ID = NEW.EventoID;
END //

DELIMITER ;

