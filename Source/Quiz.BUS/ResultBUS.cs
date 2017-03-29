using System.Collections.Generic;

using Quiz.DAL;
using Quiz.Entity;

namespace Quiz.BUS
{
    public class ResultBUS
    {
        private ResultDAL obj = new ResultDAL();
        public List<Result> Result_GetByTop(string Top, string Where, string Order)
        {
            return obj.Result_GetByTop(Top, Where, Order);
        }
        public bool Result_Insert(Result data)
        {
            return obj.Result_Insert(data);
        }

        public bool Result_Update(Result data)
        {
            return obj.Result_Update(data);
        }

        public bool Result_Delete(string ID)
        {
            return obj.Result_Delete(ID);
        }
    }
}
