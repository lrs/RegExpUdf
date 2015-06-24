-- May need to enable clr integration on the instance. Run RECONFIGURE after to install changes.
EXEC sp_configure 'clr enabled' , '1';
GO
RECONFIGURE;
GO

-- The database that the assembly is going to be installed in.
USE [MASTER]

-- Set database to trustworthy for I/O methods if needed.
ALTER DATABASE MASTER SET TRUSTWORTHY ON;
GO

-- Install the assembly.
CREATE ASSEMBLY [sqlclr.RegExUdf] AUTHORIZATION [dbo]
FROM 'C:\Windows\System32\RegExUdf.dll' WITH PERMISSION_SET = SAFE
GO

-- Create functions out of the methods in the assembly.
CREATE FUNCTION REGEXP_LIKE (
    @source NVARCHAR(250)
    ,@pattern NVARCHAR(250)
    )
RETURNS BIT
AS
EXTERNAL NAME [sqlclr.RegExUdf].RegExUdf.regexLike
GO

CREATE FUNCTION REGEXP_INSTR (
    @source NVARCHAR(250)
    ,@pattern NVARCHAR(250)
    )
RETURNS BIGINT
AS
EXTERNAL NAME [sqlclr.RegExUdf].RegExUdf.regexInstr
GO

CREATE FUNCTION REGEXP_GET (
    @source NVARCHAR(250)
    ,@pattern NVARCHAR(250)
    )
RETURNS NVARCHAR(max)
AS
EXTERNAL NAME [sqlclr.RegExUdf].RegExUdf.regexGet
GO

CREATE FUNCTION REGEXP_REPLACE (
    @source NVARCHAR(max)
    ,@pattern NVARCHAR(max)
    ,@replace NVARCHAR(max)
    )
RETURNS NVARCHAR(max)
AS
EXTERNAL NAME [sqlclr.RegExUdf].RegExUdf.regexReplace
GO

CREATE FUNCTION REGEXP_SPLIT (
    @source NVARCHAR(max)
    ,@pattern NVARCHAR(max)
    )
RETURNS TABLE (split NVARCHAR(max) NULL)
AS
EXTERNAL NAME [sqlclr.RegExUdf].RegExUdf.regexSplit
GO


