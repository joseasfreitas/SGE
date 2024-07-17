Drop Procedure if exists gerar_relatorio_eventos;

DELIMITER //

CREATE PROCEDURE gerar_relatorio_eventos(IN data_inicio DATE, IN data_fim DATE)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE evento_id INT;
    DECLARE evento_nome VARCHAR(45);
    DECLARE evento_data DATE;
    DECLARE participantes_count INT;
    DECLARE evento_cursor CURSOR FOR
        SELECT ID, Nome, Data
        FROM Eventos
        WHERE Data BETWEEN data_inicio AND data_fim;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN evento_cursor;
    read_loop: LOOP
        FETCH evento_cursor INTO evento_id, evento_nome, evento_data;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT COUNT(*) INTO participantes_count
        FROM Inscricoes
        WHERE EventoID = evento_id;
        SELECT evento_id AS EventoID, evento_nome AS NomeEvento, evento_data AS DataEvento, participantes_count AS Participantes;
    END LOOP;
    CLOSE evento_cursor;
END //

DELIMITER ;



