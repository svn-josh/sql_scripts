USE YourDatabase;
GO

DECLARE @TableName NVARCHAR(255)
DECLARE @IndexName NVARCHAR(255)
DECLARE @SQL NVARCHAR(MAX)

DECLARE frag_cursor CURSOR FOR
SELECT 
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName
FROM 
    sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'SAMPLED') AS ps
JOIN 
    sys.indexes AS i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id
WHERE 
    ps.avg_fragmentation_in_percent > 30
    AND i.index_id > 0
    AND i.name IS NOT NULL;

OPEN frag_cursor
FETCH NEXT FROM frag_cursor INTO @TableName, @IndexName

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = N'ALTER INDEX [' + @IndexName + '] ON [' + @TableName + '] REBUILD;'
    PRINT 'REBUILDING: ' + @SQL
    EXEC sp_executesql @SQL
    FETCH NEXT FROM frag_cursor INTO @TableName, @IndexName
END

CLOSE frag_cursor
DEALLOCATE frag_cursor
