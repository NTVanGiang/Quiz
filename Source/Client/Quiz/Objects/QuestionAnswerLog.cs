using Quiz.BUS;
using Quiz.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Objects
{
    public class QuestionAnswerLog
    {
        public string subQuestionID { get; set; }
        public string studentAnswerID { get; set; }
        public bool IsCorrect()
        {
            if (studentAnswerID == null) return false;
            AnswerBUS obj = new AnswerBUS();
            try
            {
                Answer ans = obj.Answer_GetByTop("", "id = '" + studentAnswerID + "'", "").ElementAt(0);
                if (ans.IsCorrect.ToLower().Equals("true")) return true;
            }
            catch
            {

            }
            return false;
        }
    }
}
