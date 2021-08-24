CREATE TABLE [dbo].[Client_SCD2](
 [ClientID] [int] IDENTITY(1,1) NOT NULL,
 [BusinessKey] [int] NOT NULL,
 [ClientName] [varchar](150) NULL,
 [Country] [varchar](50) NULL,
 [Town] [varchar](50) NULL,
 [County] [varchar](50) NULL,
 [Address1] [varchar](50) NULL,
 [Address2] [varchar](50) NULL,
 [ClientType] [varchar](20) NULL,
 [ClientSize] [varchar](10) NULL,
 ValidFrom INT NULL,
 ValidTo INT NULL,
 IsCurrent BIT NULL
) ON [PRIMARY]

-- Define the dates used in validity - assume whole 24 hour cycles
DECLARE @Yesterday INT = (YEAR(DATEADD(dd,-1,GETDATE())) * 10000) + (MONTH(DATEADD(dd,-1,GETDATE())) * 100) + DAY(DATEADD(dd,-1,GETDATE()))
DECLARE @Today INT = (YEAR(GETDATE()) * 10000) + (MONTH(GETDATE()) * 100) + DAY(GETDATE())
-- Outer insert - the updated records are added to the SCD2 table
INSERT INTO dbo.Client_SCD2 (BusinessKey, ClientName, Country, Town, Address1, Address2, ClientType, ClientSize, ValidFrom, IsCurrent)
SELECT ID, ClientName, Country, Town, Address1, Address2, ClientType, ClientSize, @Today, 1
FROM
(
-- Merge statement
MERGE INTO dbo.Client_SCD2 AS DST
USING CarSales.dbo.Client AS SRC
ON (SRC.ID = DST.BusinessKey)
-- New records inserted
WHEN NOT MATCHED THEN 
INSERT (BusinessKey, ClientName, Country, Town, County, Address1, Address2, ClientType, ClientSize, ValidFrom, IsCurrent)
VALUES (SRC.ID, SRC.ClientName, SRC.Country, SRC.Town, SRC.County, Address1, Address2, ClientType, ClientSize, @Today, 1)
-- Existing records updated if data changes
WHEN MATCHED 
AND IsCurrent = 1
AND (
 ISNULL(DST.ClientName,'') <> ISNULL(SRC.ClientName,'') 
 OR ISNULL(DST.Country,'') <> ISNULL(SRC.Country,'') 
 OR ISNULL(DST.Town,'') <> ISNULL(SRC.Town,'')
 OR ISNULL(DST.Address1,'') <> ISNULL(SRC.Address1,'')
 OR ISNULL(DST.Address2,'') <> ISNULL(SRC.Address2,'')
 OR ISNULL(DST.ClientType,'') <> ISNULL(SRC.ClientType,'')
 OR ISNULL(DST.ClientSize,'') <> ISNULL(SRC.ClientSize,'')
 )
-- Update statement for a changed dimension record, to flag as no longer active
THEN UPDATE 
SET DST.IsCurrent = 0, DST.ValidTo = @Yesterday
OUTPUT SRC.ID, SRC.ClientName, SRC.Country, SRC.Town, SRC.Address1, SRC.Address2, SRC.ClientType, SRC.ClientSize, $Action AS MergeAction
) AS MRG
WHERE MRG.MergeAction = 'UPDATE'
;