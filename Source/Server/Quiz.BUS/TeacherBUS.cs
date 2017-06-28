using System;
using System.Collections.Generic;

using Quiz.DAL;
using Quiz.Entity;

namespace Quiz.BUS
{
    public class TeacherBUS
    {
        private TeacherDAL obj = new TeacherDAL();
        public List<Teacher> Teacher_GetByTop(string Top, string Where, string Order)
        {
            return obj.Teacher_GetByTop(Top, Where, Order);
        }
        public bool Teacher_Insert(Teacher data)
        {
            return obj.Teacher_Insert(data);
        }

        public bool Teacher_Update(Teacher data)
        {
            return obj.Teacher_Update(data);
        }

        public bool Teacher_Delete(string ID)
        {
            return obj.Teacher_Delete(ID);
        }
        public bool Teacher_LoginValid(String u, String p) {
            return obj.Teacher_LoginValid(u, p);
        }
    }
}
