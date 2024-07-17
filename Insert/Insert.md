# Inserts

## Insert: Eventos

The following SQL statement inserts initial event data into the `Eventos` table. 
Each event is defined with attributes such as ID, name, date, location, total capacity, and initial remaining capacity (`CapacidadeRestante`).

```sql
INSERT INTO Eventos (ID, Nome, Data, Local, Capacidade, CapacidadeRestante) VALUES
(1, 'Conferência Internacional de Tecnologia', '2024-08-15', 'Centro de Convenções', 500, 500),
(2, 'Simpósio de Marketing Digital', '2024-09-20', 'Auditório Principal', 200, 200),
(3, 'Workshop de Inovação e Empreendedorismo', '2024-10-10', 'Sala 1', 100, 100),
(4, 'Fórum de Design e Criatividade', '2024-11-05', 'Auditório B', 300, 300),
(5, 'Palestra sobre Inteligência Artificial', '2024-09-01', 'Sala VIP', 50, 50),
(6, 'Curso Avançado de Gestão de Projetos', '2024-08-25', 'Sala 2', 80, 80),
(7, 'Convenção de Fotografia Profissional', '2024-10-15', 'Centro de Convenções', 400, 400),
(8, 'Workshop de Medicina Moderna', '2024-09-12', 'Auditório Principal', 150, 150),
(9, 'Congresso de Educação', '2024-11-20', 'Sala 3', 120, 120),
(10, 'Encontro Nacional de Tecnologia', '2024-12-05', 'Auditório C', 250, 250);
```

## Insert: Funcionarios

The following SQL statement inserts initial employee data into the `Funcionarios` table. 
Each employee is defined with attributes such as ID, name, position, and salary.

```sql
INSERT INTO Funcionarios (ID, Nome, Posição, Salário) VALUES
(1, 'Aline Rodrigues', 'Coordenador de Eventos', 5000.00),
(2, 'Gustavo Oliveira', 'Analista de Marketing', 3500.00),
(3, 'Carolina Santos', 'Desenvolvedor Web', 4000.00),
(4, 'Roberto Costa', 'Gerente de Projetos', 6000.00),
(5, 'Vanessa Pereira', 'Designer Gráfico', 3800.00),
(6, 'Fábio Lima', 'Enfermeira', 4500.00),
(7, 'Marina Almeida', 'Professor', 3800.00),
(8, 'Thiago Vieira', 'Analista de Sistemas', 4200.00),
(9, 'Jéssica Silva', 'Pesquisador', 4800.00),
(10, 'Bruno Martins', 'Consultor Educacional', 5200.00);
```

## Insert: Inscricoes

The following SQL statement inserts initial registration data into the Inscricoes table. 
Each registration links a participant (ParticipanteID) to an event (EventoID) along with the registration date (DataInscrição).

```sql
INSERT INTO Inscricoes (EventoID, ParticipanteID, DataInscrição) VALUES
(1, 1, '2024-08-10'),
(1, 2, '2024-08-12'),
(2, 3, '2024-09-18'),
(3, 4, '2024-09-25'),
(4, 5, '2024-10-01'),
(5, 6, '2024-08-20'),
(6, 7, '2024-08-28'),
(7, 8, '2024-09-05'),
(8, 9, '2024-09-10'),
(9, 10, '2024-10-18');
```

## Insert: Palestrantes

The following SQL statement inserts initial speaker data into the Palestrantes table. 
Each speaker is defined with attributes such as ID, name, and specialization (Especialidade).

```sql
INSERT INTO Palestrantes (ID, Nome, Especialidade) VALUES
(1, 'Luciana Oliveira', 'Inteligência Artificial'),
(2, 'Fernando Souza', 'Marketing Digital'),
(3, 'Camila Silva', 'Empreendedorismo'),
(4, 'Guilherme Costa', 'Design Gráfico'),
(5, 'Patricia Almeida', 'Gestão de Projetos'),
(6, 'Ricardo Lima', 'Fotografia'),
(7, 'Laura Vieira', 'Medicina'),
(8, 'Pedro Santos', 'Educação'),
(9, 'Ana Paula Silva', 'Tecnologia da Informação'),
(10, 'Marcos Oliveira', 'Inovação');
```

## Insert: Palestras

The following SQL statement inserts initial talk data into the Palestras table.
Each lecture is linked to an event (EventoID) and a speaker (PalestranteID), with attributes such as ID, title (Título), and schedule (Horário).

```sql
INSERT INTO Palestras (ID, EventoID, PalestranteID, Título, Horário) VALUES
(1, 1, 1, 'Avanços em IA', '2024-08-15 10:00:00'),
(2, 2, 2, 'Estratégias de Marketing Digital', '2024-09-20 14:30:00'),
(3, 3, 3, 'Inovação e Empreendedorismo', '2024-10-10 11:00:00'),
(4, 4, 4, 'Design e Criatividade', '2024-11-05 15:00:00'),
(5, 5, 5, 'Fotografia Profissional', '2024-09-01 16:00:00'),
(6, 6, 6, 'Gestão Eficiente de Projetos', '2024-08-25 09:30:00'),
(7, 7, 7, 'Avanços na Medicina Moderna', '2024-10-15 13:45:00'),
(8, 8, 8, 'Técnicas Avançadas de Fotografia', '2024-09-12 11:30:00'),
(9, 9, 9, 'Novas Fronteiras na Educação', '2024-11-20 10:15:00'),
(10, 10, 10, 'Tecnologia e Educação', '2024-12-05 14:00:00');
```

## Insert: PalestrasFuncionarios

The following SQL statement inserts initial employee data into the PalestrasFuncionarios table.
Each record links an employee (Funcionarios_ID) to a lecture (Palestras_ID).

```sql
INSERT INTO PalestrasFuncionarios (Palestras_ID, Funcionarios_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
```

## Insert: Participantes

The following SQL statement inserts initial participant data into the Participantes table.
Each participant is defined with attributes such as ID, name, email, and phone number (Telefone).

```sql
INSERT INTO Participantes (ID, Nome, Email, Telefone) VALUES
(1, 'Carlos Silva', 'carlos.silva@example.com', '(11) 9999-8888'),
(2, 'Patrícia Oliveira', 'patricia.oliveira@example.com', '(22) 9876-5432'),
(3, 'Felipe Santos', 'felipe.santos@example.com', '(33) 1234-5678'),
(4, 'Mariana Costa', 'mariana.costa@example.com', '(44) 8765-4321'),
(5, 'José Pereira', 'jose.pereira@example.com', '(55) 1111-2222'),
(6, 'Amanda Lima', 'amanda.lima@example.com', '(66) 3333-4444'),
(7, 'Gabriela Martins', 'gabriela.martins@example.com', '(77) 5555-6666'),
(8, 'Rafael Vieira', 'rafael.vieira@example.com', '(88) 7777-8888'),
(9, 'Juliano Almeida', 'juliano.almeida@example.com', '(99) 9999-0000'),
(10, 'Renata Rodrigues', 'renata.rodrigues@example.com', '(00) 1234-5678');
```
