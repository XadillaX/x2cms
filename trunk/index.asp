<!--#include file="config.asp" -->
<%
	'--------------------------
	' * 首页文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	CommonTags()
	
	if Easp.Get("p:s") = "" then
		Easp.Tpl.Load tpl_index
		Easp.Tpl "__title__", "首页"
	else
		dim type_rs 
		set type_rs = Easp.db.GRD("type", "typeurl='" & Easp.CheckForm(Easp.Get("p:s"), "", 1, "非法参数！") & "'")
		' echo Easp.CheckForm(Easp.Get("p:s"), "", 1, "非法参数！")
		
		if Easp.Has(type_rs) then
			if type_rs("page") then
				' 载入单页特有参数
				Easp.Tpl "__pagecode__", type_rs("pagecode")
			
				Easp.Tpl.Load tpl_single_page
			elseif not type_rs("page") then
				Easp.Tpl.Load tpl_art_list
			end if
		
			if type_rs("tpl") <> "" then 
				Easp.Tpl.Load type_rs("tpl")			' 载入特殊模板
			end if
		else
			Easp.Alert "404错误：页面不存在！"
			' echo Easp.CheckForm(Easp.Get("p:s"), "", 1, "非法参数！")
		end if
	end if
	
	Easp.Tpl.Show()
%>
