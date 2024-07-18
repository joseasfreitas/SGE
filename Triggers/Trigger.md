# Triggers

## Trigger: atualizar_capacidade_evento_insert

The following SQL statement drops the trigger if it already exists and creates a new trigger to update `CapacidadeRestante` after an insert in the `Inscricoes` table.

```sql
DROP TRIGGER IF EXISTS atualizar_capacidade_restante_insert;

DELIMITER //

-- Create the trigger to update CapacidadeRestante after insert in Inscricoes table
CREATE TRIGGER atualizar_capacidade_restante_insert
AFTER INSERT ON Inscricoes
FOR EACH ROW
BEGIN
    DECLARE capacidade_atual INT;
    DECLARE inscritos_count INT;
    
    -- Get the current capacity of the event
    SELECT Capacidade INTO capacidade_atual
    FROM Eventos
    WHERE ID = NEW.EventoID;

    -- Get the count of inscriptions for the event
    SELECT COUNT(*) INTO inscritos_count
    FROM Inscricoes
    WHERE EventoID = NEW.EventoID;

    -- Update the CapacidadeRestante for the event
    UPDATE Eventos
    SET CapacidadeRestante = capacidade_atual - inscritos_count
    WHERE ID = NEW.EventoID;
END //

DELIMITER ;
```

## Trigger: atualizar_capacidade_evento_delete

The following SQL statement drops the trigger if it already exists and creates a new trigger to update `CapacidadeRestante` after a delete in the `Inscricoes` table.

```sql
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
```

## Trigger: RemoverPalestra

The following SQL statement drops the trigger if it already exists and creates a new trigger to remove associated records from the `PalestrasFuncionarios` table after deleting a record from the `Palestras` table.

```sql
Drop trigger if exists remover_palestra_funcionarios;

DELIMITER //

CREATE TRIGGER remover_palestra_funcionarios
AFTER DELETE ON Palestras
FOR EACH ROW
BEGIN
    DELETE FROM PalestrasFuncionarios
    WHERE Palestras_ID = OLD.ID;
END //

DELIMITER ;
```
