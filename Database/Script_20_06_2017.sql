USE [master]
GO
/****** Object:  Database [Quiz]    Script Date: 6/20/2017 8:12:47 PM ******/
CREATE DATABASE [Quiz]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Quiz', FILENAME = N'D:\EPU\c#\Quiz\Database\Quiz.mdf' , SIZE = 4160KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Quiz_log', FILENAME = N'D:\EPU\c#\Quiz\Database\Quiz_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  StoredProcedure [dbo].[sp_Answer_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
	Select @strTop=' ('+ @Top +') '
	if len(@Top)=0
		BEGIN
			Select @strTop=' 100 percent '
		END
	Select @SQL= 'SELECT top '+ @strTop +' * FROM [tb_Answer] '
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
/****** Object:  StoredProcedure [dbo].[sp_Answer_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Answer_Insert]
	@subQuestionID int,
	@answer ntext = null,
	@isCorrect bit = false
AS
	BEGIN
		INSERT INTO tb_Answer VALUES (@subQuestionID,@answer,@isCorrect)
	END



GO
/****** Object:  StoredProcedure [dbo].[sp_Answer_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Class_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Class_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
	Select @strTop=' ('+ @Top +') '
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
/****** Object:  StoredProcedure [dbo].[sp_Class_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Class_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Exam_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Exam_getByTop]
@Top nvarchar(10),
@Where nvarchar(MAX),
@Order nvarchar(200)
AS
	Declare @SQL as nvarchar(500)
	Declare @strTop as nvarchar(100)
	Select @strTop=' ('+ @Top +') '
	if len(@Top)=0
		BEGIN
			Select @strTop=' 100 percent '
		END
	Select @SQL= ' SELECT top '+ @strTop +' tb+_Exam.*,(select quizName from tb_Quiz where quizID = tb_Quiz.id) as ''quizName'' FROM [tb_Quiz] '
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
/****** Object:  StoredProcedure [dbo].[sp_Faculty_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Faculty_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Faculty_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Faculty_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Image_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Image_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Image_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Image_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Level_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Level_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Level_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Level_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Question_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Question_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
	Select @SQL= 'SELECT top '+ @strTop +' * FROM [ViewQuestion]'
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
/****** Object:  StoredProcedure [dbo].[sp_Question_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Question_Insert]
	@subjectID int,
	@content ntext = null,
	@createDate date,
	@id int output
AS
	BEGIN
		INSERT INTO tb_Question VALUES (@subjectID,@content,@createDate)
		select @id = SCOPE_IDENTITY()
	END
GO
/****** Object:  StoredProcedure [dbo].[sp_Question_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Question_Update]
	@id int,
	@subjectID int,
	@content ntext
AS
	BEGIN
		UPDATE tb_Question SET
		subjectID=@subjectID,
		content = @content
	WHERE id=@id
	END



GO
/****** Object:  StoredProcedure [dbo].[sp_Quiz_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quiz_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
	Select @SQL= 'SELECT top'+ @strTop +'* FROM [ViewQuiz]'
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
/****** Object:  StoredProcedure [dbo].[sp_Quiz_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Quiz_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Result_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Result_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Result_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Result_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_search_ClassName]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Student_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Student_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Student_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Student_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Subject_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Subject_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Subject_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Subject_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SubQuestion_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_SubQuestion_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
	Select @SQL= 'SELECT top '+ @strTop +' * FROM [tb_SubQuestion]'
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
/****** Object:  StoredProcedure [dbo].[sp_SubQuestion_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SubQuestion_Insert]
	@questionID int,
	@content ntext,
	@reportCount int = 0,
	@active bit = 1,
	@id int output
AS
	BEGIN
		INSERT INTO tb_SubQuestion VALUES (@questionID,@content,@reportCount,@active)
		select @id = SCOPE_IDENTITY()
	END




GO
/****** Object:  StoredProcedure [dbo].[sp_SubQuestion_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SubQuestion_Update]
	@id int,
	@questionID int,
	@content ntext,
	@reportCount int,
	@active bit
AS
	BEGIN
		UPDATE tb_SubQuestion SET
		questionID=@questionID,
		content=@content,
		reportCount=@reportCount,
		active=@active
	WHERE id=@id
	END



GO
/****** Object:  StoredProcedure [dbo].[sp_Teacher_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Teacher_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Teacher_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Teacher_LoginValid]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Teacher_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Topic_Delete]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Topic_getByTop]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Topic_Insert]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Topic_Update]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Answer]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Class]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Exam]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Faculty]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Image]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Question]    Script Date: 6/20/2017 8:12:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Question](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[subjectID] [int] NULL,
	[content] [ntext] NULL,
	[createDate] [datetime] NULL,
 CONSTRAINT [PK_tb_CauHoi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tb_Quiz]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Result]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_ResultDetail]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Student]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Student_Exam]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Subject]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_SubQuestion]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  Table [dbo].[tb_Teacher]    Script Date: 6/20/2017 8:12:47 PM ******/
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
/****** Object:  View [dbo].[ViewQuestion]    Script Date: 6/20/2017 8:12:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewQuestion]
As
select tb_Question.*, subjectName
from tb_Question, tb_Subject
where tb_Question.subjectID = tb_Subject.id

GO
SET IDENTITY_INSERT [dbo].[tb_Answer] ON 

INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (1, 104, N'Bộ điều khiển ổ đĩa', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (2, 104, N'Bộ phối ghép màn hình', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (3, 104, N'Bộ điều khiển bàn phím', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (4, 104, N'Các thanh ghi đa năng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (5, 105, N'Màn hình', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (6, 105, N'RAM', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (7, 105, N'Đĩa cứng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (8, 105, N'Bàn phím', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (9, 106, N'Cache', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (10, 106, N'Cáp nguồn ổ cứng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (11, 106, N'Giao tiếp cổng USB', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (12, 106, N'Các thanh ghi đa năng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (13, 107, N'Phối ghép các thiết bị ngoại vi với các thành phần khác của máy tính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (14, 107, N'Đảm bảo việc chuyển dữ liệu giữa máy tính và thiết bị ngoại vi', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (15, 107, N'Điều khiển cấp phát bộ vi xử lý cho các thao tác trong môi trường đa nhiệm', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (16, 107, N'Hỗ trợ việc truyền dữ liệu giữa các thiết bị ngoại vi và bộ nhớ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (17, 108, N'Chuyển đổi dữ liệu từ môi trường bên ngoài thành dạng số và đưa vào máy tính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (18, 108, N'Đảm bảo việc trao đổi dữ liệu giữa máy tính và các thiết bị ngoại vi', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (19, 108, N'Tiếp nhận các ngắt từ các thiết bị vào ra dữ liệu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (20, 108, N'Hỗ trợ thiết lập việc truyền dữ liệu giữa các máy tính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (21, 109, N'Tốc độ truy cập nhanh', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (22, 109, N'Dung lượng nhỏ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (23, 109, N'Không mất dữ liệu khi mất nguồn', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (24, 109, N'Giá thành cao', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (25, 110, N'Bộ nhớ bán dẫn', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (26, 110, N'Bộ nhớ từ, quang hoặc quang từ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (27, 110, N'Hiện tượng từ trễ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (28, 110, N'Hiệu ứng dòng Fucô', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (29, 111, N'Các bit 1 và 0 tương ứng với các trạng thái nhiễm từ khác nhau của vật liệu từ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (30, 111, N'Các bit 1 và 0 tương ứng với các giá trị điện áp khác nhau trên vật liệu từ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (31, 111, N'Các bit 1 và 0 tương ứng với các momen lực từ khác nhau tác động lên đầu đọc', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (32, 111, N'Các bit 1 và 0 tương ứng với tốc độ di chuyển khác nhau của các điện tử trong vật liệu từ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (33, 112, N'Diện tích của phần đĩa từ trong đĩa mềm', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (34, 112, N'Đường kính của phần đĩa từ trong đĩa mềm', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (35, 112, N'Chu vi của đĩa mềm', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (36, 112, N'Chiều rộng của đĩa mềm', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (37, 113, N'2.25 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (38, 113, N'2.75 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (39, 113, N'3.5 inches', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (40, 113, N'4.25 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (41, 114, N'3.25 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (42, 114, N'3.75 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (43, 114, N'4.5 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (44, 114, N'5.25 inches', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (45, 115, N'128', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (46, 115, N'256', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (47, 115, N'512', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (48, 115, N'1024', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (49, 116, N'5.25 inches', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (50, 116, N'5.75 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (51, 116, N'6.5 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (52, 116, N'7.25 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (53, 117, N'4.25 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (54, 117, N'4.75 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (55, 117, N'5.25 inches', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (56, 117, N'6.25 inches', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (57, 118, N'80 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (58, 118, N'160 KB', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (59, 118, N'320 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (60, 118, N'640 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (61, 119, N'180 KB', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (62, 119, N'270 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (63, 119, N'360 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (64, 119, N'90 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (65, 120, N'80 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (66, 120, N'160 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (67, 120, N'320 KB', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (68, 120, N'640 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (69, 121, N'90 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (70, 121, N'180 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (71, 121, N'270 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (72, 121, N'360 KB', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (73, 122, N'0.6 MB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (74, 122, N'0.9 MB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (75, 122, N'1.2 MB', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (76, 122, N'1.8 MB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (77, 123, N'720 KB', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (78, 123, N'360 KB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (79, 123, N'0.9 MB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (80, 123, N'1.8 MB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (81, 124, N'0.9 MB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (82, 124, N'1.44 MB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (83, 124, N'1.8 MB', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (84, 124, N'2.88 MB', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (85, 125, N'Kích thước nhỏ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (86, 125, N'Kích thước lớn', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (87, 125, N'Mật độ cao', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (88, 125, N'Mật độ trung bình', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (89, 126, N'128 Byte', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (90, 126, N'256 Byte', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (91, 126, N'512 Byte', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (92, 126, N'1024 Byte', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (93, 127, N'Đĩa mềm được ghi theo hai mặt', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (94, 127, N'Kích thước lớn', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (95, 127, N'Mật độ gấp đôi', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (96, 127, N'Mật độ trung bình', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (97, 128, N'Đĩa mềm được ghi theo hai mặt', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (98, 128, N'Kích thước lớn', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (99, 128, N'Mật độ cao', 0)
GO
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (100, 128, N'Mật độ trung bình', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (101, 129, N'250 vòng/phút', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (102, 129, N'300 vòng/phút', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (103, 129, N'350 vòng/phút', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (104, 129, N'400 vòng/phút', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (105, 130, N'280 vòng/phút', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (106, 130, N'320 vòng/phút', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (107, 130, N'360 vòng/phút', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (108, 130, N'400 vòng/phút', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (109, 131, N'Sự biến thiên của từ thông của phần tử lưu trữ tạo thành điện thế cảm ứng ở hai đầu ra của cuộn dây', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (110, 131, N'Sự biến thiên của lực từ tác động lên đầu đọc tạo nên điện thế cảm ứng ở hai đầu ra của cuộn dây', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (111, 131, N'Sự biến thiên của điện trường trên đầu đọc tạo thành dòng điện cảm ứng ở hai đầu ra của cuộn dây', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (112, 131, N'Sự biến thiên của lực tác động từ động cơ bước tạo nên sức điện động cảm ứng ở hai đầu ra của cuộn dây', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (113, 132, N'Cuộn dây sẽ phát ra điện trường làm biến thiên từ thông của phần tử lưu trữ tạo thành các trạng thái tương ứng với các mức dữ liệu 0 và 1', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (114, 132, N'Cuộn dây sẽ phát ra từ trường qua khe để từ hóa bột Ôxit sắt trên mặt đĩa tạo nên các trạng thái tương ứng với các mức dữ liệu 0 và 1', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (115, 132, N'Cuộn dây sẽ phát ra điện trường trên đầu đọc tạo thành dòng điện cảm ứng tạo nên các trạng thái tương ứng với các mức dữ liệu 0 và 1', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (116, 132, N'Cuộn dây sẽ phát ra từ trường gây ra lực từ tác động lên phần tử lưu trữ tạo nên các trạng thái tương ứng với các mức dữ liệu 0 và 1', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (117, 133, N'Cổng truyền thông nối tiếp trên bản mạch chính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (118, 133, N'Cổng truyền thông song song trên bản mạch chính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (119, 133, N'Một khe cắm riêng trên bản mạch chính', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (120, 133, N'Một khe cắm PCI trên bản mạch chính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (121, 134, N'6 bit', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (122, 134, N'7 bit', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (123, 134, N'8 bit', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (124, 134, N'9 bit', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (125, 135, N'50', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (126, 135, N'100', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (127, 135, N'500', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (128, 135, N'1000', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (129, 136, N'20', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (130, 136, N'100', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (131, 136, N'200', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (132, 136, N'500', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (133, 137, N'100', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (134, 137, N'200', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (135, 137, N'500', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (136, 137, N'1000', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (137, 138, N'50', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (138, 138, N'100', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (139, 138, N'500', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (140, 138, N'1000', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (141, 139, N'600', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (142, 139, N'400', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (143, 139, N'200', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (144, 139, N'500', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (145, 140, N'600', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (146, 140, N'400', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (147, 140, N'500', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (148, 140, N'200', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (149, 141, N'350', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (150, 141, N'450', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (151, 141, N'550', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (152, 141, N'650', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (153, 142, N'1400', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (154, 142, N'1500', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (155, 142, N'1600', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (156, 142, N'1700', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (157, 143, N'1600', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (158, 143, N'1500', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (159, 143, N'1100', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (160, 143, N'900', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (161, 144, N'1150', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (162, 144, N'1050', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (163, 144, N'950', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (164, 144, N'650', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (165, 145, N'600', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (166, 145, N'700', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (167, 145, N'1100', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (168, 145, N'1200', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (169, 146, N'1150', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (170, 146, N'1050', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (171, 146, N'1450', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (172, 146, N'1650', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (173, 147, N'400', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (174, 147, N'600', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (175, 147, N'800', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (176, 147, N'1200', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (177, 148, N'1400', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (178, 148, N'1450', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (179, 148, N'1600', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (180, 148, N'1650', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (181, 149, N'1846', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (182, 149, N'2756', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (183, 149, N'2866', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (184, 149, N'2976', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (185, 150, N'26,75', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (186, 150, N'29,75', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (187, 150, N'29,65', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (188, 150, N'26,65', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (189, 151, N'21.75', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (190, 151, N'23.75', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (191, 151, N'21.65', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (192, 151, N'23.65', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (193, 152, N'23.75', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (194, 152, N'21.75', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (195, 152, N'21,25', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (196, 152, N'23.25', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (197, 153, N'27.75', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (198, 153, N'29.75', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (199, 153, N'27.25', 0)
GO
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (200, 153, N'29.25', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (201, 154, N'Công ty nhà nước.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (202, 154, N'Công ty cổ phần.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (203, 154, N'Công ty tư nhân.', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (204, 154, N'Công ty hợp danh.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (205, 155, N'Công ty hợp danh.', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (206, 155, N'Công ty trách TNHH.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (207, 155, N'Công ty tư nhân.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (208, 155, N'Công ty cổ phần.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (209, 156, N'Tăng lợi nhuận 8% so với năm trước', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (210, 156, N'Tăng thị phần 5%', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (211, 156, N'Tạo công ăn việc làm cho 200% lao động mới', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (212, 156, N'Tăng giá trị cổ phiếu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (213, 157, N'Kiểm tra về tài chính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (214, 157, N'Kiểm tra phương pháp và kiểm tra kết quả', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (215, 157, N'Kiểm tra tính an toàn của môi trường', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (216, 157, N'Kiểm tra phí tài chính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (217, 158, N'Người quản lý ở mỗi cấp phải có hiểu biết toàn diện', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (218, 158, N'Người quản lý ở mỗi cấp có chuyên môn sâu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (219, 158, N'Người quản lý ở mỗi cấp phải có sự liên hệ qua lại tốt', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (220, 158, N'Người quản lý ở mỗi cấp phải có kỹ năng nhân sự tốt', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (221, 159, N'Nhận mệnh lệnh trực tiếp từ người lãnh đạo cao nhất', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (222, 159, N'Nhận mệnh lênh từ các phòng ban tổ chức khác nhau', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (223, 159, N'Nhận thông tin theo chiều dọc', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (224, 159, N'Nhận thông tin đa chiều', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (225, 160, N'Phân tích đe dọa, cơ hội, điểm mạnh, điểm yếu của doanh nghiệp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (226, 160, N'Lập kế hoạch cụ thế của bộ phận sản xuất', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (227, 160, N'Lượng hóa các kế hoạch bằng kế hoạch tài chính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (228, 160, N'Xác định mục tiêu sứ mệnh của tổ chức', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (229, 161, N'Tổ chức sản xuất theo dòng song song', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (230, 161, N'Tổ chức sản xuất theo dòng nối tiếp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (231, 161, N'Tổ chức sản xuất theo dong hỗn hợp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (232, 161, N'Tổ chức sản xuất theo dòng sản phẩm', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (233, 162, N'Sản xuất đơn chiếc và loại nhỏ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (234, 162, N'Sản xuất loạt lớn và hàng khối', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (235, 162, N'Sản xuất gián đoạn', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (236, 162, N'Sản xuất loạt vừa', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (237, 163, N'Sản xuất liên tục theo yêu cầu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (238, 163, N'Sản xuất liên tục để dự trữ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (239, 163, N'Sản xuất gián đoạn theo yêu cầu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (240, 163, N'Sản xuất gián đoạn để dự trữ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (241, 164, N'Hệ thống tái tạo định kỳ / hệ thống điểm đặt hàng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (242, 164, N'Hệ thống tái tạo trong kỳ / hệ thống điểm đặt hàng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (243, 164, N'Hệ thống tái tọa điểm đặt hàng /  hệ thống tái tạo kỳ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (244, 164, N'Hệ thống điểm đặt hàng / hệ thống tái tạo định kỳ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (245, 165, N'Bộ phận phục vụ có tính chất công nghiệp', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (246, 165, N'Bô phận sản xuất phụ trợ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (247, 165, N'Bộ phận sản xuất chính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (248, 165, N'Bộ phận sản xuất phụ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (249, 166, N'0,8 giờ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (250, 166, N'15 giờ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (251, 166, N'12 giờ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (252, 166, N'3 giờ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (253, 167, N'Xây dựng tiêu chuẩn để tuyển dụng lao động', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (254, 167, N'Không có đáp án đùng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (255, 167, N'Thăm dò nguồn lao động', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (256, 167, N'Phân tích vị trí cần tuyển dụng lao động', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (257, 168, N'Đáp ứng các yêu cầu của luật pháp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (258, 168, N'thu hút và duy trì được nhân viên giỏi, khuyến khích và động viên nhân yêu cầu của pháp luật', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (259, 168, N'thu hút và duy trì được nhân viên giỏi', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (260, 168, N'khuyến khích, động viên nhân viên', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (261, 169, N'Tổ chức phục vụ chỗ làm việc', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (262, 169, N'Phân công và hợp tác lao động', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (263, 169, N'Tuyển dụng nhân viên', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (264, 169, N'Đào tạo và đào tạo lại', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (265, 170, N'ý nghĩa về kinh tế', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (266, 170, N'ý nghĩa về xã hội', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (267, 170, N'ý nghĩa về kỹ thuật', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (268, 170, N'ý nghĩa về tâm lý', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (269, 171, N'Thời gian tác nghiệp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (270, 171, N'Thời gian nghỉ lễ, tế theo quy định', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (271, 171, N'Thời gian chuẩn kết', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (272, 171, N'Thời gian phục vụ nơi làm việc', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (273, 172, N'Sai vì đây là đặc điểm của chi phí cố định', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (274, 172, N'Sai vì đây là đặc điểm của chi phí trực tiếp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (275, 172, N'Không có đáp án đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (276, 172, N'Đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (277, 173, N'Không có đáp án nào đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (278, 173, N'Sai vì chỉ phụ thuộc vào giá thành sản phẩm', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (279, 173, N'Sai vì phụ thuộc vào sản lượng bán ra', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (280, 173, N'Đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (281, 174, N'3.000.000. đồng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (282, 174, N'13.000.000 đồng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (283, 174, N'6.000.000 đồng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (284, 174, N'500.000 đồng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (285, 175, N'P0=Fn/(1+i.n)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (286, 175, N'P0=Fn.(1+i)/n', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (287, 175, N'P0=Fn/(1+i).n', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (288, 175, N'P0=Fn.(1+i.n)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (289, 176, N'Nghiên cứu tiền khả thi/ nghiên cứu phân tích', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (290, 176, N'Nghiên cứu tiền khả thi/ nghiên cứu khả thi', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (291, 176, N'Tất cả đều đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (292, 176, N'Tất cả đều sai', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (293, 177, N'Dự kiến nhân lực', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (294, 177, N'Đào tạo và đào tạo lại', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (295, 177, N'Phân công và hợp tác lao động', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (296, 177, N'Tuyển dụng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (297, 178, N'Trực tuyến', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (298, 178, N'Trực tuyến – chức năng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (299, 178, N'Chức năng', 0)
GO
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (300, 178, N'a và b', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (301, 179, N'Thu hồi được chi phí đầu tư vào tài sản cố định', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (302, 179, N'Giảm được chi phí sản xuất, tăng lợi nhuận', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (303, 179, N'Giảm thuế thu nhập nộp cho nhà nước', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (304, 179, N'A và c', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (305, 180, N'Không phải hoàn trả những khoản tiền đã huy động', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (306, 180, N'Không phải thế chấp tài sản', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (307, 180, N'Cả a và b', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (308, 180, N'Không có đáp án nào đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (309, 181, N'347.97 triệu đồng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (310, 181, N'335.30 triệu đồng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (311, 181, N'29.82 triệu đồng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (312, 181, N'346.49 triệu đồng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (313, 182, N'7.19%', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (314, 182, N'6.75%', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (315, 182, N'6.19%', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (316, 182, N'8.69%', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (317, 183, N'Cơ quan nhà nước', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (318, 183, N'Các tổ chức tài chính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (319, 183, N'Các tổ chức khác', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (320, 183, N'Cả ba phương án đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (321, 184, N'Tiền có khả năng sinh lời', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (322, 184, N'Dầu tư có hiệu quả', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (323, 184, N'Do nền kinh tế lạm phát', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (324, 184, N'Phương án a,b,c', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (325, 185, N'Công ty cổ phần nhà nước', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (326, 185, N'Công ty TNHH', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (327, 185, N'Công ty cổ phần', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (328, 185, N'A,b,c', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (329, 186, N'Dự Đại hội cổ đông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (330, 186, N'Nhận lợi tức cổ phiếu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (331, 186, N'Tham gia vào ban quản trị', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (332, 186, N'Cả a,b,c', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (333, 187, N'Mua cổ phiếu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (334, 187, N'Mua trái phiếu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (335, 187, N'Tham gia lao động trong doanh nghiệp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (336, 187, N'Mua cổ phiếu, trái phiếu', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (337, 188, N'Chi phí quản lý doanh nghiệp, chi phí chung, và chi phí nguyên vật liệu, nhân công trực tiếp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (338, 188, N'Chi phí nhân công trực tiếp, chi phí sản xuất chung và chi phí bán hàng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (339, 188, N'Chi phí nguyên vật liệu trực tiếp, chi phí nhân công trực tiếp và chi phí khấu hao tài sản cố định', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (340, 188, N'Chi phí nguyên vật liệu trực tiếp, chi phí nhân công trực tiếp, chi phí sản xuất chung và chi phí bán hàng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (341, 189, N'Sản phẩm vật chất kết hợp với chi phí vật chất', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (342, 189, N'Sản phẩm thuần vật chất', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (343, 189, N'Sản phẩm phi vật chất', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (344, 189, N'Là sản phẩm hữu hình', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (345, 190, N'Chi phí sai hỏng bên ngoài', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (346, 190, N'Chi phí sai hỏng bên trong', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (347, 190, N'Chi phí thẩm định', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (348, 190, N'Chi phí chất lượng gián tiếp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (349, 191, N'10.000 TCVN', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (350, 191, N'8.000 TCVN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (351, 191, N'6.000 TCVN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (352, 191, N'9.000 TCVN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (353, 192, N'Xác định nguyên giá TSCĐ và chi phí khấu hao', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (354, 192, N'Xác định nguyên giá TSCĐ và thời gian dự kiến sử dụng của tài sản', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (355, 192, N'Xác định nguyên giá TSCĐ thời gian sử dụng của tài sản và xác định chi phí khấu hao hàng năm', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (356, 192, N'Xác định chi phí khấu hao hàng năm', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (357, 193, N'Sản xuất đơn chiếc và loạt nhỏ', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (358, 193, N'Sản xuất loạt lớn và hàng khối', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (359, 193, N'Sản xuất liên tục', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (360, 193, N'Sản xuất loạt vừa', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (361, 194, N'Nhu cầu trao đổi thông tin ngày càng tăng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (362, 194, N'Khối lượng thông tin lưu trên máy tính ngày càng tăng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (363, 194, N'Khoa học và công nghệ về lĩnh vực máy tính và truyền thông phát triển', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (364, 194, N'Cả ba câu trên đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (365, 195, N'Nâng cao độ tin cậy của hệ thống máy tính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (366, 195, N'Trao đổi và chia sẻ thông tin', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (367, 195, N'Phát triển ứng dụng trên máy tính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (368, 195, N'Nâng cao chất lượng khai thác thông tin', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (369, 196, N'LAN (Local Area Networ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (370, 196, N'MAN (Metropolitan Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (371, 196, N'WAN (Wide Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (372, 196, N'GAN (Global Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (373, 197, N'LAN (Local Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (374, 197, N'MAN (Metropolitan Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (375, 197, N'WAN (Wide Area Networ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (376, 197, N'GAN (Global Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (377, 198, N'LAN (Local Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (378, 198, N'MAN (Metropolitan Area Networ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (379, 198, N'WAN (Wide Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (380, 198, N'GAN(Global Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (381, 199, N'LAN (Local Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (382, 199, N'MAN (Metropolitan Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (383, 199, N'WAN (Wide Area Network)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (384, 199, N'GAN (Global Area Networ', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (385, 200, N'Local Access Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (386, 200, N'Local Access Networking', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (387, 200, N'Local Area Network', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (388, 200, N'Local Area Networking', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (389, 201, N'Wide Access Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (390, 201, N'Wide Access Networking', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (391, 201, N'Wide Area Networking', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (392, 201, N'Wide Area Network', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (393, 202, N'Metropolitan Area Network', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (394, 202, N'Metropolitan Area Networking', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (395, 202, N'Metro Area Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (396, 202, N'Metro Area Networking', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (397, 203, N'Global Access Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (398, 203, N'Global Area Network', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (399, 203, N'Global Access Networking', 0)
GO
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (400, 203, N'Global Area Networking', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (401, 204, N'Khoảng cách địa lý', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (402, 204, N'Giao thức truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (403, 204, N'Thiết bị mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (404, 204, N'Đường truyền mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (405, 205, N'Kết nối các máy tính trong phạm vi một thành phố hay một trung tâm kinh tế', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (406, 205, N'Kết nối các máy tính trong phạm vi một quốc gia hoặc trong một châu lục.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (407, 205, N'Kết nối các máy tính trong phạm vi toàn cầu.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (408, 205, N'Kết nối các máy tính trong phạm hẹp như một toà nhà, trường học…', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (409, 206, N'Kết nối các máy tính trong phạm hẹp như một toà nhà, trường học…', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (410, 206, N'Kết nối các máy tính trong phạm vi một thành phố hay một trung tâm kinh tế.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (411, 206, N'Kết nối các máy tính trong phạm vi một quốc gia hoặc trong một châu lục', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (412, 206, N'Kết nối các máy tính trong phạm vi toàn cầu.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (413, 207, N'Kết nối các máy tính trong phạm hẹp như một toà nhà, trường học…', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (414, 207, N'Kết nối các máy tính trong phạm vi một thành phố hay một trung tâm kinh tế', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (415, 207, N'Kết nối các máy tính trong phạm vi một quốc gia hoặc trong một châu lục.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (416, 207, N'Kết nối các máy tính trong phạm vi toàn cầu.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (417, 208, N'Kết nối các máy tính trong phạm vi toàn cầu', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (418, 208, N'Kết nối các máy tính trong phạm hẹp như một toà nhà, trường học…', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (419, 208, N'Kết nối các máy tính trong phạm vi một thành phố hay một trung tâm kinh tế.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (420, 208, N'Kết nối các máy tính trong phạm vi một quốc gia hoặc trong một châu lục.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (421, 209, N'LAN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (422, 209, N'MAN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (423, 209, N'WAN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (424, 209, N'GAN', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (425, 210, N'LAN', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (426, 210, N'MAN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (427, 210, N'WAN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (428, 210, N'GAN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (429, 211, N'Mạng Internet', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (430, 211, N'Mạng LAN', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (431, 211, N'Mạng MAN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (432, 211, N'Mạng WAN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (433, 212, N'Chương trình, dữ liệu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (434, 212, N'Máy in, máy scanner…', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (435, 212, N'Ổ đĩa CD ROM.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (436, 212, N'Tất cả các tài nguyên trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (437, 213, N'Telnet', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (438, 213, N'Command Prompt', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (439, 213, N'Service', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (440, 213, N'Computer Management', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (441, 213, N'Câu 21: Sau khi đã khảo sát và thiết kế một mạng máy tính, bước tiếp theo để thiết lập một mạng máy tính, người ta cần phải thực hiện các công việc gì?', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (442, 213, N'Xây dựng và lắp đặt các thiết bị truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (443, 213, N'Xây dựng và lắp đặt các cáp truyền thông hoặc là lắp đặt các thiết bị hỗ trợ truyền thông vô tuyến', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (444, 213, N'Cài đặt và cấu hình các phần mềm giao thức mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (445, 213, N'Tất cả các công việc trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (446, 214, N'Nhằm để tránh các truy nhập bất hợp pháp từ ngoài mạng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (447, 214, N'Nhằm để tránh các lỗi do bản thân mạng sinh ra', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (448, 214, N'Nhằm để nâng cao tốc độ truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (449, 214, N'Nhằm để nâng cao hiệu suất truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (450, 215, N'Các máy tính, hệ thống đường truyền vật lý', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (451, 215, N'Các thiết bị mạng như Hub, Switch, Router…', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (452, 215, N'Giao thức mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (453, 215, N'Tất cả thành phần trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (454, 216, N'Do hai máy tính cài đặt hai hệ điều hành khác nhau?', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (455, 216, N'Do hai máy tính không được cài đặt cùng giao thức trao đổi thông tin', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (456, 216, N'Do hai máy tính đó có cấu hình phần cứng khác nhau', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (457, 216, N'Câu a và câu c đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (458, 217, N'Tắc nghẽn truyền thông?', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (459, 217, N'Chuẩn hoá và chuyển đổi giao thức', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (460, 217, N'Xử lý lỗi truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (461, 217, N'Cả ba vấn đề trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (462, 218, N'Do yêu cầu đảm bảo an ninh tài nguyên mạng của người dùng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (463, 218, N'Do sự phát triển nhanh của các cuộc xâm nhập tài nguyên mạng bất hợp pháp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (464, 218, N'Do khối lượng tài nguyên của mạng máy tính ngày càng tăng và có giá trị cao', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (465, 218, N'Cả ba câu trên đều đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (466, 219, N'Internet Explore', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (467, 219, N'BkavPro', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (468, 219, N'Symantec Antivirus', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (469, 219, N'Cả ba ứng dụng trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (470, 220, N'Telnet', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (471, 220, N'IIS (Internet Information Service)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (472, 220, N'Messenger', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (473, 220, N'Cả ba ứng dụng trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (474, 221, N'Windows Media', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (475, 221, N'Semantic Antivirus', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (476, 221, N'Câu a và b đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (477, 221, N'Notepad', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (478, 222, N'Paint', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (479, 222, N'Telnet', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (480, 222, N'Semantic Antivirus', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (481, 222, N'Yahoo Messenger', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (482, 223, N'Paint', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (483, 223, N'Notepad', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (484, 223, N'Acrobat Reader', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (485, 223, N'Câu a và c đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (486, 224, N'LAC VIET mtd2002', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (487, 224, N'Telnet', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (488, 224, N'Semantic Antivirus', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (489, 224, N'Internet Explore', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (490, 225, N'Viettel', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (491, 225, N'FPT', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (492, 225, N'Net Nam', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (493, 225, N'Cả ba tổ chức trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (494, 226, N'Internet Explore', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (495, 226, N'Yahoo Messenger', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (496, 226, N'Windows Media', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (497, 226, N'Fire Fox', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (498, 227, N'Internet Explore', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (499, 227, N'Windows Media', 0)
GO
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (500, 227, N'Yahoo Messenger', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (501, 227, N'Câu b và c đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (502, 228, N'Chia sẻ tài nguyên (ổ cứng, cơ sở dữ liệu, máy in, các phần mềm tiện ích…)', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (503, 228, N'Quản lý tập trung.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (504, 228, N'Tận dụng năng lực xử lý của các máy tính rỗi để làm các đề án lớn.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (505, 228, N'Tất cả đều đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (506, 229, N'Cấu trúc kết nối cụ thể giữa các máy trong mạng.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (507, 229, N'Các phần tử chức năng cấu thành mạng và mối quan hệ giữa chúng.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (508, 229, N'Bao gồm hai ý của câu a và b', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (509, 229, N'Cả ba câu trên đều sai.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (510, 230, N'Physical', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (511, 230, N'Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (512, 230, N'Data Link', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (513, 230, N'Transport', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (514, 231, N'Session', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (515, 231, N'Data Link', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (516, 231, N'Network', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (517, 231, N'Presentation', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (518, 232, N'4 tầng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (519, 232, N'5 tầng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (520, 232, N'6 tầng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (521, 232, N'7 tầng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (522, 233, N'IEEE', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (523, 233, N'ISO', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (524, 233, N'ANSI', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (525, 233, N'WLAN', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (526, 234, N'1969', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (527, 234, N'1970', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (528, 234, N'1971', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (529, 234, N'1981', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (530, 235, N'Application', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (531, 235, N'Presentation', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (532, 235, N'Session', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (533, 235, N'Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (534, 236, N'Application', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (535, 236, N'Presentation', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (536, 236, N'Session', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (537, 236, N'Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (538, 237, N'Application', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (539, 237, N'Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (540, 237, N'Session', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (541, 237, N'Transport', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (542, 238, N'Application', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (543, 238, N'Transport', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (544, 238, N'Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (545, 238, N'Presentation', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (546, 239, N'Data Link', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (547, 239, N'Network', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (548, 239, N'Transport', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (549, 239, N'Phisical', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (550, 240, N'Transport', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (551, 240, N'Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (552, 240, N'Data Link', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (553, 240, N'Phisical', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (554, 241, N'Các chức năng giống nhau có thể đặt ở các tầng khác nhau', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (555, 241, N'Không được định nghĩa quá nhiều tầng chức năng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (556, 241, N'Tạo ranh giới giữa các tầng chức năng sao cho số các tương tác giữa hai tầng là nhỏ nhất', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (557, 241, N'Tạo các tầng riêng biệt cho các chức năng khác nhau hoàn toàn về kỹ thuật sử dụng hoặc quá trình thực hiện', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (558, 242, N'Transport', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (559, 242, N'Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (560, 242, N'Data Link', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (561, 242, N'Phisical', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (562, 243, N'Mạng quảng bá', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (563, 243, N'Mạng chuyển mạch', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (564, 243, N'Mạng chuyển gói', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (565, 243, N'Tất cả đều sai', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (566, 244, N'Phisical', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (567, 244, N'Data Link', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (568, 244, N'Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (569, 244, N'Transport', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (570, 245, N'Data Linnk', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (571, 245, N'Network', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (572, 245, N'Transport', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (573, 245, N'Presentation', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (574, 246, N'Tự khôi phục hoặc sửa lại gói tin bị mất hoặc lỗi hoặc đó', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (575, 246, N'Đưa ra yêu cầu cho trạm nguồn gửi lại gói tin bị lỗi hoặc mất', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (576, 246, N'Huỷ phiên trao đổi dữ liệu, đưa ra thông báo lỗi cho trạm nguồn', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (577, 246, N'Cả ba câu trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (578, 247, N'Báo nhận', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (579, 247, N'Kỹ thuật hàng đợi', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (580, 247, N'Đưa ra quy định về tốc độ gửi và tốc độ nhận', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (581, 247, N'Cả ba câu trên đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (582, 248, N'Liên kết dữ liệu', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (583, 248, N'Mạng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (584, 248, N'Giao vận', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (585, 248, N'Vật lý', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (586, 249, N'Để định danh cho mỗi gói tin', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (587, 249, N'Để phân loại gói tin cho các dịch vụ trao đổi thông tin ở tầng trên', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (588, 249, N'Để xác định số thứ tự khi gửi và sắp xếp chúng khi nhận', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (589, 249, N'Nhằm để phát hiện lỗi truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (590, 250, N'Để định danh cho mỗi gói tin', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (591, 250, N'Để phân loại gói tin cho các dịch vụ trao đổi thông tin ở tầng trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (592, 250, N'để xác định số thứ tự khi gửi và sắp xếp chúng khi nhận', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (593, 250, N'Nhằm để phát hiện lỗi truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (594, 251, N'Để phát hiện lỗi truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (595, 251, N'Để nâng cao hiệu suất và độ tin cậy trong trao đổi thông tin trên mạng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (596, 251, N'Để nâng cao độ an toàn truyền thông mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (597, 251, N'Để điều khiển lưu lượng truyền thông, tránh tắc nghẽn', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (598, 252, N'Để định danh một máy tính trên mạng và cho phép các máy tính trong liên mạng có thể trao đổi thông tin với nhau', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (599, 252, N'Không có ý nghĩa gì cả', 0)
GO
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (600, 252, N'Để các máy tính trong một mạng có thể trao đổi thông tin với nhau', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (601, 252, N'Nhằm đảm bảo an ninh mạng máy tính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (602, 253, N'Để định danh một máy tính trên mạng và cho phép các máy tính trong liên mạng có thể trao đổi thông tin với nhau.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (603, 253, N'Để định danh một thiết bị trên mạng và cho phép các máy tính trong một mạng có thể trao đổi thông tin với nhau.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (604, 253, N'Để định danh một máy tính trên mạng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (605, 253, N'Nhằm nâng cao độ tin cậy trong truyền tin.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (606, 254, N'Datagram', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (607, 254, N'Dlink', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (608, 254, N'Frame', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (609, 254, N'Ethernet', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (610, 255, N'Datagram', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (611, 255, N'Dlink', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (612, 255, N'Frame', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (613, 255, N'Ethernet', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (614, 256, N'Liên kết dữ liệu', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (615, 256, N'Vật lý', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (616, 256, N'Mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (617, 256, N'Giao vận', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (618, 257, N'Định địa chỉ vật lý', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (619, 257, N'Điều khiển truy nhập đường truyền', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (620, 257, N'Điều khiển kết nối logic', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (621, 257, N'Tất cả các chức năng trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (622, 258, N'Kết nối các sản phẩm mạng của các hãng khác nhau', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (623, 258, N'Chuyên môn hoá trong sản xuất các sản phẩm mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (624, 258, N'Xây dựng các giao thức truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (625, 258, N'Xây dựng các ứng dụng trên mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (626, 259, N'Người ta không thể thiết kế và xây dựng được các giao thức mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (627, 259, N'Người ta không thể thiết kế và xây dựng được các ứng dụng trên mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (628, 259, N'Người ta vẫn có thể xây dựng được các giao thức mạng, nhưng tính hiệu quả và đồng bộ thấp, gây khó khăn cho việc xây dựng và phát triể', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (629, 259, N'Người ta không thể xây dựng được bộ giao thức TCP/IP', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (630, 260, N'IEEE', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (631, 260, N'ISO', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (632, 260, N'Cissco', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (633, 260, N'ITU', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (634, 261, N'Có thể trao đổi thông tin trực tiếp với các tầng chức năng còn lại', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (635, 261, N'Không thể trao đổi thông tin trực tiếp với các tầng chức năng còn lại', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (636, 261, N'Chỉ trao đổi thông tin trực tiếp với tầng chức năng nằm liền kề nó', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (637, 261, N'Cả ba câu trên đều sai', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (638, 262, N'Giống nhau', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (639, 262, N'Khác  nhau hoàn toàn', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (640, 262, N'Một phần giống nhau', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (641, 262, N'Gói tin trong một hệ thống có cấu trúc là mở rộng  cấu trúc gói tin của hệ thống còn lại', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (642, 263, N'Network', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (643, 263, N'Data Link', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (644, 263, N'Physical', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (645, 263, N'Transport', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (646, 264, N'Liên kết logic với nhau', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (647, 264, N'Liên kết vật lý với nhau', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (648, 264, N'Chỉ có các tầng tầng vật lý là thực sự trao đổi thông tin với nhau', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (649, 264, N'Cả 3 câu trên đều sai', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (650, 265, N'Vật lý, liên kết dữ liệu, mạng, trình diễn, giao vận, phiên, ứng dụng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (651, 265, N'Vật lý, liên kết dữ liệu, mạng, giao vận, phiên, trình diễn, ứng dụng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (652, 265, N'Vật lý, liên kết dữ liệu, mạng, phiên, giao vận, trình diễn, ứng dụng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (653, 265, N'Vật lý, liên kết dữ liệu, mạng, giao vận, trình diễn, phiên, ứng dụng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (654, 266, N'Mô hình nhằm để thiết lập các ứng dụng trao đổi thông tin', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (655, 266, N'Các quy định để truyền thông tin của một thực thể mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (656, 266, N'Một tập các quy tắc và thủ tục mà các thực thể mạng trao đổi thông tin với nhau phải tuân thủ.', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (657, 266, N'Cả ba câu trên đều sai', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (658, 267, N'Đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (659, 267, N'Sai', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (660, 268, N'Đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (661, 268, N'Sai', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (662, 269, N'Đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (663, 269, N'Sai', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (664, 270, N'Chuyển đổi dữ liệu số trong máy tính thành tín hiệu đường truyền và ngược lại', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (665, 270, N'Thiết lập địa chỉ vật lý', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (666, 270, N'Xác định phương thức truyền thông và tốc độ truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (667, 270, N'Câu a và câu c là đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (668, 271, N'Đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (669, 271, N'Sai', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (670, 272, N'Định địa chỉ IP', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (671, 272, N'Thiết lập khuôn dạng gói tin', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (672, 272, N'Thích ứng với đường truyền mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (673, 272, N'Câu a và b đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (674, 273, N'Cung cấp chức năng phát hiện và khắc phục lỗi đối với mỗi gói dữ liệu truyền', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (675, 273, N'thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (676, 273, N'Điều khiển tốc độ truyền tin', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (677, 273, N'Thực hiện điều khiển việc truy cập đường truyền chung', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (678, 273, N'Cả ba câu trên', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (679, 273, N'8Tầng mạng không thực hiện chức năng nào sau đây?:', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (680, 273, N'Tìm đường đi trên mạng tốt nhất theo những tiêu chuẩn nhất định', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (681, 273, N'Cập nhật các thông tin về mạng sử dụng cho việc chọn đường', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (682, 273, N'Phát hiện và xử lý lỗi truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (683, 273, N'Sắp xếp các gói dữ liệu khi nhận', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (684, 274, N'Địa chỉ IP của máy tính gửi và địa chỉ IP của máy nhận', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (685, 274, N'Kích thước gói tin IP, thời gian sống của gói tin IP', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (686, 274, N'Số thứ tự truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (687, 274, N'Câu a và  câu b đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (688, 275, N'Ứng dụng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (689, 275, N'Trình diễn', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (690, 275, N'Phiên', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (691, 275, N'Giao vận', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (692, 276, N'Thiết lập số hiệu cổng dịch vụ của thực thể gửi và thực thể nhận', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (693, 276, N'Phát hiện và xử lý lỗi truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (694, 276, N'Điều khiển lưu lượng truyền thông', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (695, 276, N'd)Cả ba câu a, b, c đều đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (696, 277, N'Ứng dụng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (697, 277, N'Trình diễn', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (698, 277, N'Phiên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (699, 277, N'Giao vận', 0)
GO
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (700, 278, N'Do đường truyền mạng bị lỗi', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (701, 278, N'Do giao thức tầng liên kết dữ liệu bị lỗi', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (702, 278, N'Do giao thức tầng vật lý dữ liệu bị lỗi', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (703, 278, N'Cả ba câu trên đều đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (704, 279, N'Tốc độ truyền thông cao, tỉ suất lỗi thấp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (705, 279, N'Có nhiều cơ quan quản lý', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (706, 279, N'Sử dụng chung hệ thống truyền thông, phạm vi kết nối giữa các máy tính hẹp', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (707, 279, N'Câu a và c đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (708, 280, N'Hình dạng vật lý của hệ thống mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (709, 280, N'Hình dạng logic của hệ thống mạng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (710, 280, N'Mô hình trao đổi thông tin giữa các máy tính trong mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (711, 280, N'Cả ba câu trên đều sai', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (712, 281, N'Phạm vi kết nối máy tính', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (713, 281, N'Tốc độ truyền thông và tỉ suất lỗi', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (714, 281, N'Chủ sở hữu mạng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (715, 281, N'Cả ba yếu tố trên', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (716, 282, N'Đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (717, 282, N'Sai', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (718, 283, N'Đúng', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (719, 283, N'Sai', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (720, 284, N'Đúng', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (721, 284, N'Sai', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (722, 285, N'Bus, Ring, Point – to – Point', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (723, 285, N'Bus, Ring, Star', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (724, 285, N'Ring, Star, Broadcast', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (725, 285, N'Point – to – Point, Broadcast', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (726, 286, N'Các máy tính và các thiết bị được nối với nhau bởi đường truyền dẫn chung được giới hạn bởi các đầu nối Terminato', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (727, 286, N'Các máy tính và các thiết bị được nối với nhau bởi đường truyền dẫn chung dạng vòng khép kín.', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (728, 286, N'Các máy tính và các thiết bị được nối với nhau bởi thiết bị xử lý truyền thông trung tâm', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (729, 286, N'Các máy tính và các thiết bị được nối trực tiếp với nhau', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (730, 287, N'802.3', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (731, 287, N'802.5', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (732, 287, N'802.12', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (733, 287, N'802.11b', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (734, 288, N'802', 1)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (735, 288, N'803', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (736, 288, N'804', 0)
INSERT [dbo].[tb_Answer] ([id], [subQuestionID], [answer], [isCorrect]) VALUES (737, 288, N'805', 0)
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
SET IDENTITY_INSERT [dbo].[tb_Question] ON 

INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (109, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (110, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (111, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (112, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (113, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (114, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (115, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (116, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (117, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (118, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (119, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (120, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (121, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (122, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (123, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (124, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (125, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (126, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (127, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (128, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (129, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (130, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (131, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (132, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (133, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (134, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (135, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (136, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (137, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (138, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (139, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (140, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (141, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (142, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (143, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (144, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (145, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (146, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (147, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (148, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (149, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (150, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (151, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (152, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (153, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (154, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (155, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (156, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (157, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (158, 5, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (159, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (160, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (161, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (162, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (163, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (164, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (165, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (166, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (167, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (168, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (169, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (170, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (171, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (172, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (173, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (174, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (175, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (176, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (177, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (178, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (179, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (180, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (181, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (182, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (183, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (184, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (185, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (186, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (187, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (188, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (189, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (190, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (191, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (192, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (193, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (194, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (195, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (196, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (197, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (198, 6, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (199, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (200, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (201, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (202, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (203, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (204, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (205, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (206, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (207, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
GO
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (208, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (209, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (210, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (211, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (212, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (213, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (214, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (215, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (216, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (217, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (218, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (219, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (220, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (221, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (222, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (223, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (224, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (225, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (226, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (227, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (228, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (229, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (230, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (231, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (232, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (233, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (234, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (235, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (236, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (237, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (238, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (239, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (240, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (241, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (242, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (243, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (244, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (245, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (246, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (247, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (248, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (249, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (250, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (251, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (252, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (253, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (254, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (255, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (256, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (257, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (258, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (259, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (260, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (261, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (262, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (263, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (264, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (265, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (266, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (267, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (268, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (269, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (270, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (271, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (272, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (273, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (274, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (275, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (276, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (277, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (278, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (279, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (280, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (281, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (282, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (283, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (284, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (285, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (286, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (287, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (288, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (289, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (290, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (291, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (292, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
INSERT [dbo].[tb_Question] ([id], [subjectID], [content], [createDate]) VALUES (293, 1, NULL, CAST(0x0000A79700000000 AS DateTime))
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
INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (5, N'Kiến trúc máy tính')
INSERT [dbo].[tb_Subject] ([id], [subjectName]) VALUES (6, N'Quản trị doanh nghiệp')
SET IDENTITY_INSERT [dbo].[tb_Subject] OFF
SET IDENTITY_INSERT [dbo].[tb_SubQuestion] ON 

INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (104, 109, N'Trong các khối sau, khối nào không thuộc hệ thống hỗ trợ vào ra?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (105, 110, N'Trong các thiết bị sau, thiết bị nào không phải là thiết bị ngoại vi:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (106, 111, N'Trong các thành phần sau, thành phần nào thuộc hệ thống hỗ trợ phối ghép vào ra?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (107, 112, N'Chức năng nào sau đây không phải là chức năng của hệ thống hỗ trợ vào ra?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (108, 113, N'Chức năng của hệ thống hỗ trợ vào ra là:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (109, 114, N'Đặc điểm của thiết bị lưu trữ ngoài là:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (110, 115, N'Nguyên tắc lưu trữ của thiết bị lưu trữ ngoài thường là:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (111, 116, N'Nguyên lý của việc ghi dữ liệu trên đĩa mềm là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (112, 117, N'Khi nói đĩa mềm loại 3.5 inches thì giá trị 3.5 inches là:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (113, 118, N'Trong các giá trị sau, giá trị nào có thể là kích thước của đĩa mềm?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (114, 119, N'Trong các giá trị sau, giá trị nào có thể là kích thước của đĩa mềm?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (115, 120, N'Mỗi sector trong đĩa mềm chứa bao nhiêu byte dữ liệu:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (116, 121, N'Trong các giá trị sau, giá trị nào có thể là kích thước của đĩa mềm?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (117, 122, N'Trong các giá trị sau, giá trị nào có thể là kích thước của đĩa mềm?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (118, 123, N'Một đĩa mềm một mặt có 40 track, mỗi track chia thành 8 sector thì dung lượng đĩa là bao nhiêu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (119, 124, N'Một đĩa mềm một mặt có 40 track, mỗi track chia thành 9 sector thì dung lượng đĩa là bao nhiêu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (120, 125, N'Một đĩa mềm hai mặt có 40 track, mỗi track chia thành 8 sector thì dung lượng đĩa là bao nhiêu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (121, 126, N'Một đĩa mềm hai mặt có 40 track, mỗi track chia thành 9 sector thì dung lượng đĩa là bao nhiêu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (122, 127, N'Một đĩa mềm hai mặt có 80 track, mỗi track chia thành 15 sector thì dung lượng đĩa là bao nhiêu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (123, 128, N'Một đĩa mềm hai mặt có 80 track, mỗi track chia thành 9 sector thì dung lượng đĩa là bao nhiêu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (124, 129, N'Một đĩa mềm hai mặt có 80 track, mỗi track chia thành 36 sector thì dung lượng đĩa là bao nhiêu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (125, 130, N'Kí hiệu HD trong đĩa mềm loại 3.5” DS/HD có ý nghĩa là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (126, 131, N'Mỗi Sector trong đĩa mềm chứa dữ liệu với dung lượng bằng bao nhiêu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (127, 132, N'Kí hiệu DD trong đĩa mềm loại 5.25” DS/DD có ý nghĩa là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (128, 133, N'Kí hiệu DS trong đĩa mềm loại 3.5” DS/HD có ý nghĩa là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (129, 134, N'Tốc độ quay của động cơ điều khiển ổ đĩa mềm thường bằng:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (130, 135, N'Tốc độ quay của động cơ điều khiển ổ đĩa mềm thường bằng:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (131, 136, N'Khi đọc dữ liệu trên đĩa mềm, yếu tố nào tạo nên tín hiệu dữ liệu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (132, 137, N'Khi ghi dữ liệu lên đĩa mềm, yếu tố nào tạo nên các mức 0 và 1?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (133, 138, N'Mạch điều khiển ổ đĩa mềm thường được nối với?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (134, 139, N'Trong số dấu chấm động biểu diễn dạng 32 bit trong máy tính, thành phần số mũ có độ dài bao nhiêu bit?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (135, 140, N'Chữ số L trong hệ đếm La mã tương ứng với giá trị nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (136, 141, N'Chữ số C trong hệ đếm La mã tương ứng với giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (137, 142, N'Chữ số D trong hệ đếm La mã tương ứng với giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (138, 143, N'Chữ số M trong hệ đếm La mã tương ứng với giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (139, 144, N'Trong hệ La mã số CD nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (140, 145, N'Trong hệ La mã số DC nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (141, 146, N'Trong hệ La mã số LD nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (142, 147, N'Trong hệ La mã số MD nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (143, 148, N'Trong hệ La mã số CM nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (144, 149, N'Trong hệ La mã số MCL nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (145, 150, N'Trong hệ La mã số MCC nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (146, 151, N'Trong hệ La mã số MLD nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (147, 152, N'Trong hệ La mã số DLL nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (148, 153, N'Trong hệ La mã số MCD nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (149, 154, N'Trong hệ La mã số MMCMLXXVI nhận giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (150, 155, N'Trong hệ nhị phân số 11101.11(2) tương ứng với giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (151, 156, N'Trong hệ nhị phân số 10101.11(2) tương ứng với giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (152, 157, N'Trong hệ nhị phân số 10101.01(2) tương ứng với giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (153, 158, N'Trong hệ nhị phân số 11101.01(2) tương ứng với giá trị thập phân nào trong các giá trị sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (154, 159, N'Tài sản của chủ doanh nghiệp cũng là tài sản của doanh nghiệp.', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (155, 160, N'Doanh nghiệp có trách nhiệm pháp lý hỗn hợp.', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (156, 161, N'Mục tiêu nào dưới đây không được coi là mục tiêu kinh tế của doanh nghiệp', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (157, 162, N'Dạng kiểm tra nào dưới đây không phù hợp để áp dụng trong quản trị doanh nghiệp?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (158, 163, N'Đâu là đặc điểm của Cơ câu Tổ chức Quản lý theo kiểu trực tuyến', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (159, 164, N'Đâu là đặc điểm của Cơ cấu tổ chức Quản lý theo chức năng?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (160, 165, N'Bước thực hiện nào sau đây không nằm trong lập kế hoạch chiến lược', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (161, 166, N'Chuyển sản phẩm theo từng loạt sản xuất là đặc điểm của cách tổ chức sản xuất', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (162, 167, N'Chi phí một đơn vị sản phẩm cao là đặc điểm của loại hình sản xuất:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (163, 168, N'Quá trình lọc dầu là loại hình', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (164, 169, N'Trong quản lý dự trữ, ………. có số lượng cố định và chu kỳ thay đổi, …….. có số lượng thay đổi và chu kỳ cố định', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (165, 170, N'Phân xưởng A của công ty B sản xuất khuy áo từ vỏ sò biển. Sau khi dập vỏ sò để làm khuy, còn một phần vỏ sò khá lớn được mài để làm đồ trang trí khác như cặp, cài áo v.v. trong ví dụ trên đây, khái niệm nào mô tả đúng nhất bộ phận mài vỏ sò làm các đồ trang trí khác?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (166, 171, N'Số lượng một loạt đưa vào dây chuyền sản xuất sản phẩm ở một xưởng bánh ngọt là 50kg bánh. Quá trình trải qua 4 nguyên công. Thời gian định mức để san xuất một gói bánh (1 gói bánh có tương ứng ở các nguyên công như sau t1 = 0.002 giờ, t2 = 0,02 giờ, t3 = 0.04 giờ. Biết số chỗ làm việc ở các nguyên công tương ứng là c1 = 1, c2 = 2, c3 = 2, c4 = 1. Thời gian sản xuất sản phẩm trên khi tổ chức sản xuất theo dòng nối tiếp là:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (167, 172, N'Công việc thứ hai trong qui trình tuyển dụng lao động:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (168, 173, N'Hệ thống tiền lương phải thỏa mãn điều kiện nào sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (169, 174, N'Nội dung của giai đoạn chuẩn bị và tiếp nhận nhân lực gồm', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (170, 175, N'“Đảm bảo chất lượng sản phẩm” là ý nghĩa và nhiệm vụ nào của công tác tổ chức và phục vụ chỗ làm việc:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (171, 176, N'Thời gian trong mức lao động không bao gồm thành phân nào sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (172, 177, N'Trong cách phân loại dựa theo quy mô sản xuất, chi phí biến đổi là các chi phí mà tổng giá trị của nó thay đổi khi sản lượng sản xuất tăng', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (173, 178, N'Giá bán một sản phẩm phụ thuộc vào quan hệ cung-cầu của sản phẩm đó trên thị trường', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (174, 179, N'Một người đi vay 10 triệu đồng với lãi xuất đơn 5% / 1 tháng. Sau 6 tháng, tổng số tiên anh ta sẽ phải trả là:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (175, 180, N'Giá trị hiện tại của một khoản tiền khi ghép lãi đơn với số kỳ ghép lãi n, lãi xuất I % là:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (176, 181, N'Phân tích và lập dự án là nghiêp cứu một cách toàn diện tính khả của dự án, bao gồm hai bước: Nghiên cứu ……….. và nghiên cứu', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (177, 182, N'Nội dung của giai đoạn tổ chức và sử dụng có hiệu quả nhân lực:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (178, 183, N'Kết cấu tổ chức tránh được tình trạng người thừa hành phải thi hành nhiều mệnh lệnh khác nhau khi giải quyết cùng một công việc', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (179, 184, N'Phân bố khấu hao giúp doanh nghiệp:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (180, 185, N'Sử dụng vốn của chủ sở hữu doanh nghiệp có những lợi thế nào sau đây:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (181, 186, N'Một người đầu tư 100 triệu đồng với lãi suất 8,4 % / năm. Ssau 15 năm người đó có thể nhận được bao nhiêu nếu tính lãi 3 tháng/ năm:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (182, 187, N'Tìm lãi suất thực biết lãi suất danh nghĩa là 7% / năm và tính lãi 3 tháng / năm', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (183, 188, N'Duyệt dự án thường được thực hiện với sự tham gia của các cơ quan', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (184, 189, N'Một đồng trong hiện tại có giá trị lớn hơn một đồng trong tương lai vì :', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (185, 190, N'Doanh nghiệp không được phép phát hành cổ phiếu', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (186, 191, N'Quyền nào sau đây của người có cổ phiếu có khả năng được thực hiện', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (187, 192, N'Để trở thành chủ nợ người ta', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (188, 193, N'Khi hoạch toán chi phí, chi phí biến đổi có thể bao gồm nhưng chi phí nào sau đây', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (189, 194, N'Ông A cắt tóc tại một tiệm gội đầu, sản phẩm của ông ta có được', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (190, 195, N'Chi phí do kiểm tra lại sản phẩm sau khi sửa chữa là:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (191, 196, N'TCVN là cấp tiêu chuẩn cao nhất hiện tại có tại Việt Nam bao gồm khoảng', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (192, 197, N'Khấu hao tài sản cố định bao gồm nhưng công việc nào sau đây', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (193, 198, N'Chủng loại sản phẩm đa dạng là đặc điểm của loại hình sản xuất', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (194, 199, N'Nguyên nhân cơ bản nào dẫn đến sự  ra đời của mạng máy tính', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (195, 200, N'Ý nghĩa cơ bản nhất của mạng máy tính là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (196, 201, N'Thuật ngữ viết tắt bằng tiếng Anh của mạng cục bộ là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (197, 202, N'Thuật ngữ viết tắt bằng tiếng Anh của mạng diện rộng là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (198, 203, N'Thuật ngữ viết tắt bằng tiếng Anh của mạng thành phố là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (199, 204, N'Thuật ngữ viết tắt bằng tiếng Anh của mạng toàn cục là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (200, 205, N'Thuật ngữ LAN (mạng cục bộ) là viết tắt của cụm từ nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (201, 206, N'Thuật ngữ WAN (mạng diện rộng) là viết tắt của cụm từ nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (202, 207, N'Thuật ngữ MAN (mạng thành phố) là viết tắt của cụm từ nào?', 0, 1)
GO
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (203, 208, N'Thuật ngữ GAN (mạng cục bộ) là viết tắt của cụm từ nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (204, 209, N'Các kiểu mạng LAN, MAN, WAN, GAN được phân biệt với nhau bởi tiêu chí phân loại nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (205, 210, N'Mục đích chính của việc xây dựng LAN là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (206, 211, N'Mục đích chính của việc xây dựng WAN là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (207, 212, N'Mục đích chính của việc xây dựng MAN là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (208, 213, N'Mục đích chính của việc xây dựng GAN là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (209, 214, N'Mạng Internet là mạng thuộc loại mạng nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (210, 215, N'Mạng máy tính EpuNet của Trường Đại học Điện Lực thuộc loại mạng nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (211, 216, N'Hai máy tính có thể kết nối trực tiếp với nhau để trao đổi thông tin, mạng kết nối 2 máy tính đó thuộc loại mạng nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (212, 217, N'Các tài nguyên nào có thể dùng chung được nhờ có mạng máy tính?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (213, 218, N'Người ta có thể điều khiển hoạt động của một máy tính từ xa thông qua công cụ nào sau đây?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (214, 219, N'Tại sao cần phải xây dựng hệ thống an ninh mạng máy tính?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (215, 220, N'Các thành phần tạo nên mạng máy tính là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (216, 221, N'Nguyên nhân nào gây ra việc hai máy tính (kết nối vật lý đã thông) trong mạng không thể trao đổi thông tin với nhau?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (217, 222, N'Một số vấn đề cơ bản khi mở rộng kết nối mạng?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (218, 223, N'Tại sao vấn đề an ninh mạng máy tính lại được quan tâm và phát triển hiện nay?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (219, 224, N'Ứng dụng nào sau hỗ trợ chức năng cập nhật phiên bản mới qua mạng?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (220, 225, N'Hệ điều hành Windows2000 tích hợp các ứng dụng mạng nào sau đây?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (221, 226, N'Ứng dụng nào sau có hỗ trợ chức năng truyền thông mạng?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (222, 227, N'Ứng dụng nào sau không hỗ trợ chức năng truyền thông mạng?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (223, 228, N'Ứng dụng nào sau có hỗ trợ chức năng truyền thông mạng?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (224, 229, N'Ứng dụng nào sau không hỗ trợ chức năng truyền thông mạng?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (225, 230, N'Tổ chức nào sau đây cung cấp dịch vụ truyền thông Internet?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (226, 231, N'Ứng dụng mạng nào sau đây cho phép gọi điện qua Internet?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (227, 232, N'Ứng dụng mạng nào sau đây cho phép truyền hình ảnh trực tiếp qua Internet?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (228, 233, N'Khi sử dụng mạng máy tính ta sẽ được các lợi ích:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (229, 234, N'Kiến trúc mạng máy tính là:', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (230, 235, N'Tầng nào trong mô hình OSI thực hiện gửi tín hiệu lên cáp?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (231, 236, N'Địa chỉ mạng được gán tại tầng nào trong mô hình OSI ?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (232, 237, N'Mô hình OSI được chia ra thành mấy tầng?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (233, 238, N'Mô hình OSI là một bộ định chuẩn của tổ chức nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (234, 239, N'Mô hình OSI được nghiên cứu bắt đầu từ năm nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (235, 240, N'Chức năng nén dữ liệu trước khi gửi được thực hiện bởi tầng chức năng nào trong mô hình OSI?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (236, 241, N'Chức năng chuyển đổi cú pháp cho dữ liệu truyền thông được thực hiện bởi tầng chức năng nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (237, 242, N'Chức năng xác lập địa chỉ cổng dịch vụ cho các gói dữ liệu truyền thông được thực hiện bởi tầng chức năng nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (238, 243, N'Chức năng đánh số thứ tự cho gói dữ liệu truyền thông được thực hiện bởi tầng chức năng nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (239, 244, N'Chức năng xác lập cơ chế truy nhập đường truyền được thực hiện bởi tầng chức năng nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (240, 245, N'Chức năng xác lập chuẩn đầu nối, dây cáp, tốc độ truyền, điện áp,… được thực hiện bởi tầng chức năng nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (241, 246, N'Những quy định nào sau đây không phải là của ISO dành cho việc xây dựng mô hình OSI?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (242, 247, N'Ý nghĩa của dữ liệu không được gán cho các tầng nào sau đây?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (243, 248, N'Các gói dữ liệu truyền thông giữa hai trạm theo mô hình OSI được truyền thông theo phương thức chuyển mạng gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (244, 249, N'Tầng nào trong mô hình OSI thực hiện chia nhỏ các gói tin nhận được từ tầng phiên trước khi gửi đi?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (245, 250, N'Chức năng định tuyến các gói tin xẩy ra ở tầng  nào trong mô hình OSI', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (246, 251, N'Khi gói tin bị mất hoặc bị lỗi thì tầng liên kết dữ liệu sẽ làm gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (247, 252, N'Thông thường, tầng liên kết dữ liệu sử dụng kỹ thuật nào để điều khiển tốc độ gửi và tốc độ nhận?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (248, 253, N'Định nghĩa địa chỉ IP được thực hiện tại tầng nào trong các tầng sau?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (249, 254, N'Việc đánh số thứ tự cho các gói tin của tầng giao vận có ý nghĩa gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (250, 255, N'Việc đánh số hiệu cổng cho các gói tin của tầng giao vận có ý nghĩa gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (251, 256, N'Việc chia nhỏ các gói tin tại tầng giao vận trước khi gửi đi có ý nghĩa gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (252, 257, N'Việc định nghĩa địa chỉ IP tại tầng mạng có ý nghĩa gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (253, 258, N'Việc định nghĩa địa chỉ MAC tại tầng liên kết dữ liệu có ý nghĩa gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (254, 259, N'Gói tin tại tầng liên kết dữ liệu có tên gọi là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (255, 260, N'Gói tin tại tầng mạng trong bộ giao thức TCP/IP có tên gọi là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (256, 261, N'Tầng nào trong mô hình OSI định nghĩa địa chỉ vật lý?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (257, 262, N'Chức năng cơ bản của  tầng liên kết dữ liệu là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (258, 263, N'Mục đích chính của việc xây dựng mô hình OSI là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (259, 264, N'Điều gì sẽ xẩy ra nếu không có mô hình OSI?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (260, 265, N'Tổ chức nào đã phát triển mô hình OSI', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (261, 266, N'Mỗi tầng chức năng trong mỗi hệ thống theo mô hình OSI trao đổi thông tin như thế nào với các tầng còn lại?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (262, 267, N'So sánh cấu trúc gói dữ liệu trao đổi của các tầng chức năng đồng mức ở hai hệ thống trao đổi thông tin với nhau theo mô hình OSI?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (263, 268, N'Tầng nào trong mô hình OSI có nhiệm vụ chia dữ liệu thành các khung (frame) để truyền lên mạng?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (264, 269, N'Các tầng chức năng đồng mức của hai hệ thống trao đổi thông tin với nhau theo mô hình OSI có liên kết với nhau như thế nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (265, 270, N'Thứ tự các tầng sắp xếp từ thấp đến cao trong mô hình OSI là', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (266, 271, N'Giao thức là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (267, 272, N'Giao thức có kết nối không cần thiết lập kết nối logic trước khi truyền dữ liệu, đúng hay sai?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (268, 273, N'Giao thức không kết nối không cần thiết lập kết nối logic trước khi truyền dữ liệu, đúng hay sai?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (269, 274, N'Truyền thông theo giao thức không kết nối an toàn hơn so với giao thức có kết nối, đúng hay sai?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (270, 275, N'Chức năng cơ bản của tầng vật lý trong mô hình OSI là  gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (271, 276, N'Dữ liệu tại tầng vật lý trong mô hình OSI ở dạng chuỗi bit và không có cấu trúc, đúng hay sai?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (272, 277, N'Chức năng nào sau đây không là chức năng của tầng vật lý?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (273, 278, N'Tầng liên kết dữ liệu có thể thực hiện chức năng nào sau đây?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (274, 279, N'Gói tin ở tầng mạng chứa các thông tin nào sau đây?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (275, 280, N'Tầng nào trong mô hình OSI chịu trách nhiệm mã hoá dữ liệu?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (276, 281, N'Tầng giao vận có thể cung cấp chức năng nào?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (277, 282, N'Xác thực người dùng được thực hiện bởi tầng chức năng nào', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (278, 283, N'Nguyên nhân nào có thể dẫn đến hai thực thể tầng mạng của hai máy tính trong mạng không trao đổi thông tin với nhau?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (279, 284, N'Đặc trưng của mạng cục bộ là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (280, 285, N'Mô hình ghép nối mạng (topo) là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (281, 286, N'Yếu tố khác nhau giữa mạng cục bộ và mạng diện rộng là', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (282, 287, N'Tốc độ truyền thông trong mạng cục bộ thường lớn hơn so với mạng diện rộng, đúng hay sai?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (283, 288, N'Tỉ suất lỗi xẩy ra trong mạng cục bộ thường lớn hơn so với mạng diện rộng, đúng hay sai?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (284, 289, N'Mạng cục bộ thường do nhiều cơ quan, tổ chức tham gia quản lý, đúng hay sai?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (285, 290, N'Liệt kê các mô hình ghép nối (topo) cơ bản của mạng cục bộ?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (286, 291, N'Mạng dạng tuyến(Bus) là gì?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (287, 292, N'Chuẩn IEEE nào định nghĩa mạng dùng mô hình kết nối mạng dạng vòng (ring)?', 0, 1)
INSERT [dbo].[tb_SubQuestion] ([id], [questionID], [content], [reportCount], [active]) VALUES (288, 293, N'Họ các chuẩn IEEE dành cho mạng cục bộ là', 0, 1)
SET IDENTITY_INSERT [dbo].[tb_SubQuestion] OFF
SET IDENTITY_INSERT [dbo].[tb_Teacher] ON 

INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password], [avatar]) VALUES (1, N'Nguyễn Thị Vân Giang', N'giang', N'giang', N'D:\Picture\Desktop\niem-tin-vao-cuoc-song.jpg')
INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password], [avatar]) VALUES (2, N'Nguyễn Văn Hiếu', N'hieu', N'hieu', NULL)
INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password], [avatar]) VALUES (3, N'1', N'1', N'1', NULL)
INSERT [dbo].[tb_Teacher] ([id], [name], [username], [password], [avatar]) VALUES (5, N's', N'ssss', N'sss', N'D:\Picture\Desktop\20170109-111328-hinh2_600x750-1.jpg')
SET IDENTITY_INSERT [dbo].[tb_Teacher] OFF
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
ALTER TABLE [dbo].[tb_Question]  WITH CHECK ADD  CONSTRAINT [FK_tb_Question_tb_Subject] FOREIGN KEY([subjectID])
REFERENCES [dbo].[tb_Subject] ([id])
GO
ALTER TABLE [dbo].[tb_Question] CHECK CONSTRAINT [FK_tb_Question_tb_Subject]
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
/****** Object:  Trigger [dbo].[tg_Insert_Answer]    Script Date: 6/20/2017 8:12:48 PM ******/
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
USE [master]
GO
ALTER DATABASE [Quiz] SET  READ_WRITE 
GO
