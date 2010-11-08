<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=PageTitle%></title>

<link href="style/link.css" rel="stylesheet" type="text/css" />
<link href="style/font.css" rel="stylesheet" type="text/css" />
<link href="style/base.css" rel="stylesheet" type="text/css" />
<link href="style/user.css" rel="stylesheet" type="text/css" />
<link href="style/newstyle.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="../js/json2.js"></script>
<script language="JavaScript" type="text/javascript" src="../js/easyui/jquery-1.4.2.min.js"></script>
<script language="JavaScript" type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>
<script charset="utf-8" language="JavaScript" type="text/javascript" src="../js/kindeditor/kindeditor.js"></script>
<link rel="stylesheet" type="text/css" href="../js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css">
</head>
<body>
<script type="text/javascript">
$(function(){
	$(".table_row").hover(
		function() {
			$(this).attr("bgclr", $(this).css("background-color"));
			$(this).css("background-color", "#E1F9FF");
		},
		
		function() {
			$(this).css("background-color", $(this).attr("bgclr"));
		}
	);
});

function GoURL(url) {
	window.location.href = url;
}
</script>
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="32" background="images/subMenu_bg.gif"  style=" line-height:32px">
    	<div class="l">
    		<div class="mainMenu"><%=PageTitle%></div>
    	</div>
    </td>
  </tr>
</table>
<!---->
<table width="100%" border="0" class="bg1 mytable round_angle15">
	<tr>
		<td width="241" height="25"  style="padding-left:10px; line-height:32px">
        	<span class="f14_gold14">
			<%if Session(SessionPre & "admin_type")=true then%>
            超级管理员
            <%end if%>
            </span>
            <span class="f14_blue"><%=session(SessionPre & "admin_username")%></span>,您好！
        </td>
        <td width="519" align="right"  style="padding-left:10px; line-height:32px">&nbsp;&nbsp;&nbsp;&nbsp;<span class="f14">您上次登录的时间：</span><span class=" f14_blue"><%=Session(SessionPre & "admin_logintime")%></span></span>&nbsp;&nbsp;IP：<span class="f14_blue"><%=Session(SessionPre & "admin_loginip")%></span>&nbsp;&nbsp;&nbsp;&nbsp;
        </td>
    </tr>
</table>
<!---->