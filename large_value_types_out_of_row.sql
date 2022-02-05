/*
  File:     large_value_types_out_of_row.sql

  SQL Server Versions: 2008R2 onwards

  Written by Pedro Bonilla
  For more scripts and sample code, check out https://bonisql.wordpress.com/   
  
  This code and information are provided "as is" without warranty of 
  any kind, either expressed or implied, including but not limited 
  to the implied warranties of merchantability and/or fitness for a
  particular purpose.
*/

-- Clean buffers and cache
DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;
GO

-- You can download the AdventureWorks2014 database from
-- https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver15&tabs=ssms#download-backup-files
USE AdventureWorks2014;
GO

-- 1) Check the current IO statistics for below query, this table has the large_value_types_out_of_row set to OFF (default setting)
SET STATISTICS IO, TIME ON;
GO

SELECT FirstName
		, MiddleName
		, LastName
		, ModifiedDate
	FROM Person.Person;

SET STATISTICS IO, TIME OFF;
GO
-- OUTPUT SAMPLE:
--		(19972 rows affected)
--		Table 'Person'. Scan count 1, logical reads 3847, physical reads 3, read-ahead reads 3976, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--		(1 row affected)
--		SQL Server Execution Times:
--		CPU time = 47 ms,  elapsed time = 1055 ms.



-- 2) Change the setting of large_value_types_out_of_row
EXEC sp_tableoption 'Person.Person', 'large value types out of row', 1; -- switch on the feature
GO


-- 3) Update the existing data to same value for making the LOB columns to use the new setting of large_value_types_out_of_row
UPDATE Person.Person
	SET AdditionalContactInfo = AdditionalContactInfo
	WHERE AdditionalContactInfo IS NOT NULL;

UPDATE Person.Person
	SET Demographics = Demographics
	WHERE Demographics IS NOT NULL;


-- Rebuild all indexes for taking advantage of the 'large value types out of row' feature
ALTER INDEX ALL ON Person.Person REBUILD;

-- Clean buffers and cache
DBCC DROPCLEANBUFFERS;
DBCC FREEPROCCACHE;


-- 4) Check again the current IO statistics with the query run on 1)
SET STATISTICS IO, TIME ON;
GO

SELECT FirstName
		, MiddleName
		, LastName
		, ModifiedDate
		--, AdditionalContactInfo
	FROM Person.Person;

SET STATISTICS IO, TIME OFF;
GO
-- OUTPUT SAMPLE:
--		(19972 rows affected)
--		Table 'Person'. Scan count 1, logical reads 268, physical reads 0, read-ahead reads 220, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--		(1 row affected)
--		SQL Server Execution Times:
--		CPU time = 15 ms,  elapsed time = 241 ms.

-- NB: The amount of logical reads has dropped from 3847 to 268. This is more than 90%, which is huge!