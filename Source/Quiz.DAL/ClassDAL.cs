using Quiz.Entity;

using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Quiz.DAL
{
    public class ClassDAL : SqlDataProvider
    {
            public List<Class> Class_GetByTop(string Top, string Where, string Order)
            {
                List<Class> list = new List<Class>();
                using (SqlCommand dbCmd = new SqlCommand("sp_Class_getByTop", openConnection()))
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
                            Class obj = new Class();
                            obj.ClassIDataReader(dr);
                            list.Add(obj);
                        }
                    }
                    dr.Close();
                }
                return list;
            }
            public bool Class_Insert(Class data)
            {
                bool check = false;
                try
                {
                    using (SqlCommand dbCmd = new SqlCommand("sp_Class_Insert", openConnection()))
                    {
                        dbCmd.CommandType = CommandType.StoredProcedure;
                        dbCmd.Parameters.Add(new SqlParameter("@className", data.ClassName));
                        dbCmd.Parameters.Add(new SqlParameter("@facultyID", data.FacultyID));
                        int r = dbCmd.ExecuteNonQuery();
                        if (r > 0) check = true;
                    }
                }
                catch
                {
                }
                return check;
            }

            public bool Class_Update(Class data)
            {
                bool check = false;
                try
                {
                    using (SqlCommand dbCmd = new SqlCommand("sp_Class_Update", openConnection()))
                    {
                        dbCmd.CommandType = CommandType.StoredProcedure;
                        dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@className", data.ClassName));
                    dbCmd.Parameters.Add(new SqlParameter("@facultyID", data.FacultyID));
                    int r = dbCmd.ExecuteNonQuery();
                        if (r > 0) check = true;
                    }
                }
                catch
                {
                }
                return check;
            }

            public bool Class_Delete(string ID)
            {
                bool check = false;
                try
                {
                    using (SqlCommand dbCmd = new SqlCommand("sp_Class_Delete", openConnection()))
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
