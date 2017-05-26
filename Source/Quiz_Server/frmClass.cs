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

        private void BinData(String t, String w, String o)
        {
            dgvClass.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvClass.AllowUserToAddRows = false;
            dgvClass.AllowUserToDeleteRows = false;
            dgvClass.MultiSelect = false;
            dgvClass.BackgroundColor = Color.White;
            dgvClass.ReadOnly = true;
            List<Class> data = obj.Class_GetByTop(t, w, o);
            dgvClass.DataSource = data;
            dgvClass.Columns[0].HeaderText = "Class ID";
            dgvClass.Columns[1].HeaderText = "Class Name";
            dgvClass.Columns[1].HeaderText = "className";

            //Hide column ID. Just use for update, fill, ...
            dgvClass.Columns[2].HeaderText = "Faculty ID";
            dgvClass.Columns[2].Visible = false;

            dgvClass.Columns[3].HeaderText = "Faculty Name";
            dgvClass.Columns[3].Width = 150;
        }

        private void Clear()
        {
            txtClassID.Text = "";
            txtClassName.Text = "";
            cmbFacultyID.SelectedIndex = -1;
            txtSearch.Text = "";
        }

        private void BinCmbFaculty(String t, String w, String o) {
            cmbFacultyID.DataSource = new FacultyBUS().Faculty_GetByTop(t,w,o);
            cmbFacultyID.DisplayMember = "facultyName";
            cmbFacultyID.ValueMember = "id";
            cmbFacultyID.SelectedIndex = -1;
        }

        private bool ValidField()
        {
            bool check = false;
            if (txtClassName.Text.Equals("")) check = true;
            if (cmbFacultyID.SelectedIndex < 0) check = true;
            return check;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Clear();
            txtClassName.Select();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int row = dgvClass.CurrentRow.Index;
                txtClassID.Text = dgvClass.Rows[row].Cells[0].Value.ToString();
                txtClassName.Text = dgvClass.Rows[row].Cells[1].Value.ToString();
                cmbFacultyID.SelectedValue = dgvClass.Rows[row].Cells[2].Value.ToString();
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
                if (MessageBox.Show("Delete this class ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Class_Delete(dgvClass.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete class successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinData("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete class unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void txtSearch_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearch.Text);
                    BinData("", " id = '" + x + "' or className like '%" + x + "%'", "");
                }
                catch
                {
                    BinData("", " className like '%" + txtSearch.Text + "%'", "");
                }
            }
        }

        private void txtSearch_Leave(object sender, EventArgs e)
        {
            Clear();
            BinData("", "", "");
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Class Class = new Class(txtClassID.Text,txtClassName.Text,cmbFacultyID.SelectedValue.ToString());
            if (txtClassID.Text.Equals(""))
            {
                if (obj.Class_Insert(Class))
                {
                    MessageBox.Show("Insert Class successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Insert Class unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            else
            {
                if (obj.Class_Update(Class))
                {
                    MessageBox.Show("Update Class successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("update Class unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            BinData("", "", "");
            Clear();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }
    }
}
