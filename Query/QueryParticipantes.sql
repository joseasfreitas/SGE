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
