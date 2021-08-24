CREATE TABLE [dbo].[Client_SCD1](
 [ClientID] [int] IDENTITY(1,1) NOT NULL,
 [BusinessKey] [int] NOT NULL,
 [ClientName] [varchar](150) NULL,
 [Country] [varchar](50) NULL,
 [Town] [varchar](50) NULL,
 [County] [varchar](50) NULL,
 [Address1] [varchar](50) NULL,
 [Address2] [varchar](50) NULL,
 [ClientType] [varchar](20) NULL,
 [ClientSize] [varchar](10) NULL
)

MERGE dbo.Client_SCD1 AS DST
USING CarSales.dbo.Client AS SRC
ON (SRC.ID = DST.BusinessKey)
WHEN NOT MATCHED THEN
INSERT (BusinessKey, ClientName, Country, Town, County, Address1, Address2, ClientType, ClientSize)
VALUES (SRC.ID, SRC.ClientName, SRC.Country, SRC.Town, SRC.County, Address1, Address2, ClientType, ClientSize)
WHEN MATCHED 
AND (
 ISNULL(DST.ClientName,'') <> ISNULL(SRC.ClientName,'') 
 OR ISNULL(DST.Country,'') <> ISNULL(SRC.Country,'') 
 OR ISNULL(DST.Town,'') <> ISNULL(SRC.Town,'')
 OR ISNULL(DST.Address1,'') <> ISNULL(SRC.Address1,'')
 OR ISNULL(DST.Address2,'') <> ISNULL(SRC.Address2,'')
 OR ISNULL(DST.ClientType,'') <> ISNULL(SRC.ClientType,'')
 OR ISNULL(DST.ClientSize,'') <> ISNULL(SRC.ClientSize,'')
 )
THEN UPDATE 
SET 
 DST.ClientName = SRC.ClientName 
 ,DST.Country = SRC.Country 
 ,DST.Town = SRC.Town
 ,DST.Address1 = SRC.Address1
 ,DST.Address2 = SRC.Address2
 ,DST.ClientType = SRC.ClientType
 ,DST.ClientSize = SRC.ClientSize
;