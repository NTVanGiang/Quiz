using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using Quiz.Entity;
namespace Quiz.DAL
{
    public class StudentDAL: SqlDataProvider
    {
        public List<Student> Student_GetByTop(string Top, string Where, string Order)
        {
            List<Student> list = new List<Student>();
            using (SqlCommand dbCmd = new SqlCommand("sp_Student_getByTop", openConnection()))
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
                        Student obj = new Student();
                        obj.StudentIDataReader(dr);
                        list.Add(obj);
                    }
                }
                dr.Close();
            }
            return list;
        }
        public bool Student_Insert(Student data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Student_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@fullname", data.Fullname));
                    dbCmd.Parameters.Add(new SqlParameter("@username", data.Username));
                    dbCmd.Parameters.Add(new SqlParameter("@password", data.Password));
                    dbCmd.Parameters.Add(new SqlParameter("@classID", data.ClassID));
                    dbCmd.Parameters.Add(new SqlParameter("@status", data.Status));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Student_Update(Student data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Student_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@fullname", data.Fullname));
                    dbCmd.Parameters.Add(new SqlParameter("@username", data.Username));
                    dbCmd.Parameters.Add(new SqlParameter("@password", data.Password));
                    dbCmd.Parameters.Add(new SqlParameter("@classID", data.ClassID));
                    dbCmd.Parameters.Add(new SqlParameter("@status", data.Status));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Student_Delete(string ID)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Student_Delete", openConnection()))
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
