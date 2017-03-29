using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Result
    {
        private String id;
        private String studentID;
        private String quizID;
        private String score;
        private String quizDate;
        private String flag;

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

        public string StudentID
        {
            get
            {
                return studentID;
            }

            set
            {
                studentID = value;
            }
        }

        public string QuizID
        {
            get
            {
                return quizID;
            }

            set
            {
                quizID = value;
            }
        }

        public string Score
        {
            get
            {
                return score;
            }

            set
            {
                score = value;
            }
        }

        public string QuizDate
        {
            get
            {
                return quizDate;
            }

            set
            {
                quizDate = value;
            }
        }

        public string Flag
        {
            get
            {
                return flag;
            }

            set
            {
                flag = value;
            }
        }
        public void ResultIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            Flag = dr["flag"] is DBNull ? string.Empty : dr["flag"].ToString();
            StudentID = dr["studentID"] is DBNull ? string.Empty : dr["studentID"].ToString();
            QuizDate = dr["quizDate"] is DBNull ? "" : dr["quizDate"].ToString();
            Score = dr["score"] is DBNull ? "" : dr["score"].ToString();
            QuizID = dr["quizID"] is DBNull ? "" : dr["quizID"].ToString();
        }
    }
}
