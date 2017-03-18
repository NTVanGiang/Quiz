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

        private void LoginValid(String u, String p) {
            TeacherBUS obj = new TeacherBUS();
            if(obj.Teacher_LoginValid(u,p)) {
                MessageBox.Show("Login successful!");
            }else {
                MessageBox.Show("Login unsuccessful!");
                Clear();
            }
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            LoginValid(txtUsername.Text, txtPassword.Text);
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }
    }
}
