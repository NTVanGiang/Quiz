using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Topic
    {
        private string id;
        private string subjectID;
        private string topicName;

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

        public string SubjectID
        {
            get
            {
                return subjectID;
            }

            set
            {
                subjectID = value;
            }
        }

        public string TopicName
        {
            get
            {
                return topicName;
            }

            set
            {
                topicName = value;
            }
        }
        public void TopicIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            SubjectID = dr["subjectID"] is DBNull ? string.Empty : dr["fullname"].ToString();
            TopicName = dr["topicName"] is DBNull ? string.Empty : dr["topicName"].ToString();
        }
    }
}
