Module _var
    Public gs_rutaServidorOrigen As String = My.Settings.ServerOrigen  '    "\\apolo\laboratorio$\LabEscrituraINSN\"
    Public gs_ruta_temp As String = Application.StartupPath + "\tmpRES\"
    Public gs_nombreArchivo As String = My.Settings.NombreFile   '    "\\apolo\laboratorio$\LabEscrituraINSN\

    Public gs_packEnvioInsert As Integer = Convert.ToInt32(My.Settings.PaqueteEnvio)


End Module
