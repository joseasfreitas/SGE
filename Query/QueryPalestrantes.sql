-- Replace '?' with the desired EventoID
SELECT 
    a.Nome AS NomeEvento,
    b.ID AS PalestranteID,
    b.Nome AS NomePalestrante,
    c.Título AS TituloPalestra,
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
