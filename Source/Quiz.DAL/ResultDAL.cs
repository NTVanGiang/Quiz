using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using Quiz.Entity;


namespace Quiz.DAL
{
    public class ResultDAL: SqlDataProvider
    {
        public List<Result> Result_GetByTop(string Top, string Where, string Order)
        {
            List<Result> list = new List<Result>();
            using (SqlCommand dbCmd = new SqlCommand("sp_Result_getByTop", openConnection()))
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
                        Result obj = new Result();
                        obj.ResultIDataReader(dr);
                        list.Add(obj);
                    }
                }
                dr.Close();
            }
            return list;
        }
        public bool Result_Insert(Result data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Result_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@studentID", data.StudentID));
                    dbCmd.Parameters.Add(new SqlParameter("@quizID", data.QuizID));
                    dbCmd.Parameters.Add(new SqlParameter("@score", data.Score));
                    dbCmd.Parameters.Add(new SqlParameter("@quizDate", data.QuizDate));
                    dbCmd.Parameters.Add(new SqlParameter("@flag", data.Flag));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Result_Update(Result data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Result_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@studentID", data.StudentID));
                    dbCmd.Parameters.Add(new SqlParameter("@quizID", data.QuizID));
                    dbCmd.Parameters.Add(new SqlParameter("@score", data.Score));
                    dbCmd.Parameters.Add(new SqlParameter("@quizDate", data.QuizDate));
                    dbCmd.Parameters.Add(new SqlParameter("@flag", data.Flag));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Result_Delete(string ID)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Result_Delete", openConnection()))
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
