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
            new frmStudent().Show();
            this.Hide();
        }

        private void quảnLýGiảngViênToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new frmTeacher().Show();
            this.Hide();
        }

        private void quảnLýLớpToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new frmClass().Show();
            this.Hide();
        }

        private void quảnLýKhoaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new frmFaculty().Show();
            this.Hide();
        }

        private void mônHọcToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new frmSubject().Show();
            this.Hide();
        }
        

        private void câuHỏiChaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            new frmQuestion().Show();
            this.Hide();
        }

        private void SubMenuSubAnswer_Click(object sender, EventArgs e)
        {
            new frmManSubAnswer().Show();
            this.Hide();
        }
    }
}
