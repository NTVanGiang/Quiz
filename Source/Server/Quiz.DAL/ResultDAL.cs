using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Quiz.Entity;
using System;

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
        public int Result_Insert(Result data)
        {
            int id = -1;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Result_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@studentExamID", data.StudentExamID));
                    dbCmd.Parameters.Add(new SqlParameter("@score", data.Score));
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

        public int Result_Update(Result data)
        {
            int id = -1;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Result_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@studentExamID", data.StudentExamID));
                    dbCmd.Parameters.Add(new SqlParameter("@score", data.Score));
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
