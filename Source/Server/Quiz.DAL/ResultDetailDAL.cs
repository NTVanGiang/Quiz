using Quiz.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.DAL
{
    public class ResultDetailDAL : SqlDataProvider
    {
        public List<ResultDetail> ResultDetail_GetByTop(string Top, string Where, string Order)
        {
            List<ResultDetail> list = new List<ResultDetail>();
            using (SqlCommand dbCmd = new SqlCommand("sp_ResultDetail_getByTop", openConnection()))
            {
                dbCmd.CommandType = CommandType.StoredProcedure;
                dbCmd.Parameters.Add(new SqlParameter("@Top", Top));
                dbCmd.Parameters.Add(new SqlParameter("@Where", Where));
                dbCmd.Parameters.Add(new SqlParameter("@Order", Order));
                SqlDataReader dr = dbCmd.ExecuteReader();
                dr.Close();
                dr = dbCmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        ResultDetail obj = new ResultDetail();
                        obj.ResultDetailIDataReader(dr);
                        list.Add(obj);
                    }
                }
                dr.Close();
            }
            return list;
        }
        public int ResultDetail_Insert(ResultDetail data)
        {
            int id = -1;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_ResultDetail_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@resultID", data.ResultID));
                    dbCmd.Parameters.Add(new SqlParameter("@subquestionID", data.SubQuestionID));
                    dbCmd.Parameters.Add(new SqlParameter("@studentAnswerID", data.StudentAnswerID));
                    dbCmd.Parameters.Add("@id", SqlDbType.Int).Direction = ParameterDirection.Output;
                    dbCmd.ExecuteNonQuery();
                    id = int.Parse(dbCmd.Parameters["@id"].Value.ToString());
                }
            }
            catch
            {
            }
            return id;
        }

        public bool ResultDetail_Update(ResultDetail data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_ResultDetail_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@resultID", data.ResultID));
                    dbCmd.Parameters.Add(new SqlParameter("@subquestionID", data.SubQuestionID));
                    dbCmd.Parameters.Add(new SqlParameter("@studentAnswerID", data.StudentAnswerID));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool ResultDetail_Delete(string ID)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_ResultDetail_Delete", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", ID));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }
    }
}
