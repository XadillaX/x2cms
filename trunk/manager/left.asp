<%
	'--------------------------
	' * 网站后台菜单
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/link.css" rel="stylesheet" type="text/css" />
<link href="style/font.css" rel="stylesheet" type="text/css" />
<link href="style/left.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.3.2.min.js"></script>
<script language="JavaScript" type="text/javascript" src="js/left.js"></script>
<title>网站后台菜单</title>
</head>
<body>
<div class="accordion">
	<!--<h3>标题</h3>
	<ul>
		<li><img src="images/icon/arrow_136.gif" alt="" width="9" height="9" class="small_icon"/> <a href="add_user.asp" target="BoardList">栏目</a></li>
	</ul>
	-->
	
	<%
		if SuperAdmin then
	%>
	<h3>系统管理</h3>
	<ul>
    	<li><img src="images/icon/arrow_136.gif" alt="" width="9" height="9" class="small_icon"/> <a href="main.asp" target="BoardList">管理首页</a></li>
		<li><img src="images/icon/arrow_136.gif" alt="" width="9" height="9" class="small_icon"/> <a href="admin_config.asp" target="BoardList">站点配置</a></li>
        <li><img src="images/icon/arrow_136.gif" alt="" width="9" height="9" class="small_icon"/> <a href="admin_contact.asp" target="BoardList">联系资料</a></li>
        <li><img src="images/icon/arrow_136.gif" alt="" width="9" height="9" class="small_icon"/> <a href="admin_log.asp" target="BoardList">操作日志</a></li>
	</ul>
    <h3>管理员管理</h3>
	<ul>
		<li><img src="images/icon/arrow_136.gif" alt="" width="9" height="9" class="small_icon"/> <a href="admin_admin.asp" target="BoardList">管理员列表</a></li>
	</ul>
	<%
		end if
	%>
    <h3>内容管理</h3>
	<ul>
    	<li><img src="images/icon/arrow_136.gif" alt="" width="9" height="9" class="small_icon"/> <a href="admin_type.asp" target="BoardList">栏目管理</a></li>
	</ul>
    <h6>艾克视图工作室 <%=sys_pubdate%></h6>
</div>
</body>
</html>
