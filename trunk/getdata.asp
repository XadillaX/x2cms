<!--#include file="config.asp" -->
<%
	'--------------------------
	' * 获取数据
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	dim action : action = Easp.CheckForm(Easp.Get("action:s"), "", 1, "错误的页面！")
	dim text : text = ""
	
	dim content_rs, ptid
	
	select case action
		case "flash_xml"
			ptid = Easp.CheckForm(Easp.Get("tid:n:-1"), "", 0, "错误的栏目！")
			
			set content_rs = get_art_list(ptid, 5, "幻灯")
			text = "<?xml version=""1.0"" encoding=""utf-8""?>"
			text = text & "<slider>"
			while not content_rs.Eof
				text = text & "<item href="""
				text = text & iif(content_rs("url") <> "", content_rs("url"), Root & "\content.asp?id=" & content_rs("cid"))
				text = text & """ title="""
				text = text & content_rs("title")
				text = text & """ imageurl="""
				text = text & content_rs("picurl")
				text = text & """ />"
			
				content_rs.MoveNext
			wend
			text = text & "</slider>"
			
			echo text
	end select
%>