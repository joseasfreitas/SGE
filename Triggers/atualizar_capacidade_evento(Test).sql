DROP TRIGGER IF EXISTS atualizar_capacidade_evento_insert;
DELIMITER //
CREATE TRIGGER atualizar_capacidade_evento_insert
AFTER INSERT ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE evento_id INT;
    DECLARE capacidade_atual INT;
    DECLARE inscritos_count INT;
    SET evento_id = NEW.EventoID;
    SELECT Capacidade INTO capacidade_atual
    FROM Eventos
    WHERE ID = evento_id;
    SELECT COUNT(*) INTO inscritos_count
    FROM Inscricoes
    WHERE EventoID = evento_id;
    UPDATE Eventos
    SET CapacidadeRestante = capacidade_atual - inscritos_count
    WHERE ID = evento_id;
END //

DELIMITER ;