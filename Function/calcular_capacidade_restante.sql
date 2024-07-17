DROP FUNCTION IF EXISTS calcular_capacidade_restante;

DELIMITER //

CREATE FUNCTION calcular_capacidade_restante(evento_id INT) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE capacidade_evento INT;
    DECLARE capacidade_ocupada INT;
    DECLARE capacidade_restante INT;
    SELECT Capacidade INTO capacidade_evento FROM Eventos WHERE ID = evento_id;
    SELECT COUNT(*) INTO capacidade_ocupada FROM Inscricoes WHERE EventoID = evento_id;
    SET capacidade_restante = capacidade_evento - capacidade_ocupada;
    RETURN capacidade_restante;
END //

DELIMITER ;


