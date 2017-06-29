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
    public partial class frmResult : Form
    {
        private ResultBUS rbus = new ResultBUS();
        private ResultDetailBUS rdbus = new ResultDetailBUS();
        public frmResult()
        {
            InitializeComponent();
        }

        private void frmResult_Load(object sender, EventArgs e)
        {
            BindResult();
            BindResultDetail();
        }

        private void BindResult(string t="",string w="",string o = "")
        {
            List<Result> lst = rbus.Result_GetByTop(t, w, o);
            dgrResult.DataSource = lst;
            dgrResult.Columns["examID"].Visible = false;
            dgrResult.Columns["studentID"].Visible = false;
            dgrResult.Columns["id"].DisplayIndex = 0;
            dgrResult.Columns["id"].Width = 40;
            dgrResult.Columns["score"].Width = 50;
            dgrResult.Columns["studentName"].AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
            dgrResult.Columns["studentName"].DisplayIndex = 1;
            dgrResult.Columns["studentExamID"].DisplayIndex = 2;
            dgrResult.Columns["flag"].DisplayIndex = 3;
            dgrResult.Columns["score"].DisplayIndex = 4;
        }
        private void BindResultDetail(string t = "", string w = "", string o = "")
        {
            List<ResultDetail> lst = rdbus.ResultDetail_GetByTop(t, w, o);
            dgrResultDetail.DataSource = lst;
            dgrResultDetail.Columns["id"].Width = 40;
            dgrResultDetail.Columns["resultID"].Width = 50;
            dgrResultDetail.Columns["IsCorrect"].Width = 60;
        }

        private void dgrResult_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            BindResultDetail("", "resultID='"+dgrResult.Rows[e.RowIndex].Cells["id"].Value.ToString()+"'", "");
        }
    }
}
