# SGE Database

## Overview

The `SGE` (Sistema de Gestão de Eventos) database is designed to manage events, participants, speakers, employees, and their respective registrations and schedules. 
This schema includes several tables: `Eventos`, `Funcionarios`, `Participantes`, `Inscricoes`, `Palestrantes`, `Palestras`, and `PalestrasFuncionarios`.

## Schema

### Eventos Table

Stores information about events.

- **Table Name**: `Eventos`
- **Columns**:
  - `ID` (INT, NOT NULL, AUTO_INCREMENT): Primary key.
  - `Nome` (VARCHAR(45), NOT NULL): Name of the event.
  - `Data` (DATE, NOT NULL): Date of the event.
  - `Local` (VARCHAR(45), NOT NULL): Location of the event.
  - `Capacidade` (INT, NOT NULL): Total capacity of the event.
  - `CapacidadeRestante` (INT, NOT NULL): Remaining capacity of the event.
- **Indexes**:
  - `PRIMARY KEY` (`ID`)
  - `UNIQUE INDEX` (`ID`)

### Funcionarios Table

Stores information about employees.

- **Table Name**: `Funcionarios`
- **Columns**:
  - `ID` (INT, NOT NULL, AUTO_INCREMENT): Primary key.
  - `Nome` (VARCHAR(45), NOT NULL): Name of the employee.
  - `Posição` (VARCHAR(45), NOT NULL): Position of the employee.
  - `Salário` (DECIMAL(10,0), NOT NULL): Salary of the employee.
- **Indexes**:
  - `PRIMARY KEY` (`ID`)
  - `UNIQUE INDEX` (`ID`)

### Participantes Table

Stores information about participants.

- **Table Name**: `Participantes`
- **Columns**:
  - `ID` (INT, NOT NULL, AUTO_INCREMENT): Primary key.
  - `Nome` (VARCHAR(45), NOT NULL): Name of the participant.
  - `Email` (VARCHAR(45), NOT NULL): Email of the participant.
  - `Telefone` (CHAR(20), NOT NULL): Phone number of the participant.
- **Indexes**:
  - `PRIMARY KEY` (`ID`)
  - `UNIQUE INDEX` (`ID`)

### Inscricoes Table

Stores registrations of participants to events.

- **Table Name**: `Inscricoes`
- **Columns**:
  - `ID` (INT, NOT NULL, AUTO_INCREMENT): Primary key.
  - `EventoID` (INT, NOT NULL): Foreign key referencing `Eventos(ID)`.
  - `ParticipanteID` (INT, NOT NULL): Foreign key referencing `Participantes(ID)`.
  - `DataInscrição` (DATE, NOT NULL): Date of registration.
- **Indexes**:
  - `PRIMARY KEY` (`ID`, `EventoID`, `ParticipanteID`)
  - `UNIQUE INDEX` (`ID`)
  - `INDEX` (`EventoID`)
  - `INDEX` (`ParticipanteID`)
- **Foreign Keys**:
  - `FOREIGN KEY` (`EventoID`) REFERENCES `Eventos`(`ID`)
  - `FOREIGN KEY` (`ParticipanteID`) REFERENCES `Participantes`(`ID`)

### Palestrantes Table

Stores information about speakers.

- **Table Name**: `Palestrantes`
- **Columns**:
  - `ID` (INT, NOT NULL, AUTO_INCREMENT): Primary key.
  - `Nome` (VARCHAR(45), NOT NULL): Name of the speaker.
  - `Especialidade` (VARCHAR(45), NOT NULL): Specialty of the speaker.
- **Indexes**:
  - `PRIMARY KEY` (`ID`)
  - `UNIQUE INDEX` (`ID`)

### Palestras Table

Stores information about lectures.

- **Table Name**: `Palestras`
- **Columns**:
  - `ID` (INT, NOT NULL): Primary key.
  - `EventoID` (INT, NOT NULL): Foreign key referencing `Eventos(ID)`.
  - `PalestranteID` (INT, NOT NULL): Foreign key referencing `Palestrantes(ID)`.
  - `Título` (VARCHAR(45), NOT NULL): Title of the talk.
  - `Horário` (DATETIME, NOT NULL): Schedule of the talk.
- **Indexes**:
  - `PRIMARY KEY` (`ID`, `EventoID`, `PalestranteID`)
  - `INDEX` (`EventoID`)
  - `INDEX` (`PalestranteID`)
- **Foreign Keys**:
  - `FOREIGN KEY` (`EventoID`) REFERENCES `Eventos`(`ID`)
  - `FOREIGN KEY` (`PalestranteID`) REFERENCES `Palestrantes`(`ID`)

### PalestrasFuncionarios Table

Stores the relationship between lectures and employees.

- **Table Name**: `PalestrasFuncionarios`
- **Columns**:
  - `Palestras_ID` (INT, NOT NULL): Foreign key referencing `Palestras(ID)`.
  - `Funcionarios_ID` (INT, NOT NULL): Foreign key referencing `Funcionarios(ID)`.
- **Indexes**:
  - `PRIMARY KEY` (`Funcionarios_ID`)
  - `INDEX` (`Palestras_ID`)
- **Foreign Keys**:
  - `FOREIGN KEY` (`Funcionarios_ID`) REFERENCES `Funcionarios`(`ID`)
  - `FOREIGN KEY` (`Palestras_ID`) REFERENCES `Palestras`(`ID`)
