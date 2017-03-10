using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Quiz
    {
        private string id;
        private string subjectID;
        private string quizName;
        private string questionCount;
        private string timeStart;
        private string time;
        private string questionList;
        private string teacherID;

        public string Id
        {
            get
            {
                return id;
            }

            set
            {
                id = value;
            }
        }

        public string SubjectID
        {
            get
            {
                return subjectID;
            }

            set
            {
                subjectID = value;
            }
        }

        public string QuizName
        {
            get
            {
                return quizName;
            }

            set
            {
                quizName = value;
            }
        }

        public string QuestionCount
        {
            get
            {
                return questionCount;
            }

            set
            {
                questionCount = value;
            }
        }

        public string TimeStart
        {
            get
            {
                return timeStart;
            }

            set
            {
                timeStart = value;
            }
        }

        public string Time
        {
            get
            {
                return time;
            }

            set
            {
                time = value;
            }
        }

        public string QuestionList
        {
            get
            {
                return questionList;
            }

            set
            {
                questionList = value;
            }
        }

        public string TeacherID
        {
            get
            {
                return teacherID;
            }

            set
            {
                teacherID = value;
            }
        }
        public void QuizIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            SubjectID = dr["subjectID"] is DBNull ? string.Empty : dr["subjectID"].ToString();
            QuizName = dr["quizName"] is DBNull ? string.Empty : dr["quizName"].ToString();
            QuestionCount = dr["questionCount"] is DBNull ? "" : dr["questionCount"].ToString();
            TimeStart = dr["timeStart"] is DBNull ? string.Empty : dr["timeStart"].ToString();
            Time = dr["time"] is DBNull ? string.Empty : dr["time"].ToString();
            QuestionList = dr["questionList"] is DBNull ? string.Empty : dr["questionList"].ToString();
            TeacherID = dr["teacherID"] is DBNull ? "" : dr["teacherID"].ToString();
        }
    }
}
