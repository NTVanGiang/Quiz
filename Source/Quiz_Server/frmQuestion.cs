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

        public frmQuestion()
        {
            InitializeComponent();
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            new frmImport().ShowDialog();
        }

        private void BindQuestionData(string t, string w, string o)
        {

            dgrQuestion.DataSource = new QuestionBUS().Question_GetByTop(t, w, o);
            dgrQuestion.Columns["id"].Visible = false;
            dgrQuestion.Columns["subjectID"].Visible = false;
            dgrQuestion.Columns["subjectName"].HeaderText = "Môn học";
            dgrQuestion.Columns["subjectName"].DisplayIndex = 0;
            dgrQuestion.Columns["subjectName"].Width = 160;
            dgrQuestion.Columns["content"].HeaderText = "Câu hỏi";
            dgrQuestion.Columns["content"].DisplayIndex = 1;
            dgrQuestion.Columns["createDate"].DisplayIndex = 2;
            dgrQuestion.Columns["createDate"].HeaderText = "Ngày tạo";
        }

        private void BindCmbSubject()
        {
            List<Subject> lst = new SubjectBUS().Subject_GetByTop("", "", "");
            lst.Insert(0, new Subject("0", "-- Select All --"));
            cmbSubject.DataSource = lst;
            cmbSubject.DisplayMember = "subjectName";
            cmbSubject.ValueMember = "ID";
            cmbSubject.SelectedIndex = 0;
        }

        private void frmQuestion_Load(object sender, EventArgs e)
        {
            BindCmbSubject();
            BindQuestionData("", "", "");
        }

        private void cmbSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbSubject.SelectedIndex == 0)
            {
                BindQuestionData("", "", "");
            }
            else
            {
                BindQuestionData("", "subjectID = '" + cmbSubject.SelectedValue.ToString() + "'", "");
            }
        }

        private void dgrQuestion_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            string content = "";
            int row = e.RowIndex;
            string qID = dgrQuestion.Rows[row].Cells["id"].Value.ToString();
            List<SubQuestion> lstSub = sqbus.SubQuestion_GetByTop("", "questionID = '"+qID+"'", "");
            foreach(SubQuestion sq in lstSub)
            {
                content += sq.Content + "\r\n";
            }
        }
    }
}
