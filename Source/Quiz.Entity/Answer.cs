using System;
using System.Data.SqlClient;

namespace Quiz.Entity
{
    public class Answer
    {
        private string id;
        private string quesionID;
        private string answer;
        private string isCorrect;

        public Answer(string id, string quesionId, string answer, string isCorrect)
        {
            this.id = id;
            quesionID = quesionId;
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

        public string QuesionID
        {
            get
            {
                return quesionID;
            }

            set
            {
                quesionID = value;
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
        public void AnswerIDataReader(SqlDataReader dr)
        {
            Id = dr["id"] is DBNull ? string.Empty : dr["id"].ToString();
            QuesionID = dr["questionID"] is DBNull ? string.Empty : dr["questionID"].ToString();
            Answers = dr["answer"] is DBNull ? string.Empty : dr["answer"].ToString();
            IsCorrect = dr["isCorrect"] is DBNull ? "" : dr["isCorrect"].ToString();
        }
    }
}
