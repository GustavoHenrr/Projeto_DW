/*
=============================================================
Criar Banco de Dados e Schemas
=============================================================
Objetivo do Script:
    Este script cria um novo banco de dados chamado 'DataWarehouse' após verificar se ele já existe.
    Se o banco de dados existir, ele é removido e recriado. Além disso, o script configura três schemas
    dentro do banco de dados: 'bronze', 'silver' e 'gold'.

AVISO:
    Executar este script irá remover (DROP) completamente o banco de dados 'DataWarehouse', caso ele exista.
    Todos os dados no banco de dados serão excluídos permanentemente. Prossiga com cautela
    e garanta que você tenha backups adequados antes de executar este script.
*/

USE master;
GO

-- Remove e recria o banco de dados 'DataWarehouse'
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Cria o banco de dados 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Cria os Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
