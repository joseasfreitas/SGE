-- Uncomment the WHERE if you want a more specific ID
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
