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
    public partial class frmSubAnswer : Form
    {
        private SubQuestionBUS objSub = new SubQuestionBUS();
        private AnswerBUS objAnswer = new AnswerBUS();
        private string active = "False";
        private string iscorrect = "False";
        public frmSubAnswer()
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
        private void BinCmbQuestion(String t, String w, String o)
        {
            cmbQuestionID.DataSource = new QuestionBUS().Question_GetByTop(t, w, o);
            cmbQuestionID.DisplayMember = "content";
            cmbQuestionID.ValueMember = "id";
            cmbQuestionID.SelectedIndex = -1;
        }
        private void BinCmbSubQuestion(String t, String w, String o)
        {
            cmbSubQuestionID.DataSource = new SubQuestionBUS().SubQuestion_GetByTop(t, w, o);
            cmbSubQuestionID.DisplayMember = "content";
            cmbSubQuestionID.ValueMember = "id";
            cmbSubQuestionID.SelectedIndex = -1;
        }

        private void Clear()
        {
            txtSubQuestionID.Text = "";
            cmbQuestionID.SelectedIndex = -1;
            txtContent.Text = "";
            cbxActive.Checked = false;
            txtAnswerID.Text = "";
            cmbSubQuestionID.SelectedIndex = -1;
            txtAnswer.Text = "";
            active = "False";
            cbxIsCorrect.Checked = false;
            iscorrect = "False";
            cbxIsCorrect.Checked = false;
        }

        private void frmSubAnswer_Load(object sender, EventArgs e)
        {
            BinDataSub("", "", "");
            BinDataAnswer("", "", "");
            BinCmbQuestion("", "", "");
            BinCmbSubQuestion("", "", "");
            Clear();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            BinDataSub("", "", "");
            BinDataAnswer("", "", "");
            BinCmbQuestion("", "", "");
            BinCmbSubQuestion("", "", "");
            Clear();
        }

        private bool ValidFieldSub()
        {
            bool check = false;
            if (txtContent.Text.Equals("")) check = true;
            if (cmbQuestionID.SelectedIndex < 0) check = true;
            return check;
        }

        private void btnAddSub_Click(object sender, EventArgs e)
        {
            if (ValidFieldSub())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            SubQuestion subQuestion = new SubQuestion(txtSubQuestionID.Text, cmbQuestionID.SelectedValue.ToString(), txtContent.Text, active);
            if (txtSubQuestionID.Text.Equals(""))
            {
                if (objSub.SubQuestion_Insert(subQuestion))
                {
                    MessageBox.Show("Insert subQuestion successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Insert subQuestion unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            button2_Click(objSub, e);
        }

        private void btnEditSub_Click(object sender, EventArgs e)
        {
            if (ValidFieldSub())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if(cbxActive.Checked==false)
            {
                active = "False";
            }

            SubQuestion subQuestion = new SubQuestion(txtSubQuestionID.Text, cmbQuestionID.SelectedValue.ToString(), txtContent.Text, active);
            if (!txtSubQuestionID.Text.Equals(""))
            {
                if (objSub.SubQuestion_Update(subQuestion))
                {
                    MessageBox.Show("Update subQuestion successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("update subQuestion unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            button2_Click(objSub, e);
        }

        private void dgvSubQuestion_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                int row = dgvSubQuestion.CurrentRow.Index;
                string x = dgvSubQuestion.Rows[row].Cells[0].Value.ToString();
                int id = int.Parse(x);
                BinDataAnswer("", " subQuestionID = '" + id + "' ", "");
                dgvAnswer.ReadOnly = false;
                cmbSubQuestionID.SelectedValue= dgvSubQuestion.Rows[row].Cells[0].Value.ToString();

                txtSubQuestionID.Text = dgvSubQuestion.Rows[row].Cells[0].Value.ToString();
                cmbQuestionID.SelectedValue = dgvSubQuestion.Rows[row].Cells[1].Value.ToString();
                txtContent.Text = dgvSubQuestion.Rows[row].Cells[2].Value.ToString();
                if(dgvSubQuestion.Rows[row].Cells[4].Value.ToString()=="True")
                {
                    cbxActive.Checked = true;
                }
                else
                {
                    cbxActive.Checked = false;
                }

            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void cbxActive_CheckedChanged(object sender, EventArgs e)
        {
            active = "True";
        }

        private void dgvSubQuestion_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private bool ValidFieldAnswer()
        {
            bool check = false;
            if (txtAnswer.Text.Equals("")) check = true;
            if (cmbSubQuestionID.SelectedIndex < 0) check = true;
            return check;
        }

        private void btnAddAnswer_Click(object sender, EventArgs e)
        {
            if (ValidFieldAnswer())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }

            Answer answer = new Answer(txtAnswerID.Text, cmbSubQuestionID.SelectedValue.ToString(), txtAnswer.Text, iscorrect);
            if (txtAnswerID.Text.Equals(""))
            {
                if (objAnswer.Answer_Insert(answer))
                {
                    MessageBox.Show("Insert answer successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Insert answer unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            
            string x = cmbSubQuestionID.SelectedValue.ToString();
            int id = int.Parse(x);
            BinDataAnswer("", " subQuestionID = '" + id + "' ", "");
            Clear();
            BinCmbQuestion("", "", "");
            BinCmbSubQuestion("", "", "");
        }

        private void cbxIsCorrect_CheckedChanged(object sender, EventArgs e)
        {
            iscorrect = "True";
        }

        private void dgvAnswer_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                int row = dgvAnswer.CurrentRow.Index;
                txtAnswerID.Text = dgvAnswer.Rows[row].Cells[0].Value.ToString();
                cmbSubQuestionID.SelectedValue = dgvAnswer.Rows[row].Cells[1].Value.ToString();
                txtAnswer.Text = dgvAnswer.Rows[row].Cells[2].Value.ToString();
                if (dgvAnswer.Rows[row].Cells[3].Value.ToString() == "True")
                {
                    cbxIsCorrect.Checked = true;
                }
                else
                {
                    cbxIsCorrect.Checked = false;
                }

            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnDeleteAnswer_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Delete this answer ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (objAnswer.Answer_Delete(dgvAnswer.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete answer successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinDataAnswer("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete answer unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            Clear();
        }

        private void btnEditAnswer_Click(object sender, EventArgs e)
        {
            if (ValidFieldAnswer())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            if (cbxIsCorrect.Checked == false)
            {
                iscorrect = "False";
            }

            Answer answer = new Answer(txtAnswerID.Text, cmbSubQuestionID.SelectedValue.ToString(), txtAnswer.Text, iscorrect);
            if (!txtAnswerID.Text.Equals(""))
            {
                if (objAnswer.Answer_Update(answer))
                {
                    MessageBox.Show("Update answer successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("update answer unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            string x = cmbSubQuestionID.SelectedValue.ToString();
            int id = int.Parse(x);
            BinDataAnswer("", " subQuestionID = '" + id + "' ", "");
            Clear();
            BinCmbQuestion("", "", "");
            BinCmbSubQuestion("", "", "");
            
            //?giữ selected id ở dgvSubQuestion 
        }
    }
}
