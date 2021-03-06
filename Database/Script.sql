USE [master]
GO
/****** Object:  Database [Quiz]    Script Date: 3/6/2017 8:09:31 PM ******/
CREATE DATABASE [Quiz]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Quiz', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Quiz.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Quiz_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Quiz_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Quiz] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Quiz].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Quiz] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Quiz] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Quiz] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Quiz] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Quiz] SET ARITHABORT OFF 
GO
ALTER DATABASE [Quiz] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Quiz] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Quiz] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Quiz] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Quiz] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Quiz] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Quiz] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Quiz] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Quiz] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Quiz] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Quiz] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Quiz] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Quiz] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Quiz] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Quiz] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Quiz] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Quiz] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Quiz] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Quiz] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Quiz] SET  MULTI_USER 
GO
ALTER DATABASE [Quiz] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Quiz] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Quiz] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Quiz] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Quiz]
GO
/****** Object:  StoredProcedure [dbo].[sp_Answer_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Answer_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Answer WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Answer_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Answer_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Answer]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)

GO
/****** Object:  StoredProcedure [dbo].[sp_Answer_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Answer_Insert]
	@questionID int,
	@answer ntext,
	@isCorrect int
AS
	BEGIN
		INSERT INTO tb_Answer VALUES (@questionID,@answer,@isCorrect)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Answer_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Answer_Update]
	@id int,
	@questionID int,
	@answer ntext,
	@isCorrect int
AS
	BEGIN
		UPDATE tb_Answer SET
		questionID=@questionID,
		answer=@answer,
		isCorrect=@isCorrect
	WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Class_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Class_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Class WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Class_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Class_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Class]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)

GO
/****** Object:  StoredProcedure [dbo].[sp_Class_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Class_Insert]
	@className nvarchar(50),
	@facultyID int
AS
	BEGIN
		INSERT INTO tb_Class VALUES (@className,@facultyID)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Class_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Class_Update]
	@id int,
	@className nvarchar(50),
	@facultyID int
AS
	BEGIN
		UPDATE tb_Class SET
		className=@className,
		facultyID=@facultyID
	WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Faculty_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Faculty_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Faculty WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Faculty_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Faculty_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Faculty]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)
GO
/****** Object:  StoredProcedure [dbo].[sp_Faculty_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Faculty_Insert]
	@facultyName nvarchar(50)
AS
	BEGIN
		INSERT INTO tb_Faculty VALUES (@facultyName)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Faculty_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Faculty_Update]
	@id int,
	@facultyName nvarchar(50)
AS
	BEGIN
		UPDATE tb_Faculty SET
		facultyName=@facultyName
	WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Image_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Image_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Image WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Image_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Image_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Image]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)
GO
/****** Object:  StoredProcedure [dbo].[sp_Image_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Image_Insert]
	@url ntext,
	@questionID int,
	@alt ntext
AS
	BEGIN
		INSERT INTO tb_Image(url,questionID,alt) VALUES (@url,@questionID,@alt)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Image_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Image_Update]
	@id int,
	@url ntext,
	@questionID int,
	@alt ntext
AS
	BEGIN
		UPDATE tb_Image SET
		url=@url,
		questionID=@questionID,
		alt=@alt
		WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Level_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Level_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Level WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Level_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Level_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Level]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)
GO
/****** Object:  StoredProcedure [dbo].[sp_Level_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Level_Insert]
	@detail nvarchar(100)
AS
	BEGIN
		INSERT INTO tb_Level VALUES (@detail)
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Level_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Level_Update]
	@id int,
	@detail nvarchar(100)
AS
	BEGIN
		UPDATE tb_Level SET
		detail=@detail
	WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Question_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Question_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Question WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Question_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Question_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Question]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)
GO
/****** Object:  StoredProcedure [dbo].[sp_Question_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Question_Insert]
	@subjectID int,
	@parent int,
	@topicID int,
	@levelID int,
	@content ntext,
	@reuse int,
	@reportCount int,
	@createDate date,
	@active bit
AS
	BEGIN
		INSERT INTO tb_Question VALUES (@subjectID,@parent,@topicID,@levelID,@content,@reuse,@reportCount,@createDate,@active)
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Question_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Question_Update]
	@id int,
	@subjectID int,
	@parent int,
	@topicID int,
	@levelID int,
	@content ntext,
	@reuse int,
	@reportCount int,
	@createDate date,
	@active bit
AS
	BEGIN
		UPDATE tb_Question SET
		subjectID=@subjectID,
		parent=@parent,
		topicID=@topicID,
		levelID=@levelID,
		content=@content,
		reuse=@reuse,
		reportCount=@reportCount,
		createDate=@createDate,
		active=@active
	WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quiz_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Quiz_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Quiz WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quiz_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Quiz_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Quiz]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)

GO
/****** Object:  StoredProcedure [dbo].[sp_Quiz_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Quiz_Insert]
	@subjectID int,
	@quizName nvarchar(50),
	@questionCount int,
	@timeStart time(7),
	@time text,
	@questionList text,
	@teacherID int
AS
	BEGIN
		INSERT INTO tb_Quiz VALUES (@subjectID,@quizName,@questionCount,@timeStart,@time,@questionList,@teacherID)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Quiz_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Quiz_Update]
	@id int,
	@subjectID int,
	@quizName nvarchar(50),
	@questionCount int,
	@timeStart time(7),
	@time text,
	@questionList text,
	@teacherID int
AS
	BEGIN
		UPDATE tb_Quiz SET
		subjectID=@subjectID,
		quizName=@quizName,
		questionCount=@questionCount,
		timeStart=@timeStart,
		time=@time,
		questionList=@questionList,
		teacherID=@teacherID
	WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Result_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Result_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Result WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Result_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Result_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Result]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)
GO
/****** Object:  StoredProcedure [dbo].[sp_Result_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Result_Insert]
	@studentID int,
	@quizID int,
	@score int,
	@quizDate date,
	@flag int
AS
	BEGIN
		INSERT INTO tb_Result VALUES (@studentID,@quizID,@score,@quizDate,@flag)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Result_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Result_Update]
	@id int,
	@studentID int,
	@quizID int,
	@score int,
	@quizDate date,
	@flag int
AS
	BEGIN
		UPDATE tb_Result SET
		studentID=@studentID,
		quizID=@quizID,
		score=@score,
		quizDate=@quizDate,
		flag=@flag
	WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Student_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Student_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Student WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Student_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Student_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Student]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)
GO
/****** Object:  StoredProcedure [dbo].[sp_Student_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Student_Insert]
	@fullname nvarchar(50),
	@username varchar(50),
	@password varchar(50),
	@classID int,
	@status nvarchar(200)
AS
	BEGIN
		INSERT INTO tb_Student VALUES (@fullname,@username,@password,@classID,@status)
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Student_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Student_Update]
	@id int,
	@fullname nvarchar(50),
	@username varchar(50),
	@password varchar(50),
	@classID int,
	@status nvarchar(200)
AS
	BEGIN
		UPDATE tb_Student SET
		fullname=@fullname,
		username=@username,
		password=@password,
		classID=@classID,
		status=@status
	WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Subject_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Subject_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Subject WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Subject_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Subject_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Subject]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)
GO
/****** Object:  StoredProcedure [dbo].[sp_Subject_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Subject_Insert]
	@subjectName nvarchar(50)
AS
	BEGIN
		INSERT INTO tb_Subject VALUES (@subjectName)
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Subject_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Subject_Update]
	@id int,
	@subjectName nvarchar(50)
AS
	BEGIN
		UPDATE tb_Subject SET
		subjectName=@subjectName
	WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Teacher_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Teacher_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Teacher WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Teacher_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Teacher_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Teacher]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)


GO
/****** Object:  StoredProcedure [dbo].[sp_Teacher_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Teacher_Insert]
	@name nvarchar(50),
	@username varchar(50),
	@password varchar(50)
AS
	BEGIN
		INSERT INTO tb_Teacher VALUES (@name,@username,@password)
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Teacher_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Teacher_Update]
	@id int,
	@name nvarchar(50),
	@username varchar(50),
	@password varchar(50)
AS
	BEGIN
		UPDATE tb_Teacher SET
		name=@name,
		username=@username,
		password=@password
	WHERE id=@id
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Topic_Delete]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Topic_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Topic WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Topic_getByTop]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Topic_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop='100 percent'
		END
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [tb_Topic]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + 'Where' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +'Order by'+@Order
		END
	EXEC(@SQL)
GO
/****** Object:  StoredProcedure [dbo].[sp_Topic_Insert]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Topic_Insert]
	@subjectID int,
	@topicName nvarchar(200)
AS
	BEGIN
		INSERT INTO tb_Topic VALUES (@subjectID,@topicName)
	END

GO
/****** Object:  StoredProcedure [dbo].[sp_Topic_Update]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Topic_Update]
	@id int,
	@subjectID int,
	@topicName nvarchar(200)
AS
	BEGIN
		UPDATE tb_Topic SET
		subjectID=@subjectID,
		topicName=@topicName
	WHERE id=@id
END
GO
/****** Object:  Table [dbo].[tb_Answer]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Answer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[questionID] [int] NOT NULL,
	[answer] [ntext] NOT NULL,
	[isCorrect] [bit] NULL,
 CONSTRAINT [PK_tb_Answer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Class]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Class](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[className] [nvarchar](50) NULL,
	[facultyID] [int] NULL,
 CONSTRAINT [PK_tb_Class] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Faculty]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Faculty](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[facultyName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_Faculty] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Image]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Image](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[url] [ntext] NULL,
	[questionID] [int] NULL,
	[alt] [ntext] NULL,
 CONSTRAINT [PK_tb_Image] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Level]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Level](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[detail] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_DoKho] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Question]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Question](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subjectID] [int] NULL,
	[parent] [int] NULL,
	[topicID] [int] NULL,
	[levelID] [int] NULL,
	[content] [ntext] NULL,
	[reuse] [int] NULL,
	[reportCount] [int] NULL,
	[createDate] [date] NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_tb_CauHoi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Quiz]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Quiz](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subjectID] [int] NULL,
	[quizName] [nvarchar](50) NULL,
	[questionCount] [int] NULL,
	[timeStart] [time](7) NULL,
	[time] [text] NULL,
	[questionList] [text] NULL,
	[teacherID] [int] NULL,
 CONSTRAINT [PK_tb_Quiz] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Result]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Result](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[studentID] [int] NULL,
	[quizID] [int] NULL,
	[score] [int] NULL,
	[quizDate] [date] NULL,
	[flag] [int] NULL,
 CONSTRAINT [PK_tb_Result] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Student]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Student](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[fullname] [nvarchar](50) NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[classID] [int] NULL,
	[status] [nvarchar](200) NULL,
 CONSTRAINT [PK_tbSinhVien] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Subject]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Subject](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subjectName] [nvarchar](100) NULL,
 CONSTRAINT [PK_tbMonHoc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Teacher]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Teacher](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
 CONSTRAINT [PK_tb_Teacher] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Topic]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Topic](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subjectID] [int] NULL,
	[topicName] [nvarchar](200) NULL,
 CONSTRAINT [PK_tbChuDe] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tb_Answer] ON 

INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (1, 3, N'Nhu cầu trao đổi thông tin ngày càng tăng ', 0)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (2, 3, N'Khối lượng thông tin lưu trên máy tính ngày càng tăng', 0)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (3, 3, N'Khoa học và công nghệ về lĩnh vực máy tính và truyền thông phát triển', 0)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (4, 3, N'Cả ba câu trên đúng (đáp án)', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (5, 4, N'Nâng cao độ tin cậy của hệ thống máy tính   ', 0)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (6, 4, N'Trao đổi và chia sẻ thông tin', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (7, 4, N'Phát triển ứng dụng trên máy tính   ', 0)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (8, 4, N'Nâng cao chất lượng khai thác thông tin', 0)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (9, 5, N'LAN (Local Area Network)', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (10, 5, N'MAN (Metropolitan Area Network)                  ', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (11, 5, N'WAN (Wide Area Network)                    ', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (12, 5, N'GAN (Global Area Network)', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (13, 6, N'LAN (Local Area Network)              ', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (14, 6, N'MAN (Metropolitan Area Network)                   ', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (15, 6, N'WAN (Wide Area Network)                 ', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (16, 6, N'GAN (Global Area Network)', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (17, 7, N'Khoảng cách địa lý', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (18, 7, N'Giao thức truyền thông     ', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (19, 7, N'Thiết bị mạng                      ', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (20, 7, N'Đường truyền mạng  ', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (21, 8, N'Kết nối các máy tính trong phạm vi một thành phố hay một trung tâm kinh tế', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (22, 8, N'Kết nối các máy tính trong phạm vi một quốc gia hoặc trong một châu lục.', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (23, 8, N'Kết nối các máy tính trong phạm vi toàn cầu.', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (24, 8, N'Kết nối các máy tính trong phạm hẹp như một toà nhà, trường học…', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (25, 9, N'Kết nối các máy tính trong phạm hẹp như một toà nhà, trường học…', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (26, 9, N'Kết nối các máy tính trong phạm vi một thành phố hay một trung tâm kinh tế.', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (27, 9, N'Kết nối các máy tính trong phạm vi một quốc gia hoặc trong một châu lục.', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (28, 9, N'Kết nối các máy tính trong phạm vi toàn cầu.', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (29, 10, N'Kết nối các máy tính trong phạm hẹp như một toà nhà, trường học…', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (30, 10, N'Kết nối các máy tính trong phạm vi một thành phố hay một trung tâm kinh tế.', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (31, 10, N'Kết nối các máy tính trong phạm vi một quốc gia hoặc trong một châu lục.', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (32, 10, N'Kết nối các máy tính trong phạm vi toàn cầu.', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (33, 11, N'LAN', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (34, 11, N'WAN', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (35, 11, N'GAN', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (36, 11, N'MAN', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (37, 12, N'Mạng LAN', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (38, 12, N'Mạng WAN', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (39, 12, N'Mạng Internet', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (40, 12, N'Mạng MAN', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (41, 13, N'Chương trình, dữ liệu', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (42, 13, N'Máy in ,scanner,...', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (43, 13, N'Ổ đĩa CD ROM', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (44, 13, N'Tất cả các tài nguyên trên', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (45, 14, N'Telnet', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (46, 14, N'Command Prompt', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (47, 14, N'Service', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (48, 14, N'Computer Mângement', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (49, 15, N'Xây dựng và lắp đặt các thiết bị truyền thông', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (50, 15, N'Xây dựng và lắp đặt các cáp truyền thông hoặc là lắp đặt các thiết bị hỗ trợ truyền thông vô tuyến', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (51, 15, N'Cài đặt và cấu hình các phần mềm giao thức mạng', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (52, 15, N'Tất cả các công việc trên', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (53, 16, N'Nhằm để tránh các truy nhập bất hợp pháp từ ngoài mạng', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (54, 16, N'Nhằm để tránh các lỗi do bản thân mạng sinh ra', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (55, 16, N'Nhằm để nâng cao tốc độ truyền thông', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (56, 16, N'Nhằm để nâng cao hiệu suất truyền thông', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (57, 17, N'máy tính, hệ thống đường truyền vật lý', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (58, 17, N'Các thiết bị mạng như Hub, Switch, Router…', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (59, 17, N'Giao thức mạng', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (60, 17, N'Tất cả thành phần trên ', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (61, 18, N'Do hai máy tính cài đặt hai hệ điều hành khác nhau?', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (62, 18, N'Do hai máy tính không được cài đặt cùng giao thức trao đổi thông tin.', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (63, 18, N'Do hai máy tính đó có cấu hình phần cứng khác nhau', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (64, 18, N'Câu a và câu c đúng', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (65, 19, N'Tắc nghẽn truyền thông?', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (66, 19, N'Chuẩn hoá và chuyển đổi giao thức', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (67, 19, N'Xử lý lỗi truyền thông', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (68, 19, N'Cả ba vấn đề trên ', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (69, 20, N'Internet Explore', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (70, 20, N'BkavPro', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (71, 20, N'Symantec Antivirus', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (72, 20, N'Cả 3 ứng dụng trên', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (73, 21, N'Datagram ', 1)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (74, 21, N'Dlink', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (75, 21, N'Frame', NULL)
INSERT [dbo].[tb_Answer] ([id], [questionID], [answer], [isCorrect]) VALUES (76, 21, N'Ethernet', NULL)
SET IDENTITY_INSERT [dbo].[tb_Answer] OFF
SET IDENTITY_INSERT [dbo].[tb_Class] ON 

INSERT [dbo].[tb_Class] ([id], [className], [facultyID]) VALUES (1, N'D9CNPM', 1)
INSERT [dbo].[tb_Class] ([id], [className], [facultyID]) VALUES (2, N'D9TMDT', 1)
INSERT [dbo].[tb_Class] ([id], [className], [facultyID]) VALUES (3, N'D9QTANM', 1)
INSERT [dbo].[tb_Class] ([id], [className], [facultyID]) VALUES (4, N'D9QLNL1', 5)
INSERT [dbo].[tb_Class] ([id], [className], [facultyID]) VALUES (5, N'D9QLNL2', 5)
INSERT [dbo].[tb_Class] ([id], [className], [facultyID]) VALUES (6, N'D9CODT', 2)
INSERT [dbo].[tb_Class] ([id], [className], [facultyID]) VALUES (7, N'D8CODT', 2)
INSERT [dbo].[tb_Class] ([id], [className], [facultyID]) VALUES (8, N'D9QTDN1', 6)
INSERT [dbo].[tb_Class] ([id], [className], [facultyID]) VALUES (9, N'D9QTDN2', 6)
SET IDENTITY_INSERT [dbo].[tb_Class] OFF
SET IDENTITY_INSERT [dbo].[tb_Faculty] ON 

INSERT [dbo].[tb_Faculty] ([id], [facultyName]) VALUES (1, N'Công nghệ thông tin')
INSERT [dbo].[tb_Faculty] ([id], [facultyName]) VALUES (2, N'Cơ khí')
INSERT [dbo].[tb_Faculty] ([id], [facultyName]) VALUES (3, N'Điện hạt nhân')
INSERT [dbo].[tb_Faculty] ([id], [facultyName]) VALUES (4, N'Điện tử viễn thông')
INSERT [dbo].[tb_Faculty] ([id], [facultyName]) VALUES (5, N'Quản lý năng lượng')
INSERT [dbo].[tb_Faculty] ([id], [facultyName]) VALUES (6, N'Tài chính kế toán')
SET IDENTITY_INSERT [dbo].[tb_Faculty] OFF
SET IDENTITY_INSERT [dbo].[tb_Level] ON 

INSERT [dbo].[tb_Level] ([id], [detail]) VALUES (1, N'easy')
INSERT [dbo].[tb_Level] ([id], [detail]) VALUES (2, N'basic')
INSERT [dbo].[tb_Level] ([id], [detail]) VALUES (3, N'advanced')
SET IDENTITY_INSERT [dbo].[tb_Level] OFF
SET IDENTITY_INSERT [dbo].[tb_Question] ON 

INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (3, 1, NULL, 7, 1, N'Nguyên nhân cơ bản nào dẫn đến sự  ra đời của mạng máy tính', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (4, 1, NULL, 7, 1, N'Ý nghĩa cơ bản nhất của mạng máy tính là gì?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (5, 1, NULL, 7, 1, N'Thuật ngữ viết tắt bằng tiếng Anh của mạng cục bộ là gì?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (6, 1, NULL, 7, 1, N'Thuật ngữ viết tắt bằng tiếng Anh của mạng diện rộng là gì?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (7, 1, NULL, 7, 1, N'Các kiểu mạng LAN, MAN, WAN, GAN được phân biệt với nhau bởi tiêu chí phân loại nào?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (8, 1, NULL, 7, 1, N'Mục đích chính của việc xây dựng LAN là gì? ', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (9, 1, NULL, 7, 1, N'Mục đích chính của việc xây dựng WAN là gì?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (10, 1, NULL, 7, 1, N'Mục đích chính của việc xây dựng MAN là gì?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (11, 1, NULL, 7, 1, N'Mạng máy tính EpuNet của Trường Đại học Điện Lực thuộc loại mạng nào?', NULL, 0, CAST(0x693C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (12, 1, NULL, 7, 1, N'Hai máy tính có thể kết nối trực tiếp với nhau để trao đổi thông tin, mạng kết nối 2 máy tính đó thuộc loại mạng nào?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (13, 1, NULL, 7, 1, N'Các tài nguyên nào có thể dùng chung được nhờ có mạng máy tính?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (14, 1, NULL, 7, 1, N'Người ta có thể điều khiển hoạt động của một máy tính từ xa thông qua công cụ nào sau đây?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (15, 1, NULL, 7, 1, N'Sau khi đã khảo sát và thiết kế một mạng máy tính, bước tiếp theo để thiết lập một mạng máy tính, người ta cần phải thực hiện các công việc gì?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (16, 1, NULL, 7, 1, N'Tại sao cần phải xây dựng hệ thống an ninh mạng máy tính?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (17, 1, NULL, 7, 1, N'Các thành phần tạo nên mạng máy tính là gì?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (18, 1, NULL, 7, 1, N'Nguyên nhân nào gây ra việc hai máy tính (kết nối vật lý đã thông) trong mạng không thể trao đổi thông tin với nhau?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (19, 1, NULL, 7, 1, N'Một số vấn đề cơ bản khi mở rộng kết nối mạng?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (20, 1, NULL, 7, 1, N'Ứng dụng nào sau hỗ trợ chức năng cập nhật phiên bản mới qua mạng?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
INSERT [dbo].[tb_Question] ([id], [subjectID], [parent], [topicID], [levelID], [content], [reuse], [reportCount], [createDate], [active]) VALUES (21, 1, NULL, 7, 1, N'Gói tin tại tầng mạng trong bộ giao thức TCP/IP có tên gọi là gì?', NULL, 0, CAST(0x493C0B00 AS Date), NULL)
SET IDENTITY_INSERT [dbo].[tb_Question] OFF
SET IDENTITY_INSERT [dbo].[tb_Student] ON 

INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (1, N'Nguyễn Văn Hiếu', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (2, N'Nguyễn Thị Vân Giang', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (3, N'Trịnh Đức Dương', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (4, N'Phạm Xuân Duy', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (5, N'Nguyễn Văn Dương', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (6, N'Lại Thanh Bình', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (7, N'Lê Tiến Hoàn', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (8, N'Đào Văn Hiệp', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (9, N'Nguyễn Thị Dương', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (10, N'Nguyễn Bảo Châu', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (11, N'Hán Đình Đôn', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (12, N'Nguyễn Văn Hồng', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (13, N'Công Xuân Đức', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (14, N'Hàn Tiến Mạnh Tùng', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (15, N'Nguyễn Đức Giang', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (16, N'Kim Văn Sáng', NULL, NULL, 1, NULL)
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (17, N'Nguyễn Hải Đăng', NULL, NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[tb_Student] OFF
SET IDENTITY_INSERT [dbo].[tb_Subject] ON 

INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (1, N'Mạng máy tính')
INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (2, N'Tiếng anh 1')
INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (3, N'Tiếng anh 2')
INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (4, N'Kỹ thuật điện đại cương')
SET IDENTITY_INSERT [dbo].[tb_Subject] OFF
SET IDENTITY_INSERT [dbo].[tb_Teacher] ON 

INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password]) VALUES (1, N'Nguyễn Thị Vân Giang', N'giang', N'giang')
INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password]) VALUES (2, N'Nguyễn Văn Hiếu', N'hieu', N'hieu')
SET IDENTITY_INSERT [dbo].[tb_Teacher] OFF
SET IDENTITY_INSERT [dbo].[tb_Topic] ON 

INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (7, 1, N'Topic 1')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (8, 1, N'Topic 2')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (9, 1, N'Topic 3')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (10, 1, N'Topic 4')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (11, 2, N'Topic 1')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (12, 2, N'Topic 2')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (13, 2, N'Topic 3')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (14, 2, N'Topic 4')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (15, 3, N'Topic 1')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (16, 3, N'Topic 2')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (17, 3, N'Topic 3')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (18, 4, N'Topic 1')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (19, 4, N'Topic 2')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (20, 4, N'Topic 3')
INSERT [dbo].[tb_Topic] ([id], [subjectID], [topicName]) VALUES (21, 4, N'Topic 4')
SET IDENTITY_INSERT [dbo].[tb_Topic] OFF
ALTER TABLE [dbo].[tb_Answer]  WITH CHECK ADD  CONSTRAINT [FK_tb_Answer_tb_Question] FOREIGN KEY([questionID])
REFERENCES [dbo].[tb_Question] ([id])
GO
ALTER TABLE [dbo].[tb_Answer] CHECK CONSTRAINT [FK_tb_Answer_tb_Question]
GO
ALTER TABLE [dbo].[tb_Class]  WITH CHECK ADD  CONSTRAINT [FK_tb_Class_tb_Faculty] FOREIGN KEY([facultyID])
REFERENCES [dbo].[tb_Faculty] ([id])
GO
ALTER TABLE [dbo].[tb_Class] CHECK CONSTRAINT [FK_tb_Class_tb_Faculty]
GO
ALTER TABLE [dbo].[tb_Image]  WITH CHECK ADD  CONSTRAINT [FK_tb_Image_tb_Question] FOREIGN KEY([questionID])
REFERENCES [dbo].[tb_Question] ([id])
GO
ALTER TABLE [dbo].[tb_Image] CHECK CONSTRAINT [FK_tb_Image_tb_Question]
GO
ALTER TABLE [dbo].[tb_Question]  WITH CHECK ADD  CONSTRAINT [FK_tb_Question_tb_Level] FOREIGN KEY([levelID])
REFERENCES [dbo].[tb_Level] ([id])
GO
ALTER TABLE [dbo].[tb_Question] CHECK CONSTRAINT [FK_tb_Question_tb_Level]
GO
ALTER TABLE [dbo].[tb_Question]  WITH CHECK ADD  CONSTRAINT [FK_tb_Question_tb_Subject] FOREIGN KEY([subjectID])
REFERENCES [dbo].[tb_Subject] ([id])
GO
ALTER TABLE [dbo].[tb_Question] CHECK CONSTRAINT [FK_tb_Question_tb_Subject]
GO
ALTER TABLE [dbo].[tb_Question]  WITH CHECK ADD  CONSTRAINT [FK_tb_Question_tb_Topic] FOREIGN KEY([topicID])
REFERENCES [dbo].[tb_Topic] ([id])
GO
ALTER TABLE [dbo].[tb_Question] CHECK CONSTRAINT [FK_tb_Question_tb_Topic]
GO
ALTER TABLE [dbo].[tb_Quiz]  WITH CHECK ADD  CONSTRAINT [FK_tb_Quiz_tb_Subject] FOREIGN KEY([subjectID])
REFERENCES [dbo].[tb_Subject] ([id])
GO
ALTER TABLE [dbo].[tb_Quiz] CHECK CONSTRAINT [FK_tb_Quiz_tb_Subject]
GO
ALTER TABLE [dbo].[tb_Quiz]  WITH CHECK ADD  CONSTRAINT [FK_tb_Quiz_tb_Teacher] FOREIGN KEY([teacherID])
REFERENCES [dbo].[tb_Teacher] ([id])
GO
ALTER TABLE [dbo].[tb_Quiz] CHECK CONSTRAINT [FK_tb_Quiz_tb_Teacher]
GO
ALTER TABLE [dbo].[tb_Result]  WITH CHECK ADD  CONSTRAINT [FK_tb_Result_tb_Quiz] FOREIGN KEY([quizID])
REFERENCES [dbo].[tb_Quiz] ([id])
GO
ALTER TABLE [dbo].[tb_Result] CHECK CONSTRAINT [FK_tb_Result_tb_Quiz]
GO
ALTER TABLE [dbo].[tb_Result]  WITH CHECK ADD  CONSTRAINT [FK_tb_Result_tb_Student] FOREIGN KEY([studentID])
REFERENCES [dbo].[tb_Student] ([id])
GO
ALTER TABLE [dbo].[tb_Result] CHECK CONSTRAINT [FK_tb_Result_tb_Student]
GO
ALTER TABLE [dbo].[tb_Student]  WITH CHECK ADD  CONSTRAINT [FK_tb_Student_tb_Class] FOREIGN KEY([classID])
REFERENCES [dbo].[tb_Class] ([id])
GO
ALTER TABLE [dbo].[tb_Student] CHECK CONSTRAINT [FK_tb_Student_tb_Class]
GO
ALTER TABLE [dbo].[tb_Topic]  WITH CHECK ADD  CONSTRAINT [FK_tb_Topic_tb_Subject] FOREIGN KEY([subjectID])
REFERENCES [dbo].[tb_Subject] ([id])
GO
ALTER TABLE [dbo].[tb_Topic] CHECK CONSTRAINT [FK_tb_Topic_tb_Subject]
GO
/****** Object:  Trigger [dbo].[tg_Insert_Question]    Script Date: 3/6/2017 8:09:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tg_Insert_Question]
   ON  [dbo].[tb_Question]
   for INSERT, UPDATE
AS
BEGIN
	
	update tb_Question set reuse = 0 where reuse = null
	update tb_Question set parent = 0 where parent = null
	update tb_Question set reportCount = 0 where reportCount = null
	update tb_Question set createDate = CONVERT (date, GETDATE())
	update tb_Question set active = 1 where active = null
END
GO
USE [master]
GO
ALTER DATABASE [Quiz] SET  READ_WRITE 
GO
