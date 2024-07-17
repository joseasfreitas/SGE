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
    a.ID = 1 -- replace with Event ID
ORDER BY 
    b.Nome;
