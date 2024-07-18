-- Drop the function if it already exists
DROP FUNCTION IF EXISTS calcular_capacidade_restante;

DELIMITER //

-- Create a function to calculate the remaining capacity of an event based on EventoID
CREATE FUNCTION calcular_capacidade_restante(evento_id INT) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE capacidade_evento INT;    -- Declare variable to hold total capacity of the event
    DECLARE capacidade_ocupada INT;   -- Declare variable to hold number of registrations for the event
    DECLARE capacidade_restante INT;  -- Declare variable to hold remaining capacity
    
    -- Retrieve the total capacity of the event from the Eventos table
    SELECT Capacidade INTO capacidade_evento FROM Eventos WHERE ID = evento_id;

    -- Count the number of registrations for the event from the Inscricoes table
    SELECT COUNT(*) INTO capacidade_ocupada FROM Inscricoes WHERE EventoID = evento_id;
    
    -- Calculate the remaining capacity by subtracting registrations from total capacity
    SET capacidade_restante = capacidade_evento - capacidade_ocupada;
    
    -- Return the calculated remaining capacity
    RETURN capacidade_restante;
END //

DELIMITER ;

