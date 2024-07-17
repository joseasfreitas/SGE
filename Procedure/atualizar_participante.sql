Drop Procedure if exists atualizar_participante

DELIMITER //

CREATE PROCEDURE atualizar_participante(
    IN p_ParticipanteID INT,
    IN p_Nome VARCHAR(45),
    IN p_Email VARCHAR(45),
    IN p_Telefone CHAR(20)
)
BEGIN
    DECLARE participante_existe INT;
    SELECT COUNT(*) INTO participante_existe
    FROM Participantes
    WHERE ID = p_ParticipanteID;

    IF participante_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Participante não encontrado';
    ELSE
        UPDATE Participantes
        SET Nome = p_Nome,
            Email = p_Email,
            Telefone = p_Telefone
        WHERE ID = p_ParticipanteID;
    END IF;
END //

DELIMITER ;

