using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Student
    {
        private string id;
        private string fullname;
        private string username;
        private string password;
        private string classID;
        private string status;

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

        public string Fullname
        {
            get
            {
                return fullname;
            }

            set
            {
                fullname = value;
            }
        }

        public string Username
        {
            get
            {
                return username;
            }

            set
            {
                username = value;
            }
        }

        public string Password
        {
            get
            {
                return password;
            }

            set
            {
                password = value;
            }
        }

        public string ClassID
        {
            get
            {
                return classID;
            }

            set
            {
                classID = value;
            }
        }

        public string Status
        {
            get
            {
                return status;
            }

            set
            {
                status = value;
            }
        }

        public void StudentIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            Fullname = dr["fullname"] is DBNull ? string.Empty : dr["fullname"].ToString();
            Username = dr["username"] is DBNull ? string.Empty : dr["username"].ToString();
            Password = dr["password"] is DBNull ? string.Empty : dr["password"].ToString();
            ClassID = dr["classID"] is DBNull ? string.Empty : dr["classID"].ToString();
            Status = dr["status"] is DBNull ? string.Empty : dr["status"].ToString();
        }
    }
}
