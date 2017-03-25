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
    public partial class frmMain : Form
    {
        public frmMain()
        {
            InitializeComponent();
        }

        private void ptexit_Click(object sender, EventArgs e)
        {
            Environment.Exit(0);
        }

        private void ptminimize_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void btnResourceManager_Click(object sender, EventArgs e)
        {
            pnClientStatus.Visible = false;
            pnCurrentQuiz.Dock = DockStyle.Fill;
            lbCurrentQuiz.Text = "Resource Manager";

        }
    }
}
