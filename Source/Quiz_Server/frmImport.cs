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

        private List<SimpleQuestion> lst = new List<SimpleQuestion>();
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
            //numOfAnswer++;
            SimpleQuestion qItem = null;

            Microsoft.Office.Interop.Word.Application word = new Microsoft.Office.Interop.Word.Application();

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
                if (temp != string.Empty)
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
                        if(qItem.correctAnswer != -1)
                            lst.Add(qItem);
                        else
                        {
                            MessageBox.Show("Câu \""+ qItem.question +"\" chưa có đáp án đúng");
                            lst.Clear();
                            return;
                        }
                    }
                    flag++;
                }
                else
                {
                    MessageBox.Show("Lỗi cú pháp sau câu " + lst.ElementAt(lst.Count-1).question);
                    lst.Clear();
                    return;
                }
            }
            docs.Close();
            word.Quit();
            //Bind data to gridview
            dgView.DataSource = lst;
            dgView.Columns[1].Visible = false;
            dgView.Columns[1].Width = 300;
        }

        private void BindCmbSubject()
        {
            cmbSubject.DataSource = new SubjectBUS().Subject_GetByTop("", "", "");
            cmbSubject.DisplayMember = "subjectName";
            cmbSubject.ValueMember = "ID";
            cmbSubject.SelectedIndex = -1;

        }

        private void frmImport_Load(object sender, EventArgs e)
        {
            BindCmbSubject();
        }

        private void dgView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            string question = "Câu hỏi: ";
            SimpleQuestion sq = lst.ElementAt(e.RowIndex);
            question += sq.question + "\r\n";
            question += "=======================\r\n";
            for (int i = 0; i < sq.answer.Count; ++i)
            {
                question += (char)(65 + i) + ". " + sq.answer.ElementAt(i) + "\r\n";
            }
            question += "=======================\r\n";
            question += "Đáp án đúng: " + (char)(65 + sq.correctAnswer);
            txtView.Text = question;
        }

        private void dgView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            int success = 0, qid = -1, sqid = -1;
            foreach (SimpleQuestion sq in lst)
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
            MessageBox.Show("Nhập " + success + "/"+lst.Count+" bản ghi thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}
