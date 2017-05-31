using System;
using System.Collections.Generic;

using Quiz.DAL;
using Quiz.Entity;

namespace Quiz.BUS
{
    public class SubQuestionBUS
    {
        private SubQuestionDAL obj = new SubQuestionDAL();

        public List<SubQuestion> SubQuestion_GetByTop(string Top, string Where, string Order)
        {
            return obj.SubQuestion_GetByTop(Top, Where, Order);
        }

        public bool SubQuestion_Insert(SubQuestion data)
        {
            return obj.SubQuestion_Insert(data);
        }
        public bool SubQuestion_Update(SubQuestion data)
        {
            return obj.SubQuestion_Update(data);
        }
        public bool SubQuestion_Delete(String id)
        {
            return obj.SubQuestion_Delete(id);
        }
    }
}
