<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Form1))
        Me.Button1 = New System.Windows.Forms.Button
        Me.Button2 = New System.Windows.Forms.Button
        Me.Button3 = New System.Windows.Forms.Button
        Me.LinkLabel1 = New System.Windows.Forms.LinkLabel
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip
        Me.PlikToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem
        Me.SzukajAktualizcjiToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem
        Me.WyjdźToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem
        Me.Button4 = New System.Windows.Forms.Button
        Me.Button5 = New System.Windows.Forms.Button
        Me.MenuStrip1.SuspendLayout()
        Me.SuspendLayout()
        '
        'Button1
        '
        Me.Button1.BackColor = System.Drawing.SystemColors.GrayText
        Me.Button1.Location = New System.Drawing.Point(225, 32)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(101, 40)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "Terraria"
        Me.Button1.UseVisualStyleBackColor = False
        '
        'Button2
        '
        Me.Button2.BackColor = System.Drawing.SystemColors.GrayText
        Me.Button2.Location = New System.Drawing.Point(14, 274)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(101, 40)
        Me.Button2.TabIndex = 1
        Me.Button2.Text = "Wyjdź"
        Me.Button2.UseVisualStyleBackColor = False
        '
        'Button3
        '
        Me.Button3.BackColor = System.Drawing.SystemColors.GrayText
        Me.Button3.Location = New System.Drawing.Point(225, 78)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(101, 40)
        Me.Button3.TabIndex = 2
        Me.Button3.Text = "Terraria PL"
        Me.Button3.UseVisualStyleBackColor = False
        '
        'LinkLabel1
        '
        Me.LinkLabel1.ActiveLinkColor = System.Drawing.Color.WhiteSmoke
        Me.LinkLabel1.AllowDrop = True
        Me.LinkLabel1.AutoSize = True
        Me.LinkLabel1.BackColor = System.Drawing.Color.Transparent
        Me.LinkLabel1.Cursor = System.Windows.Forms.Cursors.Default
        Me.LinkLabel1.LinkColor = System.Drawing.Color.WhiteSmoke
        Me.LinkLabel1.Location = New System.Drawing.Point(227, 303)
        Me.LinkLabel1.Name = "LinkLabel1"
        Me.LinkLabel1.Size = New System.Drawing.Size(102, 16)
        Me.LinkLabel1.TabIndex = 3
        Me.LinkLabel1.TabStop = True
        Me.LinkLabel1.Text = "http://t-mody.tk"
        Me.LinkLabel1.VisitedLinkColor = System.Drawing.Color.WhiteSmoke
        '
        'MenuStrip1
        '
        Me.MenuStrip1.BackColor = System.Drawing.Color.Transparent
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.PlikToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(341, 24)
        Me.MenuStrip1.TabIndex = 4
        Me.MenuStrip1.Text = "Menu"
        '
        'PlikToolStripMenuItem
        '
        Me.PlikToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.SzukajAktualizcjiToolStripMenuItem, Me.WyjdźToolStripMenuItem})
        Me.PlikToolStripMenuItem.ForeColor = System.Drawing.SystemColors.ControlLight
        Me.PlikToolStripMenuItem.Name = "PlikToolStripMenuItem"
        Me.PlikToolStripMenuItem.Size = New System.Drawing.Size(34, 20)
        Me.PlikToolStripMenuItem.Text = "Plik"
        '
        'SzukajAktualizcjiToolStripMenuItem
        '
        Me.SzukajAktualizcjiToolStripMenuItem.Name = "SzukajAktualizcjiToolStripMenuItem"
        Me.SzukajAktualizcjiToolStripMenuItem.Size = New System.Drawing.Size(165, 22)
        Me.SzukajAktualizcjiToolStripMenuItem.Text = "Szukaj aktualizcji"
        '
        'WyjdźToolStripMenuItem
        '
        Me.WyjdźToolStripMenuItem.Name = "WyjdźToolStripMenuItem"
        Me.WyjdźToolStripMenuItem.Size = New System.Drawing.Size(165, 22)
        Me.WyjdźToolStripMenuItem.Text = "Wyjdź"
        '
        'Button4
        '
        Me.Button4.BackColor = System.Drawing.SystemColors.GrayText
        Me.Button4.Location = New System.Drawing.Point(225, 124)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(101, 40)
        Me.Button4.TabIndex = 5
        Me.Button4.Text = "Tconfig"
        Me.Button4.UseVisualStyleBackColor = False
        '
        'Button5
        '
        Me.Button5.BackColor = System.Drawing.SystemColors.GrayText
        Me.Button5.Location = New System.Drawing.Point(222, 170)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(104, 40)
        Me.Button5.TabIndex = 6
        Me.Button5.Text = "Teh Mod Api"
        Me.Button5.UseVisualStyleBackColor = False
        '
        'Form1
        '
        Me.AllowDrop = True
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoValidate = System.Windows.Forms.AutoValidate.Disable
        Me.BackColor = System.Drawing.SystemColors.ButtonFace
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Image)
        Me.ClientSize = New System.Drawing.Size(341, 328)
        Me.Controls.Add(Me.Button5)
        Me.Controls.Add(Me.Button4)
        Me.Controls.Add(Me.LinkLabel1)
        Me.Controls.Add(Me.Button3)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.MenuStrip1)
        Me.Font = New System.Drawing.Font("Comic Sans MS", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Name = "Form1"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Terraria Launcher by KaMaR"
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents LinkLabel1 As System.Windows.Forms.LinkLabel
    Friend WithEvents MenuStrip1 As System.Windows.Forms.MenuStrip
    Friend WithEvents PlikToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents SzukajAktualizcjiToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents WyjdźToolStripMenuItem As System.Windows.Forms.ToolStripMenuItem
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents Button5 As System.Windows.Forms.Button

End Class
