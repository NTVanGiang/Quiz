using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using Quiz.Entity;
using Quiz.BUS;

namespace Quiz_Server
{
    public partial class frmClass : Form
    {
        private ClassBUS obj = new ClassBUS();
        public frmClass()
        {
            InitializeComponent();
        }



        private void frmClass_Load(object sender, EventArgs e)
        {

            BinData("", "", "");
            BinCmbFaculty("", "", "");
        }

        private void BinData(String t = "", String w = "", String o = "")
        {
            dgrClass.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgrClass.AllowUserToAddRows = false;
            dgrClass.AllowUserToDeleteRows = false;
            dgrClass.MultiSelect = false;
            dgrClass.BackgroundColor = Color.White;
            dgrClass.ReadOnly = true;
            List<Class> data = obj.Class_GetByTop(t, w, o);
            dgrClass.DataSource = data;
            dgrClass.Columns[0].HeaderText = "Class ID";
            dgrClass.Columns[1].HeaderText = "Class name";
            dgrClass.Columns[1].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;

            //Hide column ID. Just use for update, fill, ...
            dgrClass.Columns[2].HeaderText = "Faculty ID";
            dgrClass.Columns[2].Visible = false;

            dgrClass.Columns[3].HeaderText = "Faculty name";
            dgrClass.Columns[3].Width = 150;
            dgrClass.Columns[3].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
        }

        private void Clear()
        {
            txtClassID.Text = "";
            txtClassName.Text = "";
            cmbFacultyID.SelectedIndex = 0;
            txtSearch.Text = "";
        }

        private void BinCmbFaculty(String t, String w, String o)
        {
            List<Quiz.Entity.Faculty> lst = new FacultyBUS().Faculty_GetByTop(t, w, o);
            lst.Insert(0, new Faculty("0", "-- Select an option --"));
            cmbFacultyID.DataSource = lst;
            cmbFacultyID.DisplayMember = "facultyName";
            cmbFacultyID.ValueMember = "id";
            cmbFacultyID.SelectedIndex = 0;
        }

        private bool ValidField()
        {
            bool check = false;
            if (txtClassName.Text.Equals("")) check = true;
            if (cmbFacultyID.SelectedIndex < 1) check = true;
            return check;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Class Class = new Class(txtClassID.Text, txtClassName.Text, cmbFacultyID.SelectedValue.ToString());
            if (obj.Class_Insert(Class))
            {
                MessageBox.Show("Insert Class successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                BinData();
                Clear();
            }
            else
            {
                MessageBox.Show("Insert Class unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Class Class = new Class(txtClassID.Text, txtClassName.Text, cmbFacultyID.SelectedValue.ToString());

            if (obj.Class_Update(Class))
            {
                MessageBox.Show("Update Class successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            else
            {
                MessageBox.Show("update Class unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

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
                    BinData("", " id = '" + x + "' or className like N'%" + x + "%'", "");
                }
                catch
                {
                    BinData("", " className like N'%" + txtSearch.Text + "%'", "");
                }
            }
        }

        private void frmClass_FormClosed(object sender, FormClosedEventArgs e)
        {
            new frmMain().Show();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            BinData();
        }

        private void btnDeleteMore_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Delete all selected item?", "Notice", MessageBoxButtons.OKCancel, MessageBoxIcon.Information) == DialogResult.OK)
            {
                int count = 0;
                foreach (DataGridViewRow r in dgrClass.SelectedRows)
                {
                    {
                        if (obj.Class_Delete(r.Cells["id"].Value.ToString())) { count++; }
                    }
                }
                BinData("", "", "");
                MessageBox.Show("Successful delete " + count + " item.", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void dgrClass_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            try
            {
                int row = e.RowIndex;
                txtClassID.Text = dgrClass.Rows[row].Cells[0].Value.ToString();
                txtClassName.Text = dgrClass.Rows[row].Cells[1].Value.ToString();
                cmbFacultyID.SelectedValue = dgrClass.Rows[row].Cells[2].Value.ToString();
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
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

        private void menuEdit_Click(object sender, EventArgs e)
        {
            if (dgrClass.SelectedRows[0].Index < 0) return;
            try
            {
                int row = dgrClass.SelectedRows[0].Index;
                txtClassID.Text = dgrClass.Rows[row].Cells[0].Value.ToString();
                txtClassName.Text = dgrClass.Rows[row].Cells[1].Value.ToString();
                cmbFacultyID.SelectedValue = dgrClass.Rows[row].Cells[2].Value.ToString();
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void menuDelete_Click(object sender, EventArgs e)
        {
            if (dgrClass.SelectedRows[0].Index < 0) return;
            if (MessageBox.Show("Delete this teacher ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (obj.Class_Delete(dgrClass.SelectedRows[0].Cells["id"].Value.ToString()))
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

        private void dgrClass_CellMouseDown(object sender, DataGridViewCellMouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                if (e.RowIndex >= 0)
                {
                    dgrClass.ClearSelection();
                    dgrClass.Rows[e.RowIndex].Selected = true;
                }
            }
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                int x = int.Parse(txtSearch.Text);
                BinData("", " id = '" + x + "' or className like N'%" + x + "%'", "");
            }
            catch
            {
                BinData("", " className like N'%" + txtSearch.Text + "%'", "");
            }
        }
    }
}
