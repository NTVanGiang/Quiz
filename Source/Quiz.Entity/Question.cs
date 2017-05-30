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
        private string createDate;
        private string subjectName;
        private string topicName;
        private string levelName;

        public Question(string id, string subjectId, string topicId, string levelId, string content, string createDate)
        {
            this.id = id;
            this.subjectID = subjectId;
            this.topicID = topicId;
            this.levelID = levelId;
            this.content = content;
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

        public string LevelName
        {
            get
            {
                return levelName;
            }

            set
            {
                levelName = value;
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
            SubjectName = dr["subjectName"] is DBNull ? string.Empty : dr["subjectName"].ToString();
            TopicName = dr["topicName"] is DBNull ? string.Empty : dr["topicName"].ToString();
            LevelName = dr["levelName"] is DBNull ? string.Empty : dr["levelName"].ToString();
        }
    }
}
