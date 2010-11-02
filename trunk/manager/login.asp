<%
	'--------------------------
	' * 管理登陆
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="../config.asp" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台登录</title>
<link href="style/base.css" rel="stylesheet" type="text/css" />
<link href="style/login.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="style/font.css">
<script language="JavaScript" type="text/javascript" src="../js/easyui/jquery-1.4.2.min.js"></script>
<script type="text/javascript">    
    if (document.addEventListener)   
    {//如果是Firefox    
        document.addEventListener("keypress", fireFoxHandler, true);    
    } else 
    {    
        document.attachEvent("onkeypress", ieHandler);    
    }    
    function fireFoxHandler(evt)   
    {    
        //alert("firefox");    
        if (evt.keyCode == 13)   
        {    
            document.forms[0].submit();    
        }    
    }    
    function ieHandler(evt)   
    {    
        //alert("IE");    
        if (evt.keyCode == 13)   
        {    
            document.forms[0].submit();    
        }    
    }   
	
$(function(){
	$("#vcode_img").click(function(){
		$(this).attr("src", "/cls/vcode.class.asp?" + Math.random());	
	})
});
</script>
</head>
<body>
<div class="login_box bg_1">
  <form name="form1" method="post" action="chk_login.asp">
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="bg_1">
      <tr>
        <td height="293">&nbsp;</td>
        <td width="587" height="293"><table width="587" height="" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="167" class=" bg_167">&nbsp;</td>
            </tr>
            <tr>
              <td class=" bg_39">&nbsp;</td>
            </tr>
            <tr>
              <td valign="top" class=" bg_87"><table border="0" align="center" cellpadding="0" cellspacing="0" style="margin:0 auto">
                  <tr>
                    <td width="110" class="yy"><span class="f12_white">用户名：</span></td>
                    <td width="110" class="yy"><span class="f12_white">密码：</span></td>
                    <td width="100" class="yy"><span class="f12_white">验证码：</span></td>
                    <td width="90" class="yy">&nbsp;</td>
                    <td width="110" class="yy">&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="25"><label>
                        <input name="admin" type="text" class="text_box" id="admin" style="background-image:url(images/text_bg01.gif); background-position:center" size="20" maxlength="8">
                      </label></td>
                    <td><label>
                        <input name="pwd" type="password" class="text_box" id="pwd" style="background-image:url(images/text_bg02.gif)" size="20" maxlength="8">
                      </label></td>
                    <td><label>
                        <input name="yzm" type="text" class="text_box" id="yzm" style="background-image:url(images/text_bg03.gif)" size="20" maxlength="8">
                      </label></td>
                    <td><img title="点击以刷新" style="cursor: pointer;" id="vcode_img" src="/cls/vcode.class.asp?time=<%=Now()%>" height="20" /></td>
                    <td><img src="images/dr_btn.gif" width="63" height="22" onClick="document.form1.submit()" /></td>
                  </tr>
                </table>
                  <p style="text-align: center;"><%=sys_name%>&nbsp;<%=sys_ver%>. <a href="<%=sys_web%>"><%=sys_author%></a> &copy; 2008 - 2011 All rights resvered.<br /></p></td>
            </tr>
          </table></td>
        <td valign="middle">&nbsp;</td>
      </tr>
    </table>
  </form>
</div>
</body>
</html>
