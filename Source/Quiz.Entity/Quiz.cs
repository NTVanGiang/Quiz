using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Quiz
    {
        private string id;
        private string subjectID;
        private string quizName;
        private string time;
        private string teacherID;
        private string teacherName;
        private string subjectName;

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
        public string TeacherName
        {
            get
            {
                return teacherName;
            }

            set
            {
                teacherName = value;
            }
        }
        public string SubJectName
        {
            get
            {
                return subjectName;
            }

            set
            {
                subjectName = value;
            }
        }
        public string QCountSingle { get; set; }
        public string QCountMultiple { get; set; }
        public void QuizIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            SubjectID = dr["subjectID"] is DBNull ? string.Empty : dr["subjectID"].ToString();
            QuizName = dr["quizName"] is DBNull ? string.Empty : dr["quizName"].ToString();
            QCountMultiple = dr["qCountMultiple"] is DBNull ? "" : dr["qCountMultiple"].ToString();
            QCountSingle = dr["qCountSingle"] is DBNull ? "" : dr["qCountSingle"].ToString();
            Time = dr["time"] is DBNull ? string.Empty : dr["time"].ToString();
            TeacherID = dr["teacherID"] is DBNull ? "" : dr["teacherID"].ToString();
            TeacherName = dr["teacherName"] is DBNull ? "" : dr["teacherName"].ToString();
            SubJectName = dr["subjectName"] is DBNull ? "" : dr["subjectName"].ToString();
        }
    }
}
