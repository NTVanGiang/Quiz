using Quiz.BUS;
using Quiz.Entity;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Quiz_Server
{
    public partial class frmQuestion : Form
    {
        private QuestionBUS qbus = new QuestionBUS();
        private SubQuestionBUS sqbus = new SubQuestionBUS();
        private AnswerBUS abus = new AnswerBUS();

        private void btnImport_Click(object sender, EventArgs e)
        {
            new frmImport().ShowDialog();
        }

        private void BinData()
        {
            
        }
    }
}
