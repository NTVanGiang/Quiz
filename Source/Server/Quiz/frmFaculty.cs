using System;
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
            BindData();
        }
        private void BindData(String t = "", String w = "", String o = "")
        {
            dgrFaculty.DataSource = obj.Faculty_GetByTop(t, w, o);
            dgrFaculty.Columns[0].HeaderText = "Mã khoa";
            dgrFaculty.Columns[1].HeaderText = "Tên khoa";
            dgrFaculty.Columns[1].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
        }

        private void Clear()
        {
            txtFacultyName.Text = "";
            txtFacultyID.Text = "";
            txtSearch.Text = "";
        }

        private bool ValidField()
        {
            return txtFacultyName.Text.Equals(String.Empty) ? true : false;
        }
        

        private void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Delete this faculty ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Faculty_Delete(dgrFaculty.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete faculty successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BindData("", "", "");
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
            if (e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearch.Text);
                    BindData("", " id = '" + x + "' or facultyName like N'%" + x + "%'", "");
                }
                catch
                {
                    BindData("", " facultyName like N'%" + txtSearch.Text + "%'", "");
                }
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
            BindData();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                int x = int.Parse(txtSearch.Text);
                BindData("", " id = '" + x + "' or facultyName like N'%" + x + "%'", "");
            }
            catch
            {
                BindData("", " facultyName like N'%" + txtSearch.Text + "%'", "");
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
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
            BindData();
            Clear();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out textbox Faculty Name!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Faculty faculty = new Faculty(txtFacultyID.Text, txtFacultyName.Text);

            if (obj.Faculty_Update(faculty))
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

        private void dgrFaculty_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgrFaculty.SelectedRows[0].Index < 0) return;
            try
            {
                int row = dgrFaculty.SelectedRows[0].Index;
                txtFacultyID.Text = dgrFaculty.Rows[row].Cells[0].Value.ToString();
                txtFacultyName.Text = dgrFaculty.Rows[row].Cells[1].Value.ToString();
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void menuDelete_Click(object sender, EventArgs e)
        {
            if (dgrFaculty.SelectedRows[0].Index < 0) return;
            try
            {
                if (MessageBox.Show("Delete this faculty ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Faculty_Delete(dgrFaculty.SelectedRows[0].Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete faculty successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BindData("", "", "");
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

        private void menuEdit_Click(object sender, EventArgs e)
        {
            if (dgrFaculty.SelectedRows[0].Index < 0) return;
            try
            {
                int row = dgrFaculty.SelectedRows[0].Index;
                txtFacultyID.Text = dgrFaculty.Rows[row].Cells[0].Value.ToString();
                txtFacultyName.Text = dgrFaculty.Rows[row].Cells[1].Value.ToString();
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnDeleteMore_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Delete all selected item?", "Notice", MessageBoxButtons.OKCancel, MessageBoxIcon.Information) == DialogResult.OK)
            {
                int count = 0;
                foreach (DataGridViewRow r in dgrFaculty.SelectedRows)
                {
                    {
                        if (obj.Faculty_Delete(r.Cells["id"].Value.ToString())) { count++; }
                    }
                }
                BindData("", "", "");
                MessageBox.Show("Successful delete " + count + " item.", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void dgrFaculty_CellMouseDown(object sender, DataGridViewCellMouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                if (e.RowIndex >= 0)
                {
                    dgrFaculty.ClearSelection();
                    dgrFaculty.Rows[e.RowIndex].Selected = true;
                }
            }
        }
    }
}
