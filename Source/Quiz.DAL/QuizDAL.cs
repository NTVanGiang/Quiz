using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Quiz.DAL
{
    public class QuizDAL: SqlDataProvider
    {
        public List<Quiz.Entity.Quiz> Quiz_GetByTop(string Top, string Where, string Order)
        {
            List<Quiz.Entity.Quiz> list = new List<Quiz.Entity.Quiz>();
            using (SqlCommand dbCmd = new SqlCommand("sp_Quiz_getByTop", openConnection()))
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
                        Quiz.Entity.Quiz obj = new Quiz.Entity.Quiz();
                        obj.QuizIDataReader(dr);
                        list.Add(obj);
                    }
                }
                dr.Close();
            }
            return list;
        }
        public bool Quiz_Insert(Quiz.Entity.Quiz data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Quiz_Insert", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@subjectID", data.SubjectID));
                    dbCmd.Parameters.Add(new SqlParameter("@quizName", data.QuizName));
                    dbCmd.Parameters.Add(new SqlParameter("@questionCount", data.QuestionCount));
                    dbCmd.Parameters.Add(new SqlParameter("@timeStart", data.TimeStart));
                    dbCmd.Parameters.Add(new SqlParameter("@time", data.Time));
                    dbCmd.Parameters.Add(new SqlParameter("@questionList", data.QuestionList));
                    dbCmd.Parameters.Add(new SqlParameter("@teacherID", data.TeacherID));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Quiz_Update(Quiz.Entity.Quiz data)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Quiz_Update", openConnection()))
                {
                    dbCmd.CommandType = CommandType.StoredProcedure;
                    dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@subjectID", data.SubjectID));
                    dbCmd.Parameters.Add(new SqlParameter("@quizName", data.QuizName));
                    dbCmd.Parameters.Add(new SqlParameter("@questionCount", data.QuestionCount));
                    dbCmd.Parameters.Add(new SqlParameter("@timeStart", data.TimeStart));
                    dbCmd.Parameters.Add(new SqlParameter("@time", data.Time));
                    dbCmd.Parameters.Add(new SqlParameter("@questionList", data.QuestionList));
                    dbCmd.Parameters.Add(new SqlParameter("@teacherID", data.TeacherID));
                    int r = dbCmd.ExecuteNonQuery();
                    if (r > 0) check = true;
                }
            }
            catch
            {
            }
            return check;
        }

        public bool Quiz_Delete(string ID)
        {
            bool check = false;
            try
            {
                using (SqlCommand dbCmd = new SqlCommand("sp_Quiz_Delete", openConnection()))
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
