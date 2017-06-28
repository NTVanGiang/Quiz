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
    public partial class frmViewExam : Form
    {
        public frmViewExam(string view)
        {
            InitializeComponent();
            txtView.Text = view;
        }
    }
}
