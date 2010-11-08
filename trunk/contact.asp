<!--#include file="config.asp" -->
<%
	'--------------------------
	' * 首页文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	Easp.Tpl.Load tpl_contact
	CommonTags()
	
	Easp.Tpl "__title__", "联系我们"
	
	Easp.Tpl.Show()
%>
