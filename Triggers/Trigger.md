# Triggers

## Trigger: atualizar_capacidade_evento_insert

The following SQL statement drops the trigger if it already exists and creates a new trigger to update `CapacidadeRestante` after an insert in the `Inscricoes` table.

```sql
-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS atualizar_capacidade_restante_insert;

DELIMITER //

-- Create the trigger to update CapacidadeRestante after insert in Inscricoes table
CREATE TRIGGER atualizar_capacidade_restante_insert
AFTER INSERT ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE capacidade_atual INT;     -- Declare variable to hold current event capacity
    DECLARE inscritos_count INT;      -- Declare variable to count registrations for the event
    
    -- Retrieve the current capacity of the event based on the new registration
    SELECT Capacidade INTO capacidade_atual
    FROM Eventos
    WHERE ID = NEW.EventoID;

    -- Count the number of registrations for the event after the new insertion
    SELECT COUNT(*) INTO inscritos_count
    FROM Inscricoes
    WHERE EventoID = NEW.EventoID;

    -- Update the remaining capacity for the event after the new registration
    UPDATE Eventos
    SET CapacidadeRestante = capacidade_atual - inscritos_count
    WHERE ID = NEW.EventoID;
END //

DELIMITER ;
```

## Trigger: atualizar_capacidade_evento_delete

The following SQL statement drops the trigger if it already exists and creates a new trigger to update `CapacidadeRestante` after a delete in the `Inscricoes` table.

```sql
-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS atualizar_capacidade_restante_delete;

DELIMITER //

-- Create the trigger to update CapacidadeRestante after delete in Inscricoes table
CREATE TRIGGER atualizar_capacidade_restante_delete
AFTER DELETE ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE capacidade_atual INT;
    DECLARE inscritos_count INT;
    
    -- Get the current capacity of the event
    SELECT Capacidade INTO capacidade_atual
    FROM Eventos
    WHERE ID = OLD.EventoID;

    -- Get the count of inscriptions for the event
    SELECT COUNT(*) INTO inscritos_count
    FROM Inscricoes
    WHERE EventoID = OLD.EventoID;

    -- Update the CapacidadeRestante for the event
    UPDATE Eventos
    SET CapacidadeRestante = capacidade_atual - inscritos_count
    WHERE ID = OLD.EventoID;
END //

DELIMITER ;
```

## Trigger: impedir_inscricao_lotada

The following SQL statement drops the trigger if it already exists and creates a new trigger to prevent overbooking by checking the event capacity before inserting a new record in the `Inscricoes` table.

```sql
-- Drop the trigger if it already exists
DROP TRIGGER IF EXISTS impedir_inscricao_lotada;

DELIMITER //

-- Create the trigger to prevent registration when event capacity is full
CREATE TRIGGER impedir_inscricao_lotada
BEFORE INSERT ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE capacidade_total INT;        -- Declare variable to hold total event capacity
    DECLARE capacidade_inscritos INT;    -- Declare variable to count current registrations
    
    -- Retrieve the total capacity of the event based on the new registration
    SELECT Capacidade INTO capacidade_total
    FROM Eventos
    WHERE ID = NEW.EventoID;
    
    -- Count the current number of registrations for the event
    SELECT COUNT(*) INTO capacidade_inscritos
    FROM Inscricoes
    WHERE EventoID = NEW.EventoID;
    
    -- Check if there is space for one more registration
    IF capacidade_inscritos >= capacidade_total THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não é possível fazer inscrição. O evento está lotado.';
    END IF;
END //

DELIMITER ;

```

## Trigger: RemoverPalestra

The following SQL statement drops the trigger if it already exists and creates a new trigger to remove associated records from the `PalestrasFuncionarios` table after deleting a record from the `Palestras` table.

```sql
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
```
