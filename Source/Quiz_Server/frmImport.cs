using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Microsoft.Office.Interop.Word;
using Quiz.Entity;
using Quiz.BUS;
using System.Text.RegularExpressions;

namespace Quiz_Server
{
    public partial class frmImport : Form
    {
        private QuestionBUS qbus = new QuestionBUS();
        private SubQuestionBUS sqbus = new SubQuestionBUS();
        private AnswerBUS abus = new AnswerBUS();

        private List<SimpleQuestion> lstSimple = new List<SimpleQuestion>();
        private List<MultiQuestion> lstMulti = new List<MultiQuestion>();
        public frmImport()
        {
            InitializeComponent();
        }

        private void btnBrowser_Click(object sender, EventArgs e)
        {
            OpenFileDialog fdlOpen = new OpenFileDialog();
            fdlOpen.InitialDirectory = "/";
            fdlOpen.Title = "Select file";
            fdlOpen.CheckFileExists = true;
            fdlOpen.CheckPathExists = true;
            fdlOpen.Filter = "Word document(*.doc/*.docx)|*.doc*";
            fdlOpen.RestoreDirectory = true;
            fdlOpen.ReadOnlyChecked = true;
            if (fdlOpen.ShowDialog() == DialogResult.OK)
            {
                txtPath.Text = fdlOpen.FileName;
                GetData(txtPath.Text);
            }
        }

        private void GetData(object path)
        {
            //numOfAnswer++            
            Microsoft.Office.Interop.Word.Application word = new Microsoft.Office.Interop.Word.Application();
            SimpleQuestion qItem = null;
            // Define an object to pass to the API for missing parameters
            object miss = System.Reflection.Missing.Value;
            object readOnly = true;
            Microsoft.Office.Interop.Word.Document docs =
                word.Documents.Open(ref path, ref miss, ref readOnly,
                ref miss, ref miss, ref miss, ref miss, ref miss, ref miss,
                ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss);

            int flag = 0;
            for (int i = 1; i <= docs.Paragraphs.Count; i++)
            {
                string temp = docs.Paragraphs[i].Range.Text.Trim();
                if (temp.Trim().ToLower().Equals("<multi>"))
                {
                    MultiQuestion qMul = new MultiQuestion();
                    do
                    {
                        temp = docs.Paragraphs[++i].Range.Text;
                        if (temp.Trim() == "") break;
                        qMul.content += temp + "\r\n";
                    } while (temp != string.Empty);
                    if (temp.Trim() != "")
                    {
                        MessageBox.Show("Syntax error at \"" + qMul.content + "\"...");
                        lstSimple.Clear(); lstMulti.Clear();
                        return;
                    }
                    while (!temp.Trim().ToLower().Equals("</multi>"))
                    {
                        temp = docs.Paragraphs[++i].Range.Text.Trim();
                        if (temp != "")
                        {
                            qItem = new SimpleQuestion();
                            qItem.question = temp;
                            qItem.correctAnswer = -1;
                            List<string> answer = new List<string>();
                            do
                            {
                                temp = docs.Paragraphs[++i].Range.Text.Trim();
                                if (temp == string.Empty || temp.ToLower().Equals("</multi>")) break;
                                temp = Regex.Replace(temp, "[a-z1-4](\\.|\\))[ \t]+", "", RegexOptions.IgnoreCase);
                                if (temp.EndsWith("*"))
                                {
                                    qItem.correctAnswer = answer.Count;
                                    temp = temp.Substring(0, temp.Length - 1).Trim();
                                    answer.Add(temp);
                                }
                                else
                                {
                                    answer.Add(temp);
                                }
                            } while (temp != string.Empty);
                            qItem.answer = answer;
                            if (qItem.correctAnswer != -1)
                                qMul.lstQuestion.Add(qItem);
                            else
                            {
                                MessageBox.Show("Question \"" + qItem.question + "\" have no correct answer");
                                lstSimple.Clear(); lstMulti.Clear();
                                return;
                            }
                        }
                        else
                        {
                            MessageBox.Show("Syntax error at " + qMul.content + "\"...");
                            lstSimple.Clear(); lstMulti.Clear();
                            return;
                        }
                    }
                    lstMulti.Add(qMul);
                    //Ignore blank paragraph
                    i++;
                }
                else if (temp != string.Empty)
                {
                    if (flag % 2 == 0)
                    {
                        //remove question number like Câu 1, Câu 2,...
                        temp = Regex.Replace(temp, "^[0-9]+\\.[ ]*|^Câu [0-9]+:[ ]*|^Question [0-9]+:[ ]*", "", RegexOptions.IgnoreCase);
                        qItem = new SimpleQuestion();
                        qItem.question = temp;
                    }
                    else
                    {
                        List<string> answer = new List<string>();
                        qItem.correctAnswer = -1;
                        while (temp != string.Empty)
                        {
                            //remove answer key, like A,B,C,D
                            temp = Regex.Replace(temp, "[a-z1-4](\\.|\\))[ \t]+", "", RegexOptions.IgnoreCase);
                            if (temp.EndsWith("*"))
                            {
                                qItem.correctAnswer = answer.Count;
                                temp = temp.Substring(0, temp.Length - 1).Trim();
                                answer.Add(temp);
                            }
                            else
                            {
                                answer.Add(temp);
                            }
                            temp = docs.Paragraphs[++i].Range.Text.Trim();
                        }
                        qItem.answer = answer;
                        if (qItem.correctAnswer != -1)
                            lstSimple.Add(qItem);
                        else
                        {
                            MessageBox.Show("Question \"" + qItem.question + "\" have no correct answer");
                            lstSimple.Clear(); lstMulti.Clear();
                            return;
                        }
                    }
                    flag++;
                }
                else
                {
                    MessageBox.Show("Syntax error at " + lstSimple.ElementAt(lstSimple.Count - 1).question);
                    lstSimple.Clear(); lstMulti.Clear();
                    return;
                }
            }
            docs.Close();
            word.Quit();
            BindSimpleQuestion(lstSimple);
            BindMultiQuestion(lstMulti);
        }

        private void BindSimpleQuestion(List<SimpleQuestion> lst)
        {
            //Bind data to gridview
            dgrSimpleQuestion.DataSource = lst;
            dgrSimpleQuestion.Columns[1].Visible = false;
            dgrSimpleQuestion.Columns[0].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrSimpleQuestion.Columns[0].HeaderText = "Question";
        }

        private void BindMultiQuestion(List<MultiQuestion> lst)
        {
            //Bind data to gridview
            dgrMultiQuestion.DataSource = lst;
            dgrMultiQuestion.Columns[0].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrMultiQuestion.Columns[0].HeaderText = "Question";
        }

        private void BindCmbSubject()
        {

            List<Subject> lst = new SubjectBUS().Subject_GetByTop("","","");
            lst.Insert(0, new Subject("0", "Select an option"));
            cmbSubject.DataSource = lst;
            cmbSubject.DisplayMember = "subjectName";
            cmbSubject.ValueMember = "ID";
            cmbSubject.SelectedIndex = 0;

        }

        private void frmImport_Load(object sender, EventArgs e)
        {
            BindCmbSubject();
        }

        private void dgView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            string question = "Question: ";
            SimpleQuestion sq = lstSimple.ElementAt(e.RowIndex);
            question += sq.question + "\r\n";
            for (int i = 0; i < sq.answer.Count; ++i)
            {
                question += (char)(65 + i) + ". " + sq.answer.ElementAt(i) + "\r\n";
            }
            question += "=> Correct: " + (char)(65 + sq.correctAnswer) + "\r\n";
            txtView.Text = question;
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            if(cmbSubject.SelectedIndex < 1)
            {
                MessageBox.Show("Select a subject before import to db", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            } 
            int success = 0, qid = -1, sqid = -1;
            foreach (SimpleQuestion sq in lstSimple)
            {
                if ((qid = qbus.Question_Insert(new Question(null, cmbSubject.SelectedValue.ToString(), null, null))) > 0)
                {
                    if ((sqid = sqbus.SubQuestion_Insert(new SubQuestion(null, qid.ToString(), sq.question, "true"))) > 0)
                    {
                        int count = 0;
                        for (int i = 0; i < sq.answer.Count; i++)
                        {
                            if (sq.correctAnswer == i)
                            {
                                if (abus.Answer_Insert(new Answer(null, sqid.ToString(), sq.answer.ElementAt(i), "true")))
                                {
                                    count++;
                                }
                            }
                            else
                            {
                                if (abus.Answer_Insert(new Answer(null, sqid.ToString(), sq.answer.ElementAt(i), "false")))
                                {
                                    count++;
                                }
                            }
                        }
                        if (count == sq.answer.Count) success++;
                    }
                }
            }
            foreach(MultiQuestion mq in lstMulti)
            {
                if((qid = qbus.Question_Insert(new Question(null, cmbSubject.SelectedValue.ToString(), mq.content, null))) > 0)
                {
                    foreach(SimpleQuestion sq in mq.lstQuestion)
                    {
                        int count = sq.answer.Count;
                        if((sqid = sqbus.SubQuestion_Insert(new SubQuestion(null,qid.ToString(),sq.question,"true"))) > 0)
                        {
                            for(int i = 0;i < sq.answer.Count; ++i)
                            {
                                if(sq.correctAnswer == i)
                                {
                                    if (abus.Answer_Insert(new Answer(null, sqid.ToString(), sq.answer.ElementAt(i), "true"))) count--;

                                }
                                else
                                {
                                    if (abus.Answer_Insert(new Answer(null, sqid.ToString(), sq.answer.ElementAt(i), "false"))) count--;
                                }
                            }
                        }
                        if (count != 0) MessageBox.Show("Error while importing");
                    }
                }
                success++;
            }
            if(MessageBox.Show("Successful import " + success + "/" + (lstSimple.Count + lstMulti.Count) + " item", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information) == DialogResult.OK)
            {
                this.Close();
            }
        }

        private void dgrMultiQuestion_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            string question = "";
            if (e.RowIndex < 0) return;
            MultiQuestion mq = lstMulti.ElementAt(e.RowIndex);
            question += mq.content;
            question += "================================================" + "\r\n";
            foreach (SimpleQuestion sq in mq.lstQuestion)
            {
                question += sq.question + "\r\n";
                for (int i = 0; i < sq.answer.Count; ++i)
                {
                    question += (char)(65 + i) + ". " + sq.answer.ElementAt(i) + "\r\n";
                }
                question += "=> Correct: " + (char)(65 + sq.correctAnswer) + "\r\n\r\n";
            }
            txtView.Text = question;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
