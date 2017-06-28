using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Subject
    {
        private String id;
        private String subjectName;

        public Subject(string id, string name)
        {
            this.Id = id;
            this.SubjectName = name;
        }

        public Subject()
        {

        }

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
