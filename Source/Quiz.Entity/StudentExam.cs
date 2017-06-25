using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class StudentExam
    {
        public string Id { get; set; }
        public string ExamID { get; set; }
        public string StudentID { get; set; }
        public string Flag { get; set; }
        public string StartTime { get; set; }
        public void StudentExamIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            ExamID = dr["examID"] is DBNull ? string.Empty : dr["examID"].ToString();
            StudentID = dr["studentID"] is DBNull ? string.Empty : dr["studentID"].ToString();
            Flag = dr["flag"] is DBNull ? "" : dr["flag"].ToString();
            StartTime = dr["startTime"] is DBNull ? "" : dr["startTime"].ToString();
        }
    }
}
