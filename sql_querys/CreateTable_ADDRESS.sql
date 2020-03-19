USE babblefish
GO

/****** Object:  Table [sysdba].[ADDRESS]    Script Date: 3/6/2020 11:36:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [ADDRESS](
	[ADDRESSID] [char](12) NOT NULL,
	[ENTITYID] [char](12) NOT NULL,
	[TYPE] [varchar](64) NULL,
	[DESCRIPTION] [varchar](64) NULL,
	[ADDRESS1] [varchar](64) NULL,
	[ADDRESS2] [varchar](64) NULL,
	[CITY] [varchar](64) NULL,
	[STATE] [varchar](64) NULL,
	[POSTALCODE] [varchar](24) NULL,
	[COUNTY] [varchar](32) NULL,
	[COUNTRY] [varchar](64) NULL,
	[ISPRIMARY] [char](1) NULL,
	[ISMAILING] [char](1) NULL,
	[SALUTATION] [varchar](64) NULL,
	[CREATEDATE] [datetime] NULL,
	[CREATEUSER] [char](12) NULL,
	[MODIFYDATE] [datetime] NULL,
	[MODIFYUSER] [char](12) NULL,
	[ROUTING] [varchar](64) NULL,
	[ADDRESS3] [varchar](64) NULL,
	[ADDRESS4] [varchar](64) NULL,
	[TIMEZONE] [varchar](64) NULL,
	[ERPNAME] [varchar](64) NULL,
	[TICK] [int] NULL,
	[APPID] [char](12) NULL,
	[GLOBALSYNCID] [varchar](36) NULL,
	[ADDRESSTYPE] [varchar](32) NULL,
	[PRIMARYADDRESS] [varchar](1) NULL,
	[CREATESOURCE] [varchar](64) NULL,
	[ADDRESS6] [varchar](64) NULL,
	[ENTITYTYPE] [varchar](128) NULL,
	[COUNTRYCODE] [varchar](3) NULL,
	[ADDRESS5] [varchar](64) NULL,
	[GEOCODEPROVIDER] [varchar](64) NULL,
	[GEOCODELONGITUDE] [float] NULL,
	[GEOCODELATITUDE] [float] NULL,
	[GEOCODEFAILED] [char](1) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

