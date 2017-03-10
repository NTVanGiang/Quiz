using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Question
    {
        private string id;
        private string subjectID;
        private string parent;
        private string topicID;
        private string levelID;
        private string content;
        private string reuse;
        private string reportCount;
        private string createDate;
        private string active;

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

        public string Parent
        {
            get
            {
                return parent;
            }

            set
            {
                parent = value;
            }
        }

        public string TopicID
        {
            get
            {
                return topicID;
            }

            set
            {
                topicID = value;
            }
        }

        public string LevelID
        {
            get
            {
                return levelID;
            }

            set
            {
                levelID = value;
            }
        }

        public string Content
        {
            get
            {
                return content;
            }

            set
            {
                content = value;
            }
        }

        public string Reuse
        {
            get
            {
                return reuse;
            }

            set
            {
                reuse = value;
            }
        }

        public string ReportCount
        {
            get
            {
                return reportCount;
            }

            set
            {
                reportCount = value;
            }
        }

        public string CreateDate
        {
            get
            {
                return createDate;
            }

            set
            {
                createDate = value;
            }
        }

        public string Active
        {
            get
            {
                return active;
            }

            set
            {
                active = value;
            }
        }
        public void QuestionIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            SubjectID = dr["subjectID"] is DBNull ? string.Empty : dr["subjectID"].ToString();
            Parent = dr["parent"] is DBNull ? string.Empty : dr["parent"].ToString();
            TopicID = dr["topicID"] is DBNull ? "" : dr["topicID"].ToString(); 
            LevelID = dr["levelID"] is DBNull ? string.Empty : dr["levelID"].ToString();
            Content = dr["content"] is DBNull ? string.Empty : dr["content"].ToString();
            ReportCount = dr["reportCount"] is DBNull ? "" : dr["reportCount"].ToString();
            CreateDate = dr["createDate"] is DBNull ? "" : dr["createDate"].ToString();
            Active = dr["active"] is DBNull ? "" : dr["active"].ToString();
        }
    }
}
