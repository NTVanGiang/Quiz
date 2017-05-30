using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Quiz.Entity;
namespace Quiz.DAL
{
    public class TeacherDAL: SqlDataProvider
    {
        public List<Teacher> Teacher_GetByTop(string Top, string Where, string Order)
        {
            List<Teacher> list = new List<Teacher>();
            using (SqlCommand dbCmd = new SqlCommand("sp_Teacher_getByTop", openConnection()))
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
                        Teacher obj = new Teacher();
                        obj.TeacherIDataReader(dr);
                        list.Add(obj);
                    }
                }
                dr.Close();
            }
            return list;
        }
        public bool Teacher_Insert(Teacher data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Teacher_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@name", data.Name));
                    dbCmd.Parameters.Add(new SqlParameter("@username", data.Username));
                    dbCmd.Parameters.Add(new SqlParameter("@password", data.Password));
                    dbCmd.Parameters.Add(new SqlParameter("@avatar", data.Avatar));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Teacher_Update(Teacher data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Teacher_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@name", data.Name));
                    dbCmd.Parameters.Add(new SqlParameter("@username", data.Username));
                    dbCmd.Parameters.Add(new SqlParameter("@password", data.Password));
                    dbCmd.Parameters.Add(new SqlParameter("@avatar", data.Avatar));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Teacher_Delete(string ID)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Teacher_Delete", openConnection()))
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

        public bool Teacher_LoginValid(String u, String p) {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Teacher_LoginValid", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@username", u));
                    dbCmd.Parameters.Add(new SqlParameter("@password", p));
                    int r = (int)dbCmd.ExecuteScalar();
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
