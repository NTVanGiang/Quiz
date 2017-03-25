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
    public partial class frmTopic : Form
    {
        private TopicBUS obj = new TopicBUS();
        public frmTopic()
        {
            InitializeComponent();
        }

        private void frmTopic_Load(object sender, EventArgs e)
        {
            BinData("", "", "");
            BinCmbSubject("", "", "");
        }

        private void BinData(string t, string w, string o)
        {
            dgvTopic.DataSource = null;
            dgvTopic.DataSource = obj.Topic_GetByTop(t, w, o);
            dgvTopic.Columns[0].DataPropertyName = "id";
            dgvTopic.Columns[0].HeaderText = "Topic ID";
            dgvTopic.Columns[1].DataPropertyName = "topicName";
            dgvTopic.Columns[1].HeaderText = "Topic Name";
            dgvTopic.Columns[2].DataPropertyName = "subjectName";
            dgvTopic.Columns[2].HeaderText = "Subject Name";
            dgvTopic.Columns[2].Width = 150;
            dgvTopic.Columns[3].DataPropertyName = "subjectID";
            dgvTopic.Columns[3].HeaderText = "Subject ID";
            dgvTopic.Columns[3].Visible = false;
        }

        private void BinCmbSubject(string t, string w, string o)
        {
            cmbSubject.DataSource = new SubjectBUS().Subject_GetByTop(t, w, o);
            cmbSubject.DisplayMember = "subjectName";
            cmbSubject.ValueMember = "id";
            cmbSubject.SelectedIndex = -1;
        }

        private void Clear()
        {
            txtTopicID.Text = "";
            txtSearch.Text = "";
            txtTopicName.Text = "";
            cmbSubject.SelectedIndex = -1;
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                int row = dgvTopic.CurrentRow.Index;
                txtTopicID.Text = dgvTopic.Rows[row].Cells[0].Value.ToString();
                txtTopicName.Text = dgvTopic.Rows[row].Cells[1].Value.ToString();
                cmbSubject.SelectedValue = dgvTopic.Rows[row].Cells[3].Value;
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
                if (MessageBox.Show("Delete this topic ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (obj.Topic_Delete(dgvTopic.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete topic successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BinData("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete topic unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private bool ValidField()
        {
            return (txtTopicName.Text.Equals("") || cmbSubject.SelectedIndex < 0) ? true : false;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Topic topic = new Topic(txtTopicID.Text,txtTopicName.Text,cmbSubject.SelectedValue.ToString());
            if (txtTopicID.Text.Equals(""))
            {
                if (obj.Topic_Insert(topic))
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
                if (obj.Topic_Update(topic))
                {
                    MessageBox.Show("Update topic successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
                else
                {
                    MessageBox.Show("update topic unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                }
            }
            BinData("", "", "");
            Clear();
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Clear();
            txtTopicName.Select();
        }

        private void txtSearch_Leave(object sender, EventArgs e)
        {
            Clear();
            BinData("", "", "");
        }

        private void txtSearch_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearch.Text);
                    BinData("", " id = '" + x + "' or topicName like '%" + x + "%'", "");
                }
                catch
                {
                    BinData("", " topicName like '%" + txtSearch.Text + "%'", "");
                }
            }
        }
    }
}
