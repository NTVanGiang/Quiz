using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Quiz.Entity;
using Quiz.BUS;

namespace Quiz_Server
{
    public partial class frmLogin : Form
    {
        public frmLogin()
        {
            InitializeComponent();
        }

        private void Clear() {
            txtPassword.Text = "";
            txtUsername.Text = "";
        }

        private bool LoginValid(String u, String p) {
            TeacherBUS obj = new TeacherBUS();
            if(obj.Teacher_LoginValid(u,p)) {
                MessageBox.Show("Login successful!");
                return true;
            }else {
                MessageBox.Show("Login unsuccessful!");
                Clear();
                return false;
            }
        }

        private bool ValidField()
        {
            return (txtUsername.Text.Equals("") || txtPassword.Text.Equals("")) ? true : false;
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill user name and password!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                txtUsername.Select();
                return;
            }
            if (LoginValid(txtUsername.Text, txtPassword.Text))
            {
                new frmMain().Show();
                this.Hide();
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void frmLogin_Load(object sender, EventArgs e)
        {
            txtUsername.Select();
        }

        private void ptexit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void ptminimize_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }
    }
}
