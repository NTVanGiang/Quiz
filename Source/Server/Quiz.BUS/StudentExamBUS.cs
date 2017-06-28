using Quiz.DAL;
using Quiz.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.BUS
{
    public class StudentExamBUS
    {
        private StudentExamDAL obj = new StudentExamDAL();
        public List<StudentExam> StudentExam_GetByTop(string Top, string Where, string Order)
        {
            return obj.StudentExam_GetByTop(Top, Where, Order);
        }
        public int StudentExam_Insert(StudentExam data)
        {
            return obj.StudentExam_Insert(data);
        }

        public bool StudentExam_Update(StudentExam data)
        {
            return obj.StudentExam_Update(data);
        }

        public bool StudentExam_Delete(string ID)
        {
            return obj.StudentExam_Delete(ID);
        }
    }
}

