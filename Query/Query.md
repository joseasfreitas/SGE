# Queries

## Query: CapacidadeRestante

The following SQL statement selects the event capacity remaining for a specific event ID.
Replace `'?'` with the desired `EventoID`.

```sql
SELECT 
    e.ID AS EventoID,
    e.Nome AS NomeEvento,
    e.Data AS DataEvento,
    e.Capacidade - COUNT(i.EventoID) AS CapacidadeRestante
FROM 
    Eventos e
LEFT JOIN 
    Inscricoes i ON e.ID = i.EventoID
WHERE 
    e.ID = '?'; 
```

## Query: Eventos

The following SQL statement selects all events from the Eventos table.

```sql
Select * from Eventos
```

## Query: EventosporLocal

The following SQL statement selects events based on a specific location.
Replace '?' with the name of the location.

```sql
SELECT ID, Nome, Data, Local, CapacidadeTotal, CapacidadeRestante
FROM Eventos
WHERE Local = '?'; 
```

## Query: FuncionarioemEvento

The following SQL statement selects the lectures, associated employees and shows which event they are associated.
Uncomment and replace the ? with the ID of the employee or event for a more specific query.

```sql
SELECT 
    f.Nome AS Funcionário,
    p.Título AS Palestra,
    e.Nome AS NomeEvento,
    e.Data AS DataEvento
FROM 
    PalestrasFuncionarios pf
    JOIN Funcionarios f ON pf.Funcionarios_ID = f.ID
    JOIN Palestras p ON pf.Palestras_ID = p.ID
    JOIN Eventos e ON p.EventoID = e.ID
--    WHERE f.ID = ? -- Replace the ? with the ID of the Employee that you want to look up
--    WHERE e.ID = ? -- Replace the ? with the ID of the event that you want to look up
ORDER BY
    e.ID, p.ID, f.ID;
```

## Query: Palestrantes

The following SQL statement selects the speakers for a specific event ID. Replace '?' with the desired EventoID.

```sql
SELECT 
    a.Nome AS NomeEvento,
    b.ID AS PalestranteID,
    b.Nome AS NomePalestrante,
    c.Titulo AS TituloPalestra,
    c.Horário AS HorarioPalestra
FROM 
    Palestras c
JOIN 
    Eventos a ON c.EventoID = a.ID
JOIN 
    Palestrantes b ON c.PalestranteID = b.ID
WHERE
    a.ID = '?'
ORDER BY 
    b.Nome;
```

## Query: Participantes

The following SQL statement selects participants for each event.

```sql
SELECT 
    a.Nome AS NomeEvento,
    b.ID AS ParticipanteID,
    b.Nome AS NomeParticipante
FROM 
    Inscricoes c
JOIN 
    Eventos a ON c.EventoID = a.ID
JOIN 
    Participantes b ON c.ParticipanteID = b.ID
ORDER BY 
    a.Nome, b.Nome;
```
