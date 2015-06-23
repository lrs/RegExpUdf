USE [MASTER]

CREATE ASSEMBLY [regexp.RegExUdf] AUTHORIZATION [dbo]
--FROM 'C:\Windows\SysWOW64\RegExUdf.dll' WITH PERMISSION_SET = SAFE
FROM 'C:\Windows\System32\RegExUdf.dll' WITH PERMISSION_SET = SAFE
GO

CREATE FUNCTION REGEXP_LIKE (
    @source NVARCHAR(250)
    ,@pattern NVARCHAR(250)
    )
RETURNS BIT
AS
EXTERNAL NAME [regexp.RegExUdf].RegExUdf.regexLike
GO

CREATE FUNCTION REGEXP_INSTR (
    @source NVARCHAR(250)
    ,@pattern NVARCHAR(250)
    )
RETURNS BIGINT
AS
EXTERNAL NAME [regexp.RegExUdf].RegExUdf.regexInstr
GO

CREATE FUNCTION REGEXP_GET (
    @source NVARCHAR(250)
    ,@pattern NVARCHAR(250)
    )
RETURNS NVARCHAR(max)
AS
EXTERNAL NAME [regexp.RegExUdf].RegExUdf.regexGet
GO

CREATE FUNCTION REGEXP_REPLACE (
    @source NVARCHAR(max)
    ,@pattern NVARCHAR(max)
    ,@replace NVARCHAR(max)
    )
RETURNS NVARCHAR(max)
AS
EXTERNAL NAME [regexp.RegExUdf].RegExUdf.regexReplace
GO

CREATE FUNCTION REGEXP_SPLIT (
    @source NVARCHAR(max)
    ,@pattern NVARCHAR(max)
    )
RETURNS TABLE (split NVARCHAR(max) NULL)
AS
EXTERNAL NAME [regexp.RegExUdf].RegExUdf.regexSplit
GO


