using Quiz.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Quiz.DAL
{
    public class QuestionDAL : SqlDataProvider
    {
        public List<Question> Question_GetByTop(string Top, string Where, string Order)
        {
            List<Question> list = new List<Question>();
            using (SqlCommand dbCmd = new SqlCommand("sp_Question_getByTop", openConnection()))
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
                        Question obj = new Question();
                        obj.QuestionIDataReader(dr);
                        list.Add(obj);
                    }
                }
                dr.Close();
            }
            return list;
        }
        public int Question_Insert(Question data)
        {
            int id = -1;
            data.CreateDate = DateTime.Now.ToString();
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Question_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@subjectID", data.SubjectID));
                    dbCmd.Parameters.Add(new SqlParameter("@content", data.Content));
                    dbCmd.Parameters.Add(new SqlParameter("@createDate", data.CreateDate));
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

        public bool Question_Update(Question data)
        {
            data.CreateDate = DateTime.Now.ToString();
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Question_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@subjectID", data.SubjectID));
                    dbCmd.Parameters.Add(new SqlParameter("@content", data.Content));
                    //dbCmd.Parameters.Add(new SqlParameter("@createDate", data.CreateDate));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Question_Delete(string ID)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Question_Delete", openConnection()))
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
