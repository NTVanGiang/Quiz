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
    public partial class frmLevel : Form
    {
        private LevelBUS obj = new LevelBUS();
        public frmLevel()
        {
            InitializeComponent();
        }
        private void frmLevel_Load(object sender, EventArgs e)
        {

            BinData("", "", "");
        }
        private void BinData(String t, String w, String o)
        {
            dgvLevel.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            dgvLevel.AllowUserToAddRows = false;
            dgvLevel.AllowUserToDeleteRows = false;
            dgvLevel.MultiSelect = false;
            dgvLevel.BackgroundColor = Color.White;
            dgvLevel.ReadOnly = true;
            dgvLevel.DataSource = obj.Level_GetByTop(t, w, o);
            dgvLevel.Columns[0].HeaderText = "Level ID";
            dgvLevel.Columns[1].HeaderText = "Level Detail";
            dgvLevel.Columns[1].Width = 180;
        }

        private void Clear()
        {
            txtDetail.Text = "";
            txtLevelID.Text = "";
            txtSearch.Text = "";
        }

        private bool ValidField()
        {
            return txtDetail.Text.Equals(String.Empty) ? true : false;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Clear();
            txtDetail.Select();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int row = dgvLevel.CurrentRow.Index;
                txtLevelID.Text = dgvLevel.Rows[row].Cells[0].Value.ToString();
                txtDetail.Text = dgvLevel.Rows[row].Cells[1].Value.ToString();
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
                if (MessageBox.Show("Delete this item ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Level_Delete(dgvLevel.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinData("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out textbox Level Detail!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Level level = new Level(txtLevelID.Text, txtDetail.Text);
            if (txtLevelID.Text.Equals(""))
            {
                if (obj.Level_Insert(level))
                {
                    MessageBox.Show("Insert level successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
                else
                {
                    MessageBox.Show("Insert level unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            else
            {
                if (obj.Level_Update(level))
                {
                    MessageBox.Show("Update level successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("update level unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
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
                    BinData("", " id = '" + x + "' or detail like '%" + x + "%'", "");
                }
                catch
                {
                    BinData("", " detail like '%" + txtSearch.Text + "%'", "");
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
