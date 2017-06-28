using Quiz.BUS;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Quiz
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string u = txtUsername.Text;
            string p = txtPassword.Text;
            StudentBUS st = new StudentBUS();
            if(st.Student_GetByTop("","username = '"+u+"' and password = '"+p+"'","").Count > 0)
            {
                MessageBox.Show("Login success!", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
                new frmMain(u).Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Login unsuccess!", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtUsername.Text = "";
                txtPassword.Text = "";
            }
        }
    }
}
