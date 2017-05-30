using Quiz.BUS;
using Quiz.Entity;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Quiz_Server
{
    public partial class frmTeacher : Form
    {
        private TeacherBUS obj = new TeacherBUS();
        string imgLoc = "";
        public frmTeacher()
        {
            InitializeComponent();
        }
        private void BinData(String t, String w, String o)
        {
            dgvTeacher.DataSource = obj.Teacher_GetByTop(t, w, o);
            dgvTeacher.Columns[0].HeaderText = "Mã giảng viên";
            dgvTeacher.Columns[1].HeaderText = "Họ tên";
            dgvTeacher.Columns[1].Width = 180;
            dgvTeacher.Columns[2].HeaderText = "Tài khoản";
            dgvTeacher.Columns[3].HeaderText = "Mật khẩu";
            dgvTeacher.Columns[3].Visible = false;
            dgvTeacher.Columns[4].HeaderText = "Avatar";
        }
        private void Clear()
        {
            txtSearch.Text = "";
            txtTeacherID.Text = "";
            txtName.Text = "";
            txtUserName.Text = "";
            txtPassWord.Text = "";
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void frmTeacher_Load(object sender, EventArgs e)
        {
            BinData("", "", "");
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Delete this teacher ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Teacher_Delete(dgvTeacher.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete teacher successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinData("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete teacher unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Clear();
            txtName.Select();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int row = dgvTeacher.CurrentRow.Index;
                txtTeacherID.Text = dgvTeacher.Rows[row].Cells[0].Value.ToString();
                txtName.Text = dgvTeacher.Rows[row].Cells[1].Value.ToString();
                txtUserName.Text = dgvTeacher.Rows[row].Cells[2].Value.ToString();
                txtPassWord.Text = dgvTeacher.Rows[row].Cells[3].Value.ToString();
                //picture
                if (!string.IsNullOrEmpty(dgvTeacher.Rows[row].Cells[4].Value.ToString()))
                {
                    picAvatar.Image = System.Drawing.Image.FromFile(dgvTeacher.Rows[row].Cells[4].Value.ToString());
                }
                else
                {
                    picAvatar.Image = null;
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private bool ValidField()
        {
            return txtName.Text.Equals(String.Empty) ? true : false;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out textbox Name!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            byte[] img = null;
            FileStream fs = new FileStream(imgLoc, FileMode.Open, FileAccess.Read);
            BinaryReader br = new BinaryReader(fs);
            img = br.ReadBytes((int)fs.Length);
            Teacher teacher = new Teacher(txtTeacherID.Text, txtName.Text, txtUserName.Text, txtPassWord.Text, imgLoc);
            if (txtTeacherID.Text.Equals(""))
            {
                if (obj.Teacher_Insert(teacher))
                {
                    MessageBox.Show("Insert teacher successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Insert teacher unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            else
            {
                if (obj.Teacher_Update(teacher))
                {
                    MessageBox.Show("Update teacher successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("update teacher unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            BinData("", "", "");
            Clear();
        }

        private void btnBrower_Click(object sender, EventArgs e)
        {
            try
            {
                OpenFileDialog dlg = new OpenFileDialog();
                dlg.Filter = "JPG Files (*.jpg)|*.jpg|GIF Files (*.gif)|*.gif|All File (*.*)|*.*";
                dlg.Title = "Select Teacher Picture";
                if (dlg.ShowDialog() == DialogResult.OK)
                {
                    imgLoc = dlg.FileName.ToString();
                    picAvatar.ImageLocation = imgLoc;
                }
            }
            catch
            {
                MessageBox.Show("No Brower", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private void txtSearch_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearch.Text);
                    BinData("", " id = '" + x + "' or name like N'%" + x + "%' or username like '%" + x + "%'", "");
                }
                catch
                {
                    BinData("", " name like N'%" + txtSearch.Text + "%' or username like'%" + txtSearch.Text + "%'", "");
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
