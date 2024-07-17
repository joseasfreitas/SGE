DROP PROCEDURE IF EXISTS registrar_inscricao;

DELIMITER //

CREATE PROCEDURE registrar_inscricao(
    IN p_EventoID INT,
    IN p_ParticipanteID INT
)
BEGIN
    DECLARE capacidade INT;
    DECLARE inscritos INT;
    DECLARE participante_existe INT;
    SELECT Capacidade INTO capacidade
    FROM Eventos
    WHERE ID = p_EventoID;
    IF NOT EXISTS (SELECT 1 FROM Eventos WHERE ID = p_EventoID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Evento não encontrado';
    END IF;
    SELECT Capacidade - COUNT(*) INTO capacidade
    FROM Inscricoes
    WHERE EventoID = p_EventoID;

    IF capacidade <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Capacidade do evento esgotada';
    END IF;

    SELECT COUNT(*) INTO participante_existe
    FROM Inscricoes
    WHERE EventoID = p_EventoID AND ParticipanteID = p_ParticipanteID;

    IF participante_existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Participante já inscrito no evento';
    END IF;

    INSERT INTO Inscricoes (EventoID, ParticipanteID, DataInscrição)
    VALUES (p_EventoID, p_ParticipanteID, CURDATE());
END //

DELIMITER ;


