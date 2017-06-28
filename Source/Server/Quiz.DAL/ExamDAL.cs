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
    public class ExamDAL : SqlDataProvider
    {
        public List<Exam> Exam_GetByTop(string Top, string Where, string Order)
        {
            List<Exam> list = new List<Exam>();
            using (SqlCommand dbCmd = new SqlCommand("sp_Exam_getByTop", openConnection()))
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
                        Exam obj = new Exam();
                        obj.ExamIDataReader(dr);
                        list.Add(obj);
                    }
                }
                dr.Close();
            }
            return list;
        }
        public int Exam_Insert(Exam data)
        {
            int id = -1;
            data.CreateDate = DateTime.Now.ToString();
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Exam_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@quizID", data.QuizID));
                    dbCmd.Parameters.Add(new SqlParameter("@questionList", data.QuestionList));
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

        public bool Exam_Update(Exam data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Exam_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.ID));
                    dbCmd.Parameters.Add(new SqlParameter("@quizID", data.QuizID));
                    dbCmd.Parameters.Add(new SqlParameter("@questionList", data.QuestionList));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Exam_Delete(string ID)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Exam_Delete", openConnection()))
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
