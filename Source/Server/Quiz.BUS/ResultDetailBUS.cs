using Quiz.DAL;
using Quiz.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.BUS
{
    public class ResultDetailDetailBUS
    {
        private ResultDetailDAL obj = new ResultDetailDAL();
        public List<ResultDetail> ResultDetail_GetByTop(string Top, string Where, string Order)
        {
            return obj.ResultDetail_GetByTop(Top, Where, Order);
        }
        public int ResultDetail_Insert(ResultDetail data)
        {
            return obj.ResultDetail_Insert(data);
        }

        public bool ResultDetail_Update(ResultDetail data)
        {
            return obj.ResultDetail_Update(data);
        }

        public bool ResultDetail_Delete(string ID)
        {
            return obj.ResultDetail_Delete(ID);
        }
    }
}
