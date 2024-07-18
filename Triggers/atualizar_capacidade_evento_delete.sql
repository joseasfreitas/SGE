-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS atualizar_capacidade_restante_delete;

DELIMITER //

-- Create the trigger to update CapacidadeRestante after delete in Inscricoes table
CREATE TRIGGER atualizar_capacidade_restante_delete
AFTER DELETE ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE capacidade_atual INT;
    DECLARE inscritos_count INT;
    
    -- Get the current capacity of the event
    SELECT Capacidade INTO capacidade_atual
    FROM Eventos
    WHERE ID = OLD.EventoID;

    -- Get the count of inscriptions for the event
    SELECT COUNT(*) INTO inscritos_count
    FROM Inscricoes
    WHERE EventoID = OLD.EventoID;

    -- Update the CapacidadeRestante for the event
    UPDATE Eventos
    SET CapacidadeRestante = capacidade_atual - inscritos_count
    WHERE ID = OLD.EventoID;
END //

DELIMITER ;
