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
        private void BindData(String t = "", String w = "", String o = "")
        {
            dgrStudent.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgrStudent.AllowUserToAddRows = false;
            dgrStudent.AllowUserToDeleteRows = false;
            dgrStudent.MultiSelect = true;
            dgrStudent.BackgroundColor = Color.White;
            dgrStudent.ReadOnly = true;
            List<Student> data = obj.Student_GetByTop(t, w, o);
            dgrStudent.DataSource = data;
            dgrStudent.Columns[0].HeaderText = "Student ID";
            dgrStudent.Columns[0].Width = 120;
            dgrStudent.Columns[1].HeaderText = "Student name";
            dgrStudent.Columns[1].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrStudent.Columns[2].HeaderText = "Username";
            dgrStudent.Columns[3].Visible = false;
            dgrStudent.Columns[4].HeaderText = "Class ID";
            dgrStudent.Columns[4].Visible = false;
            dgrStudent.Columns[5].HeaderText = "Status";
            dgrStudent.Columns[6].HeaderText = "Class name";
            dgrStudent.Columns[6].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
        }
        private void BinCmbClass(String t, String w, String o)
        {
            List<Class> lst = new ClassBUS().Class_GetByTop(t, w, o);
            lst.Insert(0, new Quiz.Entity.Class("0", "Select an option", ""));
            cmbClassID.DataSource = lst;
            cmbClassID.DisplayMember = "className";
            cmbClassID.ValueMember = "id";
            cmbClassID.SelectedIndex = 0;
        }
        private void BinCmbFilter(String t, String w, String o)
        {
            List<Class> lst = new ClassBUS().Class_GetByTop(t, w, o);
            lst.Insert(0, new Quiz.Entity.Class("0", "Select an option", ""));
            cmbFilter.DataSource = lst;
            cmbFilter.DisplayMember = "className";
            cmbFilter.ValueMember = "id";
            cmbFilter.SelectedIndex = 0;
        }
        private void Clear()
        {
            txtSearch.Text = "";
            txtStudentID.Text = "";
            txtFullName.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
            rdActive.Checked = true;
            cmbClassID.SelectedIndex = 0;
        }
        private bool ValidField()
        {
            bool check = false;
            if (txtFullName.Text.Equals("")) check = true;
            if (txtUsername.Text.Equals("")) check = true;
            if (txtPassword.Text.Equals("")) check = true;
            if (cmbClassID.SelectedIndex < 1) check = true;
            return check;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Student Student = new Student(txtStudentID.Text, txtFullName.Text, txtUsername.Text, txtPassword.Text, cmbClassID.SelectedValue.ToString(), (rdActive.Checked ? "True" : "False"));
            if (obj.Student_Insert(Student))
            {
                MessageBox.Show("Insert Student successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Insert Student unsuccessed!\nNote: Username must be unique", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            BindData("", "", "");
            Clear();
        }

        private void frmStudent_Load(object sender, EventArgs e)
        {
            BindData("", "", "");
            BinCmbClass("", "", "");
            BinCmbFilter("", "", "");
        }

        private void btnSave_Click(object sender, EventArgs e)
        {

        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Student Student = new Student(txtStudentID.Text, txtFullName.Text, txtUsername.Text, txtPassword.Text, cmbClassID.SelectedValue.ToString(), (rdActive.Checked ? "True" : "False"));
            if (obj.Student_Update(Student))
            {
                MessageBox.Show("Update Student successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            else
            {
                MessageBox.Show("update Student unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            BindData("", "", "");
            Clear();
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Delete this student ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Student_Delete(dgrStudent.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete student successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BindData("", "", "");
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

        //private void btnSearch_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        int x = int.Parse(txtSearch.Text);
        //        BindData("", " id = '" + x + "' or fullname like N'%" + x + "%'", "");
        //    }
        //    catch
        //    {
        //        BindData("", " fullname like N'%" + txtSearch.Text + "%'", "");
        //    }
        //}

        private void txtSearch_Leave(object sender, EventArgs e)
        {
            Clear();
            BindData("", "", "");
        }

        private void dgrStudent_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            try
            {
                int row = dgrStudent.CurrentRow.Index;
                txtStudentID.Text = dgrStudent.Rows[row].Cells[0].Value.ToString();
                txtFullName.Text = dgrStudent.Rows[row].Cells[1].Value.ToString();
                txtUsername.Text = dgrStudent.Rows[row].Cells[2].Value.ToString();
                txtPassword.Text = dgrStudent.Rows[row].Cells[3].Value.ToString();
                cmbClassID.SelectedValue = dgrStudent.Rows[row].Cells[4].Value.ToString();
                if (dgrStudent.Rows[row].Cells[5].Value.ToString().ToLower() == "true")
                    rdActive.Checked = true;
                else rdBlock.Checked = true;
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        //private void dgrStudent_CellMouseDown(object sender, DataGridViewCellMouseEventArgs e)
        //{
        //    if (e.Button == MouseButtons.Right)
        //    {
        //        if (e.RowIndex >= 0)
        //        {
        //            dgrStudent.ClearSelection();
        //            dgrStudent.Rows[e.RowIndex].Selected = true;
        //        }
        //    }
        //}

        private void txtSearch_KeyPress(object sender, KeyPressEventArgs e)
        {
           if(e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearch.Text);
                    BindData("", " id = '" + x + "' or fullname like N'%" + x + "%'", "");
                }
                catch
                {
                    BindData("", " fullname like N'%" + txtSearch.Text + "%'", "");
                }
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            BindData();
        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            new frmMain().Show();
            this.Hide();
        }

        private void btnDeleteMore_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Delete all selected item?", "Notice", MessageBoxButtons.OKCancel, MessageBoxIcon.Information) == DialogResult.OK)
            {
                int count = 0;
                foreach (DataGridViewRow r in dgrStudent.SelectedRows)
                {
                    {
                        if (obj.Student_Delete(r.Cells["id"].Value.ToString())) { count++; }
                    }
                }
                BindData("", "", "");
                MessageBox.Show("Successful delete " + count + " item.", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void menuEdit_Click(object sender, EventArgs e)
        {
            if (dgrStudent.SelectedRows[0].Index < 0) return;
            try
            {
                int row = dgrStudent.SelectedRows[0].Index;
                txtStudentID.Text = dgrStudent.Rows[row].Cells[0].Value.ToString();
                txtFullName.Text = dgrStudent.Rows[row].Cells[1].Value.ToString();
                txtUsername.Text = dgrStudent.Rows[row].Cells[2].Value.ToString();
                txtPassword.Text = dgrStudent.Rows[row].Cells[3].Value.ToString();
                cmbClassID.SelectedValue = dgrStudent.Rows[row].Cells[4].Value.ToString();
                if (dgrStudent.Rows[row].Cells[5].Value.ToString().ToLower() == "true")
                    rdActive.Checked = true;
                else rdBlock.Checked = true;
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void menuDelete_Click(object sender, EventArgs e)
        {
            if (dgrStudent.SelectedRows[0].Index < 0) return;
            if (MessageBox.Show("Deleteall all selected student ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                int count = 0;
                foreach(DataGridViewRow dr in dgrStudent.SelectedRows)
                {
                    if (obj.Student_Delete(dr.Cells["id"].Value.ToString()))
                    {
                        count++;
                    }
                    else
                    {
                    }
                }
                MessageBox.Show("Delete "+ count +" student successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                BindData("", "", "");

            }
        }

        private void checkBoxX1_CheckedChanged(object sender, EventArgs e)
        {
            if (checkBoxX1.Checked) txtPassword.UseSystemPasswordChar = false;
            else txtPassword.UseSystemPasswordChar = true;
        }

        private void txtSearch_MouseLeave(object sender, EventArgs e)
        {
            BindData();
        }

        private void cmbFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbFilter.SelectedIndex == 0)
            {
                BindData();
            }
            else
            {
                BindData("", "classID = '" + cmbFilter.SelectedValue.ToString() + "'", "");
            }
        }

        private void menuGenAccount_Click(object sender, EventArgs e)
        {
            int count = 0;
            string userPrefix = Microsoft.VisualBasic.Interaction.InputBox("Username prefix?", "InputBox");
            string passPrefix = Microsoft.VisualBasic.Interaction.InputBox("Password prefix?", "InputBox");
            foreach (DataGridViewRow dr in dgrStudent.SelectedRows)
            {
                Student st = new Student();
                st.Id = dr.Cells["id"].Value.ToString();
                st.Fullname = dr.Cells["fullname"].Value.ToString();
                st.Username = userPrefix + st.Id;
                st.Password = passPrefix + st.Id;
                st.Status = dr.Cells["status"].Value.ToString();
                st.ClassID = dr.Cells["classID"].Value.ToString();
                if (obj.Student_Update(st)) count++;
            }
            MessageBox.Show("Generate " + count + " student account successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            BindData("", "", "");
        }
    }
}
