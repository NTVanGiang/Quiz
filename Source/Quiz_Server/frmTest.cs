using System.Collections.Generic;
using System.Windows.Forms;

using Microsoft.Office.Interop.Word;

using Quiz.Entity;

using Quiz_Server.Library;

namespace Quiz_Server
{
    public partial class frmTest : Form
    {
        public frmTest()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, System.EventArgs e)
        {
            DataImporter dataImporter = new DataImporter("E:/EPU subject/WinForm/Quiz/Resource/Tienganh.xls","1");
            dataImporter.ReadData();
            List<SubQuestion> lst = dataImporter.SubQuestions;
            MessageBox.Show(lst.Count.ToString());

        }
    }
}
