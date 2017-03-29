using Quiz.Entity;

using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Quiz.DAL
{
    public class ImageDAL : SqlDataProvider
    {
            public List<Image> Image_GetByTop(string Top, string Where, string Order)
            {
                List<Image> list = new List<Image>();
                using (SqlCommand dbCmd = new SqlCommand("sp_Image_getByTop", openConnection()))
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
                            Image obj = new Image();
                            obj.ImageIDataReader(dr);
                            list.Add(obj);
                        }
                    }
                    dr.Close();
                }
                return list;
            }
            public bool Image_Insert(Image data)
            {
                bool check = false;
                try
                {
                    using (SqlCommand dbCmd = new SqlCommand("sp_Image_Insert", openConnection()))
                    {
                        dbCmd.CommandType = CommandType.StoredProcedure;
                        dbCmd.Parameters.Add(new SqlParameter("@url", data.Url));
                        dbCmd.Parameters.Add(new SqlParameter("@questionID", data.QuestionID));
                        dbCmd.Parameters.Add(new SqlParameter("@alt", data.Alt));
                        int r = dbCmd.ExecuteNonQuery();
                        if (r > 0) check = true;
                    }
                }
                catch
                {
                }
                return check;
            }

            public bool Image_Update(Image data)
            {
                bool check = false;
                try
                {
                    using (SqlCommand dbCmd = new SqlCommand("sp_Image_Update", openConnection()))
                    {
                        dbCmd.CommandType = CommandType.StoredProcedure;
                        dbCmd.Parameters.Add(new SqlParameter("@id", data.Id));
                    dbCmd.Parameters.Add(new SqlParameter("@url", data.Url));
                    dbCmd.Parameters.Add(new SqlParameter("@questionID", data.QuestionID));
                    dbCmd.Parameters.Add(new SqlParameter("@alt", data.Alt));
                    int r = dbCmd.ExecuteNonQuery();
                        if (r > 0) check = true;
                    }
                }
                catch
                {
                }
                return check;
            }

            public bool Image_Delete(string ID)
            {
                bool check = false;
                try
                {
                    using (SqlCommand dbCmd = new SqlCommand("sp_Image_Delete", openConnection()))
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
