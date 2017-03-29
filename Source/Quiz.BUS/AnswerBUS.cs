using System.Collections.Generic;

using Quiz.DAL;
using Quiz.Entity;

namespace Quiz.BUS
{
    public class AnswerBUS
    {
        private AnswerDAL obj = new AnswerDAL();
        public List<Answer> Answer_GetByTop(string Top, string Where, string Order)
        {
            return obj.Answer_GetByTop(Top, Where, Order);
        }
        public bool Answer_Insert(Answer data)
        {
            return obj.Answer_Insert(data);
        }

        public bool Answer_Update(Answer data)
        {
            return obj.Answer_Update(data);
        }

        public bool Answer_Delete(string ID)
        {
            return obj.Answer_Delete(ID);
        }
    }
}
