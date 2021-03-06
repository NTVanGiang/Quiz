USE [master]
GO
/****** Object:  Database [ToiecTest]    Script Date: 5/27/2017 7:08:57 AM ******/
CREATE DATABASE [ToiecTest]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ToiecTest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ToiecTest.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ToiecTest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ToiecTest_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ToiecTest] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ToiecTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ToiecTest] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ToiecTest] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ToiecTest] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ToiecTest] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ToiecTest] SET ARITHABORT OFF 
GO
ALTER DATABASE [ToiecTest] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ToiecTest] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ToiecTest] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ToiecTest] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ToiecTest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ToiecTest] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ToiecTest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ToiecTest] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ToiecTest] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ToiecTest] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ToiecTest] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ToiecTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ToiecTest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ToiecTest] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ToiecTest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ToiecTest] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ToiecTest] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ToiecTest] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ToiecTest] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ToiecTest] SET  MULTI_USER 
GO
ALTER DATABASE [ToiecTest] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ToiecTest] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ToiecTest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ToiecTest] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ToiecTest]
GO
/****** Object:  StoredProcedure [dbo].[sp_tb_Admin_ListAll]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_tb_Admin_ListAll]
as
begin
select * from tb_Admin
end

GO
/****** Object:  StoredProcedure [dbo].[sp_tb_Admin_Login]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_tb_Admin_Login]
	@username varchar(50),
	@password varchar(50)
as
begin
	declare @count int
	declare @result bit
	select @count = count (*) from tb_Admin where username = @username and password = @password
	if @count > 0
		set @result = 1
	else
		set @result = 0
	select @result
end

GO
/****** Object:  Table [dbo].[Category]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] NULL,
	[name] [nvarchar](max) NULL,
	[parentid] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhanQuyen]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanQuyen](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TenQuyen] [nvarchar](max) NOT NULL,
	[LoaiQuyen] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_PhanQuyen] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Account]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Account](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fullName] [nvarchar](50) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
	[mobile] [varchar](11) NULL,
	[livingPlace] [nvarchar](50) NULL,
	[birthDay] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[Status] [bit] NOT NULL,
	[idQuyen] [int] NOT NULL,
 CONSTRAINT [PK_tbSinhVien] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Answer]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Answer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_SubQuestion] [int] NOT NULL,
	[answerContent] [ntext] NOT NULL,
	[isCorrect] [bit] NOT NULL,
	[Ordering] [int] NOT NULL,
 CONSTRAINT [PK_tb_Answer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Image]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Image](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[url] [ntext] NULL,
	[alt] [ntext] NULL,
	[id_SubQuestion] [int] NULL,
 CONSTRAINT [PK_tb_Image] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Level]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Level](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[levelName] [varchar](50) NOT NULL,
	[Ordering] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Level] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Part]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Part](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[partNumber] [nvarchar](50) NOT NULL,
	[id_Skill] [int] NULL,
	[Status] [bit] NOT NULL,
	[Ordering] [int] NOT NULL,
 CONSTRAINT [PK_tb_Part] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_QuangCao]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_QuangCao](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_ViTri] [int] NULL,
	[linkHinhAnh] [nvarchar](150) NULL,
	[linkWeb] [nvarchar](150) NULL,
 CONSTRAINT [PK_tb_QuangCao] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Question]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Question](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_Topic] [int] NULL,
	[id_Level] [int] NULL,
	[Title] [nvarchar](max) NULL,
	[contentQuestion] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NULL,
	[Status] [bit] NOT NULL,
	[id_Part] [int] NULL,
 CONSTRAINT [PK_tb_CauHoi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Quiz]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Quiz](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[totalQuestion] [int] NULL,
	[totalTime] [int] NULL,
	[id_Account] [int] NULL,
	[BeginTime] [datetime] NULL,
	[FinishTime] [datetime] NULL,
	[scoreRead] [int] NULL,
	[scoreListening] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[isAdminCreate] [bit] NOT NULL,
 CONSTRAINT [PK_LevelQuiz] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_QuizDetail]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_QuizDetail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_Quiz] [int] NULL,
	[id_SubQuestion] [int] NULL,
	[id_AnswerMember] [int] NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Skill]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Skill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[skillName] [nvarchar](50) NOT NULL,
	[Ordering] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Part] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Sound]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Sound](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[url] [nvarchar](150) NULL,
 CONSTRAINT [PK_Sound] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_SubQuestion]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_SubQuestion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_Question] [int] NOT NULL,
	[position] [int] NOT NULL,
	[Desciption] [nvarchar](max) NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_tb_Parent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Topic]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Topic](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[topicName] [nvarchar](200) NOT NULL,
	[Ordering] [int] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_tbChuDe] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ViTriQC]    Script Date: 5/27/2017 7:08:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ViTriQC](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[viTri] [nvarchar](100) NULL,
 CONSTRAINT [PK_ViTriQC] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[PhanQuyen] ON 

INSERT [dbo].[PhanQuyen] ([id], [TenQuyen], [LoaiQuyen]) VALUES (1, N'Admin', N'admin')
INSERT [dbo].[PhanQuyen] ([id], [TenQuyen], [LoaiQuyen]) VALUES (3, N'Học viên', N'hocvien')
SET IDENTITY_INSERT [dbo].[PhanQuyen] OFF
SET IDENTITY_INSERT [dbo].[tb_Account] ON 

INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (1, N'Nguyễn Văn Hiếu', N'1', N'c4ca4238a0b923820dcc509a6f75849b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (2, N'Nguyễn Thị Vân Giang', N'Giang', N'827ccb0eea8a706c4c34a16891f84e7b', N'vangiang2303@gmail.com', N'0982612499', NULL, CAST(0x00008AB600000000 AS DateTime), NULL, 1, 1)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (3, N'Trịnh Đức Dương', N'2', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (4, N'Phạm Xuân Duy', N'3', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (5, N'Nguyễn Văn Dương', N'4', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (6, N'Lại Thanh Bình', N'5', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (7, N'Lê Tiến Hoàn', N'6', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (8, N'Đào Văn Hiệp', N'6', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (9, N'Nguyễn Thị Dương', N'8', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (10, N'Nguyễn Bảo Châu', N'7', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (11, N'Hán Đình Đôn', N'9', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (12, N'Nguyễn Văn Hồng', N'10', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (13, N'Công Xuân Đức', N'11', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (14, N'Hàn Tiến Mạnh Tùng', N'12', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (15, N'Nguyễn Đức Giang', N'13', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (16, N'Kim Văn Sáng', N'14', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (17, N'Nguyễn Hải Đăng', N'15', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (19, N'Đỗ Hoàng Sơn', N'sonson', N'827ccb0eea8a706c4c34a16891f84e7b', NULL, NULL, NULL, NULL, NULL, 1, 1)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (30, N'Nguyễn Thị Vân Anh', N'Vân Anh', NULL, N'melove@gmail.com', NULL, NULL, CAST(0x000088AE00000000 AS DateTime), CAST(0x0000A7570023EFDF AS DateTime), 0, 3)
INSERT [dbo].[tb_Account] ([id], [fullName], [username], [password], [email], [mobile], [livingPlace], [birthDay], [CreateDate], [Status], [idQuyen]) VALUES (46, N'Nguyễn Công Pháp', N'Pháp', NULL, N'melove@gmail.com', NULL, NULL, CAST(0x0000A41300000000 AS DateTime), CAST(0x0000A7570024032C AS DateTime), 1, 3)
SET IDENTITY_INSERT [dbo].[tb_Account] OFF
SET IDENTITY_INSERT [dbo].[tb_Answer] ON 

INSERT [dbo].[tb_Answer] ([id], [id_SubQuestion], [answerContent], [isCorrect], [Ordering]) VALUES (1, 2, N'<p>nội dung c&acirc;u trả lời</p>
', 1, 0)
INSERT [dbo].[tb_Answer] ([id], [id_SubQuestion], [answerContent], [isCorrect], [Ordering]) VALUES (3, 2, N'22', 1, 1)
INSERT [dbo].[tb_Answer] ([id], [id_SubQuestion], [answerContent], [isCorrect], [Ordering]) VALUES (4, 2, N'<p>how to</p>
', 1, 1)
INSERT [dbo].[tb_Answer] ([id], [id_SubQuestion], [answerContent], [isCorrect], [Ordering]) VALUES (5, 3, N'<p>why</p>
', 0, 1)
INSERT [dbo].[tb_Answer] ([id], [id_SubQuestion], [answerContent], [isCorrect], [Ordering]) VALUES (6, 3, N'<p>fdadf</p>
', 1, 0)
INSERT [dbo].[tb_Answer] ([id], [id_SubQuestion], [answerContent], [isCorrect], [Ordering]) VALUES (7, 3, N'<p>qwq</p>
', 0, 1)
INSERT [dbo].[tb_Answer] ([id], [id_SubQuestion], [answerContent], [isCorrect], [Ordering]) VALUES (8, 2, N'<p>yes</p>
', 1, 2)
SET IDENTITY_INSERT [dbo].[tb_Answer] OFF
SET IDENTITY_INSERT [dbo].[tb_Level] ON 

INSERT [dbo].[tb_Level] ([id], [levelName], [Ordering], [Status]) VALUES (1, N'500 - 750', 2, 1)
INSERT [dbo].[tb_Level] ([id], [levelName], [Ordering], [Status]) VALUES (2, N'250 - 500', 1, 1)
INSERT [dbo].[tb_Level] ([id], [levelName], [Ordering], [Status]) VALUES (4, N'750 - 990', 3, 1)
SET IDENTITY_INSERT [dbo].[tb_Level] OFF
SET IDENTITY_INSERT [dbo].[tb_Part] ON 

INSERT [dbo].[tb_Part] ([id], [partNumber], [id_Skill], [Status], [Ordering]) VALUES (1, N'1', 1, 1, 0)
INSERT [dbo].[tb_Part] ([id], [partNumber], [id_Skill], [Status], [Ordering]) VALUES (2, N'2', 1, 1, 0)
INSERT [dbo].[tb_Part] ([id], [partNumber], [id_Skill], [Status], [Ordering]) VALUES (3, N'3', 2, 1, 1)
INSERT [dbo].[tb_Part] ([id], [partNumber], [id_Skill], [Status], [Ordering]) VALUES (5, N'6', 1, 1, 0)
INSERT [dbo].[tb_Part] ([id], [partNumber], [id_Skill], [Status], [Ordering]) VALUES (6, N'12', 1, 0, 0)
INSERT [dbo].[tb_Part] ([id], [partNumber], [id_Skill], [Status], [Ordering]) VALUES (7, N'4', 1, 1, 2)
SET IDENTITY_INSERT [dbo].[tb_Part] OFF
SET IDENTITY_INSERT [dbo].[tb_Question] ON 

INSERT [dbo].[tb_Question] ([id], [id_Topic], [id_Level], [Title], [contentQuestion], [CreateDate], [Status], [id_Part]) VALUES (2, 7, 2, N'Yes-no Question', N'Yes-No Question', CAST(0x0000A75800000000 AS DateTime), 1, 1)
INSERT [dbo].[tb_Question] ([id], [id_Topic], [id_Level], [Title], [contentQuestion], [CreateDate], [Status], [id_Part]) VALUES (3, 9, 2, N'WH Question', N'yes', CAST(0x0000A7580166D38E AS DateTime), 1, 5)
INSERT [dbo].[tb_Question] ([id], [id_Topic], [id_Level], [Title], [contentQuestion], [CreateDate], [Status], [id_Part]) VALUES (5, 13, 2, N'Yes-no Question', N'<p><img alt="" src="/Content/image/images/10828070_935691156461966_6315734114045833922_o.jpg" style="height:65px; width:100px" /></p>
', CAST(0x0000A759015ABA18 AS DateTime), 1, 2)
INSERT [dbo].[tb_Question] ([id], [id_Topic], [id_Level], [Title], [contentQuestion], [CreateDate], [Status], [id_Part]) VALUES (8, 14, 1, N'WH Question', N'<p><img alt="" src="/Content/image/images/10828070_935691156461966_6315734114045833922_o.jpg" style="height:1037px; width:1600px" /></p>
', CAST(0x0000A75B0009A075 AS DateTime), 1, 2)
INSERT [dbo].[tb_Question] ([id], [id_Topic], [id_Level], [Title], [contentQuestion], [CreateDate], [Status], [id_Part]) VALUES (9, 13, 2, N'WH Question', N'<div>
<audio controls="controls" id="audio201732005133"><source src="/Content/image/files/Viet-Nam-Di-Hon-Va-Yeu-Pham-Hong-Phuoc.mp3" type="audio/mp4" /></audio>
</div>

<p>&nbsp;</p>

<div>&nbsp;</div>

<p>&nbsp;</p>
', CAST(0x0000A75B000E4852 AS DateTime), 1, 5)
INSERT [dbo].[tb_Question] ([id], [id_Topic], [id_Level], [Title], [contentQuestion], [CreateDate], [Status], [id_Part]) VALUES (11, 13, 1, N'WH Question', N'<p>hdhfjdsjfs</p>

<p><img alt="" src="/Content/image/images/10828070_935691156461966_6315734114045833922_o.jpg" style="height:97px; width:150px" /></p>

<p>fhdfhds</p>
', CAST(0x0000A760014EC534 AS DateTime), 1, 5)
INSERT [dbo].[tb_Question] ([id], [id_Topic], [id_Level], [Title], [contentQuestion], [CreateDate], [Status], [id_Part]) VALUES (12, 12, 1, N'WH Question', N'<p>yes</p>
', CAST(0x0000A7600153862D AS DateTime), 1, 2)
INSERT [dbo].[tb_Question] ([id], [id_Topic], [id_Level], [Title], [contentQuestion], [CreateDate], [Status], [id_Part]) VALUES (13, 9, 2, N'Why not me', N'<p>i don&#39;t care</p>
', CAST(0x0000A776009C0F14 AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[tb_Question] OFF
SET IDENTITY_INSERT [dbo].[tb_Quiz] ON 

INSERT [dbo].[tb_Quiz] ([id], [Name], [totalQuestion], [totalTime], [id_Account], [BeginTime], [FinishTime], [scoreRead], [scoreListening], [CreatedDate], [isAdminCreate]) VALUES (1, N'Đề thi thử lần 1', 12, 12, 2, NULL, NULL, NULL, NULL, CAST(0x0000A77900920A6E AS DateTime), 1)
INSERT [dbo].[tb_Quiz] ([id], [Name], [totalQuestion], [totalTime], [id_Account], [BeginTime], [FinishTime], [scoreRead], [scoreListening], [CreatedDate], [isAdminCreate]) VALUES (2, N'1jkjlgyfft', 1, 1, 19, NULL, NULL, NULL, NULL, CAST(0x0000A77900921522 AS DateTime), 1)
INSERT [dbo].[tb_Quiz] ([id], [Name], [totalQuestion], [totalTime], [id_Account], [BeginTime], [FinishTime], [scoreRead], [scoreListening], [CreatedDate], [isAdminCreate]) VALUES (3, N'gfdgds', 1243243, 23242, 19, NULL, NULL, NULL, NULL, CAST(0x0000A7790092343C AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tb_Quiz] OFF
SET IDENTITY_INSERT [dbo].[tb_Skill] ON 

INSERT [dbo].[tb_Skill] ([id], [skillName], [Ordering], [Status]) VALUES (1, N'Nghe', 0, 1)
INSERT [dbo].[tb_Skill] ([id], [skillName], [Ordering], [Status]) VALUES (2, N'Đọc', 1, 1)
INSERT [dbo].[tb_Skill] ([id], [skillName], [Ordering], [Status]) VALUES (9, N'Nói', 12, 1)
SET IDENTITY_INSERT [dbo].[tb_Skill] OFF
SET IDENTITY_INSERT [dbo].[tb_SubQuestion] ON 

INSERT [dbo].[tb_SubQuestion] ([id], [id_Question], [position], [Desciption], [Status]) VALUES (2, 5, 1, N'<p>how to day</p>
', 1)
INSERT [dbo].[tb_SubQuestion] ([id], [id_Question], [position], [Desciption], [Status]) VALUES (3, 12, 1, N'why', 1)
INSERT [dbo].[tb_SubQuestion] ([id], [id_Question], [position], [Desciption], [Status]) VALUES (4, 12, 0, N'what', 1)
INSERT [dbo].[tb_SubQuestion] ([id], [id_Question], [position], [Desciption], [Status]) VALUES (5, 12, 0, N'<p>123</p>
', 1)
INSERT [dbo].[tb_SubQuestion] ([id], [id_Question], [position], [Desciption], [Status]) VALUES (7, 5, 0, N'<p>fdasdfsdf</p>
', 1)
SET IDENTITY_INSERT [dbo].[tb_SubQuestion] OFF
SET IDENTITY_INSERT [dbo].[tb_Topic] ON 

INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (7, N'Family', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (8, N'Topic 2', 2, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (9, N'Topic 3', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (10, N'Topic 4', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (11, N'Topic 1', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (12, N'Topic 12', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (13, N'Topic 13', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (14, N'Topic 14', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (15, N'Topic 5', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (16, N'Topic 6', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (17, N'Topic 7', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (18, N'Topic 8', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (19, N'Topic 9', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (20, N'Topic 10', 0, 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [Ordering], [Status]) VALUES (21, N'Topic 11', 0, 1)
SET IDENTITY_INSERT [dbo].[tb_Topic] OFF
ALTER TABLE [dbo].[tb_Account]  WITH CHECK ADD  CONSTRAINT [FK_tb_Account_PhanQuyen] FOREIGN KEY([idQuyen])
REFERENCES [dbo].[PhanQuyen] ([id])
GO
ALTER TABLE [dbo].[tb_Account] CHECK CONSTRAINT [FK_tb_Account_PhanQuyen]
GO
ALTER TABLE [dbo].[tb_Answer]  WITH CHECK ADD  CONSTRAINT [FK_tb_Answer_tb_SubQuestion] FOREIGN KEY([id_SubQuestion])
REFERENCES [dbo].[tb_SubQuestion] ([id])
GO
ALTER TABLE [dbo].[tb_Answer] CHECK CONSTRAINT [FK_tb_Answer_tb_SubQuestion]
GO
ALTER TABLE [dbo].[tb_Part]  WITH CHECK ADD  CONSTRAINT [FK_tb_Part_tb_Skill1] FOREIGN KEY([id_Skill])
REFERENCES [dbo].[tb_Skill] ([id])
GO
ALTER TABLE [dbo].[tb_Part] CHECK CONSTRAINT [FK_tb_Part_tb_Skill1]
GO
ALTER TABLE [dbo].[tb_QuangCao]  WITH CHECK ADD  CONSTRAINT [FK_tb_QuangCao_tb_ViTriQC] FOREIGN KEY([id_ViTri])
REFERENCES [dbo].[tb_ViTriQC] ([id])
GO
ALTER TABLE [dbo].[tb_QuangCao] CHECK CONSTRAINT [FK_tb_QuangCao_tb_ViTriQC]
GO
ALTER TABLE [dbo].[tb_Question]  WITH CHECK ADD  CONSTRAINT [FK_tb_Question_Level] FOREIGN KEY([id_Level])
REFERENCES [dbo].[tb_Level] ([id])
GO
ALTER TABLE [dbo].[tb_Question] CHECK CONSTRAINT [FK_tb_Question_Level]
GO
ALTER TABLE [dbo].[tb_Question]  WITH CHECK ADD  CONSTRAINT [FK_tb_Question_tb_Part] FOREIGN KEY([id_Part])
REFERENCES [dbo].[tb_Part] ([id])
GO
ALTER TABLE [dbo].[tb_Question] CHECK CONSTRAINT [FK_tb_Question_tb_Part]
GO
ALTER TABLE [dbo].[tb_Question]  WITH CHECK ADD  CONSTRAINT [FK_tb_Question_tb_Topic] FOREIGN KEY([id_Topic])
REFERENCES [dbo].[tb_Topic] ([id])
GO
ALTER TABLE [dbo].[tb_Question] CHECK CONSTRAINT [FK_tb_Question_tb_Topic]
GO
ALTER TABLE [dbo].[tb_Quiz]  WITH CHECK ADD  CONSTRAINT [FK_tb_Quiz_tb_Member] FOREIGN KEY([id_Account])
REFERENCES [dbo].[tb_Account] ([id])
GO
ALTER TABLE [dbo].[tb_Quiz] CHECK CONSTRAINT [FK_tb_Quiz_tb_Member]
GO
ALTER TABLE [dbo].[tb_QuizDetail]  WITH CHECK ADD  CONSTRAINT [FK_tb_QuizDetail_tb_Quiz] FOREIGN KEY([id_Quiz])
REFERENCES [dbo].[tb_Quiz] ([id])
GO
ALTER TABLE [dbo].[tb_QuizDetail] CHECK CONSTRAINT [FK_tb_QuizDetail_tb_Quiz]
GO
ALTER TABLE [dbo].[tb_QuizDetail]  WITH CHECK ADD  CONSTRAINT [FK_tb_QuizDetail_tb_SubQuestion] FOREIGN KEY([id_SubQuestion])
REFERENCES [dbo].[tb_SubQuestion] ([id])
GO
ALTER TABLE [dbo].[tb_QuizDetail] CHECK CONSTRAINT [FK_tb_QuizDetail_tb_SubQuestion]
GO
ALTER TABLE [dbo].[tb_SubQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tb_SubQuestion_tb_Question] FOREIGN KEY([id_Question])
REFERENCES [dbo].[tb_Question] ([id])
GO
ALTER TABLE [dbo].[tb_SubQuestion] CHECK CONSTRAINT [FK_tb_SubQuestion_tb_Question]
GO
USE [master]
GO
ALTER DATABASE [ToiecTest] SET  READ_WRITE 
GO
