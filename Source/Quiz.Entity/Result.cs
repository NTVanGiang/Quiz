using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Result
    {
        public string Id { get; set; }
        public string StudentExamID { get; set; }
        public string Score { get; set; }
        public void ResultIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            StudentExamID = dr["studentExamID"] is DBNull ? string.Empty : dr["studentExamID"].ToString();
            Score = dr["score"] is DBNull ? string.Empty : dr["score"].ToString();
        }
    }
}
