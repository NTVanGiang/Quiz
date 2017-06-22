using Quiz.BUS;
using Quiz.Entity;
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

namespace Quiz_Server
{
    public partial class frmQuestionDetail : Form
    {
        private QuestionBUS qbus = new QuestionBUS();
        private SubQuestionBUS sqbus = new SubQuestionBUS();
        private AnswerBUS abus = new AnswerBUS();
        private bool _isEdit = false;
        private string _qid = "";
        public frmQuestionDetail(bool isEdit = false, bool isSingle = true, string selectedValue = "0", string qID = "")
        {
            InitializeComponent();
            BindCmbSubject();

            if (isEdit)
            {
                _isEdit = true;
                _qid = qID;
                if (isSingle)
                {
                    rdSingle.Checked = true;
                    rdMulti.Enabled = false;
                }
                else
                {
                    rdMulti.Checked = true;
                    rdSingle.Enabled = false;
                }

                cmbSubject.SelectedValue = selectedValue;
                cmbSubject.Enabled = false;
                txtView.Text = GetContentQuestion();
                btnUpdate.Text = "Cập nhật";
            }
        }

        private string GetContentQuestion()
        {
            string content = "";
            Question q = qbus.Question_GetByTop("", "id = '" + _qid + "'", "").ElementAt(0);
            List<SubQuestion> lstSub = sqbus.SubQuestion_GetByTop("", "questionID = '" + _qid + "'", "");
            if (lstSub.Count > 1) rdSingle.Checked = false;

            if (!rdSingle.Checked)
            {
                content = q.Content + "\r\n";
            }
            foreach (SubQuestion sq in lstSub)
            {
                content += sq.Content + "\r\n";
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
            return content;
        }

        private void BindCmbSubject()
        {
            List<Subject> lst = new SubjectBUS().Subject_GetByTop("", "", "");
            lst.Insert(0, new Subject("0", "-- Select Subject --"));
            cmbSubject.DataSource = lst;
            cmbSubject.DisplayMember = "subjectName";
            cmbSubject.ValueMember = "id";
            cmbSubject.SelectedIndex = 0;
        }

        private void frmQuestionDetail_Load(object sender, EventArgs e)
        {
        }

        private void btnGuide_Click(object sender, EventArgs e)
        {
            new frmQuestionGuide().ShowDialog();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Đóng cửa sổ và hủy bỏ các thay đổi?", "Thông báo", MessageBoxButtons.YesNo, MessageBoxIcon.Information) == DialogResult.Yes)
            {
                this.Close();
            }
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if (cmbSubject.SelectedIndex < 1)
            {
                MessageBox.Show("Hãy chọn môn học trước", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            int qid = 0;
            if (_isEdit)
            {
                if (rdSingle.Checked == true)
                {
                    string s = txtView.Text.Trim();
                    int count = 0;
                    string[] temp = Regex.Split(s, "\r\n");
                    if (CheckSingleQuestion())
                    {
                        qid = qbus.Question_Insert(new Question(null, cmbSubject.SelectedValue.ToString(), "", DateTime.Now.ToString()));
                        if (qid > 0)
                        {
                            int sqID = sqbus.SubQuestion_Insert(new SubQuestion(null, qid.ToString(), temp[0], "true"));
                            if (sqID > 0)
                            {
                                for (int i = 1; i < temp.Length; i++)
                                {
                                    if (temp[i].Trim().EndsWith("*"))
                                    {
                                        abus.Answer_Insert(new Answer(null, sqID.ToString(), temp[i].Substring(0, temp.Length - 1).Trim(), "true")); count++;
                                    }
                                    else
                                    {
                                        abus.Answer_Insert(new Answer(null, sqID.ToString(), temp[i].Trim(), "false")); count++;
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        return;
                    }
                    if (count == temp.Length - 1)
                    {
                        MessageBox.Show("Cập nhật thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        qbus.Question_Delete(_qid.ToString());
                    }

                    else
                    {
                        MessageBox.Show("Cập nhật không thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        
                    }
                }
                else
                {
                    string s = txtView.Text.Trim();
                    string[] temp = Regex.Split(s, "\r\n");
                    string str = temp[0], content = "";
                    int i = 0;
                    for (i = 0; i < temp.Length; i++)
                    {
                        if (temp[i].Trim() != "") content += temp[i] + "\r\n";
                        else break;
                    }
                    qid = qbus.Question_Insert(new Question(null, cmbSubject.SelectedValue.ToString(), content, DateTime.Now.ToString()));
                    if (qid > 0)
                    {
                        i++;
                        for (; i < temp.Length; i++)
                        {
                            int sqID = sqbus.SubQuestion_Insert(new SubQuestion(null, qid.ToString(), temp[i], "true"));
                            if (sqID > 0)
                            {
                                int c = 0;
                                while (i < temp.Length - 1 && temp[++i].Trim() != "")
                                {
                                    string a = temp[i].Trim();
                                    if (a == "") break;
                                    if (a.EndsWith("*"))
                                    {
                                        c++;
                                        if (!abus.Answer_Insert(new Answer(null, sqID.ToString(), a.Substring(0, a.Length - 1).Trim(), "true")))
                                        {
                                            MessageBox.Show("Cập nhật thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                            return;
                                        }
                                    }
                                    else
                                    {
                                        if (!abus.Answer_Insert(new Answer(null, sqID.ToString(), a, "false")))
                                        {
                                            MessageBox.Show("Cập nhật thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                            return;
                                        }
                                    }
                                }
                                if (c == 0)
                                {
                                    MessageBox.Show("Cập nhật thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                    return;
                                }
                            }
                            else
                            {
                                MessageBox.Show("Cập nhật thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                return;
                            }
                        }
                    }
                    else
                    {
                        MessageBox.Show("Cập nhật thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        return;
                    }
                    MessageBox.Show("Cập nhật thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    qbus.Question_Delete(_qid.ToString());
                }
            }
            else
            {
                if (rdSingle.Checked == true)
                {
                    string s = txtView.Text.Trim();
                    int count = 0;
                    string[] temp = Regex.Split(s, "\r\n");
                    if (CheckSingleQuestion())
                    {
                        qid = qbus.Question_Insert(new Question(null, cmbSubject.SelectedValue.ToString(), "", DateTime.Now.ToString()));
                        if (qid > 0)
                        {
                            int sqID = sqbus.SubQuestion_Insert(new SubQuestion(null, qid.ToString(), temp[0], "true"));
                            if (sqID > 0)
                            {
                                for (int i = 1; i < temp.Length; i++)
                                {
                                    if (temp[i].Trim().EndsWith("*"))
                                    {
                                        abus.Answer_Insert(new Answer(null, sqID.ToString(), temp[i].Substring(0, temp.Length - 1).Trim(), "true")); count++;
                                    }
                                    else
                                    {
                                        abus.Answer_Insert(new Answer(null, sqID.ToString(), temp[i].Trim(), "false")); count++;
                                    }
                                }
                            }
                        }
                    }
                    else { return; }
                    if (count == temp.Length - 1) MessageBox.Show("Thêm mới thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    else
                    {
                        MessageBox.Show("Thêm mới không thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        if (qid > 0) qbus.Question_Delete(qid.ToString());
                    }
                }
                else
                {
                    string s = txtView.Text.Trim();
                    string[] temp = Regex.Split(s, "\r\n");
                    string str = temp[0], content = "";
                    int i = 0;
                    for (i = 0; i < temp.Length; i++)
                    {
                        if (temp[i].Trim() != "") content += temp[i] + "\r\n";
                        else break;
                    }
                    qid = qbus.Question_Insert(new Question(null, cmbSubject.SelectedValue.ToString(), content, DateTime.Now.ToString()));
                    if (qid > 0)
                    {
                        i++;
                        for (; i < temp.Length; i++)
                        {
                            int sqID = sqbus.SubQuestion_Insert(new SubQuestion(null, qid.ToString(), temp[i], "true"));
                            if (sqID > 0)
                            {
                                int c = 0;
                                while (i < temp.Length - 1 && temp[++i].Trim() != "")
                                {
                                    string a = temp[i].Trim();
                                    if (a == "") break;
                                    if (a.EndsWith("*"))
                                    {
                                        c++;
                                        if (!abus.Answer_Insert(new Answer(null, sqID.ToString(), a.Substring(0, a.Length - 1).Trim(), "true")))
                                        {
                                            MessageBox.Show("Thêm mới thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                            qbus.Question_Delete(qid.ToString());
                                            return;
                                        }
                                    }
                                    else
                                    {
                                        if (!abus.Answer_Insert(new Answer(null, sqID.ToString(), a, "false")))
                                        {
                                            MessageBox.Show("Thêm mới thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                            qbus.Question_Delete(qid.ToString());
                                            return;
                                        }
                                    }
                                }
                                if (c == 0)
                                {
                                    MessageBox.Show("Thêm mới thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                    qbus.Question_Delete(qid.ToString());
                                    return;
                                }
                            }
                            else
                            {
                                MessageBox.Show("Thêm mới thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                qbus.Question_Delete(qid.ToString());
                                return;
                            }
                        }
                    }
                    else
                    {
                        MessageBox.Show("Thêm mới thất bại", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        qbus.Question_Delete(qid.ToString());
                        return;
                    }
                    MessageBox.Show("Thêm mới thành công", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }

            }
        }

        private bool CheckSingleQuestion()
        {
            string s = txtView.Text.Trim();
            string[] temp = Regex.Split(s, "\r\n");
            if (temp.Length < 3)
            {
                MessageBox.Show("Số đáp án cần nhiều hơn 1", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            int c = 0;
            foreach (string str in temp)
            {
                if (str.Trim() == string.Empty) return false;
                if (str.Trim().EndsWith("*")) c++;
            }
            if (c == temp.Length - 1)
            {
                MessageBox.Show("Cần ít nhất một đáp án sai", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            if (c == 0)
            {
                MessageBox.Show("Cần ít nhất một đáp án đúng", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
            return true;
        }

        private void txtView_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.Control && e.KeyCode == Keys.A)
            {
                txtView.SelectAll();
            }
        }
    }
}
