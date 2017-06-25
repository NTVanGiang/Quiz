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
        private string imgLoc = "";
        private TeacherBUS obj = new TeacherBUS();
        public frmTeacher()
        {
            InitializeComponent();
        }
        private void BinData(String t, String w, String o)
        {
            dgrTeacher.DataSource = obj.Teacher_GetByTop(t, w, o);
            dgrTeacher.Columns["id"].HeaderText = "Teacher ID";
            dgrTeacher.Columns["name"].HeaderText = "Teacher name";
            dgrTeacher.Columns["name"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrTeacher.Columns["username"].HeaderText = "Username";
            dgrTeacher.Columns["password"].HeaderText = "Password";
            dgrTeacher.Columns["password"].Visible = false;
            dgrTeacher.Columns["avatar"].HeaderText = "Avatar";
            dgrTeacher.Columns["avatar"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
        }
        private void Clear()
        {
            txtSearch.Text = "";
            txtTeacherID.Text = "";
            txtName.Text = "";
            txtUsername.Text = "";
            picAvatar.Image = picAvatar.InitialImage;
            txtPassword.Text = "";
        }

        private void frmTeacher_Load(object sender, EventArgs e)
        {
            BinData("", "", "");
        }

        private void btnAdd_Click(object sender, EventArgs e)
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
            Teacher teacher = new Teacher(txtTeacherID.Text, txtName.Text, txtUsername.Text, txtPassword.Text, imgLoc);
            if (obj.Teacher_Insert(teacher))
            {
                MessageBox.Show("Insert teacher successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Insert teacher unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
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
            Teacher teacher = new Teacher(txtTeacherID.Text, txtName.Text, txtUsername.Text, txtPassword.Text, imgLoc);
            if (obj.Teacher_Update(teacher))
            {
                MessageBox.Show("Update teacher successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            else
            {
                MessageBox.Show("update teacher unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            BinData("", "", "");
            Clear();
        }
        private bool ValidField()
        {
            return txtName.Text.Equals(String.Empty) ? true : false;
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

        //private void txtSearch_Leave(object sender, EventArgs e)
        //{
        //    Clear();
        //    BinData("", "", "");
        //}

        private void btnSearch_Click(object sender, EventArgs e)
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

        private void picAvatar_Click(object sender, EventArgs e)
        {
            try
            {
                OpenFileDialog dlg = new OpenFileDialog();
                dlg.Filter = "JPG Files (*.jpg)|*.jpg|GIF Files (*.gif)";
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

        private void dgrTeacher_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0)
            {
                return;
            }
            int row = e.RowIndex;
            try
            {
                txtTeacherID.Text = dgrTeacher.Rows[row].Cells[0].Value.ToString();
                txtName.Text = dgrTeacher.Rows[row].Cells[1].Value.ToString();
                txtUsername.Text = dgrTeacher.Rows[row].Cells[2].Value.ToString();
                txtPassword.Text = dgrTeacher.Rows[row].Cells[3].Value.ToString();
                picAvatar.Image = System.Drawing.Image.FromFile(dgrTeacher.Rows[row].Cells["avatar"].Value.ToString());
            }
            catch
            {
                picAvatar.Image = picAvatar.ErrorImage;
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            new frmMain().Show();
            this.Hide();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            BinData("", "", "");
        }

        private void btnDeleteMore_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Bạn muốn xóa các bản ghi đã chọn?", "Thông báo", MessageBoxButtons.OKCancel, MessageBoxIcon.Information) == DialogResult.OK)
            {
                int count = 0;
                foreach (DataGridViewRow r in dgrTeacher.SelectedRows)
                {
                    {
                        if (obj.Teacher_Delete(r.Cells["id"].Value.ToString())) { count++; }
                    }
                }
                BinData("", "", "");
                MessageBox.Show("Xóa thành công " + count + " bản ghi.", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void dgrTeacher_CellMouseDown(object sender, DataGridViewCellMouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                if (e.RowIndex >= 0)
                {
                    dgrTeacher.ClearSelection();
                    dgrTeacher.Rows[e.RowIndex].Selected = true;
                }
            }
        }

        private void menuEdit_Click(object sender, EventArgs e)
        {
            if (dgrTeacher.SelectedRows[0].Index < 0)
            {
                return;
            }
            int row = dgrTeacher.SelectedRows[0].Index;
            try
            {
                txtTeacherID.Text = dgrTeacher.Rows[row].Cells[0].Value.ToString();
                txtName.Text = dgrTeacher.Rows[row].Cells["name"].Value.ToString();
                txtUsername.Text = dgrTeacher.Rows[row].Cells[2].Value.ToString();
                txtPassword.Text = dgrTeacher.Rows[row].Cells[3].Value.ToString();
                picAvatar.Image = System.Drawing.Image.FromFile(dgrTeacher.Rows[row].Cells["avatar"].Value.ToString());
            }
            catch
            {
                picAvatar.Image = picAvatar.ErrorImage;
            }
        }

        private void menuDelete_Click(object sender, EventArgs e)
        {
            if (dgrTeacher.CurrentRow.Index < 0) return;
            if (MessageBox.Show("Delete this teacher ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (obj.Teacher_Delete(dgrTeacher.SelectedRows[0].Cells["id"].Value.ToString()))
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

        private void ckViewPassword_CheckedChanged(object sender, EventArgs e)
        {
            if (ckViewPassword.Checked == true) txtPassword.UseSystemPasswordChar = false;
            else txtPassword.UseSystemPasswordChar = true;
        }
    }
}

