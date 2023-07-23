Module s

    Public Function str(ByRef _value As Object) As String
        Dim _ret As String
        If _value = Nothing Then Return ""
        Try
            _ret = Convert.ToString(_value)
        Catch ex As Exception
            Return ""
        End Try
        Return _ret
    End Function
    Public Function int(ByRef _value As Object) As Integer
        Dim _ret As Integer
        If _value = Nothing Then Return 0
        Try
            _ret = Convert.ToInt32(_value)
        Catch ex As Exception
            Return 0
        End Try
        Return _ret
    End Function

    Public Function dec(ByRef _value As Object) As Decimal
        Dim _ret As Decimal = 0
        If _value = Nothing Then Return 0
        Try
            _ret = Convert.ToDecimal(_value)
        Catch ex As Exception
            Return 0
        End Try
        Return _ret
    End Function
    Public Function dob(ByRef _value As Object) As Double
        Dim _ret As Double = 0
        If _value = Nothing Then Return 0
        Try
            _ret = Convert.ToDouble(_value)
        Catch ex As Exception
            Return 0
        End Try
        Return _ret
    End Function
    Public Function fec(ByRef _value As Object) As String
        Dim _ret As String = ""
        If _value = Nothing Then Return ""
        Try
            _ret = Convert.ToDateTime(_value).ToShortDateString()
        Catch ex As Exception
            Return ""
        End Try
        Return _ret
    End Function

End Module
