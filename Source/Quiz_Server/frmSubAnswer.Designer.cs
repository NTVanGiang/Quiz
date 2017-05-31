namespace Quiz_Server
{
    partial class frmSubAnswer
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnEditSub = new System.Windows.Forms.Button();
            this.btnFresh = new System.Windows.Forms.Button();
            this.cbxActive = new System.Windows.Forms.CheckBox();
            this.cmbQuestionID = new System.Windows.Forms.ComboBox();
            this.btnAddSub = new System.Windows.Forms.Button();
            this.txtContent = new System.Windows.Forms.TextBox();
            this.txtSubQuestionID = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.dgvSubQuestion = new System.Windows.Forms.DataGridView();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.cbxIsCorrect = new System.Windows.Forms.CheckBox();
            this.dgvAnswer = new System.Windows.Forms.DataGridView();
            this.cmbSubQuestionID = new System.Windows.Forms.ComboBox();
            this.txtAnswer = new System.Windows.Forms.TextBox();
            this.btnEditAnswer = new System.Windows.Forms.Button();
            this.btnDeleteAnswer = new System.Windows.Forms.Button();
            this.btnAddAnswer = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.txtAnswerID = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSubQuestion)).BeginInit();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvAnswer)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox1.Controls.Add(this.btnEditSub);
            this.groupBox1.Controls.Add(this.btnFresh);
            this.groupBox1.Controls.Add(this.cbxActive);
            this.groupBox1.Controls.Add(this.cmbQuestionID);
            this.groupBox1.Controls.Add(this.btnAddSub);
            this.groupBox1.Controls.Add(this.txtContent);
            this.groupBox1.Controls.Add(this.txtSubQuestionID);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.dgvSubQuestion);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(454, 505);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Câu hỏi con";
            // 
            // btnEditSub
            // 
            this.btnEditSub.Image = global::Quiz_Server.Properties.Resources._15673324_1795328170733853_973720954_n;
            this.btnEditSub.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnEditSub.Location = new System.Drawing.Point(110, 457);
            this.btnEditSub.Name = "btnEditSub";
            this.btnEditSub.Size = new System.Drawing.Size(102, 42);
            this.btnEditSub.TabIndex = 5;
            this.btnEditSub.Text = "Sửa";
            this.btnEditSub.UseVisualStyleBackColor = true;
            this.btnEditSub.Click += new System.EventHandler(this.btnEditSub_Click);
            // 
            // btnFresh
            // 
            this.btnFresh.Image = global::Quiz_Server.Properties.Resources._15645167_1795328157400521_1795090819_n;
            this.btnFresh.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnFresh.Location = new System.Drawing.Point(347, 457);
            this.btnFresh.Name = "btnFresh";
            this.btnFresh.Size = new System.Drawing.Size(107, 42);
            this.btnFresh.TabIndex = 5;
            this.btnFresh.Text = "       Làm mới";
            this.btnFresh.UseVisualStyleBackColor = true;
            this.btnFresh.Click += new System.EventHandler(this.button2_Click);
            // 
            // cbxActive
            // 
            this.cbxActive.AutoSize = true;
            this.cbxActive.Location = new System.Drawing.Point(159, 406);
            this.cbxActive.Name = "cbxActive";
            this.cbxActive.Size = new System.Drawing.Size(94, 23);
            this.cbxActive.TabIndex = 4;
            this.cbxActive.Text = "Kích hoạt";
            this.cbxActive.UseVisualStyleBackColor = true;
            this.cbxActive.CheckedChanged += new System.EventHandler(this.cbxActive_CheckedChanged);
            // 
            // cmbQuestionID
            // 
            this.cmbQuestionID.FormattingEnabled = true;
            this.cmbQuestionID.Location = new System.Drawing.Point(159, 333);
            this.cmbQuestionID.Name = "cmbQuestionID";
            this.cmbQuestionID.Size = new System.Drawing.Size(230, 27);
            this.cmbQuestionID.TabIndex = 3;
            // 
            // btnAddSub
            // 
            this.btnAddSub.Image = global::Quiz_Server.Properties.Resources._15666017_1795328160733854_677840402_n;
            this.btnAddSub.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnAddSub.Location = new System.Drawing.Point(2, 457);
            this.btnAddSub.Name = "btnAddSub";
            this.btnAddSub.Size = new System.Drawing.Size(102, 42);
            this.btnAddSub.TabIndex = 5;
            this.btnAddSub.Text = "     Thêm";
            this.btnAddSub.UseVisualStyleBackColor = true;
            this.btnAddSub.Click += new System.EventHandler(this.btnAddSub_Click);
            // 
            // txtContent
            // 
            this.txtContent.Location = new System.Drawing.Point(159, 373);
            this.txtContent.Name = "txtContent";
            this.txtContent.Size = new System.Drawing.Size(230, 27);
            this.txtContent.TabIndex = 2;
            // 
            // txtSubQuestionID
            // 
            this.txtSubQuestionID.Location = new System.Drawing.Point(159, 293);
            this.txtSubQuestionID.Name = "txtSubQuestionID";
            this.txtSubQuestionID.ReadOnly = true;
            this.txtSubQuestionID.Size = new System.Drawing.Size(230, 27);
            this.txtSubQuestionID.TabIndex = 2;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(17, 336);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(113, 19);
            this.label3.TabIndex = 1;
            this.label3.Text = "ND câu hỏi cha";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(17, 376);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(71, 19);
            this.label2.TabIndex = 1;
            this.label2.Text = "Nội dung";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(17, 296);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(113, 19);
            this.label1.TabIndex = 1;
            this.label1.Text = "Mã câu hỏi con";
            // 
            // dgvSubQuestion
            // 
            this.dgvSubQuestion.BackgroundColor = System.Drawing.Color.White;
            this.dgvSubQuestion.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvSubQuestion.Location = new System.Drawing.Point(0, 26);
            this.dgvSubQuestion.Name = "dgvSubQuestion";
            this.dgvSubQuestion.Size = new System.Drawing.Size(448, 252);
            this.dgvSubQuestion.TabIndex = 0;
            this.dgvSubQuestion.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvSubQuestion_CellClick);
            this.dgvSubQuestion.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvSubQuestion_CellContentClick);
            // 
            // groupBox2
            // 
            this.groupBox2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox2.Controls.Add(this.cbxIsCorrect);
            this.groupBox2.Controls.Add(this.dgvAnswer);
            this.groupBox2.Controls.Add(this.cmbSubQuestionID);
            this.groupBox2.Controls.Add(this.txtAnswer);
            this.groupBox2.Controls.Add(this.btnEditAnswer);
            this.groupBox2.Controls.Add(this.btnDeleteAnswer);
            this.groupBox2.Controls.Add(this.btnAddAnswer);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.txtAnswerID);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Location = new System.Drawing.Point(472, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(446, 505);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Đáp án";
            // 
            // cbxIsCorrect
            // 
            this.cbxIsCorrect.AutoSize = true;
            this.cbxIsCorrect.Location = new System.Drawing.Point(156, 406);
            this.cbxIsCorrect.Name = "cbxIsCorrect";
            this.cbxIsCorrect.Size = new System.Drawing.Size(64, 23);
            this.cbxIsCorrect.TabIndex = 4;
            this.cbxIsCorrect.Text = "Đúng";
            this.cbxIsCorrect.UseVisualStyleBackColor = true;
            this.cbxIsCorrect.CheckedChanged += new System.EventHandler(this.cbxIsCorrect_CheckedChanged);
            // 
            // dgvAnswer
            // 
            this.dgvAnswer.BackgroundColor = System.Drawing.Color.White;
            this.dgvAnswer.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvAnswer.Location = new System.Drawing.Point(0, 26);
            this.dgvAnswer.Name = "dgvAnswer";
            this.dgvAnswer.ReadOnly = true;
            this.dgvAnswer.Size = new System.Drawing.Size(430, 252);
            this.dgvAnswer.TabIndex = 0;
            this.dgvAnswer.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvAnswer_CellClick);
            // 
            // cmbSubQuestionID
            // 
            this.cmbSubQuestionID.FormattingEnabled = true;
            this.cmbSubQuestionID.Location = new System.Drawing.Point(156, 333);
            this.cmbSubQuestionID.Name = "cmbSubQuestionID";
            this.cmbSubQuestionID.Size = new System.Drawing.Size(230, 27);
            this.cmbSubQuestionID.TabIndex = 3;
            // 
            // txtAnswer
            // 
            this.txtAnswer.Location = new System.Drawing.Point(156, 373);
            this.txtAnswer.Name = "txtAnswer";
            this.txtAnswer.Size = new System.Drawing.Size(230, 27);
            this.txtAnswer.TabIndex = 2;
            // 
            // btnEditAnswer
            // 
            this.btnEditAnswer.Image = global::Quiz_Server.Properties.Resources._15673324_1795328170733853_973720954_n;
            this.btnEditAnswer.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnEditAnswer.Location = new System.Drawing.Point(138, 457);
            this.btnEditAnswer.Name = "btnEditAnswer";
            this.btnEditAnswer.Size = new System.Drawing.Size(102, 42);
            this.btnEditAnswer.TabIndex = 5;
            this.btnEditAnswer.Text = "Sửa";
            this.btnEditAnswer.UseVisualStyleBackColor = true;
            this.btnEditAnswer.Click += new System.EventHandler(this.btnEditAnswer_Click);
            // 
            // btnDeleteAnswer
            // 
            this.btnDeleteAnswer.Image = global::Quiz_Server.Properties.Resources.button_cancel;
            this.btnDeleteAnswer.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnDeleteAnswer.Location = new System.Drawing.Point(275, 457);
            this.btnDeleteAnswer.Name = "btnDeleteAnswer";
            this.btnDeleteAnswer.Size = new System.Drawing.Size(102, 42);
            this.btnDeleteAnswer.TabIndex = 5;
            this.btnDeleteAnswer.Text = "Xóa";
            this.btnDeleteAnswer.UseVisualStyleBackColor = true;
            this.btnDeleteAnswer.Click += new System.EventHandler(this.btnDeleteAnswer_Click);
            // 
            // btnAddAnswer
            // 
            this.btnAddAnswer.Image = global::Quiz_Server.Properties.Resources._15666017_1795328160733854_677840402_n;
            this.btnAddAnswer.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnAddAnswer.Location = new System.Drawing.Point(18, 457);
            this.btnAddAnswer.Name = "btnAddAnswer";
            this.btnAddAnswer.Size = new System.Drawing.Size(102, 42);
            this.btnAddAnswer.TabIndex = 5;
            this.btnAddAnswer.Text = "   Thêm";
            this.btnAddAnswer.UseVisualStyleBackColor = true;
            this.btnAddAnswer.Click += new System.EventHandler(this.btnAddAnswer_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(14, 296);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(78, 19);
            this.label4.TabIndex = 1;
            this.label4.Text = "Mã đáp án";
            // 
            // txtAnswerID
            // 
            this.txtAnswerID.Location = new System.Drawing.Point(156, 293);
            this.txtAnswerID.Name = "txtAnswerID";
            this.txtAnswerID.ReadOnly = true;
            this.txtAnswerID.Size = new System.Drawing.Size(230, 27);
            this.txtAnswerID.TabIndex = 2;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(14, 376);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(71, 19);
            this.label5.TabIndex = 1;
            this.label5.Text = "Nội dung";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(14, 336);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(115, 19);
            this.label6.TabIndex = 1;
            this.label6.Text = "ND câu hỏi con";
            // 
            // frmSubAnswer
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 19F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(918, 529);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Font = new System.Drawing.Font("Times New Roman", 12.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmSubAnswer";
            this.Text = "Quản lý Câu hỏi con- Đáp án";
            this.Load += new System.EventHandler(this.frmSubAnswer_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSubQuestion)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvAnswer)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.DataGridView dgvSubQuestion;
        private System.Windows.Forms.DataGridView dgvAnswer;
        private System.Windows.Forms.Button btnEditSub;
        private System.Windows.Forms.Button btnFresh;
        private System.Windows.Forms.CheckBox cbxActive;
        private System.Windows.Forms.ComboBox cmbQuestionID;
        private System.Windows.Forms.Button btnAddSub;
        private System.Windows.Forms.TextBox txtContent;
        private System.Windows.Forms.TextBox txtSubQuestionID;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.CheckBox cbxIsCorrect;
        private System.Windows.Forms.ComboBox cmbSubQuestionID;
        private System.Windows.Forms.TextBox txtAnswer;
        private System.Windows.Forms.Button btnEditAnswer;
        private System.Windows.Forms.Button btnDeleteAnswer;
        private System.Windows.Forms.Button btnAddAnswer;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtAnswerID;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
    }
}