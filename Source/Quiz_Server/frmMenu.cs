using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Quiz_Server
{
    public partial class frmMenu : Form
    {
        public frmMenu()
        {
            InitializeComponent();
        }

        private void frmMenu_Load(object sender, EventArgs e)
        {

        }

        private void quảnLySinhViênToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmStudent frm = new frmStudent();
            this.Hide();
            frm.ShowDialog();
            this.Show();
        }

        private void quảnLýGiảngViênToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmTeacher frm = new frmTeacher();
            this.Hide();
            frm.ShowDialog();
            this.Show();
        }

        private void quảnLýLớpToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmClass frm = new frmClass();
            this.Hide();
            frm.ShowDialog();
            this.Show();
        }

        private void quảnLýKhoaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmFaculty frm = new frmFaculty();
            this.Hide();
            frm.ShowDialog();
            this.Show();
        }

        private void mônHọcToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmSubject frm = new frmSubject();
            this.Hide();
            frm.ShowDialog();
            this.Show();
        }

        private void chủĐềToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmTopic frm = new frmTopic();
            this.Hide();
            frm.ShowDialog();
            this.Show();
        }

        private void mứcĐộToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmLevel frm = new frmLevel();
            this.Hide();
            frm.ShowDialog();
            this.Show();
        }

        private void câuHỏiChaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmQuestion frm = new frmQuestion();
            this.Hide();
            frm.ShowDialog();
            this.Show();
        }

        private void SubMenuSubAnswer_Click(object sender, EventArgs e)
        {
            frmManSubAnswer frm = new frmManSubAnswer();
            this.Hide();
            frm.ShowDialog();
            this.Show();
        }
    }
}
