using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Level
    {
        private string id;
        private string detail;

        public Level(string id, string detail)
        {
            this.id = id;
            this.detail = detail;
        }

        public Level() { }

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

        public string Detail
        {
            get
            {
                return detail;
            }

            set
            {
                detail = value;
            }
        }

        public void LevelIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            Detail = dr["detail"] is DBNull ? string.Empty : dr["detail"].ToString();
        }
    }
}
