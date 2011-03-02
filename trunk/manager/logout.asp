<%
    '--------------------------
    ' * 用户登出
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
%>
<!--#include file="../config.asp" -->
<%
    Session.Abandon()
    
    Easp.AlertUrl "登出成功！", "login.asp"
%>
