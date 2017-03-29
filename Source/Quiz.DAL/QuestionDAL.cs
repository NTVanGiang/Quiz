﻿using Quiz.Entity;

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
        public bool Question_Insert(Question data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Question_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@subjectID", data.SubjectID));
                    dbCmd.Parameters.Add(new SqlParameter("@topicID", data.TopicID));
                    dbCmd.Parameters.Add(new SqlParameter("@levelID", data.LevelID));
                    dbCmd.Parameters.Add(new SqlParameter("@content", data.Content));
                    dbCmd.Parameters.Add(new SqlParameter("@reuse", data.Reuse));
                    dbCmd.Parameters.Add(new SqlParameter("@createDate", data.CreateDate));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Question_Update(Question data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Question_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@subjectID", data.SubjectID));
                    dbCmd.Parameters.Add(new SqlParameter("@topicID", data.TopicID));
                    dbCmd.Parameters.Add(new SqlParameter("@levelID", data.LevelID));
                    dbCmd.Parameters.Add(new SqlParameter("@content", data.Content));
                    dbCmd.Parameters.Add(new SqlParameter("@reuse", data.Reuse));
                    dbCmd.Parameters.Add(new SqlParameter("@createDate", data.CreateDate));
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
