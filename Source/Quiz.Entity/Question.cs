using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Question
    {
        private string id;
        private string subjectID;
        private string content;
        private string createDate;
        private string subjectName;

        public Question(string id, string subjectId, string content, string createDate)
        {
            this.id = id;
            this.subjectID = subjectId;
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
        
        public void QuestionIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            SubjectID = dr["subjectID"] is DBNull ? string.Empty : dr["subjectID"].ToString();
            Content = dr["content"] is DBNull ? string.Empty : dr["content"].ToString();
            CreateDate = dr["createDate"] is DBNull ? "" : dr["createDate"].ToString();
            SubjectName = dr["subjectName"] is DBNull ? string.Empty : dr["subjectName"].ToString();
        }
    }
}
