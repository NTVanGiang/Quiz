using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Answer
    {
        private string id;
        private string subQuestionID;
        private string answer;
        private string isCorrect;
        //private string subquestionName;

        public Answer(string id, string subQuestionID, string answer, string isCorrect)
        {
            this.id = id;
            this.subQuestionID = subQuestionID;
            this.answer = answer;
            this.isCorrect = isCorrect;
        }

        public Answer()
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

        public string SubQuestionID
        {
            get
            {
                return subQuestionID;
            }

            set
            {
                subQuestionID = value;
            }
        }

        public string Answers
        {
            get
            {
                return answer;
            }

            set
            {
                answer = value;
            }
        }

        public string IsCorrect
        {
            get
            {
                return isCorrect;
            }

            set
            {
                isCorrect = value;
            }
        }
        //public string SubQuestionName
        //{
        //    get
        //    {
        //        return subquestionName;
        //    }

        //    set
        //    {
        //        subquestionName = value;
        //    }
        //}

        public void AnswerIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            SubQuestionID = dr["subQuestionID"] is DBNull ? string.Empty : dr["subQuestionID"].ToString();
            Answers = dr["answer"] is DBNull ? string.Empty : dr["answer"].ToString();
            IsCorrect = dr["isCorrect"] is DBNull ? "" : dr["isCorrect"].ToString();
            //SubQuestionName = dr["subquestionName"] is DBNull ? "" : dr["subquestionName"].ToString();
        }
    }
}
