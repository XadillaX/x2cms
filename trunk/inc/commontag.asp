<%
	'--------------------------
	' * 通用标签文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	Sub CommonTags()
		Easp.Tpl "__webname__", Title						' 网站名称标签
		Easp.Tpl "__root__", Root							' 网站根目录标签
		Easp.Tpl "__skinpath__", Easp.tpl.FilePath			' 皮肤目录标签
		Easp.Tpl "__viscount__", VisCount					' 站点计数器
	End Sub
%>