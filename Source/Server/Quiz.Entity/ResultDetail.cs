using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class ResultDetail
    {
        public string Id { get; set; }
        public string ResultID { get; set; }
        public string SubQuestionID { get; set; }
        public string StudentAnswerID { get; set; }
        public void ResultDetailIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            ResultID = dr["resultID"] is DBNull ? string.Empty : dr["resultID"].ToString();
            SubQuestionID = dr["subQuestionID"] is DBNull ? string.Empty : dr["subQuestionID"].ToString();
            StudentAnswerID = dr["studentAnswerID"] is DBNull ? string.Empty : dr["studentAnswerID"].ToString();
        }
    }
}
