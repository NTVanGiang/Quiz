﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Quiz.DAL;
using Quiz.Entity;

namespace Quiz.BUS
{
    public class QuestionBUS
    {
        private QuestionDAL obj = new QuestionDAL();
        public List<Question> Question_GetByTop(string Top, string Where, string Order)
        {
            return obj.Question_GetByTop(Top, Where, Order);
        }
        public bool Question_Insert(Question data)
        {
            return obj.Question_Insert(data);
        }

        public bool Question_Update(Question data)
        {
            return obj.Question_Update(data);
        }

        public bool Question_Delete(string ID)
        {
            return obj.Question_Delete(ID);
        }
    }
}