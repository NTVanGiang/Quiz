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
    public partial class frmStudentExam : Form
    {
        private StudentExamBUS obj = new StudentExamBUS();
        public frmStudentExam()
        {
            InitializeComponent();
        }

        private void BindCmbClass(String t, String w, String o)
        {
            List<Class> lst = new ClassBUS().Class_GetByTop(t, w, o);
            lst.Insert(0, new Quiz.Entity.Class("0", "--Select an option--", ""));
            cmbClassID.DataSource = lst;
            cmbClassID.DisplayMember = "className";
            cmbClassID.ValueMember = "id";
            cmbClassID.SelectedIndex = 0;
        }
        private void BindCmbStudent(String t, String w, String o)
        {
            List<Student> lst = new StudentBUS().Student_GetByTop(t, w, o);
            lst.Insert(0, new Quiz.Entity.Student("0", "--Select an option--", null, null, null, null));
            cmbStudentID.DataSource = lst;
            cmbStudentID.DisplayMember = "fullname";
            cmbStudentID.ValueMember = "id";
            cmbStudentID.SelectedIndex = 0;
        }
        private void BindCmbQuiz(String t, String w, String o)
        {
            List<Quiz.Entity.Quiz> lst = new QuizBUS().Quiz_GetByTop(t, w, o);
            Quiz.Entity.Quiz q = new Quiz.Entity.Quiz();
            q.Id = "0"; q.QuizName = "--Select an option--";
            lst.Insert(0, q);
            cmbQuizID.DataSource = lst;
            cmbQuizID.DisplayMember = "quizName";
            cmbQuizID.ValueMember = "id";
            cmbQuizID.SelectedIndex = 0;
        }

        private void BindCmbFilter(String t, String w, String o)
        {
            List<Quiz.Entity.Quiz> lst = new QuizBUS().Quiz_GetByTop(t, w, o);
            Quiz.Entity.Quiz q = new Quiz.Entity.Quiz();
            q.Id = "0"; q.QuizName = "--View all--";
            lst.Insert(0, q);
            cmbFilter.DataSource = lst;
            cmbFilter.DisplayMember = "quizName";
            cmbFilter.ValueMember = "id";
            cmbFilter.SelectedIndex = 0;
        }

        private void BindGrid(string t, string w, string o)
        {
            dgrStudentExam.DataSource = obj.StudentExam_GetByTop(t, w, o);
            dgrStudentExam.Columns["studentID"].Visible = false;
            dgrStudentExam.Columns["id"].Width = 50;
            dgrStudentExam.Columns["examID"].Width = 50;
            dgrStudentExam.Columns["flag"].Width = 50;
            dgrStudentExam.Columns["studentName"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
        }

        private void frmStudentExam_Load(object sender, EventArgs e)
        {
            BindCmbClass("", "", "");
            BindCmbQuiz("", "", "");
            BindCmbStudent("", "", "");
            BindCmbFilter("", "", "");
            BindGrid("", "", "");
        }

        private void cmbFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cmbFilter.SelectedIndex == 0)
            {
                BindCmbFilter("", "", "");
            }
            else
            {
                string quizID = cmbFilter.SelectedValue.ToString();
                List<Exam> lst = new ExamBUS().Exam_GetByTop("", "quizID = '" + quizID + "'", "");
                string w = "(";
                foreach (Exam ex in lst) w += ex.ID + ",";
                w = w.Substring(0, w.Length - 1) + ")";
                BindGrid("", "examID in " + w + " and startTime is null", "");
            }
        }

        private void dgrStudentExam_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            int r = e.RowIndex;
            cmbStudentID.SelectedValue = dgrStudentExam.Rows[r].Cells["studentID"].Value.ToString();
            nbFlag.Value = int.Parse(dgrStudentExam.Rows[r].Cells["flag"].Value.ToString());
            txtID.Text = dgrStudentExam.Rows[r].Cells["id"].Value.ToString();
        }

        private void btnSet_Click(object sender, EventArgs e)
        {
            StudentExam st = new StudentExam();
            st.StudentID = cmbStudentID.SelectedValue.ToString();
            st.Id = txtID.Text;
            if (obj.StudentExam_Update(st))
            {
                MessageBox.Show("Update success", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
                BindGrid("", "", "");
            }
            else
            {
                MessageBox.Show("Update unsuccess", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void btnRandom_Click(object sender, EventArgs e)
        {
            if (obj.StudentExam_GetByTop("", "isActive = 'false'", "").Count > 0)
            {
                MessageBox.Show("One more quiz is current in db. Can't create new one", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            if (cmbQuizID.SelectedIndex <= 0 || cmbClassID.SelectedIndex <= 0)
            {
                MessageBox.Show("Please fill correct value input", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
            string classID = cmbClassID.SelectedValue.ToString();
            string quizID = cmbQuizID.SelectedValue.ToString();
            List<Student> lstStudent = new StudentBUS().Student_GetByTop("", "classID = '" + classID + "'", "");
            List<Exam> lstExam = new ExamBUS().Exam_GetByTop("", "quizID = '" + quizID + "'", "");
            Random rd = new Random();
            int randomValue = 0;
            int count = 0;
            foreach (Student student in lstStudent)
            {
                randomValue = rd.Next(0, lstExam.Count - 1);
                StudentExam st = new StudentExam();
                st.ExamID = lstExam.ElementAt(randomValue).ID;
                st.StartTime = null;
                st.StudentID = student.Id;
                st.Flag = "0";
                if (obj.StudentExam_Insert(st) > 0) count++;
            }
            MessageBox.Show("Set exam success for " + count + "/" + lstStudent.Count, "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
            BindGrid("", "", "");
        }

        private void menuActive_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Set active all selected item?", "Notice", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                foreach (DataGridViewRow dr in dgrStudentExam.SelectedRows)
                {
                    StudentExam st = new StudentExam();
                    st.Id = dr.Cells["id"].Value.ToString();
                    st.StudentID = dr.Cells["studentID"].Value.ToString();
                    st.StartTime = null;
                    st.IsActive = "true";
                    obj.StudentExam_Update(st);
                }
                BindGrid("", "", "");
                MessageBox.Show("Set active success, student can start exam now", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void menuUnActive_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Set active all selected item?", "Notice", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                foreach (DataGridViewRow dr in dgrStudentExam.SelectedRows)
                {
                    StudentExam st = new StudentExam();
                    st.Id = dr.Cells["id"].Value.ToString();
                    st.StudentID = dr.Cells["studentID"].Value.ToString();
                    st.StartTime = (dr.Cells["startTime"].Value.ToString() == "" ? null : dr.Cells["startTime"].Value.ToString());
                    st.IsActive = "false";
                    st.Flag = dr.Cells["flag"].Value.ToString();
                    obj.StudentExam_Update(st);
                }
                BindGrid("", "", "");
                MessageBox.Show("Block success, student can start exam now", "Notice", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void menuDelete_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("You can't delete if student was pass, continue?", "Notice", MessageBoxButtons.YesNo, MessageBoxIcon.Information) == DialogResult.Yes)
            {
                foreach (DataGridViewRow dr in dgrStudentExam.SelectedRows)
                {
                    if (dr.Cells["startTime"].Value.ToString() == "") obj.StudentExam_Delete(dr.Cells["id"].Value.ToString());
                }
                BindGrid("", "", "");
            }
        }
    }
}
