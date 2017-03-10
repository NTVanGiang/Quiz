using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Teacher
    {
        private string id;
        private string name;
        private string username;
        private string password;

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

        public string Name
        {
            get
            {
                return name;
            }

            set
            {
                name = value;
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

        public void TeacherIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            Name = dr["name"] is DBNull ? string.Empty : dr["name"].ToString();
            Username = dr["username"] is DBNull ? string.Empty : dr["username"].ToString();
            Password = dr["password"] is DBNull ? "" : dr["password"].ToString();
        }
    }
}
