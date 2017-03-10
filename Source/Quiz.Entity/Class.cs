using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
   public class Class
    {
        private string id;
        private string className;
        private string facultyID;

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

        public string ClassName
        {
            get
            {
                return className;
            }

            set
            {
                className = value;
            }
        }

        public string FacultyID
        {
            get
            {
                return facultyID;
            }

            set
            {
                facultyID = value;
            }
        }
        public void ClassIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            ClassName = dr["className"] is DBNull ? string.Empty : dr["className"].ToString();
            FacultyID = dr["facultyID"] is DBNull ? string.Empty : dr["facultyID"].ToString();
        }
    }
}
