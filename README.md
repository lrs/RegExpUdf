#Regular Expressions for SQL Server 
##An SQLCLR assembly to provide regexp functions similar to Oracle

Provides the following functions:

*    REGEXP_LIKE(@source NVARCHAR(250), @pattern NVARCHAR(250)) returns BIT
*    REGEXP_INSTR(@source NVARCHAR(250), @pattern NVARCHAR(250)) returns BIGINT
*    REGEXP_GET(@source NVARCHAR(250), @pattern NVARCHAR(250)) returns NVARCHAR(MAX)
*    REGEXP_REPLACE(@source NVARCHAR(MAX), @pattern NVARCHAR(MAX), @replace NVARCHAR(MAX)) returns NVARCHAR(MAX)
*    REGEXP_SPLIT (@source NVARCHAR(max), @pattern NVARCHAR(max)) RETURNS TABLE (split NVARCHAR(max) NULL)