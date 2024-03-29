USE [master]
GO
/****** Object:  Database [pmrs]    Script Date: 9/16/2021 9:08:50 AM ******/
CREATE DATABASE [pmrs]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'pmrs', FILENAME = N'F:\Database\pmrs\pmrs.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'pmrs_log', FILENAME = N'F:\Database\pmrs\pmrs_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [pmrs] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [pmrs].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [pmrs] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [pmrs] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [pmrs] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [pmrs] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [pmrs] SET ARITHABORT OFF 
GO
ALTER DATABASE [pmrs] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [pmrs] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [pmrs] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [pmrs] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [pmrs] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [pmrs] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [pmrs] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [pmrs] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [pmrs] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [pmrs] SET  DISABLE_BROKER 
GO
ALTER DATABASE [pmrs] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [pmrs] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [pmrs] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [pmrs] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [pmrs] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [pmrs] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [pmrs] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [pmrs] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [pmrs] SET  MULTI_USER 
GO
ALTER DATABASE [pmrs] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [pmrs] SET DB_CHAINING OFF 
GO
ALTER DATABASE [pmrs] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [pmrs] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [pmrs] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [pmrs] SET QUERY_STORE = OFF
GO
USE [pmrs]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [pmrs]
GO
/****** Object:  User [sa]    Script Date: 9/16/2021 9:08:50 AM ******/
--CREATE USER [sa] FOR LOGIN [sa] WITH DEFAULT_SCHEMA=[dbo]
--GO
/****** Object:  User [D1BPNPMO10B\pm]    Script Date: 9/16/2021 9:08:50 AM ******/
--CREATE USER [D1BPNPMO10B\pm] FOR LOGIN [D1BPNPMO10B\pm] WITH DEFAULT_SCHEMA=[dbo]
--GO
/****** Object:  View [dbo].[vw_cpr]    Script Date: 9/16/2021 9:08:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_cpr]
AS
SELECT        c.ID, c.SECTOR, c.ESTATE, c.FEATNO, c.OLD_COMP_CODE, c.MAN_ID, c.WO_NUMBER, c.JC, c.OC, c.JCOC, c.CONT_CODE, c.START_DATE, c.WO_DATE, c.JCOC_DESC, c.FEATSIZE, c.UNITS, c.CONT_NAME, c.PAYMENT_NO, 
                         c.PAY_TYPE, c.REQ_DATE, c.REQ_SIZE, c.DELAY, c.INTDOC, c.INTDOC_DATE, c.DELAY_DAYS, c.GPS_DATE, c.GISMAP_DATE, c.GIS_UPDATE, c.QS_VALID, c.QS_DATE, c.QC_VALID, c.QC_DATE, c.QCREQ_DATE, 
                         c.QARESULT_RWA, c.QARESULT, c.NEED_RWA, c.NEED_QA, c.FEATID, c.ROTATION_HIST, c.MPR_COMPLETE_DATE, c.E_APPROVED_DATE, c.VERIFIED_BY_CAD_DATE, c.RECEIVED_BY_ACCOUNTING_DATE, 
                         c.PAID_BY_ACCOUNTING_DATE, w.SPV_CODE, w.SPV_NAME, w.WO_QUANTITY, w.WO_AREA, w.WO_VOL, w.WO_ACTUALSIZE, w.FOREMAN_ID, w.FOREMAN_NAME, w.CANCELLED, w.ACTIVE, w.RATE_CODE, w.WRFLAG
FROM            PM.dbo.tbl_cpr AS c LEFT OUTER JOIN
                         PM.dbo.tbl_woregister AS w ON c.WO_NUMBER = w.WO_NUMBER
WHERE        (c.JC IN ('06', '50', '51', '59', '09', '04')) AND (c.PAY_TYPE IN ('F')) AND (w.CANCELLED = 'F') OR
                         (c.JC = '07') AND (c.PAY_TYPE IN ('F')) AND (w.CANCELLED = 'F') AND (c.OC IN ('04', '05', '06', '07', '16', '69', '71', '74', '90'))
GO
/****** Object:  Table [dbo].[tbl_cprtrack]    Script Date: 9/16/2021 9:08:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cprtrack](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[WO_Number] [nvarchar](50) NULL,
	[PaymentNo] [int] NULL,
	[GPS_Upload_Date] [datetime] NULL,
	[GPS_Upload_By] [bigint] NULL,
	[TalySheet] [nvarchar](255) NULL,
	[ShapeFile] [nvarchar](255) NULL,
	[FileUkur] [nvarchar](255) NULL,
	[FileBAP] [nvarchar](255) NULL,
	[GPS_DocRemarks] [nvarchar](max) NULL,
	[UploadStatus] [int] NULL,
	[GPS_Verified_By] [bigint] NULL,
	[GPS_ReuploadRemarks] [nvarchar](max) NULL,
	[FinalMapDate] [datetime] NULL,
	[FinalMapFile] [nvarchar](255) NULL,
	[FinalMapStatus] [int] NULL,
	[FinalMapRemarks] [nvarchar](max) NULL,
	[MapUploadBy] [bigint] NULL,
	[MapVerifiedBy] [bigint] NULL,
	[MapReuploadRemarks] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK_tbl_cprtrack] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_cprtracking]    Script Date: 9/16/2021 9:08:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_cprtracking]
AS
SELECT        c.ID, c.SECTOR, c.ESTATE, c.FEATNO, c.OLD_COMP_CODE, c.MAN_ID, c.WO_NUMBER, c.JC, c.OC, c.JCOC, c.CONT_CODE, c.START_DATE, c.WO_DATE, c.JCOC_DESC, c.FEATSIZE, c.UNITS, c.CONT_NAME, c.PAYMENT_NO, 
                         c.PAY_TYPE, c.REQ_DATE, c.REQ_SIZE, c.DELAY, c.INTDOC, c.INTDOC_DATE, c.DELAY_DAYS, c.GPS_DATE, c.GISMAP_DATE, c.GIS_UPDATE, c.QS_VALID, c.QS_DATE, c.QC_VALID, c.QC_DATE, c.QCREQ_DATE, 
                         c.QARESULT_RWA, c.QARESULT, c.NEED_RWA, c.NEED_QA, c.FEATID, c.ROTATION_HIST, c.MPR_COMPLETE_DATE, c.E_APPROVED_DATE, c.VERIFIED_BY_CAD_DATE, c.RECEIVED_BY_ACCOUNTING_DATE, 
                         c.PAID_BY_ACCOUNTING_DATE, c.SPV_CODE, c.SPV_NAME, c.WO_QUANTITY, c.WO_AREA, c.WO_VOL, c.WO_ACTUALSIZE, c.FOREMAN_ID, c.FOREMAN_NAME, t.GPS_Upload_Date, t.GPS_Upload_By, t.TalySheet, 
                         t.ShapeFile, t.FileUkur, t.FileBAP, t.UploadStatus, t.GPS_Verified_By, t.GPS_ReuploadRemarks, t.FinalMapDate, t.FinalMapFile, t.FinalMapStatus, t.MapUploadBy, t.MapVerifiedBy, t.MapReuploadRemarks, c.CANCELLED, 
                         c.ACTIVE, c.RATE_CODE, c.WRFLAG, t.GPS_DocRemarks, t.FinalMapRemarks
FROM            dbo.vw_cpr AS c LEFT OUTER JOIN
                         dbo.tbl_cprtrack AS t ON c.WO_NUMBER = t.WO_Number AND c.PAYMENT_NO = t.PaymentNo
GO
/****** Object:  View [dbo].[vw_allcpr]    Script Date: 9/16/2021 9:08:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_allcpr]
AS
SELECT        c.ID, c.SECTOR, c.ESTATE, c.FEATNO, c.OLD_COMP_CODE, c.MAN_ID, c.WO_NUMBER, c.JC, c.OC, c.JCOC, c.CONT_CODE, c.START_DATE, c.WO_DATE, c.JCOC_DESC, c.FEATSIZE, c.UNITS, c.CONT_NAME, c.PAYMENT_NO, 
                         c.PAY_TYPE, c.REQ_DATE, c.REQ_SIZE, c.DELAY, c.INTDOC, c.INTDOC_DATE, c.DELAY_DAYS, c.GPS_DATE, c.GISMAP_DATE, c.GIS_UPDATE, c.QS_VALID, c.QS_DATE, c.QC_VALID, c.QC_DATE, c.QCREQ_DATE, 
                         c.QARESULT_RWA, c.QARESULT, c.NEED_RWA, c.NEED_QA, c.FEATID, c.ROTATION_HIST, c.MPR_COMPLETE_DATE, c.E_APPROVED_DATE, c.VERIFIED_BY_CAD_DATE, c.RECEIVED_BY_ACCOUNTING_DATE, 
                         c.PAID_BY_ACCOUNTING_DATE, w.SPV_CODE, w.SPV_NAME, w.WO_QUANTITY, w.WO_AREA, w.WO_VOL, w.WO_ACTUALSIZE, w.FOREMAN_ID, w.FOREMAN_NAME, w.CANCELLED, w.ACTIVE, w.RATE_CODE, w.WRFLAG
FROM            PM.dbo.tbl_cpr AS c LEFT OUTER JOIN
                         PM.dbo.tbl_woregister AS w ON c.WO_NUMBER = w.WO_NUMBER
WHERE        (c.PAY_TYPE IN ('F')) AND (w.CANCELLED = 'F')
GO
/****** Object:  Table [dbo].[users]    Script Date: 9/16/2021 9:08:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[fullname] [nvarchar](100) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[role_id] [bigint] NOT NULL,
	[bu] [nvarchar](255) NOT NULL,
	[sector] [nvarchar](255) NULL,
	[isAdmin] [bit] NOT NULL,
	[isActivated] [bit] NOT NULL,
	[lastActive] [datetime] NOT NULL,
	[lastRoute] [nvarchar](255) NULL,
	[guid] [uniqueidentifier] NULL,
	[domain] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK__users__3213E83FA5BB3FC0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_allcprtracking]    Script Date: 9/16/2021 9:08:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_allcprtracking]
AS
SELECT        c.ID, c.SECTOR, c.ESTATE, c.FEATNO, c.OLD_COMP_CODE, c.MAN_ID, c.WO_NUMBER, c.JC, c.OC, c.JCOC, c.CONT_CODE, c.START_DATE, c.WO_DATE, c.JCOC_DESC, c.FEATSIZE, c.UNITS, c.CONT_NAME, c.PAYMENT_NO, 
                         c.PAY_TYPE, c.REQ_DATE, c.REQ_SIZE, c.DELAY, c.INTDOC, c.INTDOC_DATE, c.DELAY_DAYS, c.GPS_DATE, c.GISMAP_DATE, c.GIS_UPDATE, c.QS_VALID, c.QS_DATE, c.QC_VALID, c.QC_DATE, c.QCREQ_DATE, 
                         c.QARESULT_RWA, c.QARESULT, c.NEED_RWA, c.NEED_QA, c.FEATID, c.ROTATION_HIST, c.MPR_COMPLETE_DATE, c.E_APPROVED_DATE, c.VERIFIED_BY_CAD_DATE, c.RECEIVED_BY_ACCOUNTING_DATE, 
                         c.PAID_BY_ACCOUNTING_DATE, c.SPV_CODE, c.SPV_NAME, c.WO_QUANTITY, c.WO_AREA, c.WO_VOL, c.WO_ACTUALSIZE, c.FOREMAN_ID, c.FOREMAN_NAME, t.GPS_Upload_Date, t.GPS_Upload_By, 
                         uG.fullname AS GPS_Upload_Name, t.TalySheet, t.ShapeFile, t.FileUkur, t.FileBAP, t.UploadStatus, t.GPS_Verified_By, uGV.fullname AS GPS_Verified_Name, t.GPS_ReuploadRemarks, t.FinalMapDate, t.FinalMapFile, 
                         t.FinalMapStatus, t.MapUploadBy, uF.fullname AS MapUploadName, t.MapVerifiedBy, uFV.fullname AS MapVerifiedName, t.MapReuploadRemarks, c.CANCELLED, c.ACTIVE, c.RATE_CODE, c.WRFLAG, t.GPS_DocRemarks, 
                         t.FinalMapRemarks
FROM            dbo.vw_allcpr AS c LEFT OUTER JOIN
                         dbo.tbl_cprtrack AS t ON c.WO_NUMBER = t.WO_Number AND c.PAYMENT_NO = t.PaymentNo LEFT OUTER JOIN
                         dbo.users AS uG ON t.GPS_Upload_By = uG.id LEFT OUTER JOIN
                         dbo.users AS uGV ON t.GPS_Verified_By = uGV.id LEFT OUTER JOIN
                         dbo.users AS uF ON t.MapUploadBy = uF.id LEFT OUTER JOIN
                         dbo.users AS uFV ON t.MapVerifiedBy = uFV.id
GO
/****** Object:  Table [dbo].[accessroles]    Script Date: 9/16/2021 9:08:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accessroles](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[module_id] [bigint] NOT NULL,
	[role_id] [bigint] NOT NULL,
	[AllowView] [bit] NOT NULL,
	[AllowAdd] [bit] NOT NULL,
	[AllowEdit] [bit] NOT NULL,
	[AllowDelete] [bit] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[appmodules]    Script Date: 9/16/2021 9:08:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[appmodules](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[ModuleName] [nvarchar](255) NOT NULL,
	[MenuTitle] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](255) NULL,
	[Path] [nvarchar](255) NULL,
	[isActive] [bit] NOT NULL,
	[parent_id] [bigint] NOT NULL,
	[label] [nvarchar](50) NULL,
	[badge] [nvarchar](50) NULL,
	[icon] [nvarchar](50) NULL,
	[MenuOrder] [int] NULL,
	[router] [nvarchar](50) NULL,
	[component] [nvarchar](50) NULL,
	[isNeedCheckAccess] [bit] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK__appmodul__3213E83F4349A14E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[audits]    Script Date: 9/16/2021 9:08:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[audits](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_type] [nvarchar](255) NULL,
	[user_id] [bigint] NULL,
	[event] [nvarchar](255) NOT NULL,
	[auditable_type] [nvarchar](255) NOT NULL,
	[auditable_id] [bigint] NOT NULL,
	[old_values] [nvarchar](max) NULL,
	[new_values] [nvarchar](max) NULL,
	[url] [nvarchar](max) NULL,
	[ip_address] [nvarchar](45) NULL,
	[user_agent] [nvarchar](1023) NULL,
	[tags] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[errorlogs]    Script Date: 9/16/2021 9:08:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[errorlogs](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](255) NULL,
	[ErrorType] [nvarchar](255) NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mailrecipients]    Script Date: 9/16/2021 9:08:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mailrecipients](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[module] [nvarchar](255) NOT NULL,
	[company_list] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[isActive] [bit] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[migrations]    Script Date: 9/16/2021 9:08:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[migrations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[migration] [nvarchar](255) NOT NULL,
	[batch] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 9/16/2021 9:08:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](255) NOT NULL,
	[RoleDescription] [nvarchar](255) NULL,
	[isActive] [bit] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [audits_auditable_type_auditable_id_index]    Script Date: 9/16/2021 9:08:52 AM ******/
CREATE NONCLUSTERED INDEX [audits_auditable_type_auditable_id_index] ON [dbo].[audits]
(
	[auditable_type] ASC,
	[auditable_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [audits_user_id_user_type_index]    Script Date: 9/16/2021 9:08:52 AM ******/
CREATE NONCLUSTERED INDEX [audits_user_id_user_type_index] ON [dbo].[audits]
(
	[user_id] ASC,
	[user_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [users_username_unique]    Script Date: 9/16/2021 9:08:52 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [users_username_unique] ON [dbo].[users]
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[accessroles] ADD  DEFAULT ('0') FOR [AllowView]
GO
ALTER TABLE [dbo].[accessroles] ADD  DEFAULT ('0') FOR [AllowAdd]
GO
ALTER TABLE [dbo].[accessroles] ADD  DEFAULT ('0') FOR [AllowEdit]
GO
ALTER TABLE [dbo].[accessroles] ADD  DEFAULT ('0') FOR [AllowDelete]
GO
ALTER TABLE [dbo].[appmodules] ADD  CONSTRAINT [DF__appmodule__isAct__4222D4EF]  DEFAULT ('1') FOR [isActive]
GO
ALTER TABLE [dbo].[appmodules] ADD  CONSTRAINT [DF_appmodules_parent_id]  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dbo].[appmodules] ADD  CONSTRAINT [DF_appmodules_isNeedCheckAccess]  DEFAULT ('0') FOR [isNeedCheckAccess]
GO
ALTER TABLE [dbo].[mailrecipients] ADD  DEFAULT ('1') FOR [isActive]
GO
ALTER TABLE [dbo].[roles] ADD  DEFAULT ('1') FOR [isActive]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_role_id]  DEFAULT ((1)) FOR [role_id]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_bu]  DEFAULT ('HO') FOR [bu]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF__users__isAdmin__3C69FB99]  DEFAULT ('0') FOR [isAdmin]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF__users__isActivat__3D5E1FD2]  DEFAULT ('0') FOR [isActivated]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF__users__lastActiv__3F466844]  DEFAULT (getdate()) FOR [lastActive]
GO
ALTER TABLE [dbo].[accessroles]  WITH CHECK ADD  CONSTRAINT [accessroles_module_id_foreign] FOREIGN KEY([module_id])
REFERENCES [dbo].[appmodules] ([id])
GO
ALTER TABLE [dbo].[accessroles] CHECK CONSTRAINT [accessroles_module_id_foreign]
GO
ALTER TABLE [dbo].[accessroles]  WITH CHECK ADD  CONSTRAINT [accessroles_role_id_foreign] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[accessroles] CHECK CONSTRAINT [accessroles_role_id_foreign]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [users_role_id_foreign] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [users_role_id_foreign]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 304
               Right = 313
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "w"
            Begin Extent = 
               Top = 6
               Left = 351
               Bottom = 329
               Right = 535
            End
            DisplayFlags = 280
            TopColumn = 27
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_allcpr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_allcpr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 324
               Right = 313
            End
            DisplayFlags = 280
            TopColumn = 41
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 351
               Bottom = 342
               Right = 561
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "uG"
            Begin Extent = 
               Top = 42
               Left = 686
               Bottom = 172
               Right = 856
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "uGV"
            Begin Extent = 
               Top = 174
               Left = 688
               Bottom = 304
               Right = 858
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "uF"
            Begin Extent = 
               Top = 6
               Left = 894
               Bottom = 136
               Right = 1064
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "uFV"
            Begin Extent = 
               Top = 6
               Left = 1102
               Bottom = 136
               Right = 1272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_allcprtracking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_allcprtracking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_allcprtracking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 321
               Right = 313
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "w"
            Begin Extent = 
               Top = 6
               Left = 351
               Bottom = 299
               Right = 535
            End
            DisplayFlags = 280
            TopColumn = 29
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_cpr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_cpr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 335
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 41
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 351
               Bottom = 331
               Right = 536
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_cprtracking'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_cprtracking'
GO
USE [master]
GO
ALTER DATABASE [pmrs] SET  READ_WRITE 
GO
