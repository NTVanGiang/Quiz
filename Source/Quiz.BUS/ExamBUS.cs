using Quiz.DAL;
using Quiz.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.BUS
{
    public class ExamBUS
    {
        private ExamDAL obj = new ExamDAL();
        public List<Exam> Exam_GetByTop(string Top, string Where, string Order)
        {
            return obj.Exam_GetByTop(Top, Where, Order);
        }
        public int Exam_Insert(Exam data)
        {
            return obj.Exam_Insert(data);
        }

        public bool Exam_Update(Exam data)
        {
            return obj.Exam_Update(data);
        }

        public bool Exam_Delete(string ID)
        {
            return obj.Exam_Delete(ID);
        }
    }
}
