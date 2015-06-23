-- Because of performance issues, only use regexp functions if there's no other choice especially in where clauses.
SET STATISTICS TIME ON;

-- Using REGEXP_LIKE and REGEXP_INSTR.
SELECT code
    ,dbo.REGEXP_INSTR(code, '04|05')
FROM codes(NOLOCK)
WHERE dbo.regexp_like(code, '0909879(06|09)..') != 0
ORDER BY code;

-- Using LIKE and REGEXP_INSTR.
SELECT code
    ,dbo.REGEXP_INSTR(code, '04|05')
FROM codes(NOLOCK)
WHERE code LIKE '090987906%'
    OR code LIKE '090987909%'
ORDER BY code;

-- Using LIKE and PATINDEX.
SELECT code
    ,CASE 
        WHEN PATINDEX('%04%', code) = 0
            THEN PATINDEX('%05%', code)
        ELSE PATINDEX('%04%', code)
        END
FROM codes(NOLOCK)
WHERE code LIKE '090987906%'
    OR code LIKE '090987909%'
ORDER BY code;

SET STATISTICS TIME OFF;
-- messages
/*

(200 row(s) affected)

 SQL Server Execution Times: -- Using REGEXP_LIKE and REGEXP_INSTR
   CPU time = 3448 ms,  elapsed time = 3605 ms.

(200 row(s) affected)

 SQL Server Execution Times: -- Using LIKE and REGEXP_INSTR
   CPU time = 0 ms,  elapsed time = 1 ms.

(200 row(s) affected)

 SQL Server Execution Times: -- Using LIKE and PATINDEX
   CPU time = 0 ms,  elapsed time = 0 ms.

*/

-- Get all numbers in that begin either 090987906xx or 090987909xx and replace with 'X' where '9' occurs in them.
SELECT code
    ,dbo.REGEXP_REPLACE(code, '9', 'X')
FROM codes(NOLOCK)
WHERE dbo.regexp_like(code, '0909879(06|09)..') != 0
ORDER BY code;

-- Mask the last four digits with 'xxxx'.
SELECT code
    ,MASTER.dbo.REGEXP_REPLACE(code, '.{4}\Z', 'xxxx')
FROM codes(NOLOCK)
WHERE code LIKE '09098790%'


-- Misc.
WITH items (item)
AS (
    SELECT *
    FROM dbo.REGEXP_SPLIT('0-1,2-3,4;5,6-7;8,9', ',|-|;')
    )
SELECT *
FROM items;


DECLARE @p VARCHAR(50);

SET @p = 'seek';

SELECT @p
    ,dbo.REGEXP_GET(@p, '(\w)\1');


DECLARE @test VARCHAR(30);

SET @test = 'This island is beautiful';

SELECT dbo.regexp_get(@test, '\bis\b');


WITH Test (CellNo)
AS (
    SELECT '7700900309'
    
    UNION
    
    SELECT '07700900309'
    
    UNION
    
    SELECT '447700900309'
    
    UNION
    
    SELECT '00447700900309'
    
    UNION
    
    SELECT '+447700900309'
    
    UNION
    
    SELECT '+004407000900309'
    
    UNION
    
    SELECT '          +004407700900309         '
    
    UNION
    
    SELECT 'F00-barr37d&@#//+00 44 (@0) [+7 7 7 0] -#0&80-{$3[0]9} @(0)57-6{#456}'
    )
SELECT CellNo
    ,'44' + master.dbo.REGEXP_GET(master.dbo.REGEXP_REPLACE(CellNo, '[\s#&@$:;+\-(){}\[\]]', ''), '7[^0]\d{8}') regexp_get
    ,master.dbo.REGEXP_REPLACE(CellNo, '^[^7]*', '44') regexp_replace
    ,'44' + RIGHT(CellNo, LEN(CellNo) - CHARINDEX('7', CellNo) + 1) charindex
FROM Test;
