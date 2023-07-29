Public Class _motor
    Dim s_error$ = ""
    Dim i_error% = 0

    Private Sub bkw_tarea_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea.DoWork


       
        Dim s_archivo_origen$ = _var.gs_rutaServidorOrigen + _var.gs_nombreArchivo
        'Dim s_ruta_cvs$ = _var.gs_rutaServidorDestino + _var.gs_nombreArchivo.Replace(".csv", Now.ToString("dd-mm-yyyy_hh-mm-ss") + ".csv")
        'Try
        '    FileCopy(s_archivo_origen, s_ruta_cvs)
        'Catch ex As Exception
        '    s_error = ex.Message
        '    e.Cancel = True
        'End Try

        Try
            Dim dc As New dbDataDataContext
            dc.CommandTimeout = 600 '10 min
            dc.pms_ecomin_MtCVSproceso(1, s_archivo_origen, s_error, i_error)
            dc = Nothing
            If i_error <> 0 Then
                e.Cancel = True
            End If
        Catch ex As Exception
            i_error = 99
            s_error = ex.Message
            e.Cancel = True
        End Try

        If i_error = 0 Then

            Try
                Dim dc As New dbDataDataContext
                dc.CommandTimeout = 900 '15 min
                dc.pms_ecomin_mtTareaCVS("depura-n1", "", "", "", s_error)
                dc = Nothing
                If s_error <> "" Then
                    i_error = 99
                End If

            Catch ex As Exception
                i_error = 99
                s_error = ex.Message
                e.Cancel = True
            End Try



        End If

    End Sub
    
    Private Sub bkw_tarea_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea.RunWorkerCompleted
        If i_error > 0 Then
            ListBox1.Items.Add("Error:" + s_error)
            ListBox1.Items.Add(Now.ToString + " - Fin Tarea 1")
        Else

            If _var.gs_nombreArchivo_N2 = "" Then
                ListBox1.Items.Add("Falta el nombre del archivo N2")
                ListBox1.Items.Add(Now.ToString + " - Fin Tarea 2")
                End
            End If
            ListBox1.Items.Add("Se completo la tarea correctamente..!")
            ListBox1.Items.Add(Now.ToString + " - Fin Tarea 1")
            ListBox1.Items.Add(Now.ToString + " - Tarea 2")
            bkw_tarea_N2.RunWorkerAsync()
        End If

    End Sub
    Private Sub _motor_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        ListBox1.Items.Add(Now.ToString + " - Tarea 1")
        bkw_tarea.RunWorkerAsync()
    End Sub

    Private Sub bkw_tarea_N2_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea_N2.DoWork


        Dim s_archivo_origen$ = _var.gs_rutaServidorOrigen + _var.gs_nombreArchivo_N2


        Try
            Dim dc As New dbDataDataContext
            dc.CommandTimeout = 600 '10 min
            dc.pms_ecomin_MtCVSproceso(2, s_archivo_origen, s_error, i_error)
            dc = Nothing
            If i_error <> 0 Then
                e.Cancel = True
            End If
        Catch ex As Exception
            i_error = 99
            s_error = ex.Message
            e.Cancel = True
        End Try
        If i_error = 0 Then

            Try
                Dim dc As New dbDataDataContext
                dc.CommandTimeout = 900 '15 min
                dc.pms_ecomin_mtTareaCVS("depura-n2", "", "", "", s_error)
                dc = Nothing
                If s_error <> "" Then
                    i_error = 99
                End If

            Catch ex As Exception
                i_error = 99
                s_error = ex.Message
                e.Cancel = True
            End Try


        End If

    End Sub

    Private Sub bkw_tarea_N2_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea_N2.RunWorkerCompleted

        If i_error > 0 Then
            ListBox1.Items.Add("Error:" + s_error)
            ListBox1.Items.Add(Now.ToString + " - Fin Tarea 2 ")
        Else
            ListBox1.Items.Add("Se completo la tarea 2 correctamente..!")
            ListBox1.Items.Add(Now.ToString + " - Fin Tarea 2")
            End
        End If

    End Sub
End Class