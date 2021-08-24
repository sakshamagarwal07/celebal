CREATE TABLE [dbo].[Client](
 [ID] [int] IDENTITY(1,1) NOT NULL,
 [ClientName] [varchar](150) NULL,
 [Country] [varchar](50) NULL,
 [Town] [varchar](50) NULL,
 [County] [varchar](50) NULL,
 [Address1] [varchar](50) NULL,
 [Address2] [varchar](50) NULL,
 [ClientType] [varchar](20) NULL,
 [ClientSize] [varchar](10) NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
 [ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET IDENTITY_INSERT [dbo].[Client] ON
INSERT [dbo].[Client] ([ID], [ClientName], [Country], [Town], [County], [Address1], [Address2], [ClientType], [ClientSize]) VALUES (1, N'John Smith', N'UK', N'Uttoxeter', N'Staffs', N'4, Grove Drive', NULL, N'Private', N'M')
INSERT [dbo].[Client] ([ID], [ClientName], [Country], [Town], [County], [Address1], [Address2], [ClientType], [ClientSize]) VALUES (2, N'Bauhaus Motors', N'UK', N'Oxford', N'Oxon', N'Suite 27', N'12-14 Turl Street', N'Business', N'S')
INSERT [dbo].[Client] ([ID], [ClientName], [Country], [Town], [County], [Address1], [Address2], [ClientType], [ClientSize]) VALUES (7, N'Honest Fred', N'UK', N'Stoke', N'Staffs', NULL, NULL, N'Business', N'S')
INSERT [dbo].[Client] ([ID], [ClientName], [Country], [Town], [County], [Address1], [Address2], [ClientType], [ClientSize]) VALUES (8, N'Fast Eddie', N'Wales', N'Cardiff', NULL, NULL, NULL, N'Business', N'L')
INSERT [dbo].[Client] ([ID], [ClientName], [Country], [Town], [County], [Address1], [Address2], [ClientType], [ClientSize]) VALUES (9, N'Slow Sid', N'France', N'Avignon', N'Vaucluse', N'2, Rue des Courtisans', NULL, N'Private', N'M')
SET IDENTITY_INSERT [dbo].[Client] OFF