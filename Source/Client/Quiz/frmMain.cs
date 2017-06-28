using Quiz.BUS;
using Quiz.Entity;
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
    public partial class frmMain : Form
    {
        private string user = "";
        private StudentExam studentExam = null;
        private int time = 0;
        private string questionList = "";
        public frmMain(string username)
        {
            InitializeComponent();
            user = username;
        }

        private void GetQuizInfo()
        {
            try
            {
                Student st = new StudentBUS().Student_GetByTop("", "username = '" + user + "'", "").ElementAt(0);
                studentExam = new StudentExamBUS().StudentExam_GetByTop("", "studentID = '" + st.Id + "' and startTime is null", "").ElementAt(0);

                Exam ex = new ExamBUS().Exam_GetByTop("", "id = '" + studentExam.ExamID + "'", "").ElementAt(0);
                questionList = ex.QuestionList;
                Quiz.Entity.Quiz q = new QuizBUS().Quiz_GetByTop("", "id = '" + ex.QuizID + "'", "").ElementAt(0);
                lbQuizName.Text += q.QuizName;
                lbTime.Text += q.Time + "minutes";
                time = int.Parse(q.Time)*60;
                lbSubject.Text += q.SubJectName;
                lbQuestionCount.Text += int.Parse(q.QCountSingle) + int.Parse(q.QCountMultiple) + " questions";
            }
            catch
            {
                lbQuizName.Text += "No Data";
                lbQuestionCount.Text += "No Data";
                lbTime.Text += "No Data";
                lbSubject.Text += "No Data";
                btnStart.Enabled = false;
            }
        }
        private void GetUserInfo()
        {
            Student st = new StudentBUS().Student_GetByTop("", "username = '" + user + "'", "").ElementAt(0);
            lbStudentID.Text += st.Id;
            lbStudentName.Text += st.Fullname;
            lbClass.Text += st.ClassName;
        }

        private void btnStart_Click(object sender, EventArgs e)
        {
            if (ckAgree.Checked == false)
            {
                ckAgree.BackColor = Color.YellowGreen;
                return;
            }
            studentExam.StartTime = DateTime.Now.ToString();
            if (new StudentExamBUS().StudentExam_Update(studentExam))
            {
                this.Hide();
                new frmQuiz(user, questionList, time).Show();
            }
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            GetUserInfo();
            GetQuizInfo();
        }

        private void ckAgree_CheckedChanged(object sender, EventArgs e)
        {
            if (ckAgree.Checked) ckAgree.BackColor = Color.Transparent;
        }
    }
}
