using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Image
    {
        private string id;
        private string url;
        private string questionID;
        private string alt;

        public string Id
        {
            get
            {
                return id;
            }

            set
            {
                id = value;
            }
        }

        public string Url
        {
            get
            {
                return url;
            }

            set
            {
                url = value;
            }
        }

        public string QuestionID
        {
            get
            {
                return questionID;
            }

            set
            {
                questionID = value;
            }
        }

        public string Alt
        {
            get
            {
                return alt;
            }

            set
            {
                alt = value;
            }
        }

        public void ImageIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            Alt = dr["alt"] is DBNull ? string.Empty : dr["alt"].ToString();
            QuestionID = dr["questionID"] is DBNull ? string.Empty : dr["questionID"].ToString();
            Url = dr["url"] is DBNull ? "" : dr["url"].ToString();
        }
    }
}
