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

namespace Quiz_Server
{
    public partial class frmQuiz : Form
    {
        private QuizBUS quizObj = new QuizBUS();
        private ExamBUS examObj = new ExamBUS();
        private QuestionBUS qbus = new QuestionBUS();
        private SubQuestionBUS sqbus = new SubQuestionBUS();
        private AnswerBUS abus = new AnswerBUS();

        public frmQuiz()
        {
            InitializeComponent();
        }

        //private BindGridQuiz(String t = "",string w = "", string o = "")
        //{

        //}
        private void BindGridQuiz(String t = "", String w = "", String o = "")
        {
            List<Quiz.Entity.Quiz> data = quizObj.Quiz_GetByTop(t, w, o);
            dgrQuiz.DataSource = data;
            dgrQuiz.Columns["id"].HeaderText = "Quiz ID";
            dgrQuiz.Columns["quizName"].HeaderText = "Quiz name";
            dgrQuiz.Columns["quizName"].DisplayIndex = 0;
            dgrQuiz.Columns["time"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrQuiz.Columns["qCountSingle"].HeaderText = "Single question";
            dgrQuiz.Columns["qCountSingle"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrQuiz.Columns["qCountMultiple"].HeaderText = "Multiple question";
            dgrQuiz.Columns["qCountMultiple"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrQuiz.Columns["time"].HeaderText = "Time";
            dgrQuiz.Columns["time"].DisplayIndex = 4;
            dgrQuiz.Columns["teacherID"].HeaderText = "Teacher ID";
            dgrQuiz.Columns["teacherName"].HeaderText = "Teacher name";
            dgrQuiz.Columns["teacherName"].Visible = false;
            dgrQuiz.Columns["subjectName"].HeaderText = "Subject name";
            dgrQuiz.Columns["subjectName"].DisplayIndex = 1;
            dgrQuiz.Columns["teacherID"].Visible = false;
            dgrQuiz.Columns["id"].Visible = false;
            dgrQuiz.Columns["teacherId"].Visible = false;
            dgrQuiz.Columns["subjectId"].Visible = false;
        }

        private void BindGridExam(String t = "", String w = "", String o = "")
        {
            List<Quiz.Entity.Exam> data = examObj.Exam_GetByTop(t, w, o);
            dgrExam.DataSource = data;
            dgrExam.Columns["id"].HeaderText = "#";
            dgrExam.Columns["id"].Width = 50;
            dgrExam.Columns["quizID"].Visible = false;
            dgrExam.Columns["quizName"].Visible = false;
            dgrExam.Columns["questionList"].HeaderText = "Question list";
            dgrExam.Columns["createDate"].HeaderText = "Create date";
            dgrExam.Columns["questionList"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
        }

        private void BinCmbSubject(String t, String w, String o)
        {
            List<Subject> lst = new SubjectBUS().Subject_GetByTop(t, w, o);
            lst.Insert(0, new Quiz.Entity.Subject("0", "Select an option"));
            cmbSubject.DataSource = lst;
            cmbSubject.DisplayMember = "subjectName";
            cmbSubject.ValueMember = "id";
            cmbSubject.SelectedIndex = 0;
        }
        private void BinCmbTeacher(String t, String w, String o)
        {
            List<Teacher> lst = new TeacherBUS().Teacher_GetByTop(t, w, o);
            lst.Insert(0, new Quiz.Entity.Teacher("0", "--Select an option--", "", "", ""));
            cmbTeacher.DataSource = lst;
            cmbTeacher.DisplayMember = "name";
            cmbTeacher.ValueMember = "id";
            cmbTeacher.SelectedIndex = 0;
        }
        private void Clear()
        {
            txtSearch.Text = "";
            txtQuizID.Text = "";
            txtQuizName.Text = "";
            nbSingle.Value = 0;
            nbQuizTime.Value = 0;
            cmbSubject.SelectedIndex = 0;
            cmbTeacher.SelectedIndex = 0;
        }
        private bool ValidField()
        {
            bool check = false;
            if (txtQuizName.Text.Equals("")) check = true;
            if (nbSingle.Value <= 0) check = true;
            if (nbQuizTime.Value <= 0) check = true;
            if (cmbTeacher.SelectedIndex < 1) check = true;
            if (cmbSubject.SelectedIndex < 1) check = true;
            return check;
        }

        private void btnAdd_Click(Object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Quiz.Entity.Quiz quiz = new Quiz.Entity.Quiz();
            quiz.QCountSingle = (nbSingle.Value.ToString());
            quiz.QCountMultiple = (nbMultiple.Value.ToString());
            quiz.Time = (nbQuizTime.Value.ToString());
            quiz.SubjectID = cmbSubject.SelectedValue.ToString();
            quiz.TeacherID = cmbTeacher.SelectedValue.ToString();
            quiz.QuizName = txtQuizName.Text;
            if (quizObj.Quiz_Insert(quiz) > 0)
            {
                MessageBox.Show("Insert Quiz successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            else
            {
                MessageBox.Show("Insert Quiz unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            BindGridQuiz("", "", "");
            Clear();
        }

        private void btnEdit_Click(Object sender, EventArgs e)
        {
            if (ValidField())
            {
                MessageBox.Show("Please fill out all textbox!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }
            Quiz.Entity.Quiz quiz = new Quiz.Entity.Quiz();
            quiz.QCountSingle = (nbSingle.Value.ToString());
            quiz.QCountMultiple = (nbMultiple.Value.ToString());
            quiz.Time = (nbQuizTime.Value.ToString());
            quiz.SubjectID = cmbSubject.SelectedValue.ToString();
            quiz.TeacherID = cmbTeacher.SelectedValue.ToString();
            quiz.QuizName = txtQuizName.Text;
            quiz.Id = txtQuizID.Text;
            if (quizObj.Quiz_Update(quiz))
            {
                MessageBox.Show("Update Quiz successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            else
            {
                MessageBox.Show("Update Quiz unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
            BindGridQuiz("", "", "");
            Clear();
        }

        private void btnDelete_Click(Object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Delete this quiz ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    if (quizObj.Quiz_Delete(dgrQuiz.CurrentRow.Cells[0].Value.ToString()))
                    {
                        MessageBox.Show("Delete quiz successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        BindGridQuiz("", "", "");
                    }
                    else
                    {
                        MessageBox.Show("Delete quiz unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    }
                }
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnSearch_Click(Object sender, EventArgs e)
        {
            try
            {
                int x = int.Parse(txtSearch.Text);
                BindGridQuiz("", " id = '" + x + "' or quizName like N'%" + x + "%'", "");
            }
            catch
            {
                BindGridQuiz("", " quizName like N'%" + txtSearch.Text + "%'", "");
            }
        }

        private void dgrQuiz_CellClick(Object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            try
            {
                int row = dgrQuiz.CurrentRow.Index;
                txtQuizID.Text = dgrQuiz.Rows[row].Cells[0].Value.ToString();
                txtQuizName.Text = dgrQuiz.Rows[row].Cells["quizName"].Value.ToString();
                nbSingle.Value = int.Parse(dgrQuiz.Rows[row].Cells["qCountSingle"].Value.ToString());
                nbMultiple.Value = int.Parse(dgrQuiz.Rows[row].Cells["qCountMultiple"].Value.ToString());
                nbQuizTime.Value = int.Parse(dgrQuiz.Rows[row].Cells["time"].Value.ToString());
                cmbSubject.SelectedValue = dgrQuiz.Rows[row].Cells["subjectID"].Value.ToString();
                cmbTeacher.SelectedValue = dgrQuiz.Rows[row].Cells["teacherID"].Value.ToString();

                BindGridExam("", "quizID = '" + txtQuizID.Text.Trim() + "'", "");
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void dgrQuiz_CellMouseDown(Object sender, DataGridViewCellMouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                if (e.RowIndex >= 0)
                {
                    dgrQuiz.ClearSelection();
                    dgrQuiz.Rows[e.RowIndex].Selected = true;
                }
            }
        }

        private void txtSearch_KeyPress(Object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == 13)
            {
                try
                {
                    int x = int.Parse(txtSearch.Text);
                    BindGridQuiz("", " id = '" + x + "' or quizName like N'%" + x + "%'", "");
                }
                catch
                {
                    BindGridQuiz("", " quizName like N'%" + txtSearch.Text + "%'", "");
                }
            }
        }

        private void btnClear_Click(Object sender, EventArgs e)
        {
            Clear();
        }

        private void btnRefresh_Click(Object sender, EventArgs e)
        {
            BindGridQuiz();
        }

        private void btnBack_Click(Object sender, EventArgs e)
        {
            new frmMain().Show();
            this.Hide();
        }

        private void btnDeleteMore_Click(Object sender, EventArgs e)
        {
            if (MessageBox.Show("Delete all selected item?", "Notice", MessageBoxButtons.OKCancel, MessageBoxIcon.Information) == DialogResult.OK)
            {
                int count = 0;
                foreach (DataGridViewRow r in dgrQuiz.SelectedRows)
                {
                    {
                        if (quizObj.Quiz_Delete(r.Cells["id"].Value.ToString())) { count++; }
                    }
                }
                BindGridQuiz("", "", "");
                MessageBox.Show("Successful delete " + count + " item.", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void menuEdit_Click(Object sender, EventArgs e)
        {
            if (dgrQuiz.SelectedRows[0].Index < 0) return;
            try
            {
                int row = dgrQuiz.CurrentRow.Index;
                txtQuizID.Text = dgrQuiz.Rows[row].Cells[0].Value.ToString();
                txtQuizName.Text = dgrQuiz.Rows[row].Cells["quizName"].Value.ToString();
                nbSingle.Value = int.Parse(dgrQuiz.Rows[row].Cells["qCountSingle"].Value.ToString());
                nbMultiple.Value = int.Parse(dgrQuiz.Rows[row].Cells["qCountMultiple"].Value.ToString());
                nbQuizTime.Value = int.Parse(dgrQuiz.Rows[row].Cells["time"].Value.ToString());
                cmbSubject.SelectedValue = dgrQuiz.Rows[row].Cells["subjectID"].Value.ToString();
                cmbTeacher.SelectedValue = dgrQuiz.Rows[row].Cells["teacherID"].Value.ToString();
            }
            catch
            {
                MessageBox.Show("Select a row first", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void menuDelete_Click(Object sender, EventArgs e)
        {
            if (dgrQuiz.SelectedRows[0].Index < 0) return;
            if (MessageBox.Show("Delete this quiz ?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                if (quizObj.Quiz_Delete(dgrQuiz.SelectedRows[0].Cells["id"].Value.ToString()))
                {
                    MessageBox.Show("Delete quiz successed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    BindGridQuiz("", "", "");
                }
                else
                {
                    MessageBox.Show("Delete quiz unsuccessed!", "Infomation", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
        }

        private void frmQuiz_Load(Object sender, EventArgs e)
        {
            BindGridQuiz("", "", "");
            BinCmbSubject("", "", "");
            BinCmbTeacher("", "", "");
            BindGridExam();
        }

        private void createRandomExamToolStripMenuItem_Click(object sender, EventArgs e)
        {
            try
            {
                string subjectID = dgrQuiz.SelectedRows[0].Cells["subjectID"].Value.ToString();
                string quizID = dgrQuiz.SelectedRows[0].Cells["id"].Value.ToString();
                int singleQuesion = int.Parse(dgrQuiz.SelectedRows[0].Cells["qCountSingle"].Value.ToString());
                int multipleQuesion = int.Parse(dgrQuiz.SelectedRows[0].Cells["qCountMultiple"].Value.ToString());
                string input = Microsoft.VisualBasic.Interaction.InputBox("Number of exam will be create?", "InputBox");
                int number = 0;
                try
                {
                    number = int.Parse(input);
                    if(number <= 0)
                    {
                        MessageBox.Show("Input number must be possitive integer", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return;
                    }
                }
                catch
                {
                    MessageBox.Show("Input number wrong format", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                int count = 0;
                for(int i = 0;i < number; i++)
                {
                    string questionList = createExam(subjectID, singleQuesion, multipleQuesion);
                    if (questionList != null)
                    {
                        Exam ex = new Exam();
                        ex.QuestionList = questionList;
                        ex.QuizID = quizID;
                        ex.CreateDate = DateTime.Now.ToString();
                        ex.ID = "";
                        int examID = 0;
                        if ((examID = examObj.Exam_Insert(ex)) > 0)
                        {
                            count++;
                        }
                        else
                        {
                            
                        }
                    }
                }
                MessageBox.Show("Make " + count + " /" + number + "exam success!", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
                BindGridExam();
            }
            catch
            {
                return;
            }
        }

        private string createExam(string subjectID, int single, int multiple)
        {
            string questionList = "";
            List<Question> lstSingle = qbus.Question_GetByTop("", "subjectID = '" + subjectID + "' and content is null", "");
            List<Question> lstMultiple = qbus.Question_GetByTop("", "subjectID = '" + subjectID + "' and content is not null", "");
            if (single > lstSingle.Count || multiple > lstMultiple.Count)
            {
                MessageBox.Show("Number of question bigger than data have", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return null;
            }
            Random rd = new Random();
            int randomValue = -1;
            for (int i = 0; i < single; ++i)
            {
                randomValue = rd.Next(0, lstSingle.Count - 1);
                if (questionList == "")
                    questionList += lstSingle.ElementAt(randomValue).Id;
                else
                    questionList += ";" + lstSingle.ElementAt(randomValue).Id;
                lstSingle.RemoveAt(randomValue);
            }
            if (multiple > 0) questionList += "-";
            for (int i = 0; i < multiple; ++i)
            {
                randomValue = rd.Next(0, lstMultiple.Count - 1);
                if (i == 0)
                    questionList += lstMultiple.ElementAt(randomValue).Id;
                else
                    questionList += ";" + lstMultiple.ElementAt(randomValue).Id;
                lstMultiple.RemoveAt(randomValue);
            }
            return questionList;
        }

        private void menuDeleteExam_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Delete selected item?", "Notice", MessageBoxButtons.YesNo, MessageBoxIcon.Information) == DialogResult.Yes)
            {
                examObj.Exam_Delete(dgrExam.SelectedRows[0].Cells["id"].Value.ToString());
                BindGridExam();
            }
        }

        private void menuViewExam_Click(object sender, EventArgs e)
        {
            string content = "";
            int questionNumber = 0;
            string[] questionList = dgrExam.SelectedRows[0].Cells["questionList"].Value.ToString().Split('-');
            string[] singleQuestion = questionList[0].Split(';');
            foreach (string item in singleQuestion)
            {
                SubQuestion sq = sqbus.SubQuestion_GetByTop("", "questionID = '" + item.Trim() + "'", "").ElementAt(0);
                content += "Question " + (++questionNumber) + ". "+ sq.Content + "\r\n";
                List<Answer> lst = abus.Answer_GetByTop("", "subQuestionID = '" + sq.Id + "'", "");
                for (int i = 0; i < lst.Count; ++i)
                {
                    Answer a = lst.ElementAt(i);
                    if (a.IsCorrect.ToLower() == "true")
                    {
                        content += (char)(65 + i) + ". " + a.Answers + " *\r\n";
                    }
                    else
                    {
                        content += (char)(65 + i) + ". " + a.Answers + "\r\n";
                    }
                }
                content += "\r\n";
            }
            if (questionList.Length > 1)
            {
                singleQuestion = questionList[1].Split(';');
                foreach (string item in singleQuestion)
                {
                    Question q = qbus.Question_GetByTop("", "id='" + item.Trim() + "'", "").ElementAt(0);
                    content += "Question " + (++questionNumber) + ". " + q.Content + "\r\n";
                    List<SubQuestion> lst = sqbus.SubQuestion_GetByTop("", "questionID = '" + q.Id + "'", "");
                    foreach (SubQuestion sq in lst)
                    {
                        content += sq.Content + "\r\n";
                        List<Answer> lstAnswer = abus.Answer_GetByTop("", "subQuestionID = '" + sq.Id + "'", "");
                        for (int i = 0; i < lstAnswer.Count; ++i)
                        {
                            Answer a = lstAnswer.ElementAt(i);
                            if (a.IsCorrect.ToLower() == "true")
                            {
                                content += (char)(65 + i) + ". " + a.Answers + " *\r\n";
                            }
                            else
                            {
                                content += (char)(65 + i) + ". " + a.Answers + "\r\n";
                            }
                        }
                        content += "\r\n";
                    }
                }
            }
            new frmViewExam(content).ShowDialog();
        }

        private void dgrExam_CellMouseDown(object sender, DataGridViewCellMouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                if (e.RowIndex >= 0)
                {
                    dgrExam.ClearSelection();
                    dgrExam.Rows[e.RowIndex].Selected = true;
                }
            }
        }
    }
}
