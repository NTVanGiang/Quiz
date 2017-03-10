using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class Answer
    {
        private string id;
        private string quesionID;
        private string answer;
        private string isCorrect;

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
