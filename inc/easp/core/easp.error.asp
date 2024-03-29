﻿<%
'######################################################################
'## easp.error.asp
'## -------------------------------------------------------------------
'## Feature     :   EasyAsp Exception Class
'## Version     :   v2.2 Alpha
'## Author      :   Coldstone(coldstone[at]qq.com)
'## Update Date :   2010/10/20 23:57:57
'## Description :   Deal with the EasyAsp Exception
'##
'######################################################################
Class EasyAsp_Error
    Private b_debug, b_redirect
    Private i_errNum, i_delay
    Private s_errStr, s_title, s_url, s_css, s_msg
    Private o_err
    Private Sub Class_Initialize
        i_errNum    = ""
        i_delay     = 3000
        s_title     = "发生错误啦"
        b_debug     = Easp.Debug
        b_redirect  = True
        s_url       = "javascript:history.go(-1)"
        Set o_err   = Server.CreateObject("Scripting.Dictionary")
    End Sub
    Private Sub Class_Terminate
        Set o_err = Nothing
    End Sub
    Public Property Get [Debug]
        [Debug] = b_debug
    End Property
    Public Property Let [Debug](ByVal b)
        b_debug = b
    End Property
    Public Default Property Get E(ByVal n)
        If o_err.Exists(n) Then
            E = o_err(n)
        Else
            E = "未知错误"
        End If
    End Property
    Public Property Let E(ByVal n, ByVal s)
        If Easp.Has(n) And Easp.Has(s) Then
            If n > "" Then
                o_err(n) = s
            End If
        End If
    End Property
    Public Property Get LastError
        LastError = i_errNum
    End Property
    Public Property Get Title
        Title = s_title
    End Property
    Public Property Let Title(ByVal s)
        s_title = s
    End Property
    Public Property Get Msg
        Msg = s_msg
    End Property
    Public Property Let Msg(ByVal s)
        s_msg = s
    End Property
    Public Property Get [Redirect]
        [Redirect] = b_redirect
    End Property
    Public Property Let [Redirect](ByVal b)
        b_redirect = b
    End Property
    Public Property Get Url
        Url = s_url
    End Property
    Public Property Let Url(ByVal s)
        s_url = s
    End Property
    Public Property Get Delay
        Delay = i_delay / 1000
    End Property
    Public Property Let Delay(ByVal i)
        i_delay = i * 1000
    End Property
    Public Property Get ClassName
        ClassName = s_css
    End Property
    Public Property Let ClassName(ByVal s)
        s_css = s
    End Property
    Public Sub Raise(ByVal n)
        If Easp.isN(n) Then Exit Sub
        i_errNum = n
        If b_debug Then
            Easp.WE ShowMsg(o_err(n) & s_msg, 1)
        End If
        s_msg = ""
    End Sub
    Public Sub Throw(ByVal msg)
        If Left(msg,1) = ":" Then
            If o_err.Exists(Mid(msg,2)) Then msg = o_err(Mid(msg,2))
        End If
        Easp.W ShowMsg(msg,0)
    End Sub
    Public Sub Defined()
        dim key
        If Easp.Has(o_err) Then
            For Each key In o_err
                Easp.Wn key & " : " & o_err(key)
            Next
        End If
    End Sub
    Private Function ShowMsg(ByVal msg, ByVal t)
        dim s,x
        s = "<fieldset id=""easpError""" & Easp.IfThen(Easp.Has(s_css)," class=""" & s_css & """") & ">" & vbCrLf
        s = s & "    <legend>" & s_title & "</legend>" & vbCrLf
        s = s & "    <p class=""msg"">" & msg & "</p>" & vbCrLf
        x = Easp.IIF(s_url = "javascript:history.go(-1)", "返回", "继续")
        If t = 1 Then
            If Err.Number<>0 Then
                s = s & "    <ul class=""dev"">" & vbCrLf
                s = s & "        <li class=""info"">以下信息针对开发者：</li>" & vbCrLf
                s = s & "        <li>错误代码：0x" & Hex(Err.Number) & "</li>" & vbCrLf
                s = s & "        <li>错误描述：" & Err.Description & "</li>" & vbCrLf
                s = s & "        <li>错误来源：" & Err.Source & "</li>" & vbCrLf
                s = s & "    </ul>" & vbCrLf
            End If
        Else
            If b_redirect Then
                s = s & "    <p class=""back"">页面将在" & i_delay/1000 & "秒钟后跳转，如果浏览器没有正常跳转，<a href=""" & s_url & """>请点击此处" & x & "</a></p>" & vbCrLf
                s_url = Easp.IIF(Left(s_url,11) = "javascript:", Mid(s_url,12), "location.href='" & s_url & "';")
                s = s & Easp.JsCode("setTimeout(function(){" & s_url & "}," & i_delay & ");")
            Else
                s = s & "    <p class=""back""><a href=""" & s_url & """>请点击此处" & x & "</a></p>" & vbCrLf
            End If
        End If
        s = s & "</fieldset>" & vbCrLf
        ShowMsg = s
    End Function
End Class
%>