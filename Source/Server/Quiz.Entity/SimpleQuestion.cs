using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Quiz.Entity
{
    public class SimpleQuestion
    {
        public string question { get; set; }
        public List<string> answer { get; set; }
        public int correctAnswer { get; set; }
    }
}
