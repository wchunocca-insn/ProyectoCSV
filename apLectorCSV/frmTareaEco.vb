Imports System.IO
Imports System.Text
Imports System.Threading
Imports System.Data.SqlClient

Public Class frmTareaEco
    Dim i_nromax% = 0
    Dim i_completo% = 0
    Public b_cvs_procesado As Boolean = False
    Dim tablaDatos As DataTable
    Public s_cvs_error As String = ""

    Dim listCVS
    Public s_cvs_archivo As String = ""
    Public s_cvs_archivo_intranet As String = "" 'nombre de archivo para guardar en BD
    ' Dim cn As SqlConnection



    Function ifx_do_validar(ByVal _snameFile As String) As String

        'If _existeArchivo(_snameFile) = True Then
        '    Return "Archivo ya existe..!"
        'End If

        Dim _filename As String = "" ' = gs_rutaServidorMedico + _snameFile '"201810021612070000005.res"

        If File.Exists(gs_rutaServidorOrigen + _snameFile) = False Then
            Return "Error el archivo no existe"
        End If
        Dim _ext As String = Path.GetExtension(gs_rutaServidorOrigen + _snameFile)
        If _ext.Trim.ToLower <> ".csv" Then
            Return "Error el archivo no es extension .CSV"
        End If
        Try

            'pfm_do_copyServerDestino(_snameFile) 'Subir archivo al servidor
            'Thread.Sleep(3000) 'esperar 5 segundos, q se termine de copiar el archivo

            pfm_do_copyTemporal(_snameFile) 'bajar al temporal para leer
        Catch ex As Exception
            Return ex.Message
        End Try
        If File.Exists(gs_ruta_temp + _snameFile) = False Then
            Return "El archivo no se pudo copiar ..!"
        End If
        Return ""

    End Function

    Public Function _existeArchivo(ByVal _snameFile As String) As Boolean
        'Try
        '    Dim dc As New dbDataDataContext
        '    Dim oreg As eco_tempo = (From r In dc.eco_tempo Where r.cvs_nombreEje = _snameFile Select r).FirstOrDefault
        '    If oreg Is Nothing Then
        '        Return False
        '    End If
        '    Return True
        'Catch ex As Exception
        '    Return ex.Message
        'End Try
        Return False
    End Function
    'Public Function pfm_do_copyServerDestino(ByVal s_archivoServerNombre$) As String

    '    Try
    '        'subir al servidor
    '        FileCopy(gs_rutaServidorOrigen + s_archivoServerNombre$, gs_rutaServidorDestino + s_archivoServerNombre$)
    '        'verificar si archivo subio al carpeta Destino
    '        'Eliminar el archivo de carpeta origen 
    '        If File.Exists(gs_rutaServidorDestino + s_archivoServerNombre$) = True Then
    '            File.Delete(gs_rutaServidorOrigen + s_archivoServerNombre$) 'eliminar de la carpeta origen
    '        End If
    '    Catch ex As Exception
    '        Return ex.Message
    '    End Try
    '    Return ""
    'End Function
    Public Function pfm_do_copyTemporal(ByVal s_archivoServerNombre$) As String

        'Limpiar el temporal
        Try
            System.IO.Directory.Delete(gs_ruta_temp, True)
            System.IO.File.Delete(gs_ruta_temp + s_archivoServerNombre)
        Catch ex As Exception
        End Try

        Try
            My.Computer.FileSystem.CreateDirectory(gs_ruta_temp)
        Catch ex As Exception

        End Try
        'Limpiar el temporal

        'Bajar archivo a la carpeta temporal
        Dim folder As New DirectoryInfo(gs_rutaServidorOrigen)
        Try
            FileCopy(gs_rutaServidorOrigen + s_archivoServerNombre$, gs_ruta_temp + s_archivoServerNombre$)
        Catch ex As Exception
            Return ex.Message
        End Try
        Return ""

    End Function
    Private Sub btn_OK_Click(sender As System.Object, e As System.EventArgs)
        '
        '
        '


    End Sub
    Private Sub ifx_do_updateAvanceTarea()
        If i_completo = 20 Then '20
            ' If i_completo = 1 Then

            b_cvs_procesado = True
            MessageBox.Show("Termino la tarea", "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Information)
            ' Me.Close()
            'cn.Close()

            Return
        End If
        pgbar_avance.Value = (i_completo * 100 / 20)

    End Sub
    Public Sub ifx_set_ErrorStop()

        lbl_error_msg.Text = s_cvs_error
        bkw_tarea.CancelAsync()
        bkw_tarea02.CancelAsync()
        bkw_tarea03.CancelAsync()
        bkw_tarea04.CancelAsync()
        bkw_tarea05.CancelAsync()
        bkw_tarea06.CancelAsync()
        bkw_tarea07.CancelAsync()
        bkw_tarea08.CancelAsync()
        bkw_tarea09.CancelAsync()
        bkw_tarea10.CancelAsync()
        bkw_tarea11.CancelAsync()
        bkw_tarea12.CancelAsync()
        bkw_tarea13.CancelAsync()
        bkw_tarea14.CancelAsync()
        bkw_tarea15.CancelAsync()
        bkw_tarea16.CancelAsync()
        bkw_tarea17.CancelAsync()
        bkw_tarea18.CancelAsync()
        bkw_tarea19.CancelAsync()
        bkw_tarea20.CancelAsync()

    End Sub
    Public Sub ifx_do_procesarCVS()

        lbl_error_msg.Text = ""
        s_cvs_error = ""
        If gs_nombreArchivo = "" Then
            Exit Sub
        End If


        Dim nombreFile$ = gs_nombreArchivo
        s_cvs_archivo_intranet = gs_nombreArchivo



        s_cvs_error = ifx_do_validar(nombreFile)
        If s_cvs_error <> "" Then
            b_cvs_procesado = False
            lbl_error_msg.Text = s_cvs_error
            'Me.Close()
            Return
        End If

        txt_ruta.Text = gs_ruta_temp + nombreFile
        i_nromax = 0
        i_completo = 0
        ListBox1.Items.Add("Inicio :" + Now.ToString)
        ifx_do_loadCVS()

        ProgressBar1.Value = 0
        'cn = New SqlConnection(My.Settings.GsECOConnectionString)
        'cn.Open()

        bkw_tarea.RunWorkerAsync()
        bkw_tarea02.RunWorkerAsync()
        bkw_tarea03.RunWorkerAsync()
        bkw_tarea04.RunWorkerAsync()
        bkw_tarea05.RunWorkerAsync()


        bkw_tarea06.RunWorkerAsync()
        bkw_tarea07.RunWorkerAsync()
        bkw_tarea08.RunWorkerAsync()
        bkw_tarea09.RunWorkerAsync()
        bkw_tarea10.RunWorkerAsync()

        bkw_tarea11.RunWorkerAsync()
        bkw_tarea12.RunWorkerAsync()
        bkw_tarea13.RunWorkerAsync()
        bkw_tarea14.RunWorkerAsync()
        bkw_tarea15.RunWorkerAsync()
        bkw_tarea16.RunWorkerAsync()
        bkw_tarea17.RunWorkerAsync()
        bkw_tarea18.RunWorkerAsync()
        bkw_tarea19.RunWorkerAsync()
        bkw_tarea20.RunWorkerAsync()

    End Sub
    'Lectura de filas y transferencia al SQL
    Private Sub ifx_do_procesar_all(ByVal igrupo%)

        Dim i_inicio%, i_final%
        Dim itotal% = listCVS.Length - 1
        Dim icant_grupo% = itotal / 20 'total por grupo

        'Determinar el numero de orden de inicio y fin del Rango
        If (igrupo = 1) Then 'inicio
            i_inicio = 1
            i_final = icant_grupo
        ElseIf (igrupo = 20) Then ' grupo Final
            i_inicio = (icant_grupo * 19) + 1
            i_final = itotal
        Else
            '            i_inicio = icant_grupo * (igrupo - 1)
            i_inicio = (icant_grupo * (igrupo - 1)) + 1
            i_final = icant_grupo * igrupo
        End If


        Dim separador As Char = Convert.ToChar(";")
        Dim separadorCampos As String = Chr(34)
        Dim i_total_filas% = (i_final - i_inicio) + 1
        Dim i_porcent As Double = 0


        'Los 
        Dim ilist As List(Of eco_tempo_N1) = Nothing
        Dim ilist2 As List(Of eco_tempo_N2) = Nothing
        Dim ilist3 As List(Of eco_tempo_N3) = Nothing
        Dim ilist4 As List(Of eco_tempo_N4) = Nothing
        Dim ilist5 As List(Of eco_tempo_N5) = Nothing

        Dim dc As New dbDataDataContext
        Select Case igrupo
            Case 1, 6, 11, 16
                ilist = New List(Of eco_tempo_N1)
            Case 2, 7, 12, 17
                ilist2 = New List(Of eco_tempo_N2)
            Case 3, 8, 13, 18
                ilist3 = New List(Of eco_tempo_N3)
            Case 4, 9, 14, 19
                ilist4 = New List(Of eco_tempo_N4)
            Case 5, 10, 15, 20
                ilist5 = New List(Of eco_tempo_N5)
        End Select


        Dim i_row% = 1

        For i = i_inicio To i_final
            Dim filasDatos = listCVS(i).Split(separador)
            i_porcent = (i_row * 100 / i_total_filas)

            Try
                Select Case igrupo
                    Case 1, 6, 11, 16
                        Dim bo As New eco_tempo_N1
                        '
                        '
                        bo.cvs_nombreEje = s_cvs_archivo_intranet
                        bo.imp_fecha = Now
                        bo.imp_nro = i
                        bo.imp_nrofor = i_row
                        bo.imp_nrogrupo = igrupo
                        '
                        bo.ANO_EJE = s.int(filasDatos(0)) '1 ANO_EJE (int)
                        bo.MES_EJE = s.int(filasDatos(1)) '2 MES_EJE (int)
                        bo.NIVEL_GOBIERNO = s.str(filasDatos(2)) '3 NIVEL_GOBIERNO (char)
                        bo.NIVEL_GOBIERNO_NOMBRE = s.str(filasDatos(3)) '4 NIVEL_GOBIERNO_NOMBRE (texto)
                        bo.SECTOR = s.int(filasDatos(4)) '5 SECTOR (char)
                        bo.SECTOR_NOMBRE = s.str(filasDatos(5)) '6 SECTOR_NOMBRE (texto)
                        bo.PLIEGO = s.int(filasDatos(6)) '7 PLIEGO (char)
                        bo.PLIEGO_NOMBRE = s.str(filasDatos(7)) '8 PLIEGO_NOMBRE (texto)
                        bo.SEC_EJEC = s.dob(filasDatos(8)) '9 SEC_EJEC (char)
                        bo.EJECUTORA = s.dob(filasDatos(9)) '10 EJECUTORA (char)
                        bo.EJECUTORA_NOMBRE = s.str(filasDatos(10)) '11 EJECUTORA_NOMBRE (texto)
                        bo.DEPARTAMENTO_EJECUTORA = s.int(filasDatos(11)) '12 DEPARTAMENTO_EJECUTORA (int)
                        bo.DEPARTAMENTO_EJECUTORA_NOMBRE = s.str(filasDatos(12)) '13 DEPARTAMENTO_EJECUTORA_NOMBRE (texto)
                        bo.PROVINCIA_EJECUTORA = s.int(filasDatos(13)) '14 PROVINCIA_EJECUTORA (int)
                        bo.PROVINCIA_EJECUTORA_NOMBRE = s.str(filasDatos(14)) '15 PROVINCIA_EJECUTORA_NOMBRE (texto)
                        bo.DISTRITO_EJECUTORA = s.int(filasDatos(15)) '16 DISTRITO_EJECUTORA (int)
                        bo.DISTRITO_EJECUTORA_NOMBRE = s.str(filasDatos(16)) '17 DISTRITO_EJECUTORA_NOMBRE (texto)
                        bo.SEC_FUNC = s.int(filasDatos(17)) '18 SEC_FUNC (int)
                        bo.PROGRAMA_PPTO = s.int(filasDatos(18)) '19 PROGRAMA_PPTO (int)
                        bo.PROGRAMA_PPTO_NOMBRE = s.str(filasDatos(19)) '20 PROGRAMA_PPTO_NOMBRE (texto)
                        bo.TIPO_ACT_PROY = s.int(filasDatos(20)) '21 TIPO_ACT_PROY (int)
                        bo.TIPO_ACT_PROY_NOMBRE = s.str(filasDatos(21)) '22 TIPO_ACT_PROY_NOMBRE (texto)
                        bo.PRODUCTO_PROYECTO = s.str(filasDatos(22)) '23 PRODUCTO_PROYECTO (char)
                        bo.PRODUCTO_PROYECTO_NOMBRE = s.str(filasDatos(23)) '24 PRODUCTO_PROYECTO_NOMBRE (texto)
                        bo.ACTIVIDAD_ACCION_OBRA = s.str(filasDatos(24)) '25 ACTIVIDAD_ACCION_OBRA (char)
                        bo.ACTIVIDAD_ACCION_OBRA_NOMBRE = s.str(filasDatos(25)) '26 ACTIVIDAD_ACCION_OBRA_NOMBRE (texto)
                        bo.FUNCION = s.int(filasDatos(26)) '27 FUNCION (int)
                        bo.FUNCION_NOMBRE = s.str(filasDatos(27)) '28 FUNCION_NOMBRE (texto)
                        bo.DIVISION_FUNCIONAL = s.int(filasDatos(28)) '29 DIVISION_FUNCIONAL (int)
                        bo.DIVISION_FUNCIONAL_NOMBRE = s.str(filasDatos(29)) '30 DIVISION_FUNCIONAL_NOMBRE (texto)
                        bo.GRUPO_FUNCIONAL = s.int(filasDatos(30)) '31 GRUPO_FUNCIONAL (int)
                        bo.GRUPO_FUNCIONAL_NOMBRE = s.str(filasDatos(31)) '32 GRUPO_FUNCIONAL_NOMBRE (texto)
                        bo.META = s.int(filasDatos(32)) '33 META (int)
                        bo.FINALIDAD = s.dob(filasDatos(33)) '34 FINALIDAD ()
                        bo.META_NOMBRE = s.str(filasDatos(34)) '35 META_NOMBRE (texto)
                        bo.DEPARTAMENTO_META = s.int(filasDatos(35)) '36 DEPARTAMENTO_META (int)
                        bo.DEPARTAMENTO_META_NOMBRE = s.str(filasDatos(36)) '37 DEPARTAMENTO_META_NOMBRE (texto)
                        bo.FUENTE_FINANCIAMIENTO = s.int(filasDatos(37)) '38 FUENTE_FINANCIAMIENTO (int)
                        bo.FUENTE_FINANCIAMIENTO_NOMBRE = s.str(filasDatos(38)) '39 FUENTE_FINANCIAMIENTO_NOMBRE (texto)
                        bo.RUBRO = s.int(filasDatos(39)) '40 RUBRO (int)
                        bo.RUBRO_NOMBRE = s.str(filasDatos(40)) '41 RUBRO_NOMBRE (texto)
                        bo.TIPO_RECURSO = s.int(filasDatos(41)) '42 TIPO_RECURSO (int)
                        bo.TIPO_RECURSO_NOMBRE = s.str(filasDatos(42)) '43 TIPO_RECURSO_NOMBRE (texto)
                        bo.CATEGORIA_GASTO = s.int(filasDatos(43)) '44 CATEGORIA_GASTO (int)
                        bo.CATEGORIA_GASTO_NOMBRE = s.str(filasDatos(44)) '45 CATEGORIA_GASTO_NOMBRE (texto)
                        bo.TIPO_TRANSACCION = s.int(filasDatos(45)) '46 TIPO_TRANSACCION (int)
                        bo.GENERICA = s.int(filasDatos(46)) '47 GENERICA (int)
                        bo.GENERICA_NOMBRE = s.str(filasDatos(47)) '48 GENERICA_NOMBRE (texto)
                        bo.SUBGENERICA = s.int(filasDatos(48)) '49 SUBGENERICA (int)
                        bo.SUBGENERICA_NOMBRE = s.str(filasDatos(49)) '50 SUBGENERICA_NOMBRE (texto)
                        bo.SUBGENERICA_DET = s.int(filasDatos(50)) '51 SUBGENERICA_DET (int)
                        bo.SUBGENERICA_DET_NOMBRE = s.str(filasDatos(51)) '52 SUBGENERICA_DET_NOMBRE (texto)
                        bo.ESPECIFICA = s.int(filasDatos(52)) '53 ESPECIFICA (int)
                        bo.ESPECIFICA_NOMBRE = s.str(filasDatos(53)) '54 ESPECIFICA_NOMBRE (texto)
                        bo.ESPECIFICA_DET = s.int(filasDatos(54)) '55 ESPECIFICA_DET (int)
                        bo.ESPECIFICA_DET_NOMBRE = s.str(filasDatos(55)) '56 ESPECIFICA_DET_NOMBRE (texto)
                        bo.MONTO_PIA = s.dob(filasDatos(56)) '57 MONTO_PIA (decimal)
                        bo.MONTO_PIM = s.dob(filasDatos(57)) '58 MONTO_PIM (decimal)
                        bo.MONTO_CERTIFICADO = s.dob(filasDatos(58)) '59 MONTO_CERTIFICADO (decimal)
                        bo.MONTO_COMPROMETIDO_ANUAL = s.dob(filasDatos(59)) '60 MONTO_COMPROMETIDO_ANUAL (decimal)
                        bo.MONTO_COMPROMETIDO = s.dob(filasDatos(60)) '61 MONTO_COMPROMETIDO (decimal)
                        bo.MONTO_DEVENGADO = s.dob(filasDatos(61)) '62 MONTO_DEVENGADO (decimal)
                        bo.MONTO_GIRADO = s.dob(filasDatos(62)) '63 MONTO_GIRADO (decimal)
                        '
                        '
                        ilist.Add(bo)
                        bo = Nothing
                    Case 2, 7, 12, 17
                        Dim bo2 As New eco_tempo_N2
                        bo2.cvs_nombreEje = s_cvs_archivo_intranet
                        bo2.imp_fecha = Now
                        bo2.imp_nro = i
                        bo2.imp_nrofor = i_row
                        bo2.imp_nrogrupo = igrupo
                        '
                        bo2.ANO_EJE = s.int(filasDatos(0)) '1 ANO_EJE (int)
                        bo2.MES_EJE = s.int(filasDatos(1)) '2 MES_EJE (int)
                        bo2.NIVEL_GOBIERNO = s.str(filasDatos(2)) '3 NIVEL_GOBIERNO (char)
                        bo2.NIVEL_GOBIERNO_NOMBRE = s.str(filasDatos(3)) '4 NIVEL_GOBIERNO_NOMBRE (texto)
                        bo2.SECTOR = s.int(filasDatos(4)) '5 SECTOR (char)
                        bo2.SECTOR_NOMBRE = s.str(filasDatos(5)) '6 SECTOR_NOMBRE (texto)
                        bo2.PLIEGO = s.int(filasDatos(6)) '7 PLIEGO (char)
                        bo2.PLIEGO_NOMBRE = s.str(filasDatos(7)) '8 PLIEGO_NOMBRE (texto)
                        bo2.SEC_EJEC = s.dob(filasDatos(8)) '9 SEC_EJEC (char)
                        bo2.EJECUTORA = s.dob(filasDatos(9)) '10 EJECUTORA (char)
                        bo2.EJECUTORA_NOMBRE = s.str(filasDatos(10)) '11 EJECUTORA_NOMBRE (texto)
                        bo2.DEPARTAMENTO_EJECUTORA = s.int(filasDatos(11)) '12 DEPARTAMENTO_EJECUTORA (int)
                        bo2.DEPARTAMENTO_EJECUTORA_NOMBRE = s.str(filasDatos(12)) '13 DEPARTAMENTO_EJECUTORA_NOMBRE (texto)
                        bo2.PROVINCIA_EJECUTORA = s.int(filasDatos(13)) '14 PROVINCIA_EJECUTORA (int)
                        bo2.PROVINCIA_EJECUTORA_NOMBRE = s.str(filasDatos(14)) '15 PROVINCIA_EJECUTORA_NOMBRE (texto)
                        bo2.DISTRITO_EJECUTORA = s.int(filasDatos(15)) '16 DISTRITO_EJECUTORA (int)
                        bo2.DISTRITO_EJECUTORA_NOMBRE = s.str(filasDatos(16)) '17 DISTRITO_EJECUTORA_NOMBRE (texto)
                        bo2.SEC_FUNC = s.int(filasDatos(17)) '18 SEC_FUNC (int)
                        bo2.PROGRAMA_PPTO = s.int(filasDatos(18)) '19 PROGRAMA_PPTO (int)
                        bo2.PROGRAMA_PPTO_NOMBRE = s.str(filasDatos(19)) '20 PROGRAMA_PPTO_NOMBRE (texto)
                        bo2.TIPO_ACT_PROY = s.int(filasDatos(20)) '21 TIPO_ACT_PROY (int)
                        bo2.TIPO_ACT_PROY_NOMBRE = s.str(filasDatos(21)) '22 TIPO_ACT_PROY_NOMBRE (texto)
                        bo2.PRODUCTO_PROYECTO = s.str(filasDatos(22)) '23 PRODUCTO_PROYECTO (char)
                        bo2.PRODUCTO_PROYECTO_NOMBRE = s.str(filasDatos(23)) '24 PRODUCTO_PROYECTO_NOMBRE (texto)
                        bo2.ACTIVIDAD_ACCION_OBRA = s.str(filasDatos(24)) '25 ACTIVIDAD_ACCION_OBRA (char)
                        bo2.ACTIVIDAD_ACCION_OBRA_NOMBRE = s.str(filasDatos(25)) '26 ACTIVIDAD_ACCION_OBRA_NOMBRE (texto)
                        bo2.FUNCION = s.int(filasDatos(26)) '27 FUNCION (int)
                        bo2.FUNCION_NOMBRE = s.str(filasDatos(27)) '28 FUNCION_NOMBRE (texto)
                        bo2.DIVISION_FUNCIONAL = s.int(filasDatos(28)) '29 DIVISION_FUNCIONAL (int)
                        bo2.DIVISION_FUNCIONAL_NOMBRE = s.str(filasDatos(29)) '30 DIVISION_FUNCIONAL_NOMBRE (texto)
                        bo2.GRUPO_FUNCIONAL = s.int(filasDatos(30)) '31 GRUPO_FUNCIONAL (int)
                        bo2.GRUPO_FUNCIONAL_NOMBRE = s.str(filasDatos(31)) '32 GRUPO_FUNCIONAL_NOMBRE (texto)
                        bo2.META = s.int(filasDatos(32)) '33 META (int)
                        bo2.FINALIDAD = s.dob(filasDatos(33)) '34 FINALIDAD ()
                        bo2.META_NOMBRE = s.str(filasDatos(34)) '35 META_NOMBRE (texto)
                        bo2.DEPARTAMENTO_META = s.int(filasDatos(35)) '36 DEPARTAMENTO_META (int)
                        bo2.DEPARTAMENTO_META_NOMBRE = s.str(filasDatos(36)) '37 DEPARTAMENTO_META_NOMBRE (texto)
                        bo2.FUENTE_FINANCIAMIENTO = s.int(filasDatos(37)) '38 FUENTE_FINANCIAMIENTO (int)
                        bo2.FUENTE_FINANCIAMIENTO_NOMBRE = s.str(filasDatos(38)) '39 FUENTE_FINANCIAMIENTO_NOMBRE (texto)
                        bo2.RUBRO = s.int(filasDatos(39)) '40 RUBRO (int)
                        bo2.RUBRO_NOMBRE = s.str(filasDatos(40)) '41 RUBRO_NOMBRE (texto)
                        bo2.TIPO_RECURSO = s.int(filasDatos(41)) '42 TIPO_RECURSO (int)
                        bo2.TIPO_RECURSO_NOMBRE = s.str(filasDatos(42)) '43 TIPO_RECURSO_NOMBRE (texto)
                        bo2.CATEGORIA_GASTO = s.int(filasDatos(43)) '44 CATEGORIA_GASTO (int)
                        bo2.CATEGORIA_GASTO_NOMBRE = s.str(filasDatos(44)) '45 CATEGORIA_GASTO_NOMBRE (texto)
                        bo2.TIPO_TRANSACCION = s.int(filasDatos(45)) '46 TIPO_TRANSACCION (int)
                        bo2.GENERICA = s.int(filasDatos(46)) '47 GENERICA (int)
                        bo2.GENERICA_NOMBRE = s.str(filasDatos(47)) '48 GENERICA_NOMBRE (texto)
                        bo2.SUBGENERICA = s.int(filasDatos(48)) '49 SUBGENERICA (int)
                        bo2.SUBGENERICA_NOMBRE = s.str(filasDatos(49)) '50 SUBGENERICA_NOMBRE (texto)
                        bo2.SUBGENERICA_DET = s.int(filasDatos(50)) '51 SUBGENERICA_DET (int)
                        bo2.SUBGENERICA_DET_NOMBRE = s.str(filasDatos(51)) '52 SUBGENERICA_DET_NOMBRE (texto)
                        bo2.ESPECIFICA = s.int(filasDatos(52)) '53 ESPECIFICA (int)
                        bo2.ESPECIFICA_NOMBRE = s.str(filasDatos(53)) '54 ESPECIFICA_NOMBRE (texto)
                        bo2.ESPECIFICA_DET = s.int(filasDatos(54)) '55 ESPECIFICA_DET (int)
                        bo2.ESPECIFICA_DET_NOMBRE = s.str(filasDatos(55)) '56 ESPECIFICA_DET_NOMBRE (texto)
                        bo2.MONTO_PIA = s.dob(filasDatos(56)) '57 MONTO_PIA (decimal)
                        bo2.MONTO_PIM = s.dob(filasDatos(57)) '58 MONTO_PIM (decimal)
                        bo2.MONTO_CERTIFICADO = s.dob(filasDatos(58)) '59 MONTO_CERTIFICADO (decimal)
                        bo2.MONTO_COMPROMETIDO_ANUAL = s.dob(filasDatos(59)) '60 MONTO_COMPROMETIDO_ANUAL (decimal)
                        bo2.MONTO_COMPROMETIDO = s.dob(filasDatos(60)) '61 MONTO_COMPROMETIDO (decimal)
                        bo2.MONTO_DEVENGADO = s.dob(filasDatos(61)) '62 MONTO_DEVENGADO (decimal)
                        bo2.MONTO_GIRADO = s.dob(filasDatos(62)) '63 MONTO_GIRADO (decimal)


                        ilist2.Add(bo2)
                        bo2 = Nothing
                    Case 3, 8, 13, 18
                        Dim bo3 As New eco_tempo_N3
                        bo3.cvs_nombreEje = s_cvs_archivo_intranet
                        bo3.imp_fecha = Now
                        bo3.imp_nro = i
                        bo3.imp_nrofor = i_row
                        bo3.imp_nrogrupo = igrupo
                        '
                        bo3.ANO_EJE = s.int(filasDatos(0)) '1 ANO_EJE (int)
                        bo3.MES_EJE = s.int(filasDatos(1)) '2 MES_EJE (int)
                        bo3.NIVEL_GOBIERNO = s.str(filasDatos(2)) '3 NIVEL_GOBIERNO (char)
                        bo3.NIVEL_GOBIERNO_NOMBRE = s.str(filasDatos(3)) '4 NIVEL_GOBIERNO_NOMBRE (texto)
                        bo3.SECTOR = s.int(filasDatos(4)) '5 SECTOR (char)
                        bo3.SECTOR_NOMBRE = s.str(filasDatos(5)) '6 SECTOR_NOMBRE (texto)
                        bo3.PLIEGO = s.int(filasDatos(6)) '7 PLIEGO (char)
                        bo3.PLIEGO_NOMBRE = s.str(filasDatos(7)) '8 PLIEGO_NOMBRE (texto)
                        bo3.SEC_EJEC = s.dob(filasDatos(8)) '9 SEC_EJEC (char)
                        bo3.EJECUTORA = s.dob(filasDatos(9)) '10 EJECUTORA (char)
                        bo3.EJECUTORA_NOMBRE = s.str(filasDatos(10)) '11 EJECUTORA_NOMBRE (texto)
                        bo3.DEPARTAMENTO_EJECUTORA = s.int(filasDatos(11)) '12 DEPARTAMENTO_EJECUTORA (int)
                        bo3.DEPARTAMENTO_EJECUTORA_NOMBRE = s.str(filasDatos(12)) '13 DEPARTAMENTO_EJECUTORA_NOMBRE (texto)
                        bo3.PROVINCIA_EJECUTORA = s.int(filasDatos(13)) '14 PROVINCIA_EJECUTORA (int)
                        bo3.PROVINCIA_EJECUTORA_NOMBRE = s.str(filasDatos(14)) '15 PROVINCIA_EJECUTORA_NOMBRE (texto)
                        bo3.DISTRITO_EJECUTORA = s.int(filasDatos(15)) '16 DISTRITO_EJECUTORA (int)
                        bo3.DISTRITO_EJECUTORA_NOMBRE = s.str(filasDatos(16)) '17 DISTRITO_EJECUTORA_NOMBRE (texto)
                        bo3.SEC_FUNC = s.int(filasDatos(17)) '18 SEC_FUNC (int)
                        bo3.PROGRAMA_PPTO = s.int(filasDatos(18)) '19 PROGRAMA_PPTO (int)
                        bo3.PROGRAMA_PPTO_NOMBRE = s.str(filasDatos(19)) '20 PROGRAMA_PPTO_NOMBRE (texto)
                        bo3.TIPO_ACT_PROY = s.int(filasDatos(20)) '21 TIPO_ACT_PROY (int)
                        bo3.TIPO_ACT_PROY_NOMBRE = s.str(filasDatos(21)) '22 TIPO_ACT_PROY_NOMBRE (texto)
                        bo3.PRODUCTO_PROYECTO = s.str(filasDatos(22)) '23 PRODUCTO_PROYECTO (char)
                        bo3.PRODUCTO_PROYECTO_NOMBRE = s.str(filasDatos(23)) '24 PRODUCTO_PROYECTO_NOMBRE (texto)
                        bo3.ACTIVIDAD_ACCION_OBRA = s.str(filasDatos(24)) '25 ACTIVIDAD_ACCION_OBRA (char)
                        bo3.ACTIVIDAD_ACCION_OBRA_NOMBRE = s.str(filasDatos(25)) '26 ACTIVIDAD_ACCION_OBRA_NOMBRE (texto)
                        bo3.FUNCION = s.int(filasDatos(26)) '27 FUNCION (int)
                        bo3.FUNCION_NOMBRE = s.str(filasDatos(27)) '28 FUNCION_NOMBRE (texto)
                        bo3.DIVISION_FUNCIONAL = s.int(filasDatos(28)) '29 DIVISION_FUNCIONAL (int)
                        bo3.DIVISION_FUNCIONAL_NOMBRE = s.str(filasDatos(29)) '30 DIVISION_FUNCIONAL_NOMBRE (texto)
                        bo3.GRUPO_FUNCIONAL = s.int(filasDatos(30)) '31 GRUPO_FUNCIONAL (int)
                        bo3.GRUPO_FUNCIONAL_NOMBRE = s.str(filasDatos(31)) '32 GRUPO_FUNCIONAL_NOMBRE (texto)
                        bo3.META = s.int(filasDatos(32)) '33 META (int)
                        bo3.FINALIDAD = s.dob(filasDatos(33)) '34 FINALIDAD ()
                        bo3.META_NOMBRE = s.str(filasDatos(34)) '35 META_NOMBRE (texto)
                        bo3.DEPARTAMENTO_META = s.int(filasDatos(35)) '36 DEPARTAMENTO_META (int)
                        bo3.DEPARTAMENTO_META_NOMBRE = s.str(filasDatos(36)) '37 DEPARTAMENTO_META_NOMBRE (texto)
                        bo3.FUENTE_FINANCIAMIENTO = s.int(filasDatos(37)) '38 FUENTE_FINANCIAMIENTO (int)
                        bo3.FUENTE_FINANCIAMIENTO_NOMBRE = s.str(filasDatos(38)) '39 FUENTE_FINANCIAMIENTO_NOMBRE (texto)
                        bo3.RUBRO = s.int(filasDatos(39)) '40 RUBRO (int)
                        bo3.RUBRO_NOMBRE = s.str(filasDatos(40)) '41 RUBRO_NOMBRE (texto)
                        bo3.TIPO_RECURSO = s.int(filasDatos(41)) '42 TIPO_RECURSO (int)
                        bo3.TIPO_RECURSO_NOMBRE = s.str(filasDatos(42)) '43 TIPO_RECURSO_NOMBRE (texto)
                        bo3.CATEGORIA_GASTO = s.int(filasDatos(43)) '44 CATEGORIA_GASTO (int)
                        bo3.CATEGORIA_GASTO_NOMBRE = s.str(filasDatos(44)) '45 CATEGORIA_GASTO_NOMBRE (texto)
                        bo3.TIPO_TRANSACCION = s.int(filasDatos(45)) '46 TIPO_TRANSACCION (int)
                        bo3.GENERICA = s.int(filasDatos(46)) '47 GENERICA (int)
                        bo3.GENERICA_NOMBRE = s.str(filasDatos(47)) '48 GENERICA_NOMBRE (texto)
                        bo3.SUBGENERICA = s.int(filasDatos(48)) '49 SUBGENERICA (int)
                        bo3.SUBGENERICA_NOMBRE = s.str(filasDatos(49)) '50 SUBGENERICA_NOMBRE (texto)
                        bo3.SUBGENERICA_DET = s.int(filasDatos(50)) '51 SUBGENERICA_DET (int)
                        bo3.SUBGENERICA_DET_NOMBRE = s.str(filasDatos(51)) '52 SUBGENERICA_DET_NOMBRE (texto)
                        bo3.ESPECIFICA = s.int(filasDatos(52)) '53 ESPECIFICA (int)
                        bo3.ESPECIFICA_NOMBRE = s.str(filasDatos(53)) '54 ESPECIFICA_NOMBRE (texto)
                        bo3.ESPECIFICA_DET = s.int(filasDatos(54)) '55 ESPECIFICA_DET (int)
                        bo3.ESPECIFICA_DET_NOMBRE = s.str(filasDatos(55)) '56 ESPECIFICA_DET_NOMBRE (texto)
                        bo3.MONTO_PIA = s.dob(filasDatos(56)) '57 MONTO_PIA (decimal)
                        bo3.MONTO_PIM = s.dob(filasDatos(57)) '58 MONTO_PIM (decimal)
                        bo3.MONTO_CERTIFICADO = s.dob(filasDatos(58)) '59 MONTO_CERTIFICADO (decimal)
                        bo3.MONTO_COMPROMETIDO_ANUAL = s.dob(filasDatos(59)) '60 MONTO_COMPROMETIDO_ANUAL (decimal)
                        bo3.MONTO_COMPROMETIDO = s.dob(filasDatos(60)) '61 MONTO_COMPROMETIDO (decimal)
                        bo3.MONTO_DEVENGADO = s.dob(filasDatos(61)) '62 MONTO_DEVENGADO (decimal)
                        bo3.MONTO_GIRADO = s.dob(filasDatos(62)) '63 MONTO_GIRADO (decimal)

                        ilist3.Add(bo3)
                        bo3 = Nothing
                    Case 4, 9, 14, 19
                        Dim bo4 As New eco_tempo_N4

                        bo4.cvs_nombreEje = s_cvs_archivo_intranet
                        bo4.imp_fecha = Now
                        bo4.imp_nro = i
                        bo4.imp_nrofor = i_row
                        bo4.imp_nrogrupo = igrupo
                        '
                        bo4.ANO_EJE = s.int(filasDatos(0)) '1 ANO_EJE (int)
                        bo4.MES_EJE = s.int(filasDatos(1)) '2 MES_EJE (int)
                        bo4.NIVEL_GOBIERNO = s.str(filasDatos(2)) '3 NIVEL_GOBIERNO (char)
                        bo4.NIVEL_GOBIERNO_NOMBRE = s.str(filasDatos(3)) '4 NIVEL_GOBIERNO_NOMBRE (texto)
                        bo4.SECTOR = s.int(filasDatos(4)) '5 SECTOR (char)
                        bo4.SECTOR_NOMBRE = s.str(filasDatos(5)) '6 SECTOR_NOMBRE (texto)
                        bo4.PLIEGO = s.int(filasDatos(6)) '7 PLIEGO (char)
                        bo4.PLIEGO_NOMBRE = s.str(filasDatos(7)) '8 PLIEGO_NOMBRE (texto)
                        bo4.SEC_EJEC = s.dob(filasDatos(8)) '9 SEC_EJEC (char)
                        bo4.EJECUTORA = s.dob(filasDatos(9)) '10 EJECUTORA (char)
                        bo4.EJECUTORA_NOMBRE = s.str(filasDatos(10)) '11 EJECUTORA_NOMBRE (texto)
                        bo4.DEPARTAMENTO_EJECUTORA = s.int(filasDatos(11)) '12 DEPARTAMENTO_EJECUTORA (int)
                        bo4.DEPARTAMENTO_EJECUTORA_NOMBRE = s.str(filasDatos(12)) '13 DEPARTAMENTO_EJECUTORA_NOMBRE (texto)
                        bo4.PROVINCIA_EJECUTORA = s.int(filasDatos(13)) '14 PROVINCIA_EJECUTORA (int)
                        bo4.PROVINCIA_EJECUTORA_NOMBRE = s.str(filasDatos(14)) '15 PROVINCIA_EJECUTORA_NOMBRE (texto)
                        bo4.DISTRITO_EJECUTORA = s.int(filasDatos(15)) '16 DISTRITO_EJECUTORA (int)
                        bo4.DISTRITO_EJECUTORA_NOMBRE = s.str(filasDatos(16)) '17 DISTRITO_EJECUTORA_NOMBRE (texto)
                        bo4.SEC_FUNC = s.int(filasDatos(17)) '18 SEC_FUNC (int)
                        bo4.PROGRAMA_PPTO = s.int(filasDatos(18)) '19 PROGRAMA_PPTO (int)
                        bo4.PROGRAMA_PPTO_NOMBRE = s.str(filasDatos(19)) '20 PROGRAMA_PPTO_NOMBRE (texto)
                        bo4.TIPO_ACT_PROY = s.int(filasDatos(20)) '21 TIPO_ACT_PROY (int)
                        bo4.TIPO_ACT_PROY_NOMBRE = s.str(filasDatos(21)) '22 TIPO_ACT_PROY_NOMBRE (texto)
                        bo4.PRODUCTO_PROYECTO = s.str(filasDatos(22)) '23 PRODUCTO_PROYECTO (char)
                        bo4.PRODUCTO_PROYECTO_NOMBRE = s.str(filasDatos(23)) '24 PRODUCTO_PROYECTO_NOMBRE (texto)
                        bo4.ACTIVIDAD_ACCION_OBRA = s.str(filasDatos(24)) '25 ACTIVIDAD_ACCION_OBRA (char)
                        bo4.ACTIVIDAD_ACCION_OBRA_NOMBRE = s.str(filasDatos(25)) '26 ACTIVIDAD_ACCION_OBRA_NOMBRE (texto)
                        bo4.FUNCION = s.int(filasDatos(26)) '27 FUNCION (int)
                        bo4.FUNCION_NOMBRE = s.str(filasDatos(27)) '28 FUNCION_NOMBRE (texto)
                        bo4.DIVISION_FUNCIONAL = s.int(filasDatos(28)) '29 DIVISION_FUNCIONAL (int)
                        bo4.DIVISION_FUNCIONAL_NOMBRE = s.str(filasDatos(29)) '30 DIVISION_FUNCIONAL_NOMBRE (texto)
                        bo4.GRUPO_FUNCIONAL = s.int(filasDatos(30)) '31 GRUPO_FUNCIONAL (int)
                        bo4.GRUPO_FUNCIONAL_NOMBRE = s.str(filasDatos(31)) '32 GRUPO_FUNCIONAL_NOMBRE (texto)
                        bo4.META = s.int(filasDatos(32)) '33 META (int)
                        bo4.FINALIDAD = s.dob(filasDatos(33)) '34 FINALIDAD ()
                        bo4.META_NOMBRE = s.str(filasDatos(34)) '35 META_NOMBRE (texto)
                        bo4.DEPARTAMENTO_META = s.int(filasDatos(35)) '36 DEPARTAMENTO_META (int)
                        bo4.DEPARTAMENTO_META_NOMBRE = s.str(filasDatos(36)) '37 DEPARTAMENTO_META_NOMBRE (texto)
                        bo4.FUENTE_FINANCIAMIENTO = s.int(filasDatos(37)) '38 FUENTE_FINANCIAMIENTO (int)
                        bo4.FUENTE_FINANCIAMIENTO_NOMBRE = s.str(filasDatos(38)) '39 FUENTE_FINANCIAMIENTO_NOMBRE (texto)
                        bo4.RUBRO = s.int(filasDatos(39)) '40 RUBRO (int)
                        bo4.RUBRO_NOMBRE = s.str(filasDatos(40)) '41 RUBRO_NOMBRE (texto)
                        bo4.TIPO_RECURSO = s.int(filasDatos(41)) '42 TIPO_RECURSO (int)
                        bo4.TIPO_RECURSO_NOMBRE = s.str(filasDatos(42)) '43 TIPO_RECURSO_NOMBRE (texto)
                        bo4.CATEGORIA_GASTO = s.int(filasDatos(43)) '44 CATEGORIA_GASTO (int)
                        bo4.CATEGORIA_GASTO_NOMBRE = s.str(filasDatos(44)) '45 CATEGORIA_GASTO_NOMBRE (texto)
                        bo4.TIPO_TRANSACCION = s.int(filasDatos(45)) '46 TIPO_TRANSACCION (int)
                        bo4.GENERICA = s.int(filasDatos(46)) '47 GENERICA (int)
                        bo4.GENERICA_NOMBRE = s.str(filasDatos(47)) '48 GENERICA_NOMBRE (texto)
                        bo4.SUBGENERICA = s.int(filasDatos(48)) '49 SUBGENERICA (int)
                        bo4.SUBGENERICA_NOMBRE = s.str(filasDatos(49)) '50 SUBGENERICA_NOMBRE (texto)
                        bo4.SUBGENERICA_DET = s.int(filasDatos(50)) '51 SUBGENERICA_DET (int)
                        bo4.SUBGENERICA_DET_NOMBRE = s.str(filasDatos(51)) '52 SUBGENERICA_DET_NOMBRE (texto)
                        bo4.ESPECIFICA = s.int(filasDatos(52)) '53 ESPECIFICA (int)
                        bo4.ESPECIFICA_NOMBRE = s.str(filasDatos(53)) '54 ESPECIFICA_NOMBRE (texto)
                        bo4.ESPECIFICA_DET = s.int(filasDatos(54)) '55 ESPECIFICA_DET (int)
                        bo4.ESPECIFICA_DET_NOMBRE = s.str(filasDatos(55)) '56 ESPECIFICA_DET_NOMBRE (texto)
                        bo4.MONTO_PIA = s.dob(filasDatos(56)) '57 MONTO_PIA (decimal)
                        bo4.MONTO_PIM = s.dob(filasDatos(57)) '58 MONTO_PIM (decimal)
                        bo4.MONTO_CERTIFICADO = s.dob(filasDatos(58)) '59 MONTO_CERTIFICADO (decimal)
                        bo4.MONTO_COMPROMETIDO_ANUAL = s.dob(filasDatos(59)) '60 MONTO_COMPROMETIDO_ANUAL (decimal)
                        bo4.MONTO_COMPROMETIDO = s.dob(filasDatos(60)) '61 MONTO_COMPROMETIDO (decimal)
                        bo4.MONTO_DEVENGADO = s.dob(filasDatos(61)) '62 MONTO_DEVENGADO (decimal)
                        bo4.MONTO_GIRADO = s.dob(filasDatos(62)) '63 MONTO_GIRADO (decimal)

                        ilist4.Add(bo4)
                        bo4 = Nothing
                    Case 5, 10, 15, 20
                        Dim bo5 As New eco_tempo_N5

                        bo5.cvs_nombreEje = s_cvs_archivo_intranet
                        bo5.imp_fecha = Now
                        bo5.imp_nro = i
                        bo5.imp_nrofor = i_row
                        bo5.imp_nrogrupo = igrupo
                        '
                        bo5.ANO_EJE = s.int(filasDatos(0)) '1 ANO_EJE (int)
                        bo5.MES_EJE = s.int(filasDatos(1)) '2 MES_EJE (int)
                        bo5.NIVEL_GOBIERNO = s.str(filasDatos(2)) '3 NIVEL_GOBIERNO (char)
                        bo5.NIVEL_GOBIERNO_NOMBRE = s.str(filasDatos(3)) '4 NIVEL_GOBIERNO_NOMBRE (texto)
                        bo5.SECTOR = s.int(filasDatos(4)) '5 SECTOR (char)
                        bo5.SECTOR_NOMBRE = s.str(filasDatos(5)) '6 SECTOR_NOMBRE (texto)
                        bo5.PLIEGO = s.int(filasDatos(6)) '7 PLIEGO (char)
                        bo5.PLIEGO_NOMBRE = s.str(filasDatos(7)) '8 PLIEGO_NOMBRE (texto)
                        bo5.SEC_EJEC = s.dob(filasDatos(8)) '9 SEC_EJEC (char)
                        bo5.EJECUTORA = s.dob(filasDatos(9)) '10 EJECUTORA (char)
                        bo5.EJECUTORA_NOMBRE = s.str(filasDatos(10)) '11 EJECUTORA_NOMBRE (texto)
                        bo5.DEPARTAMENTO_EJECUTORA = s.int(filasDatos(11)) '12 DEPARTAMENTO_EJECUTORA (int)
                        bo5.DEPARTAMENTO_EJECUTORA_NOMBRE = s.str(filasDatos(12)) '13 DEPARTAMENTO_EJECUTORA_NOMBRE (texto)
                        bo5.PROVINCIA_EJECUTORA = s.int(filasDatos(13)) '14 PROVINCIA_EJECUTORA (int)
                        bo5.PROVINCIA_EJECUTORA_NOMBRE = s.str(filasDatos(14)) '15 PROVINCIA_EJECUTORA_NOMBRE (texto)
                        bo5.DISTRITO_EJECUTORA = s.int(filasDatos(15)) '16 DISTRITO_EJECUTORA (int)
                        bo5.DISTRITO_EJECUTORA_NOMBRE = s.str(filasDatos(16)) '17 DISTRITO_EJECUTORA_NOMBRE (texto)
                        bo5.SEC_FUNC = s.int(filasDatos(17)) '18 SEC_FUNC (int)
                        bo5.PROGRAMA_PPTO = s.int(filasDatos(18)) '19 PROGRAMA_PPTO (int)
                        bo5.PROGRAMA_PPTO_NOMBRE = s.str(filasDatos(19)) '20 PROGRAMA_PPTO_NOMBRE (texto)
                        bo5.TIPO_ACT_PROY = s.int(filasDatos(20)) '21 TIPO_ACT_PROY (int)
                        bo5.TIPO_ACT_PROY_NOMBRE = s.str(filasDatos(21)) '22 TIPO_ACT_PROY_NOMBRE (texto)
                        bo5.PRODUCTO_PROYECTO = s.str(filasDatos(22)) '23 PRODUCTO_PROYECTO (char)
                        bo5.PRODUCTO_PROYECTO_NOMBRE = s.str(filasDatos(23)) '24 PRODUCTO_PROYECTO_NOMBRE (texto)
                        bo5.ACTIVIDAD_ACCION_OBRA = s.str(filasDatos(24)) '25 ACTIVIDAD_ACCION_OBRA (char)
                        bo5.ACTIVIDAD_ACCION_OBRA_NOMBRE = s.str(filasDatos(25)) '26 ACTIVIDAD_ACCION_OBRA_NOMBRE (texto)
                        bo5.FUNCION = s.int(filasDatos(26)) '27 FUNCION (int)
                        bo5.FUNCION_NOMBRE = s.str(filasDatos(27)) '28 FUNCION_NOMBRE (texto)
                        bo5.DIVISION_FUNCIONAL = s.int(filasDatos(28)) '29 DIVISION_FUNCIONAL (int)
                        bo5.DIVISION_FUNCIONAL_NOMBRE = s.str(filasDatos(29)) '30 DIVISION_FUNCIONAL_NOMBRE (texto)
                        bo5.GRUPO_FUNCIONAL = s.int(filasDatos(30)) '31 GRUPO_FUNCIONAL (int)
                        bo5.GRUPO_FUNCIONAL_NOMBRE = s.str(filasDatos(31)) '32 GRUPO_FUNCIONAL_NOMBRE (texto)
                        bo5.META = s.int(filasDatos(32)) '33 META (int)
                        bo5.FINALIDAD = s.dob(filasDatos(33)) '34 FINALIDAD ()
                        bo5.META_NOMBRE = s.str(filasDatos(34)) '35 META_NOMBRE (texto)
                        bo5.DEPARTAMENTO_META = s.int(filasDatos(35)) '36 DEPARTAMENTO_META (int)
                        bo5.DEPARTAMENTO_META_NOMBRE = s.str(filasDatos(36)) '37 DEPARTAMENTO_META_NOMBRE (texto)
                        bo5.FUENTE_FINANCIAMIENTO = s.int(filasDatos(37)) '38 FUENTE_FINANCIAMIENTO (int)
                        bo5.FUENTE_FINANCIAMIENTO_NOMBRE = s.str(filasDatos(38)) '39 FUENTE_FINANCIAMIENTO_NOMBRE (texto)
                        bo5.RUBRO = s.int(filasDatos(39)) '40 RUBRO (int)
                        bo5.RUBRO_NOMBRE = s.str(filasDatos(40)) '41 RUBRO_NOMBRE (texto)
                        bo5.TIPO_RECURSO = s.int(filasDatos(41)) '42 TIPO_RECURSO (int)
                        bo5.TIPO_RECURSO_NOMBRE = s.str(filasDatos(42)) '43 TIPO_RECURSO_NOMBRE (texto)
                        bo5.CATEGORIA_GASTO = s.int(filasDatos(43)) '44 CATEGORIA_GASTO (int)
                        bo5.CATEGORIA_GASTO_NOMBRE = s.str(filasDatos(44)) '45 CATEGORIA_GASTO_NOMBRE (texto)
                        bo5.TIPO_TRANSACCION = s.int(filasDatos(45)) '46 TIPO_TRANSACCION (int)
                        bo5.GENERICA = s.int(filasDatos(46)) '47 GENERICA (int)
                        bo5.GENERICA_NOMBRE = s.str(filasDatos(47)) '48 GENERICA_NOMBRE (texto)
                        bo5.SUBGENERICA = s.int(filasDatos(48)) '49 SUBGENERICA (int)
                        bo5.SUBGENERICA_NOMBRE = s.str(filasDatos(49)) '50 SUBGENERICA_NOMBRE (texto)
                        bo5.SUBGENERICA_DET = s.int(filasDatos(50)) '51 SUBGENERICA_DET (int)
                        bo5.SUBGENERICA_DET_NOMBRE = s.str(filasDatos(51)) '52 SUBGENERICA_DET_NOMBRE (texto)
                        bo5.ESPECIFICA = s.int(filasDatos(52)) '53 ESPECIFICA (int)
                        bo5.ESPECIFICA_NOMBRE = s.str(filasDatos(53)) '54 ESPECIFICA_NOMBRE (texto)
                        bo5.ESPECIFICA_DET = s.int(filasDatos(54)) '55 ESPECIFICA_DET (int)
                        bo5.ESPECIFICA_DET_NOMBRE = s.str(filasDatos(55)) '56 ESPECIFICA_DET_NOMBRE (texto)
                        bo5.MONTO_PIA = s.dob(filasDatos(56)) '57 MONTO_PIA (decimal)
                        bo5.MONTO_PIM = s.dob(filasDatos(57)) '58 MONTO_PIM (decimal)
                        bo5.MONTO_CERTIFICADO = s.dob(filasDatos(58)) '59 MONTO_CERTIFICADO (decimal)
                        bo5.MONTO_COMPROMETIDO_ANUAL = s.dob(filasDatos(59)) '60 MONTO_COMPROMETIDO_ANUAL (decimal)
                        bo5.MONTO_COMPROMETIDO = s.dob(filasDatos(60)) '61 MONTO_COMPROMETIDO (decimal)
                        bo5.MONTO_DEVENGADO = s.dob(filasDatos(61)) '62 MONTO_DEVENGADO (decimal)
                        bo5.MONTO_GIRADO = s.dob(filasDatos(62)) '63 MONTO_GIRADO (decimal)

                        ilist5.Add(bo5)
                        bo5 = Nothing
                End Select
            Catch ex As Exception
                s_cvs_error = ex.Message
            End Try




            's_cvs_error = _ejeSQL(igrupo, bo)
            ' If ilist.Count = 10 Or ilist2.Count = 10 Then
            Try
                If s_cvs_error = "" Then
                    Select Case igrupo
                        Case 1, 6, 11, 16
                            If ilist.Count = gs_packEnvioInsert Then
                                dc.eco_tempo_N1.InsertAllOnSubmit(ilist)
                                dc.SubmitChanges()
                                ilist = New List(Of eco_tempo_N1)
                            End If
                        Case 2, 7, 12, 17
                            If ilist2.Count = gs_packEnvioInsert Then
                                dc.eco_tempo_N2.InsertAllOnSubmit(ilist2)
                                dc.SubmitChanges()
                                ilist2 = New List(Of eco_tempo_N2)
                            End If
                        Case 3, 8, 13, 18
                            If ilist3.Count = gs_packEnvioInsert Then
                                dc.eco_tempo_N3.InsertAllOnSubmit(ilist3)
                                dc.SubmitChanges()
                                ilist3 = New List(Of eco_tempo_N3)
                            End If
                        Case 4, 9, 14, 19
                            If ilist4.Count = gs_packEnvioInsert Then
                                dc.eco_tempo_N4.InsertAllOnSubmit(ilist4)
                                dc.SubmitChanges()
                                ilist4 = New List(Of eco_tempo_N4)
                            End If
                        Case 5, 10, 15, 20
                            If ilist5.Count = gs_packEnvioInsert Then
                                dc.eco_tempo_N5.InsertAllOnSubmit(ilist5)
                                dc.SubmitChanges()
                                ilist5 = New List(Of eco_tempo_N5)
                            End If


                    End Select
                End If
            Catch ex As Exception
                s_cvs_error = ex.Message
            End Try



            'error 
            Select Case igrupo
                Case 1 : bkw_tarea.ReportProgress(i_porcent)
                Case 2 : bkw_tarea02.ReportProgress(i_porcent)
                Case 3 : bkw_tarea03.ReportProgress(i_porcent)
                Case 4 : bkw_tarea04.ReportProgress(i_porcent)
                Case 5 : bkw_tarea05.ReportProgress(i_porcent)
                Case 6 : bkw_tarea06.ReportProgress(i_porcent)
                Case 7 : bkw_tarea07.ReportProgress(i_porcent)
                Case 8 : bkw_tarea08.ReportProgress(i_porcent)
                Case 9 : bkw_tarea09.ReportProgress(i_porcent)
                Case 10 : bkw_tarea10.ReportProgress(i_porcent)
                Case 11 : bkw_tarea11.ReportProgress(i_porcent)
                Case 12 : bkw_tarea12.ReportProgress(i_porcent)
                Case 13 : bkw_tarea13.ReportProgress(i_porcent)
                Case 14 : bkw_tarea14.ReportProgress(i_porcent)
                Case 15 : bkw_tarea15.ReportProgress(i_porcent)
                Case 16 : bkw_tarea16.ReportProgress(i_porcent)
                Case 17 : bkw_tarea17.ReportProgress(i_porcent)
                Case 18 : bkw_tarea18.ReportProgress(i_porcent)
                Case 19 : bkw_tarea19.ReportProgress(i_porcent)
                Case 20 : bkw_tarea20.ReportProgress(i_porcent)
            End Select

            'ilist.Add(bo)
            'dc.eco_tempo.InsertOnSubmit(bo)
            'dc.SubmitChanges()
            'bo = Nothing

            'If ilist.Count = 10 Then
            'dc.eco_tempo.InsertAllOnSubmit(ilist)
            'dc.SubmitChanges()
            ' ilist = New List(Of eco_tempo)
            '       dc = Nothing
            'End If

            i_row = i_row + 1
            ' 
        Next
        Try

            Select Case igrupo
                Case 1, 6, 11, 16
                    If ilist.Count > 0 Then
                        dc.eco_tempo_N1.InsertAllOnSubmit(ilist)
                        dc.SubmitChanges()

                    End If
                Case 2, 7, 12, 17
                    If ilist2.Count > 0 Then
                        dc.eco_tempo_N2.InsertAllOnSubmit(ilist2)
                        dc.SubmitChanges()

                    End If
                Case 3, 8, 13, 18
                    If ilist3.Count > 0 Then
                        dc.eco_tempo_N3.InsertAllOnSubmit(ilist3)
                        dc.SubmitChanges()

                    End If
                Case 4, 9, 14, 19
                    If ilist4.Count > 0 Then
                        dc.eco_tempo_N4.InsertAllOnSubmit(ilist4)
                        dc.SubmitChanges()

                    End If
                Case 5, 10, 15, 20
                    If ilist5.Count > 0 Then
                        dc.eco_tempo_N5.InsertAllOnSubmit(ilist5)
                        dc.SubmitChanges()

                    End If


            End Select
            ilist = Nothing
            ilist2 = Nothing
            ilist3 = Nothing
            ilist4 = Nothing
            ilist5 = Nothing



        Catch ex As Exception
            s_cvs_error = ex.Message
        End Try
        dc = Nothing




    End Sub



    Private Sub ifx_do_loadCVS()

        Dim ficheroCSV As String = txt_ruta.Text
        Dim separador As Char = Convert.ToChar(";")
        Dim separadorCampos As String = Chr(34)
        listCVS = File.ReadAllLines(ficheroCSV, Encoding.Default)
        lbl_cant.Text = listCVS.Length - 1
    End Sub
    'Private Sub ifx_do_lector()


    '    Dim ficheroCSV As String = txt_ruta.Text
    '    Dim separador As Char = Convert.ToChar(";")
    '    Dim separadorCampos As String = Chr(34)




    '    tablaDatos = New DataTable()
    '    Dim lineas = File.ReadAllLines(ficheroCSV, Encoding.Default)




    '    'Titulos
    '    Dim ci As Integer = 0
    '    Dim lista As List(Of String) = New List(Of String)()
    '    'Dim etiquetaTitulosFinal As String()

    '    '
    '    '
    '    'For Each campoActual In lineas(0).Split(";")
    '    '    i_nromax = i_nromax + 1
    '    '    bkw_tarea.ReportProgress((i_nromax * 100 / 300)) '5 min
    '    '    ci = ci + 1
    '    '    Dim valor = campoActual
    '    '    If separadorCampos IsNot "" Then
    '    '        valor = valor.TrimEnd(Convert.ToChar(separadorCampos))
    '    '        valor = valor.TrimStart(Convert.ToChar(separadorCampos))
    '    '    End If
    '    '    tablaDatos.Columns.Add(New DataColumn(valor))
    '    '    lista.Add(valor)
    '    'Next
    '    'etiquetaTitulosFinal = lista.ToArray()

    '    Dim bo As New eco_tempo
    '    'Dim ilist As New List(Of eco_tempo)
    '    Dim dc As New dbDataDataContext

    '    For i = 1 To lineas.Length - 1
    '        Dim filasDatos = lineas(i).Split(separador)
    '        ' Dim dataGridS As DataRow = tablaDatos.NewRow()
    '        Dim columnIndex = 0


    '        bo = New eco_tempo
    '        bkw_tarea.ReportProgress((i * 100 / lineas.Length)) '5 min

    '        bo = New eco_tempo
    '        bo.MES_EJE = i

    '        dc.eco_tempo.InsertOnSubmit(bo)
    '        dc.SubmitChanges()
    '        bo = Nothing

    '        'For Each campoActual In etiquetaTitulosFinal

    '        '    Dim valor = filasDatos(columnIndex)
    '        '    ' Quitamos el posible carácter de inicio y fin de valor
    '        '    If separadorCampos <> "" Then
    '        '        valor = valor.TrimEnd(Convert.ToChar(separadorCampos))
    '        '        valor = valor.TrimStart(Convert.ToChar(separadorCampos))
    '        '    End If
    '        '    columnIndex = columnIndex + 1
    '        '    bo = New eco_tempo
    '        '    bo.grupo = i
    '        '    dc.eco_tempo.InsertOnSubmit(bo)
    '        '    dc.SubmitChanges()
    '        '    bo = Nothing
    '        '    '               [grupo] [float] NULL,
    '        '    '[FECHA] [datetime] NULL,
    '        '    '[ANO_EJE] [float] NULL,
    '        '    '[TIPO_GOBIERNO] [nvarchar](255) NULL,
    '        '    '[TIPO_GOBIERNO_NOMBRE] [nvarchar](255) NULL,
    '        '    '[SECTOR] [float] NULL,
    '        '    '[SECTOR_NOMBRE] [nvarchar](255) NULL,
    '        '    '[PLIEGO] [float] NULL,
    '        '    '[PLIEGO_NOMBRE] [nvarchar](255) NULL,
    '        '    '[SEC_EJEC] [float] NULL,
    '        '    '[EJECUTORA] [float] NULL,
    '        '    '[EJECUTORA_NOMBRE] [nvarchar](255) NULL,
    '        '    '[DEPARTAMENTO_EJECUTORA] [float] NULL,
    '        '    '[DEPARTAMENTO_EJECUTORA_NOMBRE] [nvarchar](255) NULL,
    '        '    '[PROVINCIA_EJECUTORA] [float] NULL,
    '        '    '[PROVINCIA_EJECUTORA_NOMBRE] [nvarchar](255) NULL,
    '        '    '[DISTRITO_EJECUTORA] [float] NULL,
    '        '    '[DISTRITO_EJECUTORA_NOMBRE] [nvarchar](255) NULL,
    '        '    '[SEC_FUNC] [float] NULL,
    '        '    '[PROGRAMA_PPTO] [float] NULL,
    '        '    '[PROGRAMA_PPTO_NOMBRE] [nvarchar](255) NULL,
    '        '    '[TIPO_ACT_PROY] [float] NULL,
    '        '    '[TIPO_ACT_PROY_NOMBRE] [nvarchar](255) NULL,
    '        '    '[PRODUCTO_PROYECTO] [float] NULL,
    '        '    '[PRODUCTO_PROYECTO_NOMBRE] [nvarchar](255) NULL,
    '        '    '[ACTIVIDAD_ACCION_OBRA] [float] NULL,
    '        '    '[ACTIVIDAD_ACCION_OBRA_NOMBRE] [nvarchar](255) NULL,
    '        '    '[FUNCION] [float] NULL,
    '        '    '[FUNCION_NOMBRE] [nvarchar](255) NULL,
    '        '    '[DIVISION_FUNCIONAL] [float] NULL,
    '        '    '[DIVISION_FUNCIONAL_NOMBRE] [nvarchar](255) NULL,
    '        '    '[GRUPO_FUNCIONAL] [float] NULL,
    '        '    '[GRUPO_FUNCIONAL_NOMBRE] [nvarchar](255) NULL,
    '        '    '[META] [float] NULL,
    '        '    '[FINALIDAD] [float] NULL,
    '        '    '[META_NOMBRE] [nvarchar](255) NULL,
    '        '    '[DEPARTAMENTO_META] [float] NULL,
    '        '    '[DEPARTAMENTO_META_NOMBRE] [nvarchar](255) NULL,
    '        '    '[FUENTE_FINANC] [float] NULL,
    '        '    '[FUENTE_FINANCIAMIENTO_NOMBRE] [nvarchar](255) NULL,
    '        '    '[RUBRO] [float] NULL,
    '        '    '[RUBRO_NOMBRE] [nvarchar](255) NULL,
    '        '    '[TIPO_RECURSO] [float] NULL,
    '        '    '[TIPO_RECURSO_NOMBRE] [nvarchar](255) NULL,
    '        '    '[CATEG_GASTO] [float] NULL,
    '        '    '[CATEGORIA_GASTO_NOMBRE] [nvarchar](255) NULL,
    '        '    '[TIPO_TRANSACCION] [float] NULL,
    '        '    '[GENERICA] [float] NULL,
    '        '    '[GENERICA_NOMBRE] [nvarchar](255) NULL,
    '        '    '[SUBGENERICA] [float] NULL,
    '        '    '[SUBGENERICA_NOMBRE] [nvarchar](255) NULL,
    '        '    '[SUBGENERICA_DET] [float] NULL,
    '        '    '[SUBGENERICA_DET_NOMBRE] [nvarchar](255) NULL,
    '        '    '[ESPECIFICA] [float] NULL,
    '        '    '[ESPECIFICA_NOMBRE] [nvarchar](255) NULL,
    '        '    '[ESPECIFICA_DET] [float] NULL,
    '        '    '[ESPECIFICA_DET_NOMBRE] [nvarchar](255) NULL,
    '        '    '[MONTO_PIA] [float] NULL,
    '        '    '[MONTO_PIM] [float] NULL,
    '        '    '[MONTO_CERTIFICADO] [float] NULL,
    '        '    '[MONTO_COMPROMETIDO_ANUAL] [float] NULL,
    '        '    '[MONTO_COMPROMETIDO] [float] NULL,
    '        '    '[MONTO_DEVENGADO(0)] [float] NULL,
    '        '    '[MONTO_DEVENGADO(ENE)] [nvarchar](255) NULL,
    '        '    '[MONTO_DEVENGADO(FEB)] [nvarchar](255) NULL,
    '        '    '[MONTO_DEVENGADO(MAR)] [float] NULL,
    '        '    '[MONTO_DEVENGADO(ABR)] [nvarchar](255) NULL,
    '        '    '[MONTO_DEVENGADO(MAY)] [nvarchar](255) NULL,
    '        '    '[MONTO_GIRADO] [float] NULL

    '        '    'dataGridS(campoActual) = valor
    '        'Next
    '        '            tablaDatos.Rows.Add(dataGridS)
    '        '  ilist.Add(bo)
    '    Next

    '    dc = Nothing



    '    'for (int i = inicioFila; i < lineas.Length; i++)
    '    '       {
    '    '           string[] filasDatos = lineas[i].Split(separador);
    '    '           DataRow dataGridS = tablaDatos.NewRow();
    '    '           int columnIndex = 0;
    '    '           foreach (string campoActual in etiquetaTitulosFinal)
    '    '           {
    '    '               string valor = filasDatos[columnIndex++];
    '    '               // Quitamos el posible carácter de inicio y fin de valor
    '    '               if (separadorCampos != "")
    '    '               {
    '    '                   valor = valor.TrimEnd(Convert.ToChar(separadorCampos));
    '    '                   valor = valor.TrimStart(Convert.ToChar(separadorCampos));
    '    '               }
    '    '               dataGridS[campoActual] = valor;
    '    '           }
    '    '           tablaDatos.Rows.Add(dataGridS);
    '    '       }



    'End Sub

    Private Sub bkw_tarea_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea.DoWork
        '        ifx_do_procesar(1)
        ifx_do_procesar_all(1)
    End Sub

    Private Sub bkw_tarea_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea.ProgressChanged
        ProgressBar1.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()

    End Sub

    Private Sub bkw_tarea_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea.RunWorkerCompleted
        '  dtgLista.DataSource = tablaDatos.DefaultView
        'lbl_irow.Text = tablaDatos.Rows.Count


        lbl_fase_01.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()

    End Sub

    Private Sub bkw_tarea02_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea02.DoWork
        ifx_do_procesar_all(2)
    End Sub

    Private Sub bkw_tarea02_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea02.ProgressChanged
        probar_02.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()

    End Sub

    Private Sub bkw_tarea03_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea03.DoWork
        ifx_do_procesar_all(3)
    End Sub

    Private Sub bkw_tarea03_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea03.ProgressChanged
        probar_03.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea04_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea04.DoWork
        ifx_do_procesar_all(4)
    End Sub

    Private Sub bkw_tarea04_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea04.ProgressChanged
        probar_04.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea05_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea05.DoWork
        ifx_do_procesar_all(5)
    End Sub

    Private Sub bkw_tarea05_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea05.ProgressChanged
        probar_05.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea06_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea06.DoWork
        ifx_do_procesar_all(6)
    End Sub

    Private Sub bkw_tarea06_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea06.ProgressChanged
        probar_06.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea07_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea07.DoWork
        ifx_do_procesar_all(7)
    End Sub

    Private Sub bkw_tarea07_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea07.ProgressChanged
        probar_07.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea08_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea08.DoWork
        ifx_do_procesar_all(8)
    End Sub

    Private Sub bkw_tarea08_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea08.ProgressChanged
        probar_08.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub
    Private Sub bkw_tarea09_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea09.DoWork
        ifx_do_procesar_all(9)
    End Sub
    Private Sub bkw_tarea09_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea09.ProgressChanged
        probar_09.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub
    Private Sub bkw_tarea10_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea10.DoWork
        ifx_do_procesar_all(10)
    End Sub
    Private Sub bkw_tarea10_ProgressChanged(sender As Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea10.ProgressChanged
        probar_10.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub frmTareaEco_Activated(sender As Object, e As System.EventArgs) Handles Me.Activated

    End Sub

    Private Sub Form1_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        ifx_do_procesarCVS()
    End Sub

    Private Sub bkw_tarea11_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea11.DoWork
        ifx_do_procesar_all(11)
    End Sub

    Private Sub probar_11_Click(sender As System.Object, e As System.EventArgs) Handles probar_11.Click

    End Sub

    Private Sub bkw_tarea11_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea11.ProgressChanged
        probar_11.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea12_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea12.ProgressChanged
        probar_12.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea13_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea13.ProgressChanged
        probar_13.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea14_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea14.DoWork
        ifx_do_procesar_all(14)
    End Sub

    Private Sub bkw_tarea14_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea14.ProgressChanged
        probar_14.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea15_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea15.DoWork
        ifx_do_procesar_all(15)
    End Sub

    Private Sub bkw_tarea15_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea15.ProgressChanged
        probar_15.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea16_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea16.DoWork
        ifx_do_procesar_all(16)
    End Sub

    Private Sub bkw_tarea16_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea16.ProgressChanged
        probar_16.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea17_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea17.DoWork
        ifx_do_procesar_all(17)
    End Sub

    Private Sub bkw_tarea17_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea17.ProgressChanged
        probar_17.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea18_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea18.DoWork
        ifx_do_procesar_all(18)
    End Sub

    Private Sub bkw_tarea18_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea18.ProgressChanged
        probar_18.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea19_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea19.DoWork
        ifx_do_procesar_all(19)
    End Sub

    Private Sub bkw_tarea19_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea19.ProgressChanged
        probar_19.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea20_DoWork(sender As Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea20.DoWork
        ifx_do_procesar_all(20)
    End Sub

    Private Sub bkw_tarea20_ProgressChanged(sender As System.Object, e As System.ComponentModel.ProgressChangedEventArgs) Handles bkw_tarea20.ProgressChanged
        probar_20.Value = e.ProgressPercentage
        If s_cvs_error <> "" Then ifx_set_ErrorStop()
    End Sub

    Private Sub bkw_tarea12_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea12.DoWork
        ifx_do_procesar_all(12)
    End Sub

    Private Sub bkw_tarea13_DoWork(sender As System.Object, e As System.ComponentModel.DoWorkEventArgs) Handles bkw_tarea13.DoWork
        ifx_do_procesar_all(13)
    End Sub

    Private Sub bkw_tarea14_RunWorkerCompleted(sender As System.Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea14.RunWorkerCompleted
        lbl_fase_14.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea15_RunWorkerCompleted(sender As System.Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea15.RunWorkerCompleted
        lbl_fase_15.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea16_RunWorkerCompleted(sender As System.Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea16.RunWorkerCompleted
        lbl_fase_16.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea17_RunWorkerCompleted(sender As System.Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea17.RunWorkerCompleted
        lbl_fase_17.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea18_RunWorkerCompleted(sender As System.Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea18.RunWorkerCompleted
        lbl_fase_18.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea19_RunWorkerCompleted(sender As System.Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea19.RunWorkerCompleted
        lbl_fase_19.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea20_RunWorkerCompleted(sender As System.Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea20.RunWorkerCompleted
        lbl_fase_20.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea02_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea02.RunWorkerCompleted
        lbl_fase_02.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()

    End Sub

    Private Sub bkw_tarea03_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea03.RunWorkerCompleted
        lbl_fase_03.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea04_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea04.RunWorkerCompleted
        lbl_fase_04.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea05_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea05.RunWorkerCompleted
        lbl_fase_05.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea06_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea06.RunWorkerCompleted
        lbl_fase_06.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea07_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea07.RunWorkerCompleted
        lbl_fase_07.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea08_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea08.RunWorkerCompleted
        lbl_fase_08.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea09_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea09.RunWorkerCompleted
        lbl_fase_09.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea10_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea10.RunWorkerCompleted
        lbl_fase_10.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea11_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea11.RunWorkerCompleted
        lbl_fase_11.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea12_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea12.RunWorkerCompleted
        lbl_fase_12.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()
    End Sub

    Private Sub bkw_tarea13_RunWorkerCompleted(sender As Object, e As System.ComponentModel.RunWorkerCompletedEventArgs) Handles bkw_tarea13.RunWorkerCompleted
        lbl_fase_13.Visible = True
        ListBox1.Items.Add(Now.ToString)
        i_completo = i_completo + 1
        ifx_do_updateAvanceTarea()


    End Sub
    Public Function _ejeSQL(ByVal igrupo As Integer, ByVal bo As eco_tempo_N1) As String

        Dim s_error As String = ""
        ''Dim cn As New SqlConnection(My.Settings.GsECOConnectionString)
        ''cn.Open()

        'Dim s_ins As String = ""
        'Dim s_tabla As String = ""
        'Select Case igrupo
        '    Case 1 : s_tabla = "eco_tempo"
        '    Case 2 : s_tabla = "eco_tempo_N2"


        'End Select
        's_ins = "Insert into " + s_tabla + " (MES_EJE,ANO_EJE,SECTOR,cvs_nombreEje) values ("
        's_ins = String.Concat(s_ins, bo.MES_EJE, ",") 'MES_EJE
        's_ins = String.Concat(s_ins, bo.ANO_EJE, ",") 'ANO_EJE
        's_ins = String.Concat(s_ins, "'", bo.SECTOR, "',") 'SECTOR
        's_ins = String.Concat(s_ins, "'", bo.cvs_nombreEje, "' )") 'cvs_nombreEje

        'Try
        '    If cn.State = ConnectionState.Closed Then
        '        cn.Open()
        '    End If

        '    Dim cmd As New SqlCommand()

        '    cmd.CommandType = CommandType.Text
        '    cmd.CommandText = s_ins
        '    cmd.Connection = cn
        '    cmd.ExecuteNonQuery()
        '    '  cn.Close()

        'Catch ex As Exception
        '    s_error = ex.Message
        'End Try
        Return s_error
    End Function


    'public static _error _ejeSQL(string ssSQL)
    '   {

    '       _error erro = new _error();


    '       try
    '       {

    '           SqlConnection cn = new SqlConnection(dao_telehis.Properties.Settings.Default.GSHISConnectionString + vars._var.gs_passwBASE);
    '           cn.Open();           
    '           SqlCommand cmd = new SqlCommand();
    '           cmd.CommandType = CommandType.Text;
    '           cmd.CommandText = ssSQL;
    '           cmd.Connection = cn;
    '           cmd.ExecuteNonQuery();
    '           cn.Close();
    '           //
    '           //
    '       }
    '       catch (Exception ex)
    '       {
    '           erro.errorNumero = 99;
    '           erro.errorMensaje = ex.Message.ToString();
    '           return erro;
    '       }

    '       return erro;
    '   }

End Class
