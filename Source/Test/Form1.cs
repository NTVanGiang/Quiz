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

namespace Test
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Microsoft.Office.Interop.Word.Application word = new Microsoft.Office.Interop.Word.Application();

            // Define an object to pass to the API for missing parameters
            object miss = System.Reflection.Missing.Value;
            object path = @"C:\Word\Test.docx";
            object readOnly = true;
            Microsoft.Office.Interop.Word.Document docs =
                word.Documents.Open(ref path, ref miss, ref readOnly,
                ref miss, ref miss, ref miss, ref miss, ref miss, ref miss,
                ref miss, ref miss, ref miss, ref miss, ref miss, ref miss, ref miss);


            List<string> data = new List<string>();

            Console.OutputEncoding = System.Text.Encoding.UTF8;
            int flag = 0, q_id;
            for (int i = 0; i < docs.Paragraphs.Count; i++)
            {
                string temp = docs.Paragraphs[i + 1].Range.Text.Trim();
                if (temp != string.Empty)
                {
                    if(flag%5 == 0)
                    {
                        temp = temp.Substring(8);
                    }
                    else
                    {
                        if (temp.EndsWith("*"))
                        {
                            Console.WriteLine(temp.Substring(0, temp.Length - 1).Trim() + " - True");
                        }
                        else
                        {
                            Console.WriteLine(temp);
                        }
                    }
                    flag++;

                }
            }
            docs.Close();
            word.Quit();
        }
    }
}
