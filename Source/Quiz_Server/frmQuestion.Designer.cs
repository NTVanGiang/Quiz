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
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmQuestion));
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
            this.pnData = new System.Windows.Forms.Panel();
            this.dgrQuestion = new DevComponents.DotNetBar.Controls.DataGridViewX();
            this.ctmDgrQuestion = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.btnEditQuestion = new System.Windows.Forms.ToolStripMenuItem();
            this.btnDeleteQuestion = new System.Windows.Forms.ToolStripMenuItem();
            this.pnView = new System.Windows.Forms.Panel();
            this.dgrSubQuestion = new DevComponents.DotNetBar.Controls.DataGridViewX();
            this.panel1 = new System.Windows.Forms.Panel();
            this.dgrAnswer = new DevComponents.DotNetBar.Controls.DataGridViewX();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.pnFilter = new System.Windows.Forms.Panel();
            this.txtSearch = new DevComponents.DotNetBar.Controls.TextBoxX();
            this.cmbSubject = new DevComponents.DotNetBar.Controls.ComboBoxEx();
            this.btnRefresh = new DevComponents.DotNetBar.ButtonX();
            this.btnImport = new DevComponents.DotNetBar.ButtonX();
            this.btnAdd = new DevComponents.DotNetBar.ButtonX();
            this.panel2 = new System.Windows.Forms.Panel();
            this.txtDisplay = new System.Windows.Forms.TextBox();
            this.pnData.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgrQuestion)).BeginInit();
            this.ctmDgrQuestion.SuspendLayout();
            this.pnView.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgrSubQuestion)).BeginInit();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgrAnswer)).BeginInit();
            this.pnFilter.SuspendLayout();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnData
            // 
            this.pnData.Controls.Add(this.dgrQuestion);
            this.pnData.Location = new System.Drawing.Point(13, 100);
            this.pnData.Name = "pnData";
            this.pnData.Size = new System.Drawing.Size(509, 287);
            this.pnData.TabIndex = 1;
            // 
            // dgrQuestion
            // 
            this.dgrQuestion.AllowUserToAddRows = false;
            this.dgrQuestion.AllowUserToDeleteRows = false;
            this.dgrQuestion.AllowUserToOrderColumns = true;
            this.dgrQuestion.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle4.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("Times New Roman", 12.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgrQuestion.DefaultCellStyle = dataGridViewCellStyle4;
            this.dgrQuestion.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgrQuestion.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(215)))), ((int)(((byte)(229)))));
            this.dgrQuestion.Location = new System.Drawing.Point(0, 0);
            this.dgrQuestion.Name = "dgrQuestion";
            this.dgrQuestion.ReadOnly = true;
            this.dgrQuestion.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgrQuestion.Size = new System.Drawing.Size(509, 287);
            this.dgrQuestion.TabIndex = 0;
            this.dgrQuestion.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgrQuestion_CellClick);
            this.dgrQuestion.CellMouseDown += new System.Windows.Forms.DataGridViewCellMouseEventHandler(this.dgrQuestion_CellMouseDown);
            // 
            // ctmDgrQuestion
            // 
            this.ctmDgrQuestion.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.btnEditQuestion,
            this.btnDeleteQuestion});
            this.ctmDgrQuestion.Name = "ctmDgrQuestion";
            this.ctmDgrQuestion.Size = new System.Drawing.Size(137, 48);
            this.ctmDgrQuestion.Opening += new System.ComponentModel.CancelEventHandler(this.ctmDgrQuestion_Opening);
            // 
            // btnEditQuestion
            // 
            this.btnEditQuestion.AccessibleName = "btnEditQuestion";
            this.btnEditQuestion.Image = ((System.Drawing.Image)(resources.GetObject("btnEditQuestion.Image")));
            this.btnEditQuestion.Name = "btnEditQuestion";
            this.btnEditQuestion.Size = new System.Drawing.Size(136, 22);
            this.btnEditQuestion.Text = "Sửa câu hỏi";
            this.btnEditQuestion.Click += new System.EventHandler(this.btnEditQuestion_Click);
            // 
            // btnDeleteQuestion
            // 
            this.btnDeleteQuestion.AccessibleName = "btnDeleteQuestion";
            this.btnDeleteQuestion.Image = ((System.Drawing.Image)(resources.GetObject("btnDeleteQuestion.Image")));
            this.btnDeleteQuestion.Name = "btnDeleteQuestion";
            this.btnDeleteQuestion.Size = new System.Drawing.Size(136, 22);
            this.btnDeleteQuestion.Text = "Xóa câu hỏi";
            this.btnDeleteQuestion.Click += new System.EventHandler(this.btnDeleteQuestion_Click);
            // 
            // pnView
            // 
            this.pnView.Controls.Add(this.dgrSubQuestion);
            this.pnView.Location = new System.Drawing.Point(519, 100);
            this.pnView.Name = "pnView";
            this.pnView.Size = new System.Drawing.Size(541, 143);
            this.pnView.TabIndex = 2;
            // 
            // dgrSubQuestion
            // 
            this.dgrSubQuestion.AllowUserToAddRows = false;
            this.dgrSubQuestion.AllowUserToDeleteRows = false;
            this.dgrSubQuestion.AllowUserToOrderColumns = true;
            this.dgrSubQuestion.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle5.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle5.Font = new System.Drawing.Font("Times New Roman", 12.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle5.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle5.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle5.SelectionForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle5.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgrSubQuestion.DefaultCellStyle = dataGridViewCellStyle5;
            this.dgrSubQuestion.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgrSubQuestion.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(215)))), ((int)(((byte)(229)))));
            this.dgrSubQuestion.Location = new System.Drawing.Point(0, 0);
            this.dgrSubQuestion.Name = "dgrSubQuestion";
            this.dgrSubQuestion.ReadOnly = true;
            this.dgrSubQuestion.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.dgrSubQuestion.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgrSubQuestion.Size = new System.Drawing.Size(541, 143);
            this.dgrSubQuestion.TabIndex = 0;
            this.dgrSubQuestion.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgrSubQuestion_CellClick);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.dgrAnswer);
            this.panel1.Location = new System.Drawing.Point(519, 241);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(541, 146);
            this.panel1.TabIndex = 2;
            // 
            // dgrAnswer
            // 
            this.dgrAnswer.AllowUserToAddRows = false;
            this.dgrAnswer.AllowUserToDeleteRows = false;
            this.dgrAnswer.AllowUserToOrderColumns = true;
            this.dgrAnswer.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle6.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle6.Font = new System.Drawing.Font("Times New Roman", 12.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle6.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle6.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle6.SelectionForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle6.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgrAnswer.DefaultCellStyle = dataGridViewCellStyle6;
            this.dgrAnswer.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgrAnswer.GridColor = System.Drawing.Color.FromArgb(((int)(((byte)(208)))), ((int)(((byte)(215)))), ((int)(((byte)(229)))));
            this.dgrAnswer.Location = new System.Drawing.Point(0, 0);
            this.dgrAnswer.Name = "dgrAnswer";
            this.dgrAnswer.ReadOnly = true;
            this.dgrAnswer.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.dgrAnswer.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgrAnswer.Size = new System.Drawing.Size(541, 146);
            this.dgrAnswer.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(10, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(116, 19);
            this.label1.TabIndex = 1;
            this.label1.Text = "Select a subject";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(279, 9);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(117, 19);
            this.label2.TabIndex = 2;
            this.label2.Text = "Search question";
            // 
            // pnFilter
            // 
            this.pnFilter.Controls.Add(this.txtSearch);
            this.pnFilter.Controls.Add(this.cmbSubject);
            this.pnFilter.Controls.Add(this.btnRefresh);
            this.pnFilter.Controls.Add(this.btnImport);
            this.pnFilter.Controls.Add(this.btnAdd);
            this.pnFilter.Controls.Add(this.label2);
            this.pnFilter.Controls.Add(this.label1);
            this.pnFilter.Location = new System.Drawing.Point(13, 13);
            this.pnFilter.Name = "pnFilter";
            this.pnFilter.Size = new System.Drawing.Size(1047, 81);
            this.pnFilter.TabIndex = 0;
            // 
            // txtSearch
            // 
            // 
            // 
            // 
            this.txtSearch.Border.Class = "TextBoxBorder";
            this.txtSearch.Border.CornerType = DevComponents.DotNetBar.eCornerType.Square;
            this.txtSearch.Location = new System.Drawing.Point(283, 31);
            this.txtSearch.Name = "txtSearch";
            this.txtSearch.Size = new System.Drawing.Size(272, 27);
            this.txtSearch.TabIndex = 7;
            // 
            // cmbSubject
            // 
            this.cmbSubject.DisplayMember = "Text";
            this.cmbSubject.DrawMode = System.Windows.Forms.DrawMode.OwnerDrawFixed;
            this.cmbSubject.FormattingEnabled = true;
            this.cmbSubject.ItemHeight = 21;
            this.cmbSubject.Location = new System.Drawing.Point(14, 31);
            this.cmbSubject.Name = "cmbSubject";
            this.cmbSubject.Size = new System.Drawing.Size(216, 27);
            this.cmbSubject.Style = DevComponents.DotNetBar.eDotNetBarStyle.StyleManagerControlled;
            this.cmbSubject.TabIndex = 6;
            this.cmbSubject.SelectedIndexChanged += new System.EventHandler(this.cmbSubject_SelectedIndexChanged);
            // 
            // btnRefresh
            // 
            this.btnRefresh.AccessibleRole = System.Windows.Forms.AccessibleRole.PushButton;
            this.btnRefresh.ColorTable = DevComponents.DotNetBar.eButtonColor.OrangeWithBackground;
            this.btnRefresh.Image = ((System.Drawing.Image)(resources.GetObject("btnRefresh.Image")));
            this.btnRefresh.ImageFixedSize = new System.Drawing.Size(24, 24);
            this.btnRefresh.Location = new System.Drawing.Point(917, 25);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(119, 37);
            this.btnRefresh.Style = DevComponents.DotNetBar.eDotNetBarStyle.StyleManagerControlled;
            this.btnRefresh.TabIndex = 5;
            this.btnRefresh.Text = "Refresh";
            this.btnRefresh.Click += new System.EventHandler(this.btnRefresh_Click);
            // 
            // btnImport
            // 
            this.btnImport.AccessibleRole = System.Windows.Forms.AccessibleRole.PushButton;
            this.btnImport.ColorTable = DevComponents.DotNetBar.eButtonColor.OrangeWithBackground;
            this.btnImport.Image = ((System.Drawing.Image)(resources.GetObject("btnImport.Image")));
            this.btnImport.ImageFixedSize = new System.Drawing.Size(24, 24);
            this.btnImport.Location = new System.Drawing.Point(769, 25);
            this.btnImport.Name = "btnImport";
            this.btnImport.Size = new System.Drawing.Size(105, 37);
            this.btnImport.Style = DevComponents.DotNetBar.eDotNetBarStyle.StyleManagerControlled;
            this.btnImport.TabIndex = 5;
            this.btnImport.Text = "Import";
            this.btnImport.Click += new System.EventHandler(this.btnImport_Click);
            // 
            // btnAdd
            // 
            this.btnAdd.AccessibleRole = System.Windows.Forms.AccessibleRole.PushButton;
            this.btnAdd.ColorTable = DevComponents.DotNetBar.eButtonColor.OrangeWithBackground;
            this.btnAdd.Image = ((System.Drawing.Image)(resources.GetObject("btnAdd.Image")));
            this.btnAdd.ImageFixedSize = new System.Drawing.Size(24, 24);
            this.btnAdd.Location = new System.Drawing.Point(598, 25);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(134, 37);
            this.btnAdd.Style = DevComponents.DotNetBar.eDotNetBarStyle.StyleManagerControlled;
            this.btnAdd.TabIndex = 5;
            this.btnAdd.Text = "Add question";
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.txtDisplay);
            this.panel2.Location = new System.Drawing.Point(13, 393);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(1047, 149);
            this.panel2.TabIndex = 3;
            // 
            // txtDisplay
            // 
            this.txtDisplay.BackColor = System.Drawing.SystemColors.ActiveBorder;
            this.txtDisplay.ForeColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.txtDisplay.Location = new System.Drawing.Point(0, 0);
            this.txtDisplay.Multiline = true;
            this.txtDisplay.Name = "txtDisplay";
            this.txtDisplay.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtDisplay.Size = new System.Drawing.Size(1047, 140);
            this.txtDisplay.TabIndex = 0;
            // 
            // frmQuestion
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 19F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1072, 545);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.pnView);
            this.Controls.Add(this.pnData);
            this.Controls.Add(this.pnFilter);
            this.Font = new System.Drawing.Font("Times New Roman", 12.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Margin = new System.Windows.Forms.Padding(4);
            this.Name = "frmQuestion";
            this.Text = "EPU Contest System - Question Manager";
            this.Load += new System.EventHandler(this.frmQuestion_Load);
            this.pnData.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgrQuestion)).EndInit();
            this.ctmDgrQuestion.ResumeLayout(false);
            this.pnView.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgrSubQuestion)).EndInit();
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgrAnswer)).EndInit();
            this.pnFilter.ResumeLayout(false);
            this.pnFilter.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Panel pnData;
        private System.Windows.Forms.Panel pnView;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Panel pnFilter;
        private System.Windows.Forms.ContextMenuStrip ctmDgrQuestion;
        private System.Windows.Forms.ToolStripMenuItem btnEditQuestion;
        private System.Windows.Forms.ToolStripMenuItem btnDeleteQuestion;
        private DevComponents.DotNetBar.Controls.DataGridViewX dgrQuestion;
        private DevComponents.DotNetBar.Controls.DataGridViewX dgrSubQuestion;
        private DevComponents.DotNetBar.Controls.DataGridViewX dgrAnswer;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.TextBox txtDisplay;
        private DevComponents.DotNetBar.Controls.TextBoxX txtSearch;
        private DevComponents.DotNetBar.Controls.ComboBoxEx cmbSubject;
        private DevComponents.DotNetBar.ButtonX btnRefresh;
        private DevComponents.DotNetBar.ButtonX btnImport;
        private DevComponents.DotNetBar.ButtonX btnAdd;
    }
}