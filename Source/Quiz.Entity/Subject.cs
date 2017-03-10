using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Subject
    {
        private string id;
        private string subjectName;

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

        public string SubjectName
        {
            get
            {
                return subjectName;
            }

            set
            {
                subjectName = value;
            }
        }
        public void SubjectIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            SubjectName = dr["subjectName"] is DBNull ? string.Empty : dr["subjectName"].ToString();
        }
    }
}
