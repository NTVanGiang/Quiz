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
    public partial class frmManSubAnswer : Form
    {
        private SubQuestionBUS objSub = new SubQuestionBUS();
        private AnswerBUS objAnswer = new AnswerBUS();
        public frmManSubAnswer()
        {
            InitializeComponent();
        }

        private void BinDataSub(String t, String w, String o)
        {
            dgvSubQuestion.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvSubQuestion.AllowUserToAddRows = false;
            dgvSubQuestion.AllowUserToDeleteRows = false;
            dgvSubQuestion.MultiSelect = false;
            dgvSubQuestion.BackgroundColor = Color.White;
            dgvSubQuestion.ReadOnly = true;
            List<SubQuestion> dataSub = objSub.SubQuestion_GetByTop(t, w, o);
            dgvSubQuestion.DataSource = dataSub;
            dgvSubQuestion.Columns[0].HeaderText = "Mã câu hỏi con";
            dgvSubQuestion.Columns[1].HeaderText = "QuestionID";
            dgvSubQuestion.Columns[1].Visible = false;
            dgvSubQuestion.Columns[2].HeaderText = "Nội dung";
            dgvSubQuestion.Columns[3].HeaderText = "ReportCount";
            dgvSubQuestion.Columns[3].Visible = false;
            dgvSubQuestion.Columns[4].HeaderText = "Trạng thái";
            dgvSubQuestion.Columns[5].HeaderText = "ND câu hỏi cha";

        }
        private void BinDataAnswer(String t, String w, String o)
        {
            dgvAnswer.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvAnswer.AllowUserToAddRows = false;
            dgvAnswer.AllowUserToDeleteRows = false;
            dgvAnswer.MultiSelect = false;
            dgvAnswer.BackgroundColor = Color.White;
            dgvAnswer.ReadOnly = true;
            List<Answer> dataAnswer = objAnswer.Answer_GetByTop(t, w, o);
            dgvAnswer.DataSource = dataAnswer;
            dgvAnswer.Columns[0].HeaderText = "Mã câu trả lời";
            dgvAnswer.Columns[1].HeaderText = "subQuestionID";
            dgvAnswer.Columns[1].Visible = false;
            dgvAnswer.Columns[2].HeaderText = "Nội dung";
            dgvAnswer.Columns[3].HeaderText = "Trạng thái";
            dgvAnswer.Columns[4].HeaderText = "ND câu hỏi con";
        }



        private void frmSubQuestion_Load(object sender, EventArgs e)
        {
            BinDataSub("", "", "");
            BinDataAnswer("", "", "");
            Clear();
        }

        private void Clear()
        {
            txtSearchSub.Text = "";
            txtSearchAnswer.Text = "";
        }

        private void btnFresh_Click(object sender, EventArgs e)
        {
            BinDataSub("", "", "");
            BinDataAnswer("", "", "");
            Clear();
        }

        private void txtSearchSub_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearchSub.Text);
                    BinDataSub("", " id = '" + x + "' or content like N'%" + x + "%'", "");
                }
                catch
                {
                    BinDataSub("", " content like N'%" + txtSearchSub.Text + "%'", "");
                }
            }
        }

        private void txtSearchSub_Leave(object sender, EventArgs e)
        {
            Clear();
            BinDataSub("", "", "");
        }

        private void txtSearchAnswer_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearchAnswer.Text);
                    BinDataAnswer("", " id = '" + x + "' or answer like N'%" + x + "%'", "");
                }
                catch
                {
                    BinDataAnswer("", " answer like N'%" + txtSearchAnswer.Text + "%'", "");
                }
            }
        }

        private void txtSearchAnswer_Leave(object sender, EventArgs e)
        {
            Clear();
            BinDataAnswer("", "", "");
        }

        private void dgvSubQuestion_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                int row = dgvSubQuestion.CurrentRow.Index;
                string x = dgvSubQuestion.Rows[row].Cells[0].Value.ToString();
                int id = int.Parse(x);
                BinDataAnswer("", " subQuestionID = '" + id + "' ", "");

            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Delete this subquestion ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (objSub.SubQuestion_Delete(dgvSubQuestion.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete subquestion successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinDataSub("", "", "");
                        BinDataAnswer("", "", "");

                    }
                    else
                    {
                        MessageBox.Show("Delete subquestion unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            frmSubAnswer frm = new frmSubAnswer();
            this.Hide();
            frm.ShowDialog();
            this.Show();
            BinDataSub("", "", "");
            BinDataAnswer("", "", "");
        }
    }
}
