using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Quiz.DAL;
using Quiz.Entity;

namespace Quiz.BUS
{
    public class ClassBUS
    {
        private ClassDAL obj = new ClassDAL();
        public List<Class> Class_GetByTop(string Top, string Where, string Order)
        {
            return obj.Class_GetByTop(Top, Where, Order);
        }
        public bool Class_Insert(Class data)
        {
            return obj.Class_Insert(data);
        }

        public bool Class_Update(Class data)
        {
            return obj.Class_Update(data);
        }

        public bool Class_Delete(string ID)
        {
            return obj.Class_Delete(ID);
        }
    }
}
