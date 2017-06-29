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
        private bool isReport = false;
        public frmQuestion()
        {
            InitializeComponent();
            BindQuestionData();
        }
        public frmQuestion(bool _isReport)
        {
            InitializeComponent();
            isReport = _isReport;
            BindSubQuestionData();
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            new frmImport().ShowDialog();
        }

        private void BindQuestionData(string t = "", string w = "", string o = "")
        {

            dgrQuestion.DataSource = new QuestionBUS().Question_GetByTop(t, w, o);
            dgrQuestion.Columns["id"].DisplayIndex = 0;
            dgrQuestion.Columns["id"].HeaderText = "#";
            dgrQuestion.Columns["subjectID"].Visible = false;
            dgrQuestion.Columns["subjectName"].HeaderText = "Subject";
            dgrQuestion.Columns["subjectName"].DisplayIndex = 1;
            dgrQuestion.Columns["subjectName"].Width = 160;
            dgrQuestion.Columns["content"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrQuestion.Columns["content"].HeaderText = "Question";
            dgrQuestion.Columns["content"].DisplayIndex = 2;
            dgrQuestion.Columns["createDate"].DisplayIndex = 3;
            dgrQuestion.Columns["createDate"].HeaderText = "Creat date";
        }
        private void BindSubQuestionData(string t = "", string w = "", string o = "")
        {
            if (isReport) o = " reportCount desc";
            dgrSubQuestion.DataSource = new SubQuestionBUS().SubQuestion_GetByTop(t, w, o);
            dgrSubQuestion.Columns["id"].DisplayIndex = 0;
            dgrSubQuestion.Columns["id"].HeaderText = "#";
            dgrSubQuestion.Columns["questionID"].Visible = false;
            dgrSubQuestion.Columns["content"].HeaderText = "Sub question";
            dgrSubQuestion.Columns["content"].DisplayIndex = 1;
            dgrSubQuestion.Columns["content"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrSubQuestion.Columns["reportCount"].HeaderText = "Report";
            dgrSubQuestion.Columns["reportCount"].DisplayIndex = 2;
            if (isReport) dgrSubQuestion.Columns["reportCount"].DefaultCellStyle.BackColor = Color.Gray;
            dgrSubQuestion.Columns["active"].DisplayIndex = 3;
            dgrSubQuestion.Columns["active"].HeaderText = "Active";
        }

        private void BindAnswerData(List<Answer> lst = null, string t = "", string w = "", string o = "")
        {

            if (lst == null)
            {
                dgrAnswer.DataSource = new AnswerBUS().Answer_GetByTop(t, w, o);
            }
            else
            {
                dgrAnswer.DataSource = lst;
            }
            dgrAnswer.Columns["id"].DisplayIndex = 0;
            dgrAnswer.Columns["id"].HeaderText = "#";
            dgrAnswer.Columns["subQuestionID"].Visible = false;
            dgrAnswer.Columns["answers"].HeaderText = "Answer";
            dgrAnswer.Columns["answers"].DisplayIndex = 1;
            dgrAnswer.Columns["answers"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrAnswer.Columns["isCorrect"].HeaderText = "Correct";
            dgrAnswer.Columns["isCorrect"].DisplayIndex = 2;
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


        private void cmbSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbSubject.SelectedIndex == 0)
            {
                BindQuestionData("", "", "");
            }
            else
            {
                BindQuestionData("", "subjectID = '" + cmbSubject.SelectedValue.ToString() + "'", "");
            }
        }


        private void frmQuestion_Load(object sender, EventArgs e)
        {
            BindCmbSubject();
            //BindSubQuestionData();
            //BindAnswerData();
        }

        private void dgrQuestion_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            string txtView = "";
            int row = e.RowIndex;
            if (row < 0) return;
            string qID = dgrQuestion.Rows[row].Cells["id"].Value.ToString();
            List<SubQuestion> lstSub = sqbus.SubQuestion_GetByTop("", "questionID = '" + qID + "'", "");
            BindSubQuestionData("", "questionID='" + qID + "'", "");
            List<Answer> lstAnswer = new List<Answer>();
            if (dgrQuestion.Rows[row].Cells["content"].Value.ToString() != "")
            {
                txtView += dgrQuestion.Rows[row].Cells["content"].Value.ToString() + "\r\n";
            }
            foreach (SubQuestion sq in lstSub)
            {
                txtView += "Question: " + sq.Content + "\r\n";
                List<Answer> lst = abus.Answer_GetByTop("", "subQuestionID = '" + sq.Id + "'", "");
                for (int i = 0; i < lst.Count; i++)
                {
                    Answer ans = lst.ElementAt(i);
                    lstAnswer.Add(ans);
                    if (ans.IsCorrect == "True")
                    {
                        txtView += "    " + (char)(65 + i) + ". " + ans.Answers + " *\r\n";
                    }
                    else
                    {
                        txtView += "    " + (char)(65 + i) + ". " + ans.Answers + "\r\n";
                    }
                }
                txtView += "\r\n";
            }
            txtDisplay.Text = txtView;

            BindAnswerData(lstAnswer);
        }

        private void dgrSubQuestion_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int row = e.RowIndex;
            if (row < 0) return;
            string subID = dgrSubQuestion.Rows[row].Cells["id"].Value.ToString();
            BindAnswerData(null, "", "subQuestionID = '" + subID + "'", "");
            BindQuestionData("", "id='" + dgrSubQuestion.Rows[row].Cells["questionID"].Value.ToString() + "'", "");
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            new frmQuestionDetail().ShowDialog();
        }

        private void dgrQuestion_CellMouseDown(object sender, DataGridViewCellMouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                if (e.RowIndex >= 0)
                {
                    dgrQuestion.ClearSelection();
                    dgrQuestion.Rows[e.RowIndex].Selected = true;
                }
            }
        }

        private void btnDeleteQuestion_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Delete this item?", "Notice", MessageBoxButtons.YesNo, MessageBoxIcon.Warning) == DialogResult.Yes)
            {
                if (qbus.Question_Delete(dgrQuestion.CurrentRow.Cells["id"].Value.ToString()))
                {
                    MessageBox.Show("Delete success", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    BindQuestionData();
                }
                else
                {
                    MessageBox.Show("Delete unsuccess", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
        }

        private void ctmDgrQuestion_Opening(object sender, CancelEventArgs e)
        {
            if (dgrQuestion.CurrentRow.Index < 0)
            {
                e.Cancel = true;
            }
        }

        private void btnEditQuestion_Click(object sender, EventArgs e)
        {
            string selectedValue = dgrQuestion.CurrentRow.Cells["subjectID"].Value.ToString();
            bool isSingle = true;
            string qid = dgrQuestion.CurrentRow.Cells["id"].Value.ToString();
            

            new frmQuestionDetail(true, isSingle, selectedValue, qid).ShowDialog();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            BindQuestionData();
        }

        private void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindSubQuestionData("", "content like N'%" + txtSearch.Text + "%'", "");
            BindQuestionData("", "content like N'%" + txtSearch.Text + "%'", "");
        }

        private void frmQuestion_FormClosed(object sender, FormClosedEventArgs e)
        {
            new frmMain().Show();
        }
    }
}
