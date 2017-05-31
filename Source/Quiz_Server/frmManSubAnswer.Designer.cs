namespace Quiz_Server
{
    partial class frmManSubAnswer
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
            this.panel1 = new System.Windows.Forms.Panel();
            this.dgvSubQuestion = new System.Windows.Forms.DataGridView();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.txtSearchSub = new System.Windows.Forms.TextBox();
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.txtSearchAnswer = new System.Windows.Forms.TextBox();
            this.dgvAnswer = new System.Windows.Forms.DataGridView();
            this.btnDelete = new System.Windows.Forms.Button();
            this.btnEdit = new System.Windows.Forms.Button();
            this.btnFresh = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSubQuestion)).BeginInit();
            this.groupBox1.SuspendLayout();
            this.flowLayoutPanel1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvAnswer)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.panel1.Controls.Add(this.dgvSubQuestion);
            this.panel1.Controls.Add(this.groupBox1);
            this.panel1.Location = new System.Drawing.Point(7, 8);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(409, 361);
            this.panel1.TabIndex = 0;
            // 
            // dgvSubQuestion
            // 
            this.dgvSubQuestion.BackgroundColor = System.Drawing.Color.White;
            this.dgvSubQuestion.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvSubQuestion.Location = new System.Drawing.Point(5, 77);
            this.dgvSubQuestion.Name = "dgvSubQuestion";
            this.dgvSubQuestion.Size = new System.Drawing.Size(400, 284);
            this.dgvSubQuestion.TabIndex = 1;
            this.dgvSubQuestion.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvSubQuestion_CellClick);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.txtSearchSub);
            this.groupBox1.Location = new System.Drawing.Point(5, 4);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(318, 66);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Tìm kiếm câu hỏi con";
            // 
            // txtSearchSub
            // 
            this.txtSearchSub.Location = new System.Drawing.Point(39, 26);
            this.txtSearchSub.Name = "txtSearchSub";
            this.txtSearchSub.Size = new System.Drawing.Size(226, 27);
            this.txtSearchSub.TabIndex = 0;
            this.txtSearchSub.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtSearchSub_KeyPress);
            this.txtSearchSub.Leave += new System.EventHandler(this.txtSearchSub_Leave);
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.flowLayoutPanel1.Controls.Add(this.groupBox2);
            this.flowLayoutPanel1.Controls.Add(this.dgvAnswer);
            this.flowLayoutPanel1.Location = new System.Drawing.Point(422, 7);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(378, 361);
            this.flowLayoutPanel1.TabIndex = 1;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.txtSearchAnswer);
            this.groupBox2.Location = new System.Drawing.Point(3, 3);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(318, 66);
            this.groupBox2.TabIndex = 0;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Tìm kiếm đáp án";
            // 
            // txtSearchAnswer
            // 
            this.txtSearchAnswer.Location = new System.Drawing.Point(39, 26);
            this.txtSearchAnswer.Name = "txtSearchAnswer";
            this.txtSearchAnswer.Size = new System.Drawing.Size(226, 27);
            this.txtSearchAnswer.TabIndex = 0;
            this.txtSearchAnswer.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtSearchAnswer_KeyPress);
            this.txtSearchAnswer.Leave += new System.EventHandler(this.txtSearchAnswer_Leave);
            // 
            // dgvAnswer
            // 
            this.dgvAnswer.BackgroundColor = System.Drawing.Color.White;
            this.dgvAnswer.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvAnswer.Location = new System.Drawing.Point(3, 75);
            this.dgvAnswer.Name = "dgvAnswer";
            this.dgvAnswer.ReadOnly = true;
            this.dgvAnswer.Size = new System.Drawing.Size(375, 286);
            this.dgvAnswer.TabIndex = 1;
            // 
            // btnDelete
            // 
            this.btnDelete.Image = global::Quiz_Server.Properties.Resources.button_cancel;
            this.btnDelete.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnDelete.Location = new System.Drawing.Point(536, 396);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(104, 41);
            this.btnDelete.TabIndex = 2;
            this.btnDelete.Text = "Xóa";
            this.btnDelete.UseVisualStyleBackColor = true;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // btnEdit
            // 
            this.btnEdit.Image = global::Quiz_Server.Properties.Resources.system_32;
            this.btnEdit.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnEdit.Location = new System.Drawing.Point(360, 396);
            this.btnEdit.Name = "btnEdit";
            this.btnEdit.Size = new System.Drawing.Size(119, 41);
            this.btnEdit.TabIndex = 2;
            this.btnEdit.Text = "         Cập nhật";
            this.btnEdit.UseVisualStyleBackColor = true;
            this.btnEdit.Click += new System.EventHandler(this.btnEdit_Click);
            // 
            // btnFresh
            // 
            this.btnFresh.Image = global::Quiz_Server.Properties.Resources._15645167_1795328157400521_1795090819_n;
            this.btnFresh.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnFresh.Location = new System.Drawing.Point(184, 396);
            this.btnFresh.Name = "btnFresh";
            this.btnFresh.Size = new System.Drawing.Size(114, 41);
            this.btnFresh.TabIndex = 2;
            this.btnFresh.Text = "      Làm mới";
            this.btnFresh.UseVisualStyleBackColor = true;
            this.btnFresh.Click += new System.EventHandler(this.btnFresh_Click);
            // 
            // frmManSubAnswer
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 19F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(812, 469);
            this.Controls.Add(this.btnDelete);
            this.Controls.Add(this.btnEdit);
            this.Controls.Add(this.btnFresh);
            this.Controls.Add(this.flowLayoutPanel1);
            this.Controls.Add(this.panel1);
            this.Font = new System.Drawing.Font("Times New Roman", 12.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmManSubAnswer";
            this.Text = "Câu hỏi con- Đáp án";
            this.Load += new System.EventHandler(this.frmSubQuestion_Load);
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvSubQuestion)).EndInit();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.flowLayoutPanel1.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvAnswer)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox txtSearchSub;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox txtSearchAnswer;
        private System.Windows.Forms.DataGridView dgvSubQuestion;
        private System.Windows.Forms.DataGridView dgvAnswer;
        private System.Windows.Forms.Button btnFresh;
        private System.Windows.Forms.Button btnEdit;
        private System.Windows.Forms.Button btnDelete;
    }
}