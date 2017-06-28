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
    public class StudentExamDAL : SqlDataProvider
    {
        public List<StudentExam> StudentExam_GetByTop(string Top, string Where, string Order)
        {
            List<StudentExam> list = new List<StudentExam>();
            using (SqlCommand dbCmd = new SqlCommand("sp_StudentExam_getByTop", openConnection()))
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
                        StudentExam obj = new StudentExam();
                        obj.StudentExamIDataReader(dr);
                        list.Add(obj);
                    }
                }
                dr.Close();
            }
            return list;
        }
        public int StudentExam_Insert(StudentExam data)
        {
            int id = -1;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_StudentExam_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@examID", data.ExamID));
                    dbCmd.Parameters.Add(new SqlParameter("@studentID", data.StudentID));
                    dbCmd.Parameters.Add(new SqlParameter("@flag", data.Flag));
                    dbCmd.Parameters.Add(new SqlParameter("@startTime", data.StartTime));
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

        public bool StudentExam_Update(StudentExam data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_StudentExam_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@isActive", data.IsActive));
                    dbCmd.Parameters.Add(new SqlParameter("@flag", data.Flag));
                    dbCmd.Parameters.Add(new SqlParameter("@startTime", data.StartTime));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool StudentExam_Delete(string ID)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_StudentExam_Delete", openConnection()))
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
