# Regular Expressions for SQL Server

## SQLCLR assembly to provide regexp functions similar to Oracle

Provides the following functions:

- REGEXP_LIKE(@source NVARCHAR(250), @pattern NVARCHAR(250)) RETURNS BIT
- REGEXP_INSTR(@source NVARCHAR(250), @pattern NVARCHAR(250)) RETURNS BIGINT
- REGEXP_GET(@source NVARCHAR(250), @pattern NVARCHAR(250)) RETURNS NVARCHAR(MAX)
- REGEXP_REPLACE(@source NVARCHAR(MAX), @pattern NVARCHAR(MAX), @replace NVARCHAR(MAX)) RETURNS NVARCHAR(MAX)
- REGEXP_SPLIT (@source NVARCHAR(MAX), @pattern NVARCHAR(MAX)) RETURNS TABLE (split NVARCHAR(max) NULL)

See CreateFunctions.sql and Examples.sql for installation and usage.
