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
        // as seconds
        private int time;
        private string user;
        public frmQuiz(string _user, string _questionList, int _time)
        {
            InitializeComponent();

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
            Button btn = new Button();
            btn.Text = "Finish the quiz";
            fpnQuestionView.Controls.Add(btn);
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
                lb.Text = "Question " + (questionNumber) + ". " + q.Content + "\r\n";
                LinkLabel llb = new LinkLabel();
                llb.Name = "llb_" + questionID;
                llb.Text = "Flag Question";
                fpn.Controls.Add(lb);
                fpn.Controls.Add(llb);
            }
            List<SubQuestion> lstSub = sqbus.SubQuestion_GetByTop("", "questionID='" + questionID + "'", "");
            foreach (SubQuestion sq in lstSub)
            {
                // fill subquesion content
                Label lb = new Label();
                lb.AutoSize = true;
                lb.MaximumSize = new Size(fpnQuestionView.Width, 0);
                lb.Font = new Font(lb.Font.FontFamily, 12);
                if (lstSub.Count == 1)
                {
                    lb.Text = "Question " + (questionNumber) + ". " + sq.Content + "\r\n";
                    LinkLabel llb = new LinkLabel();
                    llb.Name = "llb_" + questionNumber;
                    llb.Text = "Flag Question";
                    fpn.Controls.Add(lb);
                    fpn.Controls.Add(llb);
                }
                else
                {
                    lb.Text = sq.Content + "\r\n";
                    fpn.Controls.Add(lb);
                }

                List<Answer> lstAnswer = abus.Answer_GetByTop("", "subQuestionID='" + sq.Id + "'", "");
                for (int i = 0; i < lstAnswer.Count; i++)
                {
                    Answer answer = lstAnswer.ElementAt(i);
                    RadioButton rd = new RadioButton();
                    rd.MaximumSize = new Size(fpnQuestionView.Width, 0);
                    rd.AutoSize = true;
                    rd.Click += new EventHandler(rdAnswer_CheckedChanged);
                    rd.Name = "answer_" + questionNumber + "_" + i + "_" + answer.Id;
                    rd.Text = (char)(65 + i) + ". " + answer.Answers;
                    fpn.Controls.Add(rd);
                }
            }
            return fpn;
        }
        private void rdAnswer_CheckedChanged(Object sender, EventArgs e)
        {
            RadioButton rd = (RadioButton)sender;
            string[] arr = rd.Name.Split('_');
            if(rd.Checked == true)
            {
                lbNotification.Text = "Choose answer " + rd.Text.ElementAt(0) + " at question " + arr[1];
                exNotification.Refresh();
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
                MessageBox.Show("Time up!");
            }
        }

        private void llbFinnish_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            MessageBox.Show("Finnished!");
        }

        private void QuestionNumberButtonAdd()
        {
            for (int i = 1; i <= questionList.Count; ++i)
            {
                Button btn = new Button();
                btn.Font = new Font(btn.Font.FontFamily, 8);
                btn.Name = "btn_" + questionList.ElementAt(i - 1) + "_" + i;
                btn.Text = i.ToString();
                btn.Click += new EventHandler(btnQuestion_Click);
                btn.Size = new Size(30, 30);
                fpnQuestionButton.Controls.Add(btn);
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
            fpnQuestionView.VerticalScroll.Value += 100;
        }
        #endregion
    }
}
