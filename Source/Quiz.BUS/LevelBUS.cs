using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Quiz.DAL;
using Quiz.Entity;

namespace Quiz.BUS
{
    public class LevelBUS
    {
        private LevelDAL obj = new LevelDAL();
        public List<Level> Level_GetByTop(string Top, string Where, string Order)
        {
            return obj.Level_GetByTop(Top, Where, Order);
        }
        public bool Level_Insert(Level data)
        {
            return obj.Level_Insert(data);
        }

        public bool Level_Update(Level data)
        {
            return obj.Level_Update(data);
        }

        public bool Level_Delete(string ID)
        {
            return obj.Level_Delete(ID);
        }
    }
}
