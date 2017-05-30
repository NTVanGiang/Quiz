using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Quiz.BUS;
using Quiz.Entity;

namespace Quiz_Server
{
    public partial class frmStudent : Form
    {
        private StudentBUS obj = new StudentBUS();
        public frmStudent()
        {
            InitializeComponent();
        }
        private void BinData(String t, String w, String o)
        {
            dgvStudent.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvStudent.AllowUserToAddRows = false;
            dgvStudent.AllowUserToDeleteRows = false;
            dgvStudent.MultiSelect = false;
            dgvStudent.BackgroundColor = Color.White;
            dgvStudent.ReadOnly = true;
            List<Student> data = obj.Student_GetByTop(t, w, o);
            dgvStudent.DataSource = data;
            dgvStudent.Columns[0].HeaderText = "Mã học viên";
            dgvStudent.Columns[0].Width = 120;
            dgvStudent.Columns[1].HeaderText = "Họ tên";
            dgvStudent.Columns[1].Width = 180;
            dgvStudent.Columns[2].HeaderText = "Tài khoản";
            dgvStudent.Columns[3].Visible = false;
            dgvStudent.Columns[4].HeaderText = "Mã lớp";
            dgvStudent.Columns[4].Visible = false;
            dgvStudent.Columns[5].HeaderText = "Status";
            dgvStudent.Columns[6].HeaderText = "Tên lớp";
        }
        private void BinCmbClass(String t, String w, String o)
        {
            cmbClassID.DataSource = new ClassBUS().Class_GetByTop(t, w, o);
            cmbClassID.DisplayMember = "className";
            cmbClassID.ValueMember = "id";
            cmbClassID.SelectedIndex = -1;
        }
        private void Clear()
        {
            txtSearch.Text = "";
            txtStudentID.Text = "";
            txtFullName.Text = "";
            txtUserName.Text = "";
            txtPassWord.Text = "";
            txtStatus.Text = "";
            cmbClassID.SelectedIndex = -1;
        }
        private bool ValidField()
        {
            bool check = false;
            if (txtFullName.Text.Equals("")) check = true;
            if (txtUserName.Text.Equals("")) check = true;
            if (txtPassWord.Text.Equals("")) check = true;
            if (cmbClassID.SelectedIndex < 0) check = true;
            return check;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Clear();
            txtFullName.Select();
        }

        private void frmStudent_Load(object sender, EventArgs e)
        {
            BinData("", "", "");
            BinCmbClass("", "", "");
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Student Student = new Student(txtStudentID.Text, txtFullName.Text,txtUserName.Text,txtPassWord.Text, cmbClassID.SelectedValue.ToString(), txtStatus.Text);
            if (txtStudentID.Text.Equals(""))
            {
                if (obj.Student_Insert(Student))
                {
                    MessageBox.Show("Insert Student successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Insert Student unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            else
            {
                if (obj.Student_Update(Student))
                {
                    MessageBox.Show("Update Student successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("update Student unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            BinData("", "", "");
            Clear();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int row = dgvStudent.CurrentRow.Index;
                txtStudentID.Text = dgvStudent.Rows[row].Cells[0].Value.ToString();
                txtFullName.Text = dgvStudent.Rows[row].Cells[1].Value.ToString();
                txtUserName.Text = dgvStudent.Rows[row].Cells[2].Value.ToString();
                txtPassWord.Text = dgvStudent.Rows[row].Cells[3].Value.ToString();
                cmbClassID.SelectedValue = dgvStudent.Rows[row].Cells[4].Value.ToString();
                txtStatus.Text = dgvStudent.Rows[row].Cells[5].Value.ToString();
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
                if (MessageBox.Show("Delete this student ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Student_Delete(dgvStudent.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete student successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinData("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete student unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            if(rbUserName.Checked)
            {
                BinData("", " username like N'%" + txtSearch.Text + "%'", "");
            }
            if(rbClass.Checked)
            {
                List<Student> data = obj.Search_ClassName(txtSearch.Text);
                dgvStudent.DataSource = data;
                dgvStudent.Columns[0].HeaderText = "Mã học viên";
                dgvStudent.Columns[0].Width = 120;
                dgvStudent.Columns[1].HeaderText = "Họ tên";
                dgvStudent.Columns[1].Width = 180;
                dgvStudent.Columns[2].HeaderText = "Tài khoản";
                dgvStudent.Columns[3].Visible = false;
                dgvStudent.Columns[4].HeaderText = "Mã lớp";
                dgvStudent.Columns[4].Visible = false;
                dgvStudent.Columns[5].HeaderText = "Status";
            }
        }

        private void txtSearch_Leave(object sender, EventArgs e)
        {
            Clear();
            BinData("", "", "");
        }
    }
}
