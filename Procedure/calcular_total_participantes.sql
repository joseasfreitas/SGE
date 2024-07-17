DROP PROCEDURE IF EXISTS calcular_total_participantes;

DELIMITER //

CREATE PROCEDURE calcular_total_participantes(IN p_EventoID INT)
BEGIN
    IF p_EventoID IS NOT NULL THEN
        IF (SELECT COUNT(*) FROM Eventos WHERE ID = p_EventoID) = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Evento não encontrado';
        END IF;
        SELECT COUNT(*) AS TotalParticipantes
        FROM Inscricoes
        WHERE EventoID = p_EventoID;
    ELSE
        SELECT 
            e.ID AS EventoID,
            e.Nome AS NomeEvento,
            e.Data AS DataEvento,
            IFNULL((
                SELECT COUNT(*)
                FROM Inscricoes i
                WHERE i.EventoID = e.ID
            ), 0) AS TotalParticipantes
        FROM 
            Eventos e;
    END IF;
END //

DELIMITER ;

