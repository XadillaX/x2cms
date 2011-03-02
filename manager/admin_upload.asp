<%
'==================================
'=文 件 名：upload.asp
'=
'=功    能：上传文件表单
'=作    者：新酷数据
'=日    期：2008-2-19 18:09
'=版    权：http://www.xksj.net
'=联系QQ：308588016 389057646
'==================================
%>
<!--#include file="admin_common.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
body { background: #eee; padding-top: 1px; font-size: 12px; }
</style>
</head>
<body topmargin="0" leftmargin="0" class="tablebody">
<form name="up" method="post" action="admin_upfile.asp" enctype="multipart/form-data"><input name="img" type="file" size="30">
&nbsp;<input type="submit" name="submit2" value="上传">
</form>
</body>
</html>
