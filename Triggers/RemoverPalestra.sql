Drop trigger if exists remover_palestra_funcionarios;

DELIMITER //

CREATE TRIGGER remover_palestra_funcionarios
AFTER DELETE ON Palestras
FOR EACH ROW
BEGIN
    DELETE FROM PalestrasFuncionarios
    WHERE Palestras_ID = OLD.ID;
END;
//

DELIMITER ;