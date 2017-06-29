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
    public partial class frmMain : DevComponents.DotNetBar.Office2007RibbonForm
    {
        public frmMain()
        {
            InitializeComponent();
        }
        private static bool isClose = false;
        private void frmMain_Load(object sender, EventArgs e)
        {
        }

        private void btnStudentManager_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmStudent().Show();
        }

        private void btnQuestionManager_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmQuestion().Show();
        }

        private void btnSubjectManager_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmSubject().Show();
        }

        private void btnFacultyManager_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmFaculty().Show();
        }

        private void btnClassManager_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmClass().Show();
        }

        private void btnTeacherManager_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmTeacher().Show();
        }

        private void btnCreateQuiz_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmQuiz().Show();
        }

        private void btnQuizMng_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmStudentExam().Show();
        }

        private void btnQuestionImporter_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmImport().Show();
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void frmMain_FormClosing(object sender, FormClosingEventArgs e)
        {
            if(isClose == false)
            {
                if (MessageBox.Show("Exit application?", "Notification", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No)
                {
                    e.Cancel = true;
                }
                isClose = true;
            }
            else
            {
                Application.Exit();
            }
            
        }

        private void buttonItem13_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Maximized;
        }

        private void buttonItem14_Click(object sender, EventArgs e)
        {
            WindowState = FormWindowState.Minimized;
        }

        private void buttonItem15_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmLogin().Show();
        }

        private void frmMain_FormClosed(object sender, FormClosedEventArgs e)
        {
            
        }

        private void buttonItem23_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmQuestion(true).Show();
        }

        private void buttonItem24_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmResult().Show();
        }

        private void buttonItem24_Click_1(object sender, EventArgs e)
        {
            this.Hide();
            new frmResult().Show();
        }

        private void buttonItem19_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmQuiz().Show();
        }

        private void buttonItem20_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmStudentExam().Show();
        }

        private void buttonItem21_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmImport().Show();
        }

        private void buttonItem22_Click(object sender, EventArgs e)
        {
            this.Hide();
            new frmStudent().Show();
        }
    }
}
