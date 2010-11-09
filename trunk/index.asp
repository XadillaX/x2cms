<!--#include file="config.asp" -->
<%
	'--------------------------
	' * 首页文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	dim tid, action
	action = Easp.Get("p:s")

	if action = "" then
		Easp.Tpl.Load tpl_index
		Easp.Tpl "__title__", "首页"
	else
		' 获取页面信息
		dim type_rs
		set type_rs = Easp.db.GRD("type", "typeurl='" & Easp.CheckForm(Easp.Get("p:s"), "", 1, "非法参数！") & "'")
		
		if Easp.Has(type_rs) then
			tid = type_rs("tid")
			' 判断页面类型
			if type_rs("page") then
				Easp.Tpl "__pagecode__", type_rs("pagecode")
				Easp.Tpl.Load tpl_single_page
			else
				Easp.Tpl.Load tpl_art_list
			end if
		
			' 若有指定模板
			if type_rs("tpl") <> "" then Easp.Tpl.Load type_rs("tpl")
			
			' 载入子目录标签
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
			while cstr(f_type_rs("father")) <> cstr(-1)
				map_str = " » <a href='" & Root & "\?p=" & f_type_rs("typeurl") & "'>" & f_type_rs("type") & "</a>" & map_str
				f_type_rs = Easp.db.GRD("type", "tid=" & f_type_rs("father"))
			wend
			map_str = "<a href='" & Root & "\?p=" & f_type_rs("typeurl") & "'>" & f_type_rs("type") & "</a>" & map_str
			Easp.Tpl "__mapstr__", map_str
			
			' 载入普通文章列表
			dim art_list, art_list_pager
			set art_list = get_art_list_by_page(type_rs("tid"), DefaultPageSize)
			art_list_pager = Easp.db.GetPager("default")
			' echo art_list_pager
			
			' 特有标签
			Easp.Tpl "__title__", type_rs("type")
			Easp.Tpl "__tid__", type_rs("tid")
			Easp.Tpl "__typeurl__", type_rs("typeurl")
			Easp.Tpl "__count__", type_rs("count")
			Easp.Tpl "__roottitle__", f_type_rs("type")
			Easp.Tpl "__roottid__", f_type_rs("tid")
			Easp.Tpl "__roottypeurl__", f_type_rs("typeurl")
			Easp.Tpl "__rootcount__", f_type_rs("count")
		else
			Easp.Alert "404错误：页面不存在！"
		end if
	end if
	
	' Flash幻灯片标签，若要自定义栏目以及长宽请在模板中请用ASP标签调用函数get_flash(栏目id, 宽, 高)
	Easp.Tpl "__flash__", get_flash(iif(action = "", -1, tid), 250, 250)
	
	' 载入通用标签
	CommonTags()
	Easp.Tpl.Show()
%>
