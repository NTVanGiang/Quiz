using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Question
    {
        private string id;
        private string subjectID;
        private string topicID;
        private string levelID;
        private string content;
        private string reuse;
        private string createDate;

        public Question(string id, string subjectId, string topicId, string levelId, string content, string reuse, string createDate)
        {
            this.id = id;
            subjectID = subjectId;
            topicID = topicId;
            levelID = levelId;
            this.content = content;
            this.reuse = reuse;
            this.createDate = createDate;
        }

        public Question()
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
        public void QuestionIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            SubjectID = dr["subjectID"] is DBNull ? string.Empty : dr["subjectID"].ToString();
            TopicID = dr["topicID"] is DBNull ? "" : dr["topicID"].ToString(); 
            LevelID = dr["levelID"] is DBNull ? string.Empty : dr["levelID"].ToString();
            Content = dr["content"] is DBNull ? string.Empty : dr["content"].ToString();
            CreateDate = dr["createDate"] is DBNull ? "" : dr["createDate"].ToString();
        }
    }
}
