﻿<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class _motor
    Inherits System.Windows.Forms.Form

    'Form reemplaza a Dispose para limpiar la lista de componentes.
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

    'Requerido por el Diseñador de Windows Forms
    Private components As System.ComponentModel.IContainer

    'NOTA: el Diseñador de Windows Forms necesita el siguiente procedimiento
    'Se puede modificar usando el Diseñador de Windows Forms.  
    'No lo modifique con el editor de código.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(_motor))
        Me.bkw_tarea = New System.ComponentModel.BackgroundWorker()
        Me.lbl_error_mesage = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'bkw_tarea
        '
        Me.bkw_tarea.WorkerReportsProgress = True
        Me.bkw_tarea.WorkerSupportsCancellation = True
        '
        'lbl_error_mesage
        '
        Me.lbl_error_mesage.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.lbl_error_mesage.Font = New System.Drawing.Font("Microsoft Sans Serif", 15.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lbl_error_mesage.ForeColor = System.Drawing.Color.Navy
        Me.lbl_error_mesage.Location = New System.Drawing.Point(12, 9)
        Me.lbl_error_mesage.Name = "lbl_error_mesage"
        Me.lbl_error_mesage.Size = New System.Drawing.Size(525, 54)
        Me.lbl_error_mesage.TabIndex = 52
        Me.lbl_error_mesage.Text = "Iniciando...."
        '
        '_motor
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(564, 72)
        Me.Controls.Add(Me.lbl_error_mesage)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "_motor"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Modulo  migracion"
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents bkw_tarea As System.ComponentModel.BackgroundWorker
    Friend WithEvents lbl_error_mesage As System.Windows.Forms.Label
End Class
