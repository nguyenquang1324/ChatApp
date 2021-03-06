USE [master]
GO
/****** Object:  Database [VChat]    Script Date: 05/23/2022 2:25:09 PM ******/
CREATE DATABASE [VChat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VChat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\VChat.mdf' , SIZE = 22528KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'VChat_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\VChat_log.ldf' , SIZE = 20096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [VChat] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VChat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VChat] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VChat] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VChat] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VChat] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VChat] SET ARITHABORT OFF 
GO
ALTER DATABASE [VChat] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VChat] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VChat] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VChat] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VChat] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VChat] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VChat] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VChat] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VChat] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VChat] SET  DISABLE_BROKER 
GO
ALTER DATABASE [VChat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VChat] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VChat] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VChat] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VChat] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VChat] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [VChat] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VChat] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [VChat] SET  MULTI_USER 
GO
ALTER DATABASE [VChat] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VChat] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VChat] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VChat] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [VChat] SET DELAYED_DURABILITY = DISABLED 
GO
USE [VChat]
GO
/****** Object:  Table [dbo].[Call]    Script Date: 05/23/2022 2:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Call](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GroupCallCode] [varchar](32) NOT NULL,
	[UserCode] [varchar](32) NOT NULL,
	[Url] [nvarchar](500) NOT NULL,
	[Status] [varchar](32) NOT NULL,
	[Created] [datetime] NOT NULL,
 CONSTRAINT [PK_Call] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 05/23/2022 2:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserCode] [varchar](32) NOT NULL,
	[ContactCode] [varchar](32) NOT NULL,
	[Created] [datetime] NOT NULL,
	[Approved] [bit] NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Group]    Script Date: 05/23/2022 2:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Group](
	[Code] [varchar](32) NOT NULL,
	[Type] [varchar](32) NOT NULL,
	[Avatar] [varchar](max) NULL,
	[Name] [nvarchar](250) NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [varchar](32) NOT NULL,
	[LastActive] [datetime] NOT NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GroupCall]    Script Date: 05/23/2022 2:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GroupCall](
	[Code] [varchar](32) NOT NULL,
	[Type] [varchar](32) NOT NULL,
	[Avatar] [varchar](max) NULL,
	[Name] [nvarchar](250) NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [varchar](32) NOT NULL,
	[LastActive] [datetime] NOT NULL,
 CONSTRAINT [PK_GroupCall] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GroupUser]    Script Date: 05/23/2022 2:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GroupUser](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[GroupCode] [varchar](32) NOT NULL,
	[UserCode] [varchar](32) NOT NULL,
 CONSTRAINT [PK_GroupUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Message]    Script Date: 05/23/2022 2:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Message](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](10) NOT NULL,
	[GroupCode] [varchar](32) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Path] [nvarchar](255) NULL,
	[Created] [datetime] NOT NULL,
	[CreatedBy] [varchar](32) NOT NULL,
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 05/23/2022 2:25:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Code] [varchar](32) NOT NULL,
	[UserName] [varchar](32) NULL,
	[Password] [varchar](124) NULL,
	[FullName] [nvarchar](50) NULL,
	[Dob] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Address] [nvarchar](255) NULL,
	[Avatar] [varchar](max) NULL,
	[Gender] [nvarchar](10) NULL,
	[LastLogin] [datetime] NULL,
	[CurrentSession] [varchar](500) NULL,
	[OTP] [varchar](6) NULL,
	[Active] [bit] NOT NULL,
	[Token] [varchar](32) NULL,
	[ExpiredTokenTime] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Call] ON 

INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (55, N'60d491428e6748d4b4f0390b72a41c5a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/PnmNKVWMpvIWxc9bMEhs', N'OUT_GOING', CAST(N'2021-07-26 23:29:22.713' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (56, N'60d491428e6748d4b4f0390b72a41c5a', N'8053110542b44e04ba59b4dbbc7b830c', N'https://vchatdnx.daily.co/PnmNKVWMpvIWxc9bMEhs', N'MISSED', CAST(N'2021-07-26 23:29:22.713' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (57, N'60d491428e6748d4b4f0390b72a41c5a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/0GpyBcgXRhRZvcpcR3cm', N'OUT_GOING', CAST(N'2021-07-26 23:30:52.207' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (58, N'60d491428e6748d4b4f0390b72a41c5a', N'8053110542b44e04ba59b4dbbc7b830c', N'https://vchatdnx.daily.co/0GpyBcgXRhRZvcpcR3cm', N'MISSED', CAST(N'2021-07-26 23:30:52.207' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (59, N'f0a227f3c28b49c89310de6a8df38a1a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/BxSpP9UmftD8L2qykMBH', N'OUT_GOING', CAST(N'2021-07-26 23:35:43.140' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (60, N'f0a227f3c28b49c89310de6a8df38a1a', N'18d2e99f599e4a70862cd299e8a96676', N'https://vchatdnx.daily.co/BxSpP9UmftD8L2qykMBH', N'MISSED', CAST(N'2021-07-26 23:35:43.140' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (61, N'960f365d2c7742b681ee2e6d8aea6ad1', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/XJzshOs67SSOXDnX6yUj', N'OUT_GOING', CAST(N'2021-07-26 23:36:06.837' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (62, N'960f365d2c7742b681ee2e6d8aea6ad1', N'1df7822da40b4938a860f318aa84865a', N'https://vchatdnx.daily.co/XJzshOs67SSOXDnX6yUj', N'MISSED', CAST(N'2021-07-26 23:36:06.837' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (63, N'60d491428e6748d4b4f0390b72a41c5a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/h7oFSOWgsOQCafQgE8LL', N'OUT_GOING', CAST(N'2021-07-27 10:28:55.797' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (64, N'60d491428e6748d4b4f0390b72a41c5a', N'8053110542b44e04ba59b4dbbc7b830c', N'https://vchatdnx.daily.co/h7oFSOWgsOQCafQgE8LL', N'MISSED', CAST(N'2021-07-27 10:28:55.797' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (65, N'60d491428e6748d4b4f0390b72a41c5a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/Nkq3PfIzlv56IvOqdaLF', N'OUT_GOING', CAST(N'2021-07-27 10:29:21.783' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (66, N'60d491428e6748d4b4f0390b72a41c5a', N'8053110542b44e04ba59b4dbbc7b830c', N'https://vchatdnx.daily.co/Nkq3PfIzlv56IvOqdaLF', N'MISSED', CAST(N'2021-07-27 10:29:21.783' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (67, N'60d491428e6748d4b4f0390b72a41c5a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/eHBLW0JxKm0bWXol4ne3', N'OUT_GOING', CAST(N'2021-07-27 10:33:21.217' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (68, N'60d491428e6748d4b4f0390b72a41c5a', N'8053110542b44e04ba59b4dbbc7b830c', N'https://vchatdnx.daily.co/eHBLW0JxKm0bWXol4ne3', N'MISSED', CAST(N'2021-07-27 10:33:21.217' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (69, N'60d491428e6748d4b4f0390b72a41c5a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/FzwMMebBugO7lG6HX383', N'OUT_GOING', CAST(N'2021-07-27 10:36:51.043' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (70, N'60d491428e6748d4b4f0390b72a41c5a', N'8053110542b44e04ba59b4dbbc7b830c', N'https://vchatdnx.daily.co/FzwMMebBugO7lG6HX383', N'MISSED', CAST(N'2021-07-27 10:36:51.043' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (71, N'60d491428e6748d4b4f0390b72a41c5a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/6t5IrqjyBjo5DieheCfU', N'OUT_GOING', CAST(N'2021-07-27 10:38:38.650' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (72, N'60d491428e6748d4b4f0390b72a41c5a', N'8053110542b44e04ba59b4dbbc7b830c', N'https://vchatdnx.daily.co/6t5IrqjyBjo5DieheCfU', N'MISSED', CAST(N'2021-07-27 10:38:38.650' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (73, N'60d491428e6748d4b4f0390b72a41c5a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/M8jI6dd547sPffCZ0Rbx', N'OUT_GOING', CAST(N'2021-07-27 11:25:42.657' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (74, N'60d491428e6748d4b4f0390b72a41c5a', N'8053110542b44e04ba59b4dbbc7b830c', N'https://vchatdnx.daily.co/M8jI6dd547sPffCZ0Rbx', N'MISSED', CAST(N'2021-07-27 11:25:42.657' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (75, N'f0a227f3c28b49c89310de6a8df38a1a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/w4E6jTOBNqHgdxgDuS9s', N'OUT_GOING', CAST(N'2021-07-27 11:33:28.277' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (76, N'f0a227f3c28b49c89310de6a8df38a1a', N'18d2e99f599e4a70862cd299e8a96676', N'https://vchatdnx.daily.co/w4E6jTOBNqHgdxgDuS9s', N'MISSED', CAST(N'2021-07-27 11:33:28.277' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (77, N'60d491428e6748d4b4f0390b72a41c5a', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/kthFNyal5V7KzQhfDyrI', N'OUT_GOING', CAST(N'2021-07-27 11:38:18.260' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (78, N'60d491428e6748d4b4f0390b72a41c5a', N'8053110542b44e04ba59b4dbbc7b830c', N'https://vchatdnx.daily.co/kthFNyal5V7KzQhfDyrI', N'MISSED', CAST(N'2021-07-27 11:38:18.260' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (79, N'c4b1864c4e4844629bfd4b782f984a3d', N'39c3575543284110a80372b59234d6f7', N'https://vchatdnx.daily.co/0vbMNtRdKiJwcehzKglx', N'OUT_GOING', CAST(N'2021-08-10 00:40:12.247' AS DateTime))
INSERT [dbo].[Call] ([Id], [GroupCallCode], [UserCode], [Url], [Status], [Created]) VALUES (80, N'c4b1864c4e4844629bfd4b782f984a3d', N'3e48f1ce9f015cc59bd7bf0605681f28', N'https://vchatdnx.daily.co/0vbMNtRdKiJwcehzKglx', N'MISSED', CAST(N'2021-08-10 00:40:12.247' AS DateTime))
SET IDENTITY_INSERT [dbo].[Call] OFF
SET IDENTITY_INSERT [dbo].[Contact] ON 

INSERT [dbo].[Contact] ([Id], [UserCode], [ContactCode], [Created], [Approved]) VALUES (22, N'3e48f1ce9f015cc59bd7bf0605681f28', N'2b388cc0b9b6405c99c6b30b50c9d8ec', CAST(N'2021-07-26 22:39:42.567' AS DateTime), 0)
INSERT [dbo].[Contact] ([Id], [UserCode], [ContactCode], [Created], [Approved]) VALUES (23, N'3e48f1ce9f015cc59bd7bf0605681f28', N'18d2e99f599e4a70862cd299e8a96676', CAST(N'2021-07-26 22:39:51.483' AS DateTime), 0)
INSERT [dbo].[Contact] ([Id], [UserCode], [ContactCode], [Created], [Approved]) VALUES (24, N'3e48f1ce9f015cc59bd7bf0605681f28', N'2699d7dc23434f81b6501af3175e6bbd', CAST(N'2021-07-26 22:39:54.810' AS DateTime), 0)
INSERT [dbo].[Contact] ([Id], [UserCode], [ContactCode], [Created], [Approved]) VALUES (25, N'3e48f1ce9f015cc59bd7bf0605681f28', N'9074aca1de2d42c598fccc0152082d76', CAST(N'2021-07-26 22:39:58.337' AS DateTime), 0)
INSERT [dbo].[Contact] ([Id], [UserCode], [ContactCode], [Created], [Approved]) VALUES (26, N'3e48f1ce9f015cc59bd7bf0605681f28', N'8607cf69ac024bfcaca7364883ef5640', CAST(N'2021-07-26 22:40:01.407' AS DateTime), 0)
INSERT [dbo].[Contact] ([Id], [UserCode], [ContactCode], [Created], [Approved]) VALUES (27, N'3e48f1ce9f015cc59bd7bf0605681f28', N'1df7822da40b4938a860f318aa84865a', CAST(N'2021-07-26 22:40:05.000' AS DateTime), 0)
INSERT [dbo].[Contact] ([Id], [UserCode], [ContactCode], [Created], [Approved]) VALUES (30, N'39c3575543284110a80372b59234d6f7', N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2021-08-10 00:16:48.430' AS DateTime), 0)
INSERT [dbo].[Contact] ([Id], [UserCode], [ContactCode], [Created], [Approved]) VALUES (36, N'e5f371bb528549609bd2c2fc928cfce5', N'2b388cc0b9b6405c99c6b30b50c9d8ec', CAST(N'2022-05-07 00:54:31.890' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Contact] OFF
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'33c47cc785744d36a517d44c57d8b561', N'single', NULL, N'Ngô Xuân Dương', CAST(N'2021-08-10 00:17:03.477' AS DateTime), N'39c3575543284110a80372b59234d6f7', CAST(N'2022-05-07 01:23:10.003' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'366a70849f0a49418310ebf4270d9f85', N'multi', N'Resource/Avatar/842b975e7bde44558125b11190e3f24e', N'As Fast As Lightning', CAST(N'2021-07-26 22:49:40.117' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2021-07-26 23:04:47.433' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'3fea5e8164b04bc1a3891bd7137d06d8', N'multi', N'Resource/Avatar/260a84a298e8460e8cd58e9018fd68b1', N'Gia đình kiểu mẫu', CAST(N'2021-07-26 22:48:06.460' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2022-05-07 01:31:08.413' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'90d94199caf14ae28378ec00b7f90b91', N'multi', N'Resource/Avatar/69997b00b5364c259d94c31f79a219f3', N'Nhóm yêu cái đẹp', CAST(N'2021-07-26 22:49:07.197' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2022-05-07 01:33:30.297' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'934b99e5d1cf4d3d9576299e479a1bf1', N'single', NULL, N'Ngô Minh Trí', CAST(N'2021-07-26 23:06:25.957' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2022-05-07 01:21:55.927' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'a90d114f23d7456782370765af767e8f', N'multi', N'Resource/Avatar/0ce7a1060217418cb5673b754b657d7c', N'Chuyện mới lớn', CAST(N'2021-07-26 22:50:28.510' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2021-07-26 23:04:26.317' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'abd5d2c48f5947ae9db5777e2bf89792', N'single', NULL, N'Bùi Ngọc Anh', CAST(N'2021-12-05 13:52:04.567' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2022-05-07 01:23:45.310' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'b759f5c421ce4a5f8ca08bf76627b233', N'multi', N'Resource/Avatar/d7b6a0cb985b4087ab674fa349903e01', N'Xách balo lên và đi', CAST(N'2021-07-26 22:51:01.550' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2021-07-26 23:03:08.027' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'c8b00e01f4c04845b1167aff59e50cc3', N'multi', N'Resource/Avatar/3371ac29f4064d78af763103ff8bd063', N'Dũng sỹ diệt mồi', CAST(N'2021-07-26 22:49:26.187' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2021-07-26 23:05:18.000' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'f04778e4b8ae4e4b81bfdb7bcbd50b0d', N'multi', N'Resource/Avatar/b1e285b5a2a64187b01f15fdfcdbb1fc', N'VChat <3', CAST(N'2021-07-26 23:07:58.527' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2022-05-07 01:26:32.047' AS DateTime))
INSERT [dbo].[Group] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'f5d4c201f0b84397ab724c648c0db810', N'single', NULL, N'Phạm Băng Trang', CAST(N'2021-07-26 23:07:01.137' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2021-07-26 23:07:01.137' AS DateTime))
INSERT [dbo].[GroupCall] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'60d491428e6748d4b4f0390b72a41c5a', N'single', NULL, NULL, CAST(N'2021-07-26 23:29:22.713' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2021-07-26 23:29:22.713' AS DateTime))
INSERT [dbo].[GroupCall] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'960f365d2c7742b681ee2e6d8aea6ad1', N'single', NULL, NULL, CAST(N'2021-07-26 23:36:06.837' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2021-07-26 23:36:06.837' AS DateTime))
INSERT [dbo].[GroupCall] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'c4b1864c4e4844629bfd4b782f984a3d', N'single', NULL, NULL, CAST(N'2021-08-10 00:40:12.247' AS DateTime), N'39c3575543284110a80372b59234d6f7', CAST(N'2021-08-10 00:40:12.247' AS DateTime))
INSERT [dbo].[GroupCall] ([Code], [Type], [Avatar], [Name], [Created], [CreatedBy], [LastActive]) VALUES (N'f0a227f3c28b49c89310de6a8df38a1a', N'single', NULL, NULL, CAST(N'2021-07-26 23:35:43.140' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28', CAST(N'2021-07-26 23:35:43.140' AS DateTime))
SET IDENTITY_INSERT [dbo].[GroupUser] ON 

INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (36, N'3fea5e8164b04bc1a3891bd7137d06d8', N'2b388cc0b9b6405c99c6b30b50c9d8ec')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (37, N'3fea5e8164b04bc1a3891bd7137d06d8', N'18d2e99f599e4a70862cd299e8a96676')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (38, N'3fea5e8164b04bc1a3891bd7137d06d8', N'8053110542b44e04ba59b4dbbc7b830c')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (39, N'3fea5e8164b04bc1a3891bd7137d06d8', N'2699d7dc23434f81b6501af3175e6bbd')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (40, N'3fea5e8164b04bc1a3891bd7137d06d8', N'9074aca1de2d42c598fccc0152082d76')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (41, N'3fea5e8164b04bc1a3891bd7137d06d8', N'8607cf69ac024bfcaca7364883ef5640')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (42, N'3fea5e8164b04bc1a3891bd7137d06d8', N'1df7822da40b4938a860f318aa84865a')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (44, N'90d94199caf14ae28378ec00b7f90b91', N'2b388cc0b9b6405c99c6b30b50c9d8ec')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (45, N'90d94199caf14ae28378ec00b7f90b91', N'18d2e99f599e4a70862cd299e8a96676')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (46, N'90d94199caf14ae28378ec00b7f90b91', N'8053110542b44e04ba59b4dbbc7b830c')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (47, N'90d94199caf14ae28378ec00b7f90b91', N'2699d7dc23434f81b6501af3175e6bbd')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (48, N'90d94199caf14ae28378ec00b7f90b91', N'9074aca1de2d42c598fccc0152082d76')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (49, N'90d94199caf14ae28378ec00b7f90b91', N'8607cf69ac024bfcaca7364883ef5640')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (50, N'90d94199caf14ae28378ec00b7f90b91', N'1df7822da40b4938a860f318aa84865a')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (52, N'c8b00e01f4c04845b1167aff59e50cc3', N'2b388cc0b9b6405c99c6b30b50c9d8ec')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (53, N'c8b00e01f4c04845b1167aff59e50cc3', N'18d2e99f599e4a70862cd299e8a96676')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (54, N'c8b00e01f4c04845b1167aff59e50cc3', N'8053110542b44e04ba59b4dbbc7b830c')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (55, N'c8b00e01f4c04845b1167aff59e50cc3', N'2699d7dc23434f81b6501af3175e6bbd')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (56, N'c8b00e01f4c04845b1167aff59e50cc3', N'9074aca1de2d42c598fccc0152082d76')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (57, N'c8b00e01f4c04845b1167aff59e50cc3', N'8607cf69ac024bfcaca7364883ef5640')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (58, N'c8b00e01f4c04845b1167aff59e50cc3', N'1df7822da40b4938a860f318aa84865a')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (59, N'c8b00e01f4c04845b1167aff59e50cc3', N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (60, N'366a70849f0a49418310ebf4270d9f85', N'2b388cc0b9b6405c99c6b30b50c9d8ec')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (61, N'366a70849f0a49418310ebf4270d9f85', N'18d2e99f599e4a70862cd299e8a96676')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (62, N'366a70849f0a49418310ebf4270d9f85', N'8053110542b44e04ba59b4dbbc7b830c')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (63, N'366a70849f0a49418310ebf4270d9f85', N'2699d7dc23434f81b6501af3175e6bbd')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (64, N'366a70849f0a49418310ebf4270d9f85', N'9074aca1de2d42c598fccc0152082d76')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (65, N'366a70849f0a49418310ebf4270d9f85', N'8607cf69ac024bfcaca7364883ef5640')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (66, N'366a70849f0a49418310ebf4270d9f85', N'1df7822da40b4938a860f318aa84865a')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (67, N'366a70849f0a49418310ebf4270d9f85', N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (68, N'a90d114f23d7456782370765af767e8f', N'2b388cc0b9b6405c99c6b30b50c9d8ec')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (69, N'a90d114f23d7456782370765af767e8f', N'18d2e99f599e4a70862cd299e8a96676')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (70, N'a90d114f23d7456782370765af767e8f', N'8053110542b44e04ba59b4dbbc7b830c')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (71, N'a90d114f23d7456782370765af767e8f', N'2699d7dc23434f81b6501af3175e6bbd')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (72, N'a90d114f23d7456782370765af767e8f', N'9074aca1de2d42c598fccc0152082d76')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (73, N'a90d114f23d7456782370765af767e8f', N'8607cf69ac024bfcaca7364883ef5640')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (74, N'a90d114f23d7456782370765af767e8f', N'1df7822da40b4938a860f318aa84865a')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (75, N'a90d114f23d7456782370765af767e8f', N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (76, N'b759f5c421ce4a5f8ca08bf76627b233', N'2b388cc0b9b6405c99c6b30b50c9d8ec')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (77, N'b759f5c421ce4a5f8ca08bf76627b233', N'18d2e99f599e4a70862cd299e8a96676')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (78, N'b759f5c421ce4a5f8ca08bf76627b233', N'8053110542b44e04ba59b4dbbc7b830c')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (79, N'b759f5c421ce4a5f8ca08bf76627b233', N'2699d7dc23434f81b6501af3175e6bbd')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (80, N'b759f5c421ce4a5f8ca08bf76627b233', N'9074aca1de2d42c598fccc0152082d76')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (81, N'b759f5c421ce4a5f8ca08bf76627b233', N'8607cf69ac024bfcaca7364883ef5640')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (82, N'b759f5c421ce4a5f8ca08bf76627b233', N'1df7822da40b4938a860f318aa84865a')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (83, N'b759f5c421ce4a5f8ca08bf76627b233', N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (84, N'934b99e5d1cf4d3d9576299e479a1bf1', N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (85, N'934b99e5d1cf4d3d9576299e479a1bf1', N'8053110542b44e04ba59b4dbbc7b830c')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (86, N'f5d4c201f0b84397ab724c648c0db810', N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (87, N'f5d4c201f0b84397ab724c648c0db810', N'9074aca1de2d42c598fccc0152082d76')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (88, N'f04778e4b8ae4e4b81bfdb7bcbd50b0d', N'2b388cc0b9b6405c99c6b30b50c9d8ec')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (89, N'f04778e4b8ae4e4b81bfdb7bcbd50b0d', N'18d2e99f599e4a70862cd299e8a96676')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (90, N'f04778e4b8ae4e4b81bfdb7bcbd50b0d', N'8053110542b44e04ba59b4dbbc7b830c')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (91, N'f04778e4b8ae4e4b81bfdb7bcbd50b0d', N'2699d7dc23434f81b6501af3175e6bbd')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (92, N'f04778e4b8ae4e4b81bfdb7bcbd50b0d', N'9074aca1de2d42c598fccc0152082d76')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (93, N'f04778e4b8ae4e4b81bfdb7bcbd50b0d', N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (99, N'33c47cc785744d36a517d44c57d8b561', N'39c3575543284110a80372b59234d6f7')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (100, N'33c47cc785744d36a517d44c57d8b561', N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (101, N'abd5d2c48f5947ae9db5777e2bf89792', N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[GroupUser] ([Id], [GroupCode], [UserCode]) VALUES (102, N'abd5d2c48f5947ae9db5777e2bf89792', N'2b388cc0b9b6405c99c6b30b50c9d8ec')
SET IDENTITY_INSERT [dbo].[GroupUser] OFF
SET IDENTITY_INSERT [dbo].[Message] ON 

INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (189, N'text', N'b759f5c421ce4a5f8ca08bf76627b233', N'Di chuyển nào anh em ơi!', NULL, CAST(N'2021-07-26 23:03:08.027' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (190, N'text', N'a90d114f23d7456782370765af767e8f', N'chuyện tối hôm qua bây giờ mới kể', NULL, CAST(N'2021-07-26 23:04:26.317' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (191, N'text', N'366a70849f0a49418310ebf4270d9f85', N'Nào nào mình cùng lại đây phê pha', NULL, CAST(N'2021-07-26 23:04:47.433' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (192, N'text', N'c8b00e01f4c04845b1167aff59e50cc3', N'20kg thịt bò, 12kg thịt lơn, 10kg mực', NULL, CAST(N'2021-07-26 23:05:18.000' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (193, N'text', N'90d94199caf14ae28378ec00b7f90b91', N'lần đầu tiên trong cuộc đời', NULL, CAST(N'2021-07-26 23:05:35.110' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (194, N'text', N'3fea5e8164b04bc1a3891bd7137d06d8', N'Một gia đình hạnh phúc là như thế nào?', NULL, CAST(N'2021-07-26 23:05:50.107' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (196, N'text', N'f5d4c201f0b84397ab724c648c0db810', N'Tuyển dụng thêm 5 bạn nhân sự marketing vị trí thực tập', NULL, CAST(N'2021-07-26 23:07:01.137' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (242, N'text', N'abd5d2c48f5947ae9db5777e2bf89792', N'hihi', NULL, CAST(N'2021-12-10 19:05:00.493' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (246, N'text', N'33c47cc785744d36a517d44c57d8b561', N'sà', NULL, CAST(N'2022-05-07 01:02:10.003' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (247, N'text', N'934b99e5d1cf4d3d9576299e479a1bf1', N'&#128533; &#129303;', NULL, CAST(N'2022-05-07 01:21:26.447' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (248, N'text', N'934b99e5d1cf4d3d9576299e479a1bf1', N'&#128527; &#128579; &#128524;', NULL, CAST(N'2022-05-07 01:21:46.880' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (249, N'text', N'934b99e5d1cf4d3d9576299e479a1bf1', N'&#128512;', NULL, CAST(N'2022-05-07 01:21:55.927' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (250, N'text', N'33c47cc785744d36a517d44c57d8b561', N'&#128533;', NULL, CAST(N'2022-05-07 01:23:10.003' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (251, N'text', N'abd5d2c48f5947ae9db5777e2bf89792', N'&#128540;', NULL, CAST(N'2022-05-07 01:23:39.480' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (252, N'text', N'abd5d2c48f5947ae9db5777e2bf89792', N'&#128074;', NULL, CAST(N'2022-05-07 01:23:42.837' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (253, N'text', N'abd5d2c48f5947ae9db5777e2bf89792', N'&#128069;', NULL, CAST(N'2022-05-07 01:23:45.310' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (254, N'text', N'f04778e4b8ae4e4b81bfdb7bcbd50b0d', N'&#128534;', NULL, CAST(N'2022-05-07 01:26:32.047' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (258, N'notify', N'3fea5e8164b04bc1a3891bd7137d06d8', N'Ngô Xuân Dương đã rời khỏi nhóm trò chuyện', NULL, CAST(N'2022-05-07 01:31:08.413' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
INSERT [dbo].[Message] ([Id], [Type], [GroupCode], [Content], [Path], [Created], [CreatedBy]) VALUES (259, N'text', N'90d94199caf14ae28378ec00b7f90b91', N'Ngô Xuân Dương đã rời khỏi nhóm trò chuyện', NULL, CAST(N'2022-05-07 01:33:30.297' AS DateTime), N'3e48f1ce9f015cc59bd7bf0605681f28')
SET IDENTITY_INSERT [dbo].[Message] OFF
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'08f3caa8c99748d1a1b11bc434025e04', N'123', N'99249dc7aaff4400820064d7e59dca52d16c1f97642a62665bc2eae4be9b7fd5', N'Ngo Xuan DUong', NULL, N'3we', N'duongnx.work@gmail.com', NULL, N'Resource/no_img.jpg', NULL, NULL, NULL, N'645974', 0, N'e21008bb9bfb4d658a136e9c1e95ae74', CAST(N'2022-05-07 01:48:23.650' AS DateTime))
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'18d2e99f599e4a70862cd299e8a96676', N'anhngoc.ngo', N'1a33b9a1d9a21935befbee288ef5df5b0f8e05bb213d5e34ea1c3087edeb1d15', N'Ngô Minh Ngọc Ánh', N'01/02/1998', N'0923.123.765', N'anhngoc@gmail.com', N'Thành phố Đà Nẵng, Việt Nam', N'Resource/Avatar/2f166915f5a0472da1a5674deff5fd04', N'Nữ', CAST(N'2021-07-26 23:10:23.953' AS DateTime), N'_nenWLoh683qAuwMulMqcQ', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'1df7822da40b4938a860f318aa84865a', N'binhminh.tran', N'748305c24cb40701a018091cfa2b51787ed4140d285c629396ffd165269a9e0a', N'Trần Bình Minh', N'16/05/1992', N'0124.321.198', N'tranbinhminh@gmail.com', N'Thành Phố Hồ Chí Minh, Việt Nam', N'Resource/Avatar/84d07c7d1e924a1ebdf258c4d5d3b784', N'Nam', CAST(N'2021-07-26 22:34:11.670' AS DateTime), N'O5jF9-fXlakp3EhF-a96tg', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'2699d7dc23434f81b6501af3175e6bbd', N'ngoctrinh.nguyen', N'a013d37d9c52d41ace3f101b48443724bce0a87d0e1ca55995af798c3c3b67d1', N'Nguyễn Ngọc Trinh', N'12/12/2000', N'0934.123.432', N'nguyenngoctrinh@gmail.com', N'Thành Phố Hồ Chí Minh, Việt Nam', N'Resource/Avatar/76412470446b4aab86acde51bfff5eeb', N'Nữ', CAST(N'2021-07-26 23:12:35.190' AS DateTime), N'5sf7Yb7hQqXmT1e2CVATzg', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'2b388cc0b9b6405c99c6b30b50c9d8ec', N'ngocanh.bui', N'980c348c3a944a63d1cda1d09d67eace90a628da49db241919adc79aeba2f27c', N'Bùi Ngọc Anh', N'22/01/1994', N'0983.125.345', N'buingocanh@gmail.com', N'TP Hạ Long, Quảng Ninh, Việt Nam', N'Resource/Avatar/d8ea0463f4d14e9d825bcab117b20ccd', N'Nữ', CAST(N'2021-07-26 22:35:51.597' AS DateTime), N'8yqvF0sNKASYMozfQBWVVA', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'39c3575543284110a80372b59234d6f7', N'ngocanh.truong', N'676609f1ae67fa102b5841736fa3e0e7b3eb0bbf07f15b68687e371277593175', N'Trương Ngọc Anh', N'1990', N'0983.123.333', N'ngocanh@gmail.com', NULL, N'Resource/Avatar/102132e535df4c29a5ce3590ba16a228', N'Nữ', CAST(N'2021-08-10 00:16:11.290' AS DateTime), N'aMGFsmHUQEo_Tuzw2ufytQ', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'3e48f1ce9f015cc59bd7bf0605681f28', N'admin', N'4d5c5f61bb3d2c299d3211c2992a28a7849b6ce933919c399ce24903c1715d45', N'Ngô Xuân Dương', N'01/01/1990', N'0983216534', N'mymail@gmail.com', N'Hà Nội, Việt Nam', N'Resource/Avatar/9bb8cddea6814c6e97c1cd99b01b5b06', N'Nam', CAST(N'2022-05-07 00:56:13.160' AS DateTime), N'Tpl4MbXnNW8ZGnzIaAt2OA', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'4a3bd44ffec249569fd415b7f2cdfb0f', N'ac1', N'0a4893413039405a11748eeafdc109420f11f22ad4842575fc3efff4ae7ed966', N'Abc', NULL, N'987', N'duongnx.work@gmail.com', NULL, N'Resource/no_img.jpg', NULL, NULL, NULL, N'879188', 0, N'a2fc947bf66346c6a2a4820f0070a282', CAST(N'2022-05-07 13:53:58.490' AS DateTime))
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'57ec8237112f4e63a5b96bf7d08f50ac', N'ac', N'b5199fa2096f3d47c3179a0ff66e59049237b154de84cc4b61c40fe281eaa09e', N'Abc', NULL, N'987', N'duongnx.work@gmail.com', NULL, N'Resource/no_img.jpg', NULL, NULL, NULL, N'310724', 0, N'667b712140144b378f1c5aacf35896f8', CAST(N'2022-05-07 13:53:30.340' AS DateTime))
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'6d014673d43c42e498ca240206b076c7', N'1231', N'90818a6341a9bc71686834ecdd3e911a10ec99d677787af8b41d27c21906038a', N'Ngo Xuan DUong', NULL, N'3we', N'duongnx.work@gmail.com', NULL, N'Resource/no_img.jpg', NULL, NULL, NULL, N'337064', 1, N'42e7b0b55db641fe8f752f55af56aea8', CAST(N'2022-05-07 01:49:33.653' AS DateTime))
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'8053110542b44e04ba59b4dbbc7b830c', N'minhtri.ngo', N'087782207b6155f25c3cb5a8b21fe53ad8441a4b206153be399a8cbf91499480', N'Ngô Minh Trí', N'15/18/1996', N'0923.123.456', N'ngominhtri@gmail.com', N'Thái Bình, Việt Nam', N'Resource/Avatar/9c0563b0d44a4c87890396d29a63bc71', N'Nam', CAST(N'2022-05-07 01:34:12.827' AS DateTime), N'MCzCDD6o2vfNZwUr2xXy4A', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'8607cf69ac024bfcaca7364883ef5640', N'quynhanh.pham', N'05c5302185c8657e4a34a759d1724aac82b7c7318b5e684ac47e534f82811261', N'Phạm Quỳnh Anh', N'04/12/2000', N'0936.234.562', N'phamquynhanh@gmail.com', N'Ninh Bình, Việt Nam', N'Resource/Avatar/8ac2076595304c16a7ad295195a8a92a', N'Nữ', CAST(N'2021-07-26 22:36:50.593' AS DateTime), N'S3MBmz0e_bJW9TFrcO2ztw', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'8cff932c7d8048ee87cb5a78f259cdf9', N'111', N'ee2b4be2a2c5ae93f05da0f332c4e7df0b0d68a422380a62e437df61ae0cc460', N'23', NULL, N'0987', N'duongnx.work@gmail.com', NULL, N'Resource/no_img.jpg', NULL, NULL, NULL, N'987628', 1, N'93420e070c9a46c2af13960571fa152e', CAST(N'2022-05-07 01:50:23.357' AS DateTime))
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'8fed189644974049b628afc415c8b8bd', N'test', N'af55b907c7e2b53a4be95bc6d36098d1002f985181d4082d21e89191a57a539d', N'Ngo Xuan DUong', NULL, N'3we', N'duongnx.work@gmail.com', NULL, N'Resource/no_img.jpg', NULL, NULL, NULL, N'261103', 1, N'b9662fef930e4fdf8f40a46cd5fb5e0d', CAST(N'2022-05-07 01:48:06.560' AS DateTime))
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'9074aca1de2d42c598fccc0152082d76', N'trangbang.pham', N'30f7fb8b6fdb6f36762fafdbcba5cc1fc354e3ffb88b91698448c2b43a8e5717', N'Phạm Băng Trang', N'25/08/1999', N'0983.123.456', N'phambangtrang@gmail.com', N'Cầu Giấy, Hà Nội, Việt Nam', N'Resource/Avatar/3b6b61ae36dd4d25b66a7ef56d313830', N'Nữ', CAST(N'2021-07-26 22:38:23.633' AS DateTime), N'aiCM3oXM7rb0-C0sI7HYyw', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'a71eff90f79e40e29881c4149c07ecfe', N'minhquang.ho', N'7c244bf95b1d968810e99a6b21638bb582c2a1f4f4408b2abf5dea50d2866155', N'Hồ Minh Quang', NULL, N'0912.321.122', N'hominhquang@gmail.com', NULL, N'Resource/no_img.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'bcd3d540b5094924b701535a23f9855d', N'ngoctrang.tran', N'9a35886f3db6a77d14307a1416559727cb06991921ad511e7f3b6e8131d659c4', N'Trần Ngọc Trang', N'19/22/2000', N'0984.123.432', N'tranngoctrang@gmail.com', N'Bắc Ninh, Việt Nam', N'Resource/Avatar/8af7f1b946a442a6a42da02e74eeee83', N'Nữ', CAST(N'2021-07-26 22:43:19.497' AS DateTime), N'8fVH7SOWBXxUvapfw7-qGg', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'bfde8b0c618f44eb94e3986af4223101', N'2', N'48fccc7ee00b729591402c4e50040b31043a26b5a196ea792fce1b9dca5deb40', N'1', NULL, N'uu', N'duongnx.work@gmail.com', NULL, N'Resource/no_img.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'e5f371bb528549609bd2c2fc928cfce5', N'1', N'551e8b15be547418fbf59dbfdb9c1788e0846b7994be099e6e0e9960ff26457f', N'1', NULL, N'1', N'duongnx.work@gmail.com', NULL, N'Resource/no_img.jpg', NULL, CAST(N'2022-05-07 00:52:58.320' AS DateTime), N'BvrKrZRHg27Ex9cNgkU42w', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'ea813c82cd87403083abfb2d1c143cfb', N'baohan.le', N'e81a271aacd2f4fe6256a407ed3d7bf4d7e15a78b05b73a15cbd818d5aca9340', N'Lê Ngọc Bảo Hân', N'12/12/2001', N'0254.123.349', N'lengocbaohan@gmail.com', N'Ninh Giang', N'Resource/Avatar/f178bdbee0d640f6b09a65046ef78019', N'Nữ', CAST(N'2021-07-26 22:41:57.580' AS DateTime), N'LsWWfOT9nMzzYXEuslPfbA', NULL, 1, NULL, NULL)
INSERT [dbo].[User] ([Code], [UserName], [Password], [FullName], [Dob], [Phone], [Email], [Address], [Avatar], [Gender], [LastLogin], [CurrentSession], [OTP], [Active], [Token], [ExpiredTokenTime]) VALUES (N'ee7dbac1ef704fa79f839eb67fa7e8e8', N'ngocnhi.truong', N'd1f160ce90ab7ee87a9e370c37c14dbc232b98d01442b2a35e2f13a10e889f4c', N'Trương Ngọc Nhi', NULL, N'0932.123.333', N'ngocnhi.truong@gmail.com', NULL, N'Resource/no_img.jpg', NULL, NULL, NULL, NULL, 1, NULL, NULL)
ALTER TABLE [dbo].[Call]  WITH CHECK ADD  CONSTRAINT [FK_Call_GroupCall] FOREIGN KEY([GroupCallCode])
REFERENCES [dbo].[GroupCall] ([Code])
GO
ALTER TABLE [dbo].[Call] CHECK CONSTRAINT [FK_Call_GroupCall]
GO
ALTER TABLE [dbo].[Call]  WITH CHECK ADD  CONSTRAINT [FK_Call_User] FOREIGN KEY([UserCode])
REFERENCES [dbo].[User] ([Code])
GO
ALTER TABLE [dbo].[Call] CHECK CONSTRAINT [FK_Call_User]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_User] FOREIGN KEY([UserCode])
REFERENCES [dbo].[User] ([Code])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_User]
GO
ALTER TABLE [dbo].[Contact]  WITH CHECK ADD  CONSTRAINT [FK_Contact_User1] FOREIGN KEY([ContactCode])
REFERENCES [dbo].[User] ([Code])
GO
ALTER TABLE [dbo].[Contact] CHECK CONSTRAINT [FK_Contact_User1]
GO
ALTER TABLE [dbo].[GroupUser]  WITH CHECK ADD  CONSTRAINT [FK_GroupUser_Group] FOREIGN KEY([GroupCode])
REFERENCES [dbo].[Group] ([Code])
GO
ALTER TABLE [dbo].[GroupUser] CHECK CONSTRAINT [FK_GroupUser_Group]
GO
ALTER TABLE [dbo].[GroupUser]  WITH CHECK ADD  CONSTRAINT [FK_GroupUser_GroupUser] FOREIGN KEY([Id])
REFERENCES [dbo].[GroupUser] ([Id])
GO
ALTER TABLE [dbo].[GroupUser] CHECK CONSTRAINT [FK_GroupUser_GroupUser]
GO
ALTER TABLE [dbo].[GroupUser]  WITH CHECK ADD  CONSTRAINT [FK_GroupUser_User] FOREIGN KEY([UserCode])
REFERENCES [dbo].[User] ([Code])
GO
ALTER TABLE [dbo].[GroupUser] CHECK CONSTRAINT [FK_GroupUser_User]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Group] FOREIGN KEY([GroupCode])
REFERENCES [dbo].[Group] ([Code])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Group]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_User] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[User] ([Code])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_User]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'single: chat 1-1
multi: chat 1-n' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Group', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'single: chat 1-1
multi: chat 1-n' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'GroupCall', @level2type=N'COLUMN',@level2name=N'Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'text
media
attachment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Message', @level2type=N'COLUMN',@level2name=N'Type'
GO
USE [master]
GO
ALTER DATABASE [VChat] SET  READ_WRITE 
GO
