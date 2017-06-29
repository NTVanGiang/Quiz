using System;
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

        private void BindData(String t = "", String w = "", String o = "")
        {
            dgvSubject.DataSource = obj.Subject_GetByTop(t, w, o);
            dgvSubject.Columns[0].HeaderText = "Subject ID";
            dgvSubject.Columns[1].HeaderText = "Subject name";
            dgvSubject.Columns[1].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
        }
        private void Clear()
        {
            txtSearch.Text = "";
            txtSubjectID.Text = "";
            txtSubjectName.Text = "";
        }

        private bool ValidField()
        {
            return txtSubjectName.Text.Equals(String.Empty) ? true : false;
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {

        }

        private void txtSearch_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearch.Text);
                    BindData("", " id = '" + x + "' or subjectName like N'%" + x + "%'", "");
                }
                catch
                {
                    BindData("", " subjectName like N'%" + txtSearch.Text + "%'", "");
                }
            }
        }

        private void frmSubject_Load(object sender, EventArgs e)
        {
            BindData("", "", "");
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out textbox Subject Name!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Subject subject = new Subject(txtSubjectID.Text, txtSubjectName.Text);
            if (obj.Subject_Insert(subject))
            {
                MessageBox.Show("Insert faculty successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Insert faculty unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            BindData("", "", "");
            Clear();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out textbox Subject Name!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Subject subject = new Subject(txtSubjectID.Text, txtSubjectName.Text);
            if (obj.Subject_Update(subject))
            {
                MessageBox.Show("Update faculty successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            else
            {
                MessageBox.Show("update faculty unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            BindData("", "", "");
            Clear();
        }

        private void menuDelete_Click(object sender, EventArgs e)
        {
            if (dgvSubject.SelectedRows[0].Index < 0) return;
            try
            {
                if (MessageBox.Show("Delete this subject ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Subject_Delete(dgvSubject.SelectedRows[0].Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete subject successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BindData("", "", "");
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

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            BindData();
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                int x = int.Parse(txtSearch.Text);
                BindData("", " id = '" + x + "' or subjectName like N'%" + x + "%'", "");
            }
            catch
            {
                BindData("", " subjectName like N'%" + txtSearch.Text + "%'", "");
            }
        }

        private void dgvSubject_CellClick(object sender, DataGridViewCellEventArgs e)
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

        private void dgvSubject_CellMouseDown(object sender, DataGridViewCellMouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                if (e.RowIndex >= 0)
                {
                    dgvSubject.ClearSelection();
                    dgvSubject.Rows[e.RowIndex].Selected = true;
                }
            }
        }

        private void menuEdit_Click(object sender, EventArgs e)
        {
            if (dgvSubject.SelectedRows[0].Index < 0) return;
            try
            {
                int row = dgvSubject.CurrentRow.Index;
                txtSubjectID.Text = dgvSubject.SelectedRows[0].Cells[0].Value.ToString();
                txtSubjectName.Text = dgvSubject.Rows[row].Cells[1].Value.ToString();
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
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
                foreach (DataGridViewRow r in dgvSubject.SelectedRows)
                {
                    {
                        if (obj.Subject_Delete(r.Cells["id"].Value.ToString())) { count++; }
                    }
                }
                BindData("", "", "");
                MessageBox.Show("Successful delete " + count + " item.", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void frmSubject_FormClosed(object sender, FormClosedEventArgs e)
        {
            new frmMain().Show();
        }
    }
}
