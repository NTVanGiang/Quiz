using System;
using System.Windows.Forms;

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

        private void frmLogin_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }
    }
}
