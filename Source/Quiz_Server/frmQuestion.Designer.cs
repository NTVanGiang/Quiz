namespace Quiz_Server
{
    partial class frmQuestion
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.pnFilter = new System.Windows.Forms.Panel();
            this.btnImport = new System.Windows.Forms.Button();
            this.btnAdd = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.cmbSubject = new System.Windows.Forms.ComboBox();
            this.pnData = new System.Windows.Forms.Panel();
            this.dgrQuestion = new System.Windows.Forms.DataGridView();
            this.pnView = new System.Windows.Forms.Panel();
            this.panel1 = new System.Windows.Forms.Panel();
            this.pnFilter.SuspendLayout();
            this.pnData.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgrQuestion)).BeginInit();
            this.SuspendLayout();
            // 
            // pnFilter
            // 
            this.pnFilter.Controls.Add(this.btnImport);
            this.pnFilter.Controls.Add(this.btnAdd);
            this.pnFilter.Controls.Add(this.textBox1);
            this.pnFilter.Controls.Add(this.label2);
            this.pnFilter.Controls.Add(this.label1);
            this.pnFilter.Controls.Add(this.cmbSubject);
            this.pnFilter.Location = new System.Drawing.Point(13, 13);
            this.pnFilter.Name = "pnFilter";
            this.pnFilter.Size = new System.Drawing.Size(1047, 100);
            this.pnFilter.TabIndex = 0;
            // 
            // btnImport
            // 
            this.btnImport.Location = new System.Drawing.Point(633, 44);
            this.btnImport.Name = "btnImport";
            this.btnImport.Size = new System.Drawing.Size(126, 37);
            this.btnImport.TabIndex = 4;
            this.btnImport.Text = "Nhập câu hỏi";
            this.btnImport.UseVisualStyleBackColor = true;
            this.btnImport.Click += new System.EventHandler(this.btnImport_Click);
            // 
            // btnAdd
            // 
            this.btnAdd.Location = new System.Drawing.Point(468, 44);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(126, 37);
            this.btnAdd.TabIndex = 4;
            this.btnAdd.Text = "Thêm câu hỏi";
            this.btnAdd.UseVisualStyleBackColor = true;
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(237, 54);
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(187, 27);
            this.textBox1.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(233, 19);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(127, 19);
            this.label2.TabIndex = 2;
            this.label2.Text = "Tìm kiếm câu hỏi";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(33, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(135, 19);
            this.label1.TabIndex = 1;
            this.label1.Text = "Lựa chọn môn học";
            // 
            // cmbSubject
            // 
            this.cmbSubject.FormattingEnabled = true;
            this.cmbSubject.Location = new System.Drawing.Point(37, 54);
            this.cmbSubject.Name = "cmbSubject";
            this.cmbSubject.Size = new System.Drawing.Size(142, 27);
            this.cmbSubject.TabIndex = 0;
            // 
            // pnData
            // 
            this.pnData.Controls.Add(this.dgrQuestion);
            this.pnData.Location = new System.Drawing.Point(13, 120);
            this.pnData.Name = "pnData";
            this.pnData.Size = new System.Drawing.Size(416, 359);
            this.pnData.TabIndex = 1;
            // 
            // dgrQuestion
            // 
            this.dgrQuestion.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgrQuestion.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgrQuestion.Location = new System.Drawing.Point(0, 0);
            this.dgrQuestion.Name = "dgrQuestion";
            this.dgrQuestion.Size = new System.Drawing.Size(416, 359);
            this.dgrQuestion.TabIndex = 0;
            // 
            // pnView
            // 
            this.pnView.Location = new System.Drawing.Point(435, 120);
            this.pnView.Name = "pnView";
            this.pnView.Size = new System.Drawing.Size(354, 359);
            this.pnView.TabIndex = 2;
            // 
            // panel1
            // 
            this.panel1.Location = new System.Drawing.Point(795, 119);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(258, 364);
            this.panel1.TabIndex = 2;
            // 
            // frmQuestion
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 19F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1072, 495);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.pnView);
            this.Controls.Add(this.pnData);
            this.Controls.Add(this.pnFilter);
            this.Font = new System.Drawing.Font("Times New Roman", 12.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmQuestion";
            this.Text = "Quản lí câu hỏi";
            this.pnFilter.ResumeLayout(false);
            this.pnFilter.PerformLayout();
            this.pnData.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgrQuestion)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel pnFilter;
        private System.Windows.Forms.Panel pnData;
        private System.Windows.Forms.Panel pnView;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cmbSubject;
        private System.Windows.Forms.Button btnAdd;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Button btnImport;
        private System.Windows.Forms.DataGridView dgrQuestion;
        private System.Windows.Forms.Panel panel1;
    }
}