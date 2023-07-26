Public Class _motor
    Dim s_error$ = ""
    Dim i_error% = 0

    Private Sub bkw_tarea_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea.DoWork


       
        Dim s_archivo_origen$ = _var.gs_rutaServidorOrigen + _var.gs_nombreArchivo
        Dim s_ruta_cvs$ = _var.gs_rutaServidorDestino + _var.gs_nombreArchivo.Replace(".csv", Now.ToString("dd-mm-yyyy_hh-mm-ss") + ".csv")

        Try
            FileCopy(s_archivo_origen, s_ruta_cvs)
        Catch ex As Exception
            s_error = ex.Message
            e.Cancel = True
        End Try

        Try
            Dim dc As New dbDataDataContext
            dc.CommandTimeout = 600 '10 min
            dc.pms_ecomin_MtCVSproceso(s_ruta_cvs, s_error, i_error)
            dc = Nothing
        Catch ex As Exception
            s_error = ex.Message
            e.Cancel = True
        End Try



    End Sub
    
    Private Sub bkw_tarea_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea.RunWorkerCompleted

        If i_error > 0 Then
            lbl_error_mesage.Text = s_error
            lbl_error_mesage.ForeColor = Color.Red
        Else
            lbl_error_mesage.Text = "Se completo la tarea correctamente..!"
            lbl_error_mesage.ForeColor = Color.Navy
        End If

    End Sub
    Private Sub _motor_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load

        bkw_tarea.RunWorkerAsync()

    End Sub
End Class