-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS remover_palestra_funcionarios;

DELIMITER //

-- Create the trigger to remove entries from PalestrasFuncionarios after a delete on Palestras
CREATE TRIGGER remover_palestra_funcionarios
AFTER DELETE ON Palestras
FOR EACH ROW
BEGIN
    -- Delete records from PalestrasFuncionarios where Palestras_ID matches the deleted Palestras.ID
    DELETE FROM PalestrasFuncionarios
    WHERE Palestras_ID = OLD.ID;
END;
//

DELIMITER ;

