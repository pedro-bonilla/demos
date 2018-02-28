/*
  File:     LOB_cols_out_of_the_row.sql

  SQL Server Versions: 2008R2 onwards

  Written by Pedro Bonilla
  For more scripts and sample code, check out https://bonisql.wordpress.com/   
  
  This code and information are provided "as is" without warranty of 
  any kind, either expressed or implied, including but not limited 
  to the implied warranties of merchantability and/or fitness for a
  particular purpose.
*/

USE AdventureWorks2014; -- Use your DB name here :)
GO

-- This query return tables with columns that are not using the LARGE_VALUE_TYPES_OUT_OF_ROW feature
SELECT s.[name] AS schemaName
		, t.[name] AS tableName
		, bigCols.colName
		, bigCols.typeName
		, bigCols.max_length 
		, t.large_value_types_out_of_row
	FROM sys.tables AS t
		INNER JOIN sys.schemas AS s ON t.[schema_id] = s.[schema_id]
		INNER JOIN (SELECT [object_id], col.[name] AS colName, ty.[name] AS typeName, col.max_length
							FROM sys.columns AS col
								INNER JOIN sys.types AS ty ON col.system_type_id = ty.system_type_id 
									AND col.user_type_id = ty.user_type_id
							WHERE col.max_length >= 8000 
								OR col.max_length < 1
						) AS bigCols ON t.[object_id] = bigCols.[object_id]
	ORDER BY schemaName
		, tableName
		, colName;