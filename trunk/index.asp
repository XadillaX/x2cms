<!--#include file="config.asp" -->
<%
	'--------------------------
	' * 首页文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------

	if Easp.Get("p:s") = "" then
		Easp.Tpl.Load tpl_index
		Easp.Tpl "__title__", "首页"
		
		CommonTags()
	else
		dim type_rs 
		set type_rs = Easp.db.GRD("type", "typeurl='" & Easp.CheckForm(Easp.Get("p:s"), "", 1, "非法参数！") & "'")
		' echo Easp.CheckForm(Easp.Get("p:s"), "", 1, "非法参数！")
		
		' 若此页面存在
		if Easp.Has(type_rs) then
			' 若是单页
			if type_rs("page") then
				' 载入单页特有参数
				Easp.Tpl "__pagecode__", type_rs("pagecode")
			
				' 载入单页模板
				Easp.Tpl.Load tpl_single_page
			else
				' 载入文章目录模板
				Easp.Tpl.Load tpl_art_list
			end if
		
			' 若有指定模板
			if type_rs("tpl") <> "" then 
				Easp.Tpl.Load type_rs("tpl")			' 载入特殊模板
			end if
			
			' 载入子目录
			dim ch_type_rs
			set ch_type_rs = Easp.db.GR("type", "father=" & type_rs("tid"), "ord asc")
			if Easp.Has(ch_type_rs) then
				while not ch_type_rs.EOF
					Easp.Tpl "__chnav__.type", ch_type_rs("type")
					Easp.Tpl "__chnav__.count", ch_type_rs("count")
					Easp.Tpl "__chnav__.ord", ch_type_rs("ord")
					Easp.Tpl "__chnav__.pagecode", ch_type_rs("pagecode")
					Easp.Tpl "__chnav__.url", Root & "\?p=" & ch_type_rs("typeurl")
					
					ch_type_rs.MoveNext
					Easp.Tpl.Update "__chnav__"
				wend
			end if
			
			' 导航字符串
			dim f_type_rs, map_str
			map_str = ""
			f_type_rs = type_rs
			' echo f_type_rs("father")
			while cstr(f_type_rs("father")) <> cstr(-1)
				map_str = " » <a href='" & Root & "\?p=" & f_type_rs("typeurl") & "'>" & f_type_rs("type") & "</a>" & map_str
				f_type_rs = Easp.db.GRD("type", "tid=" & f_type_rs("father"))
			wend
			map_str = "<a href='" & Root & "\?p=" & f_type_rs("typeurl") & "'>" & f_type_rs("type") & "</a>" & map_str
			Easp.Tpl "__mapstr__", map_str
			
			' 载入通用标签
			CommonTags()
		else
			Easp.Alert "404错误：页面不存在！"
			' echo Easp.CheckForm(Easp.Get("p:s"), "", 1, "非法参数！")
		end if
	end if
	
	Easp.Tpl.Show()
%>
