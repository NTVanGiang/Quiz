using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Result
    {
        public string Id { get; set; }
        public string StudentExamID { get; set; }
        public string Score { get; set; }
        public string StudentID { get; set; }
        public string ExamID { get; set; }
        public string StudentName { get; set; }
        public string Flag { get; set; }
        public void ResultIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            StudentExamID = dr["studentExamID"] is DBNull ? string.Empty : dr["studentExamID"].ToString();
            Score = dr["score"] is DBNull ? string.Empty : dr["score"].ToString();
            StudentID = dr["studentID"] is DBNull ? string.Empty : dr["studentID"].ToString();
            ExamID = dr["examID"] is DBNull ? string.Empty : dr["examID"].ToString();
            StudentName = dr["fullname"] is DBNull ? string.Empty : dr["fullname"].ToString();
            Flag = dr["flag"] is DBNull ? string.Empty : dr["flag"].ToString();
        }
    }
}
