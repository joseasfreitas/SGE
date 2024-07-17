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
    e.ID = 1; 
