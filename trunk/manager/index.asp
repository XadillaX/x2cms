<%
    '--------------------------
    ' * 管理大厅
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
%>
<!--#include file="admin_common.asp" -->
<html>
<head>
<meta NAME="GENERATOR" Content="Microsoft FrontPage 5.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href=style/font.css rel=STYLESHEET type=text/css>
<title>&copy;<%=sys_name%>&nbsp;<%=sys_ver%> - 后台管理中心</title>
<script language="JavaScript" type="text/javascript" src="js/open_btn.js"></script>
<link href="style/font.css" rel="stylesheet" type="text/css">
<link href="style/link.css" rel="stylesheet" type="text/css">
<link href="style/admin.css" rel="stylesheet" type="text/css">
</head>
<body scroll="no" style="MARGIN: 0px">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="24" background="images/head_01_bg.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td><img src="images/motif.gif" width="128" height="24"></td>
                <td width="20" valign="middle">&nbsp;</td>
                <td width="75"><a href="index.asp" class=""><div class="btn_81x22">后台主页</div></a></td>
              </tr>
            </table></td>
          <td width="10">&nbsp;</td>
          <td width="90"><a href="admin_chg_pwd.asp" target="BoardList" class=""><div class="btn_81x22">修改密码</div></a></td>
          <td width="100"><a href="logout.asp" class=""><div class="btn_81x22">退出系统</div></a></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td valign="middle"  style="background-image:url(images/banner.gif); background-repeat:no-repeat; height:85px; line-height:85px; background-color:#41b2fe;text-align:right">&nbsp;</td>
  </tr>
  <tr>
    <td height="11" background="images/head_02_bg.gif"></td>
  </tr>
  <tr>
    <td><table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
        <tr>
          <td id="frmTitle" name="frmTitle" nowrap valign="middle" align="center"><IFRAME id="BoardTitle" name="main" style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 188; Z-INDEX: 2" scrolling="auto" frameborder="0" src="left.asp"></IFRAME>
          <td valign="middle" background="images/middle_line_bg.gif" bgcolor="#CCCCCC" style="width:14px" onClick="switchSysBar()"><br>
            <table height="22" border="0" align="center" cellpadding="0" cellspacing="0" background="images/middle_btn_01.gif" style="width:14px" >
              <tr>
                <td align="center" style="height:100%"><span class="navPoint" id="switchPoint" title="关闭/打开左栏">3</span>
            </table></td>
          <td style="width:100%"><IFRAME id="frmright" name="BoardList" style="HEIGHT: 100%; VISIBILITY: inherit; WIDTH: 100%; Z-INDEX: 1;" scrolling="auto" frameborder="0" src="main.asp"></IFRAME>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="44" align="center" background="images/foot_bg.gif">
        <p>X2CMS 由 
        (艾克斯の編碼者:<a href="http://www.xcoder.in/">http://www.xcoder.in</a>)@(艾克视图：<a href="http://www.x2studio.net/">http://www.x2studio.net</a>) 开发
        </p>
    </td>
  </tr>
</table>
</body>
</html>