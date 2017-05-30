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
        private QuestionBUS obj = new QuestionBUS();
        public frmQuestion()
        {
            InitializeComponent();
        }
        private void BinData(String t, String w, String o)
        {
            dgvQuestion.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvQuestion.AllowUserToAddRows = false;
            dgvQuestion.AllowUserToDeleteRows = false;
            dgvQuestion.MultiSelect = false;
            dgvQuestion.BackgroundColor = Color.White;
            dgvQuestion.ReadOnly = true;
            List<Question> data = obj.Question_GetByTop(t, w, o);
            dgvQuestion.DataSource = data;
            dgvQuestion.Columns[0].HeaderText = "Mã câu hỏi";
            dgvQuestion.Columns[0].Width = 120;
            dgvQuestion.Columns[1].HeaderText = "SubjectID";
            dgvQuestion.Columns[1].Visible = false;
            dgvQuestion.Columns[2].HeaderText = "TopicID";
            dgvQuestion.Columns[2].Visible = false;
            dgvQuestion.Columns[3].HeaderText = "LevelID";
            dgvQuestion.Columns[3].Visible = false;
            dgvQuestion.Columns[4].HeaderText = "Nội dung";
            dgvQuestion.Columns[4].Width = 180;
            dgvQuestion.Columns[5].HeaderText = "Ngày tạo";
            dgvQuestion.Columns[6].HeaderText = "Tên môn học";
            dgvQuestion.Columns[6].Width = 130;
            dgvQuestion.Columns[7].HeaderText = "Tên chủ đề";
            dgvQuestion.Columns[7].Width = 130;
            dgvQuestion.Columns[8].HeaderText = "Tên level";
        }
        private void BinCmbSubject(String t, String w, String o)
        {
            cmbSubjectID.DataSource = new SubjectBUS().Subject_GetByTop(t, w, o);
            cmbSubjectID.DisplayMember = "subjectName";
            cmbSubjectID.ValueMember = "id";
            cmbSubjectID.SelectedIndex = -1;
        }
        private void BinCmbTopic(String t, String w, String o)
        {
            cmbTopicID.DataSource = new TopicBUS().Topic_GetByTop(t, w, o);
            cmbTopicID.DisplayMember = "topicName";
            cmbTopicID.ValueMember = "id";
            cmbTopicID.SelectedIndex = -1;
        }
        private void BinCmbLevel(String t, String w, String o)
        {
            cmbLevelID.DataSource = new LevelBUS().Level_GetByTop(t, w, o);
            cmbLevelID.DisplayMember = "detail";
            cmbLevelID.ValueMember = "id";
            cmbLevelID.SelectedIndex = -1;
        }

        private void Clear()
        {
            txtSearch.Text = "";
            txtQuestionID.Text = "";
            txtContent.Text = "";
            cmbSubjectID.SelectedIndex = -1;
            cmbTopicID.SelectedIndex = -1;
            cmbLevelID.SelectedIndex = -1;
            dtpCreateDate.Value = DateTime.Now;
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void frmQuestion_Load(object sender, EventArgs e)
        {
            BinData("", "", "");
            BinCmbSubject("", "", "");
            BinCmbTopic("", "", "");
            BinCmbLevel("", "", "");
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Clear();
            cmbSubjectID.Select();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int row = dgvQuestion.CurrentRow.Index;
                txtQuestionID.Text = dgvQuestion.Rows[row].Cells[0].Value.ToString();
                cmbSubjectID.SelectedValue = dgvQuestion.Rows[row].Cells[1].Value.ToString();
                cmbTopicID.SelectedValue = dgvQuestion.Rows[row].Cells[2].Value.ToString();
                cmbLevelID.SelectedValue = dgvQuestion.Rows[row].Cells[3].Value.ToString();
                txtContent.Text = dgvQuestion.Rows[row].Cells[4].Value.ToString();
                dtpCreateDate.Text = dgvQuestion.Rows[row].Cells[5].Value.ToString();
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnDetele_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Delete this question ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Question_Delete(dgvQuestion.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete question successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinData("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete question unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private bool ValidField()
        {
            bool check = false;
            if (txtContent.Text.Equals("")) check = true;
            if (cmbSubjectID.SelectedIndex < 0) check = true;
            if (cmbTopicID.SelectedIndex < 0) check = true;
            if (cmbLevelID.SelectedIndex < 0) check = true;
            if (dtpCreateDate.Text.Equals("")) check = true;
            return check;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Question Question = new Question(txtQuestionID.Text, cmbSubjectID.SelectedValue.ToString(), cmbTopicID.SelectedValue.ToString(), cmbLevelID.SelectedValue.ToString(),txtContent.Text, dtpCreateDate.Text.ToString());
            if (txtQuestionID.Text.Equals(""))
            {
                if (obj.Question_Insert(Question))
                {
                    MessageBox.Show("Insert Question successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Insert Question unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            else
            {
                if (obj.Question_Update(Question))
                {
                    MessageBox.Show("Update Question successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("update Question unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            BinData("", "", "");
            Clear();
        }

        private void txtSearch_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearch.Text);
                    BinData("", " id = '" + x + "' or content like N'%" + x + "%'", "");
                }
                catch
                {
                    BinData("", " content like N'%" + txtSearch.Text + "%'", "");
                }
            }
        }

        private void txtSearch_Leave(object sender, EventArgs e)
        {
            Clear();
            BinData("", "", "");
        }
    }
}
