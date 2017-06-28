using System;
using System.Data.SqlClient;

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
        private string className;

        public Student() { }

        public Student(String id, string fullname, string username, string password, string classID, string status)
        {
            this.id = id;
            this.fullname = fullname;
            this.username = username;
            this.password = password;
            this.classID = classID;
            this.status = status;
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

        public void StudentIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            Fullname = dr["fullname"] is DBNull ? string.Empty : dr["fullname"].ToString();
            Username = dr["username"] is DBNull ? string.Empty : dr["username"].ToString();
            Password = dr["password"] is DBNull ? string.Empty : dr["password"].ToString();
            ClassID = dr["classID"] is DBNull ? string.Empty : dr["classID"].ToString();
            Status = dr["status"] is DBNull ? string.Empty : dr["status"].ToString();
            ClassName = dr["className"] is DBNull ? string.Empty : dr["className"].ToString(); ;
        }
    }
}
