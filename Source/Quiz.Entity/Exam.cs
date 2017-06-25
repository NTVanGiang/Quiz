using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Exam
    {
        public string ID { get; set; }
        public string QuizID { get; set; }
        public string QuestionList { get; set; }
        public string CreateDate { get; set; }
        public string QuizName { get; set; }

        public void ExamIDataReader(SqlDataReader dr)
        {
            ID = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            QuizID = dr["quizID"] is DBNull ? string.Empty : dr["quizID"].ToString();
            QuestionList = dr["questionList"] is DBNull ? string.Empty : dr["questionList"].ToString();
            CreateDate = dr["createDate"] is DBNull ? "" : dr["createDate"].ToString();
            QuizName = dr["quizName"] is DBNull ? "" : dr["quizName"].ToString();
        }
    }
}
