<!--#include virtual="config.asp" -->
<%
	'--------------------------
	' * 首页文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	Easp.Tpl.Load "index.tpl"
	CommonTags()
	
	Easp.Tpl "__title__", "首页"
	
	Easp.Tpl.Show()
%>
