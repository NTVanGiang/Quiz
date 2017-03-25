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
    public partial class frmSubject : Form
    {

        private SubjectBUS obj = new SubjectBUS();
        public frmSubject()
        {
            InitializeComponent();
        }

        private void BinData(String t, String w, String o)
        {
            dgvSubject.DataSource = obj.Subject_GetByTop(t, w, o);
            dgvSubject.Columns[0].HeaderText = "Subject ID";
            dgvSubject.Columns[1].HeaderText = "Subject Name";
            dgvSubject.Columns[1].Width = 180;
        }
        private void Clear()
        {
            txtSearch.Text = "";
            txtSubjectID.Text = "";
            txtSubjectName.Text = "";
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Clear();
            txtSubjectName.Select();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int row = dgvSubject.CurrentRow.Index;
                txtSubjectID.Text = dgvSubject.Rows[row].Cells[0].Value.ToString();
                txtSubjectName.Text = dgvSubject.Rows[row].Cells[1].Value.ToString();
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private bool ValidField()
        {
            return txtSubjectName.Text.Equals(String.Empty) ? true : false;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Delete this subject ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Subject_Delete(dgvSubject.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete subject successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinData("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete subject unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

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
                    BinData("", " id = '" + x + "' or subjectName like '%" + x + "%'", "");
                }
                catch
                {
                    BinData("", " subjectName like '%" + txtSearch.Text + "%'", "");
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
                MessageBox.Show("Please fill out textbox Subject Name!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Subject subject = new Subject(txtSubjectID.Text, txtSubjectName.Text);
            if (txtSubjectID.Text.Equals(""))
            {
                if (obj.Subject_Insert(subject))
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
                if (obj.Subject_Update(subject))
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

        private void frmSubject_Load(object sender, EventArgs e)
        {

            BinData("", "", "");
        }
    }
}
