USE [master]
GO
/****** Object:  Database [Quiz]    Script Date: 5/31/2017 1:58:50 PM ******/
CREATE DATABASE [Quiz]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Quiz', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Quiz.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Quiz_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Quiz_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  StoredProcedure [dbo].[sp_Answer_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_Answer_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_Answer WHERE id=@id
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Answer_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
			Select @strTop=' 100 percent '
		END
	Select @SQL= ' SELECT top '+ @strTop +'tb_Answer.*, (select [content] from tb_SubQuestion where subQuestionID = tb_SubQuestion.id and active = 1) as ''subquestionName'' FROM [tb_Answer]'
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
/****** Object:  StoredProcedure [dbo].[sp_Answer_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Answer_Insert]
	@subQuestionID int,
	@answer ntext,
	@isCorrect bit
AS
	BEGIN
		INSERT INTO tb_Answer(subQuestionID,answer,isCorrect) VALUES (@subQuestionID,@answer,@isCorrect)
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_Answer_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Answer_Update]
	@id int,
	@subQuestionID int,
	@answer ntext,
	@isCorrect bit
AS
	BEGIN
		UPDATE tb_Answer SET
		subQuestionID=@subQuestionID,
		answer=@answer,
		isCorrect=@isCorrect
	WHERE id=@id
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_Class_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Class_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
			Select @strTop=' 100 percent '
		END
	Select @SQL= ' SELECT top '+ @strTop +' tb_Class.*,(select [facultyName] from tb_Faculty where facultyID = tb_Faculty.id) as ''facultyName'' FROM [tb_Class] '
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + ' Where ' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +' Order by '+@Order
		END
	EXEC(@SQL)



GO
/****** Object:  StoredProcedure [dbo].[sp_Class_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Class_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Faculty_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Faculty_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
			Select @strTop=' 100 percent '
		END
	Select @SQL= 'SELECT top '+ @strTop +' * FROM [tb_Faculty]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + ' Where ' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +' Order by '+@Order
		END
	EXEC(@SQL)


GO
/****** Object:  StoredProcedure [dbo].[sp_Faculty_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Faculty_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Image_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Image_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Image_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Image_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Level_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Level_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
			Select @strTop=' 100 percent '
		END
	Select @SQL= 'SELECT top '+ @strTop +' * FROM [tb_Level] '
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL +  'Where ' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +' Order by '+@Order
		END
	EXEC(@SQL)


GO
/****** Object:  StoredProcedure [dbo].[sp_Level_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Level_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Question_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Question_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
			Select @strTop=' 100 percent '
		END
	Select @SQL= ' SELECT top '+ @strTop +'tb_Question.* ,(select [subjectName] from tb_Subject where subjectID = tb_Subject.id) as ''subjectName'', 
	(select [topicName] from tb_Topic where topicID = tb_Topic.id) as ''topicName'', (select [detail] from tb_Level where levelID = tb_Level.id) as ''levelName'' FROM [tb_Question]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + ' Where ' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +' Order by '+@Order
		END
	EXEC(@SQL)


GO
/****** Object:  StoredProcedure [dbo].[sp_Question_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Question_Insert]
	@subjectID int,
	@topicID int,
	@levelID int,
	@content ntext,
	@createDate date
AS
	BEGIN
		INSERT INTO tb_Question VALUES (@subjectID,@topicID,@levelID,@content,@createDate)
	END



GO
/****** Object:  StoredProcedure [dbo].[sp_Question_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Question_Update]
	@id int,
	@subjectID int,
	@topicID int,
	@levelID int,
	@content ntext,
	@createDate date
AS
	BEGIN
		UPDATE tb_Question SET
		subjectID=@subjectID,
		topicID=@topicID,
		levelID=@levelID,
		content = @content,
		createDate=@createDate
	WHERE id=@id
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_Quiz_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quiz_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quiz_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quiz_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Result_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Result_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Result_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Result_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_search_ClassName]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_search_ClassName]
@classname nvarchar(50)
AS
 select * from tb_Student join tb_Class on tb_Student.classID = tb_Class.id and tb_Class.className like N'%'+@classname+'%'
RETURN
GO
/****** Object:  StoredProcedure [dbo].[sp_Student_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Student_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
			Select @strTop=' 100 percent '
		END
	Select @SQL= ' SELECT top '+ @strTop +'tb_Student.*,(select [className] from tb_Class where classID = tb_Class.id) as ''className'' FROM [tb_Student]'
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
/****** Object:  StoredProcedure [dbo].[sp_Student_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Student_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Subject_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Subject_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
			Select @strTop=' 100 percent '
		END
	Select @SQL= 'SELECT top '+ @strTop +' * FROM [tb_Subject]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + ' Where ' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +' Order by '+@Order
		END
	EXEC(@SQL)


GO
/****** Object:  StoredProcedure [dbo].[sp_Subject_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Subject_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SubQuestion_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SubQuestion_Delete]
	@id int
AS
	BEGIN
		DELETE FROM tb_SubQuestion WHERE id=@id
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_SubQuestion_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SubQuestion_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop='('+ @Top +')'
	if len(@Top)=0
		BEGIN
			Select @strTop=' 100 percent '
		END
	Select @SQL= 'SELECT top '+ @strTop +' tb_SubQuestion.*, (select [content] from tb_Question where questionID = tb_Question.id) as ''questionName'' FROM [tb_SubQuestion]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + ' Where ' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +' Order by '+@Order
		END
	EXEC(@SQL)


GO
/****** Object:  StoredProcedure [dbo].[sp_SubQuestion_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SubQuestion_Insert]
	@questionID int,
	@content ntext,
	@active bit
AS
	BEGIN
		INSERT INTO tb_SubQuestion(questionID,content,active) VALUES (@questionID,@content,@active)
	END



GO
/****** Object:  StoredProcedure [dbo].[sp_SubQuestion_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SubQuestion_Update]
	@id int,
	@questionID int,
	@content ntext,
	@active bit
AS
	BEGIN
		UPDATE tb_SubQuestion SET
		questionID=@questionID,
		content=@content,
		active=@active
	WHERE id=@id
	END


GO
/****** Object:  StoredProcedure [dbo].[sp_Teacher_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Teacher_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
			Select @strTop=' 100 percent '
		END
	Select @SQL= 'SELECT top '+ @strTop +' * FROM [tb_Teacher]'
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + ' Where ' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +' Order by '+@Order
		END
	EXEC(@SQL)




GO
/****** Object:  StoredProcedure [dbo].[sp_Teacher_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Teacher_Insert]
	@name nvarchar(50),
	@username varchar(50),
	@password varchar(50),
	@avatar nvarchar(500)
AS
	BEGIN
		INSERT INTO tb_Teacher VALUES (@name,@username,@password,@avatar)
	END



GO
/****** Object:  StoredProcedure [dbo].[sp_Teacher_LoginValid]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Teacher_LoginValid]
	@username varchar(50),
	@password varchar(50)
AS
BEGIN
	select count(*) from tb_Teacher where username = @username and password = @password
END


GO
/****** Object:  StoredProcedure [dbo].[sp_Teacher_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Teacher_Update]
	@id int,
	@name nvarchar(50),
	@username varchar(50),
	@password varchar(50),
	@avatar text
AS
	BEGIN
		UPDATE tb_Teacher SET
		name=@name,
		username=@username,
		password=@password,
		avatar=@avatar
	WHERE id=@id
	END



GO
/****** Object:  StoredProcedure [dbo].[sp_Topic_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Topic_getByTop]    Script Date: 5/31/2017 1:58:50 PM ******/
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
			Select @strTop=' 100 percent '
		END
	Select @SQL= 'SELECT top ' + @strTop + ' tb_Topic.*
	,(select [subjectName] from tb_Subject where tb_Topic.subjectID = tb_Subject.id) as ''subjectName''
	FROM [tb_Topic] '
	if len(@Where)>0
		BEGIN
			Select @SQL= @SQL + ' Where ' + @Where
		END
	if len(@Order)>0
		BEGIN
			Select @SQL=@SQL +' Order by '+@Order
		END
	EXEC(@SQL)



GO
/****** Object:  StoredProcedure [dbo].[sp_Topic_Insert]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Topic_Insert]
	@subjectID int,
	@topicName nvarchar(200)
AS
	BEGIN
		INSERT INTO tb_Topic(topicName,subjectID) VALUES (@topicName,@subjectID)
	END



GO
/****** Object:  StoredProcedure [dbo].[sp_Topic_Update]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  Table [dbo].[tb_Answer]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Answer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subQuestionID] [int] NOT NULL,
	[answer] [ntext] NOT NULL,
	[isCorrect] [bit] NULL,
 CONSTRAINT [PK_tb_Answer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Class]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  Table [dbo].[tb_Exam]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Exam](
	[id] [int] NOT NULL,
	[quizID] [int] NULL,
	[questionList] [varchar](500) NULL,
	[createDate] [datetime] NULL,
	[createBy] [int] NULL,
 CONSTRAINT [PK_tb_Exam] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Faculty]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  Table [dbo].[tb_Image]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Image](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[url] [nvarchar](500) NULL,
	[subquestionID] [int] NULL,
 CONSTRAINT [PK_tb_Image] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Level]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  Table [dbo].[tb_Question]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Question](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subjectID] [int] NULL,
	[topicID] [int] NULL,
	[levelID] [int] NULL,
	[content] [ntext] NULL,
	[createDate] [date] NULL,
 CONSTRAINT [PK_tb_CauHoi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Quiz]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Quiz](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subjectID] [int] NULL,
	[quizName] [nvarchar](50) NULL,
	[questionCount] [int] NULL,
	[time] [text] NULL,
	[teacherID] [int] NULL,
 CONSTRAINT [PK_tb_Quiz] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Result]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Result](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[studentExamID] [int] NULL,
	[score] [float] NULL,
 CONSTRAINT [PK_tb_Result] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_ResultDetail]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ResultDetail](
	[id] [int] NULL,
	[resultID] [int] NULL,
	[SubQuestionID] [int] NULL,
	[studentAnswerID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Student]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  Table [dbo].[tb_Student_Exam]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Student_Exam](
	[id] [int] NOT NULL,
	[examID] [int] NULL,
	[studentID] [int] NULL,
	[flag] [int] NULL,
	[startTime] [datetime] NULL,
 CONSTRAINT [PK_tb_Student_Exam] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Subject]    Script Date: 5/31/2017 1:58:50 PM ******/
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
/****** Object:  Table [dbo].[tb_SubQuestion]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_SubQuestion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[questionID] [int] NULL,
	[content] [ntext] NULL,
	[reportCount] [int] NULL,
	[active] [bit] NULL,
 CONSTRAINT [PK_tb_SubQuestion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Teacher]    Script Date: 5/31/2017 1:58:50 PM ******/
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
	[avatar] [nvarchar](500) NULL,
 CONSTRAINT [PK_tb_Teacher] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Topic]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Topic](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[topicName] [nvarchar](200) NULL,
	[subjectID] [int] NULL,
 CONSTRAINT [PK_tbChuDe] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tb_Answer] ON 

INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (3, 3, N'2', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (8, 1, N'3', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (9, 3, N'3', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (10, 3, N'4', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (12, 3, N'5', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (13, 1, N'3', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (15, 8, N'2', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (16, 8, N'3', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (18, 9, N'3', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (19, 9, N'4', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (21, 3, N'ghjgjjh', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (22, 3, N'jkhk', 0)
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

INSERT [dbo].[tb_Question] ([id], [subjectID], [topicID], [levelID], [content], [createDate]) VALUES (2, 1, 7, 1, N'Điền vào chỗ trống ', CAST(0x9D3C0B00 AS Date))
INSERT [dbo].[tb_Question] ([id], [subjectID], [topicID], [levelID], [content], [createDate]) VALUES (3, 2, 9, 2, N'2', CAST(0xDD3C0B00 AS Date))
INSERT [dbo].[tb_Question] ([id], [subjectID], [topicID], [levelID], [content], [createDate]) VALUES (6, 4, 7, 2, N'4', CAST(0xDF3C0B00 AS Date))
INSERT [dbo].[tb_Question] ([id], [subjectID], [topicID], [levelID], [content], [createDate]) VALUES (7, 4, 7, 2, N'Test', CAST(0xDF3C0B00 AS Date))
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
INSERT [dbo].[tb_Student] ([id], [fullname], [username], [password], [classID], [status]) VALUES (18, N'1', N'1', N'1', 1, N'1')
SET IDENTITY_INSERT [dbo].[tb_Student] OFF
SET IDENTITY_INSERT [dbo].[tb_Subject] ON 

INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (1, N'Mạng máy tính')
INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (2, N'Tiếng anh 1')
INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (3, N'Tiếng anh 2')
INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (4, N'Kỹ thuật điện đại cương')
SET IDENTITY_INSERT [dbo].[tb_Subject] OFF
SET IDENTITY_INSERT [dbo].[tb_SubQuestion] ON 

INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (1, 2, N'2', 2, 0)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (3, 3, N'3', 3, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (8, 2, N'1', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (9, 2, N'3', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (10, 2, N'4', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (11, 2, N'5', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (12, 2, N'6', 0, 0)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (13, 2, N'7', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (14, 2, N'8', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (15, 2, N'9', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (16, 2, N'10', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (17, 2, N'11', 0, 0)
SET IDENTITY_INSERT [dbo].[tb_SubQuestion] OFF
SET IDENTITY_INSERT [dbo].[tb_Teacher] ON 

INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password], [avatar]) VALUES (1, N'Nguyễn Thị Vân Giang', N'giang', N'giang', N'D:\Picture\Desktop\niem-tin-vao-cuoc-song.jpg')
INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password], [avatar]) VALUES (2, N'Nguyễn Văn Hiếu', N'hieu', N'hieu', N'D:\Picture\Desktop\20170109-111642-hinh6_600x483-1.jpg')
INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password], [avatar]) VALUES (3, N'1', N'1', N'1', NULL)
INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password], [avatar]) VALUES (5, N's', N'ssss', N'sss', N'D:\Picture\Desktop\20170109-111328-hinh2_600x750-1.jpg')
SET IDENTITY_INSERT [dbo].[tb_Teacher] OFF
SET IDENTITY_INSERT [dbo].[tb_Topic] ON 

INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (7, N'Topic 1', 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (8, N'Topic 2', 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (9, N'Topic 3', 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (10, N'Topic 4', 1)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (11, N'Topic 1', 2)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (12, N'Topic 2', 2)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (13, N'Topic 3', 2)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (14, N'Topic 4', 2)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (15, N'Topic 1', 3)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (16, N'Topic 2', 3)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (17, N'Topic 3', 3)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (18, N'Topic 1', 4)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (19, N'Topic 2', 4)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (20, N'Topic 3', 4)
INSERT [dbo].[tb_Topic] ([id], [topicName], [subjectID]) VALUES (21, N'Topic 4', 4)
SET IDENTITY_INSERT [dbo].[tb_Topic] OFF
ALTER TABLE [dbo].[tb_Answer] ADD  CONSTRAINT [DF_tb_Answer_isCorrect]  DEFAULT ((0)) FOR [isCorrect]
GO
ALTER TABLE [dbo].[tb_Question] ADD  CONSTRAINT [DF_tb_Question_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[tb_SubQuestion] ADD  CONSTRAINT [DF_tb_SubQuestion_reportCount]  DEFAULT ((0)) FOR [reportCount]
GO
ALTER TABLE [dbo].[tb_SubQuestion] ADD  CONSTRAINT [DF_tb_SubQuestion_active]  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[tb_Answer]  WITH CHECK ADD  CONSTRAINT [FK_tb_Answer_tb_SubQuestion] FOREIGN KEY([subQuestionID])
REFERENCES [dbo].[tb_SubQuestion] ([id])
GO
ALTER TABLE [dbo].[tb_Answer] CHECK CONSTRAINT [FK_tb_Answer_tb_SubQuestion]
GO
ALTER TABLE [dbo].[tb_Class]  WITH CHECK ADD  CONSTRAINT [FK_tb_Class_tb_Faculty] FOREIGN KEY([facultyID])
REFERENCES [dbo].[tb_Faculty] ([id])
GO
ALTER TABLE [dbo].[tb_Class] CHECK CONSTRAINT [FK_tb_Class_tb_Faculty]
GO
ALTER TABLE [dbo].[tb_Exam]  WITH CHECK ADD  CONSTRAINT [FK_tb_Exam_tb_Quiz] FOREIGN KEY([quizID])
REFERENCES [dbo].[tb_Quiz] ([id])
GO
ALTER TABLE [dbo].[tb_Exam] CHECK CONSTRAINT [FK_tb_Exam_tb_Quiz]
GO
ALTER TABLE [dbo].[tb_Image]  WITH CHECK ADD  CONSTRAINT [FK_tb_Image_tb_SubQuestion] FOREIGN KEY([subquestionID])
REFERENCES [dbo].[tb_SubQuestion] ([id])
GO
ALTER TABLE [dbo].[tb_Image] CHECK CONSTRAINT [FK_tb_Image_tb_SubQuestion]
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
ALTER TABLE [dbo].[tb_Result]  WITH CHECK ADD  CONSTRAINT [FK_tb_Result_tb_Student_Exam] FOREIGN KEY([studentExamID])
REFERENCES [dbo].[tb_Student_Exam] ([id])
GO
ALTER TABLE [dbo].[tb_Result] CHECK CONSTRAINT [FK_tb_Result_tb_Student_Exam]
GO
ALTER TABLE [dbo].[tb_ResultDetail]  WITH CHECK ADD  CONSTRAINT [FK_tb_ResultDetail_tb_Result] FOREIGN KEY([resultID])
REFERENCES [dbo].[tb_Result] ([id])
GO
ALTER TABLE [dbo].[tb_ResultDetail] CHECK CONSTRAINT [FK_tb_ResultDetail_tb_Result]
GO
ALTER TABLE [dbo].[tb_Student]  WITH CHECK ADD  CONSTRAINT [FK_tb_Student_tb_Class] FOREIGN KEY([classID])
REFERENCES [dbo].[tb_Class] ([id])
GO
ALTER TABLE [dbo].[tb_Student] CHECK CONSTRAINT [FK_tb_Student_tb_Class]
GO
ALTER TABLE [dbo].[tb_Student_Exam]  WITH CHECK ADD  CONSTRAINT [FK_tb_Student_Exam_tb_Exam] FOREIGN KEY([examID])
REFERENCES [dbo].[tb_Exam] ([id])
GO
ALTER TABLE [dbo].[tb_Student_Exam] CHECK CONSTRAINT [FK_tb_Student_Exam_tb_Exam]
GO
ALTER TABLE [dbo].[tb_Student_Exam]  WITH CHECK ADD  CONSTRAINT [FK_tb_Student_Exam_tb_Student] FOREIGN KEY([studentID])
REFERENCES [dbo].[tb_Student] ([id])
GO
ALTER TABLE [dbo].[tb_Student_Exam] CHECK CONSTRAINT [FK_tb_Student_Exam_tb_Student]
GO
ALTER TABLE [dbo].[tb_SubQuestion]  WITH CHECK ADD  CONSTRAINT [FK_tb_SubQuestion_tb_Question] FOREIGN KEY([questionID])
REFERENCES [dbo].[tb_Question] ([id])
GO
ALTER TABLE [dbo].[tb_SubQuestion] CHECK CONSTRAINT [FK_tb_SubQuestion_tb_Question]
GO
ALTER TABLE [dbo].[tb_Topic]  WITH CHECK ADD  CONSTRAINT [FK_tb_Topic_tb_Subject] FOREIGN KEY([subjectID])
REFERENCES [dbo].[tb_Subject] ([id])
GO
ALTER TABLE [dbo].[tb_Topic] CHECK CONSTRAINT [FK_tb_Topic_tb_Subject]
GO
/****** Object:  Trigger [dbo].[tg_Insert_Answer]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tg_Insert_Answer]
   ON  [dbo].[tb_Answer]
   for INSERT, UPDATE
AS
BEGIN
	
	update tb_Answer set isCorrect = 0 where isCorrect is null
END


GO
/****** Object:  Trigger [dbo].[tg_Question_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tg_Question_Delete]
on [dbo].[tb_Question]
instead of delete
as
begin
	declare @id int=(select id from deleted);
	delete from tb_SubQuestion where questionID=@id;
	delete from tb_Question where id=@id;
end
GO
/****** Object:  Trigger [dbo].[tg_SubQuestion_Delete]    Script Date: 5/31/2017 1:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tg_SubQuestion_Delete]
on [dbo].[tb_SubQuestion]
instead of delete
as
begin
	declare @id int=(select id from deleted);
	delete from tb_Answer where subQuestionID=@id;
	delete from tb_SubQuestion where id=@id;
end
GO
USE [master]
GO
ALTER DATABASE [Quiz] SET  READ_WRITE 
GO
