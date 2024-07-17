DROP TRIGGER IF EXISTS impedir_inscricao_lotada;
DELIMITER //

CREATE TRIGGER impedir_inscricao_lotada
BEFORE INSERT ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE capacidade_total INT;
    DECLARE capacidade_inscritos INT;
    
    -- Obter a capacidade total do evento
    SELECT Capacidade INTO capacidade_total
    FROM Eventos
    WHERE ID = NEW.EventoID;
    
    -- Contar o número atual de inscrições
    SELECT COUNT(*) INTO capacidade_inscritos
    FROM Inscricoes
    WHERE EventoID = NEW.EventoID;
    
    -- Verificar se há espaço para mais uma inscrição
    IF capacidade_inscritos >= capacidade_total THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não é possível fazer inscrição. O evento está lotado.';
    END IF;
END //

DELIMITER ;
