using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Topic
    {
        private string id;
        private string topicName;
        private string subjectName;
        private string subjectID;

        public Topic(string id, string topicName, string subjectId)
        {
            this.id = id;
            this.topicName = topicName;
            subjectID = subjectId;
        }

        public Topic()
        {
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
            TopicName = dr["topicName"] is DBNull ? string.Empty : dr["topicName"].ToString();
            SubjectID = dr["subjectID"] is DBNull ? string.Empty : dr["subjectID"].ToString();
            SubjectName = dr["subjectName"] is DBNull ? string.Empty : dr["subjectName"].ToString();
        }
    }
}
