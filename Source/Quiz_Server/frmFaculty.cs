using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Quiz.Entity;
using Quiz.BUS;
namespace Quiz_Server
{
    public partial class frmFaculty : Form
    {
        private FacultyBUS obj = new FacultyBUS();
        public frmFaculty()
        {
            InitializeComponent();
        }

        private void frmFaculty_Load(object sender, EventArgs e)
        {
            BinData("", "", "");
        }
        private void BinData(String t, String w, String o)
        {
            dgvFaculty.DataSource = obj.Faculty_GetByTop(t, w, o);
            dgvFaculty.Columns[0].HeaderText = "Faculty ID";
            dgvFaculty.Columns[1].HeaderText = "Faculty Name";
            dgvFaculty.Columns[1].Width = 180;
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int row = dgvFaculty.CurrentRow.Index;
                txtFacultyID.Text = dgvFaculty.Rows[row].Cells[0].Value.ToString();
                txtFacultyName.Text = dgvFaculty.Rows[row].Cells[1].Value.ToString();
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void Clear()
        {
            txtFacultyName.Text = "";
            txtFacultyID.Text = "";
            txtSearch.Text = "";
        }

        private bool ValidField() {
            return txtFacultyName.Text.Equals(String.Empty) ? true : false;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if(ValidField()) {
                MessageBox.Show("Please fill out textbox Faculty Name!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Faculty faculty = new Faculty(txtFacultyID.Text, txtFacultyName.Text);
            if (txtFacultyID.Text.Equals(""))
            {
                if (obj.Faculty_Insert(faculty))
                {
                    MessageBox.Show("Insert faculty successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Insert faculty unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            else
            {
                if (obj.Faculty_Update(faculty))
                {
                    MessageBox.Show("Update faculty successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("update faculty unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            BinData("", "", "");
            Clear();
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Delete this faculty ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Faculty_Delete(dgvFaculty.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete faculty successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinData("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete faculty unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

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
            if(e.KeyChar == 13) {
                try {
                    int x = int.Parse(txtSearch.Text);
                    BinData("", " id = '" + x + "' or facultyName like '%" + x + "%'", "");
                }
                catch {
                    BinData("", " facultyName like '%" + txtSearch.Text + "%'", "");
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
