using Quiz.BUS;
using Quiz.Entity;
using Quiz.Objects;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Quiz
{
    public partial class frmQuiz : Form
    {
        #region
        private List<string> questionList;
        private QuestionBUS qbus = new QuestionBUS();
        private SubQuestionBUS sqbus = new SubQuestionBUS();
        private AnswerBUS abus = new AnswerBUS();
        private Random rng = new Random();
        private string studentExamID = "";
        private Dictionary<string, string> studentAnswerLog = new Dictionary<string, string>();
        // as seconds
        private int time;
        private string user;
        public frmQuiz(string _studentExamID, string _user, string _questionList, int _time)
        {
            InitializeComponent();
            studentExamID = _studentExamID;
            time = _time;
            user = _user;
            GetQuestionList(_questionList);
        }

        private void frmQuiz_Load(object sender, EventArgs e)
        {
            CountDownStart();
            GetUserInfo();
            QuestionNumberButtonAdd();
            AddScrollToPanelView(fpnQuestionView);
            AddScrollToPanelView(fpnQuestionButton);

            BindQuestion();
        }

        private void GetQuestionList(string _questionList)
        {
            questionList = new List<string>();
            string[] arr = Regex.Split(_questionList, "-|;");
            foreach (string i in arr) questionList.Add(i);

        }

        void AddScrollToPanelView(FlowLayoutPanel mypanel)
        {
            mypanel.AutoScroll = false;
            mypanel.HorizontalScroll.Enabled = false;
            mypanel.HorizontalScroll.Visible = false;
            mypanel.HorizontalScroll.Maximum = 0;
            mypanel.AutoScroll = true;
        }

        private void GetUserInfo()
        {
            Student st = new StudentBUS().Student_GetByTop("", "username = '" + user + "'", "").ElementAt(0);
            lbStudentID.Text += st.Id;
            lbStudentName.Text += st.Fullname;
            lbClassName.Text += st.ClassName;
        }

        private void CountDownStart()
        {
            lbTime.Text = TimeSpan.FromSeconds(time).ToString();
            tmCountDown.Interval = 1000;
            tmCountDown.Start();
        }

        private void BindQuestion()
        {
            fpnQuestionView.BackColor = System.Drawing.ColorTranslator.FromHtml("#CAE1FF");
            int questionNumber = 0;
            foreach (string questionID in questionList)
            {
                fpnQuestionView.Controls.Add(GetQuestion(++questionNumber, questionID));
            }

            Label lb = new Label();
            lb.Size = new Size(10, 1000);
            fpnQuestionView.Controls.Add(lb);

            Label lb1 = new Label();
            lb1.Name = "lbEnd";
            fpnQuestionView.Controls.Add(lb1);
        }


        private void QuestionNumberButtonAdd()
        {
            for (int i = 1; i <= questionList.Count; ++i)
            {
                Button btn = new Button();
                btn.Font = new Font(btn.Font.FontFamily, 8);
                btn.Name = "btn_" + i;
                btn.Text = i.ToString();
                btn.Click += new EventHandler(btnQuestion_Click);
                btn.Size = new Size(30, 30);
                fpnQuestionButton.Controls.Add(btn);
            }
        }
        #endregion
        private FlowLayoutPanel GetQuestion(int questionNumber, string questionID)
        {
            FlowLayoutPanel fpn = new FlowLayoutPanel();
            fpn.FlowDirection = FlowDirection.TopDown;
            fpn.BackColor = System.Drawing.ColorTranslator.FromHtml("#CAE1FF");
            fpn.MaximumSize = new Size(fpnQuestionView.Width, Int32.MaxValue);
            fpn.AutoSize = true;

            Question q = qbus.Question_GetByTop("", "id='" + questionID + "'", "").ElementAt(0);
            if (q.Content != "")
            {
                Label lb = new Label();
                lb.MaximumSize = new Size(fpnQuestionView.Width, 0);
                lb.AutoSize = true;
                lb.Name = "lb_" + questionID;
                lb.Text = "Question " + (questionNumber) + ". " + q.Content + "\r\n";
                fpn.Controls.Add(lb);
            }
            List<SubQuestion> lstSub = sqbus.SubQuestion_GetByTop("", "questionID='" + questionID + "'", "");
            foreach (SubQuestion sq in lstSub)
            {
                studentAnswerLog.Add(sq.Id, null);
                // fill subquesion content
                Label lb = new Label();
                lb.AutoSize = true;
                lb.MaximumSize = new Size(fpnQuestionView.Width, 0);
                lb.Font = new Font(lb.Font.FontFamily, 12);
                if (lstSub.Count == 1)
                {
                    lb.Text = "Question " + (questionNumber) + ". " + sq.Content + "\r\n";
                    lb.Name = "lb_" + questionNumber;
                    fpn.Controls.Add(lb);
                }
                else
                {
                    lb.Text = sq.Content + "\r\n";
                }
                LinkLabel llb = new LinkLabel();
                llb.Name = "llb_" + sq.Id + "_" +questionID+"_"+sq.Content+"_"+sq.Active + "_" + sq.ReportCount;
                llb.Click += new EventHandler(llbFlagQuestion_Click);
                llb.Text = "Flag Question";

                fpn.Controls.Add(lb);
                fpn.Controls.Add(llb);

                List<Answer> lstAnswer = abus.Answer_GetByTop("", "subQuestionID='" + sq.Id + "'", "");
                //Shuffle lstAnswer
                Shuffle(lstAnswer);
                for (int i = 0; i < lstAnswer.Count; i++)
                {
                    Answer answer = lstAnswer.ElementAt(i);
                    RadioButton rd = new RadioButton();
                    rd.MaximumSize = new Size(fpnQuestionView.Width, 0);
                    rd.AutoSize = true;
                    rd.Click += new EventHandler(rdAnswer_CheckedChanged);
                    rd.Name = "answer_" + questionNumber + "_" + questionID + "_" + sq.Id + "_" + answer.Id + "_" + answer.IsCorrect;
                    rd.Text = (char)(65 + i) + ". " + answer.Answers;
                    fpn.Controls.Add(rd);
                }
            }
            return fpn;
        }

        private void llbFlagQuestion_Click(Object sender, EventArgs e)
        {
            if(MessageBox.Show("Flag this question?","Question is wrong?",MessageBoxButtons.YesNo,MessageBoxIcon.Question) == DialogResult.Yes)
            {
                LinkLabel llb = sender as LinkLabel;
                string[] arr = llb.Name.Split('_');
                SubQuestion sq = new SubQuestion(arr[1], arr[2], arr[3], arr[4]);
                sq.ReportCount = (int.Parse(arr[5]) + 1).ToString();
                if (sqbus.SubQuestion_Update(sq))
                {
                    lbNotification.Text = "FLag question success";
                }
                else
                {
                    lbNotification.Text = "FLag question unsuccess";
                }
                ex2.Refresh();
                llb.Enabled = false;
            }
        }
        private void rdAnswer_CheckedChanged(Object sender, EventArgs e)
        {

            RadioButton rd = (RadioButton)sender;
            string[] arr = rd.Name.Split('_');
            Button btnFinder = Controls.Find("btn_" + arr[1], true).FirstOrDefault() as Button;
            btnFinder.BackColor = Color.Red;
            lbNotification.Text = "Choose answer " + rd.Text.ElementAt(0) + " at question " + arr[1];
            ex2.Refresh();
            string key = arr[3];
            if (studentAnswerLog.ContainsKey(key) == false)
            {
                studentAnswerLog.Add(key, arr[4]);
            }
            else
            {
                studentAnswerLog[key] = arr[4];
            }
        }

        private void QuizSubmit()
        {
            fpnQuestionView.Enabled = false;
            QuestionAnswerLog check = new QuestionAnswerLog();
            int count = 0;

            Result result = new Result();
            result.StudentExamID = studentExamID;
            int resultID = 0;
            if ((resultID = new ResultBUS().Result_Insert(result)) > 0)
            {
                int counter = 0;
                foreach (string key in studentAnswerLog.Keys)
                {
                    check.studentAnswerID = studentAnswerLog[key];
                    if (check.IsCorrect()) count++;
                    ResultDetail rsDetail = new ResultDetail();
                    rsDetail.ResultID = resultID.ToString();
                    rsDetail.SubQuestionID = key;
                    rsDetail.StudentAnswerID = (check.studentAnswerID == null ? null : check.studentAnswerID);
                    rsDetail.IsCorrect = (check.IsCorrect() ? "True" : "False");
                    if (new ResultDetailBUS().ResultDetail_Insert(rsDetail) > 0) counter++;
                }
                if (counter == studentAnswerLog.Count)
                {
                    StudentExam studentExam = new StudentExamBUS().StudentExam_GetByTop("", "id='" + studentExamID + "'", "").ElementAt(0);
                    double score = (float)10 / studentAnswerLog.Count * count;
                    double finalScore = Math.Round((100 - int.Parse(studentExam.Flag)) * score / (float)100, 2);
                    result.Score = finalScore.ToString();
                    result.Id = resultID.ToString();
                    if (new ResultBUS().Result_Update(result))
                    {
                        llbFinnish.LinkBehavior = LinkBehavior.NeverUnderline;
                        llbFinnish.Text = "Correct: " + count + "/" + studentAnswerLog.Count;
                        llbFinnish.Text += "\r\nFlag: " + studentExam.Flag + " % score";
                        llbFinnish.Text += "\r\nFinal Score: " + finalScore;
                    }
                    else
                    {
                        llbFinnish.Text = "Error at Resutl update";
                    }
                }
                else
                {
                    llbFinnish.Text = "Error at Resutl detail insert";
                }
            }
            else
            {
                llbFinnish.Text = "Error at Resutl insert";
            }
        }
        #region
        private void tmCountDown_Tick(object sender, EventArgs e)
        {
            time--;
            lbTime.Text = TimeSpan.FromSeconds(time).ToString();
            if (time == 0)
            {
                tmCountDown.Stop();
                MessageBox.Show("Time's up!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                QuizSubmit();
            }
        }

        private void llbFinnish_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            if (MessageBox.Show("Submit the quiz?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                QuizSubmit();
                tmCountDown.Stop();
            }
        }


        private void Shuffle(List<Answer> list)
        {
            int n = list.Count;
            while (n > 1)
            {
                n--;
                int k = rng.Next(n + 1);
                Answer value = list[k];
                list[k] = list[n];
                list[n] = value;
            }
        }
        private void btnQuestion_Click(Object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            Label lb = Controls.Find("lbEnd", true).FirstOrDefault() as Label;
            lb.Select();
            lb = Controls.Find("lb_" + btn.Name.Split('_')[1], true).FirstOrDefault() as Label;
            lb.Select();
        }
        #endregion

        private void frmQuiz_FormClosed(object sender, FormClosedEventArgs e)
        {
            Application.Exit();
        }
    }
}
