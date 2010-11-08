<%
	'--------------------------
	' * 管理员函数文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	' 写入日志
	sub SetLog(username, text, rt)
		Easp.db.AR "admin_log", Array("username:" & username, "logtext:" & text, "time:" & Now(), "ip:" & realip, "right:" & iif(rt = true, "true", "false"))
	end sub
	
	' 递归获取栏目table
	function AdminType_GetThisType(rs, lay)
		dim class_str : class_str = "table_row_clr_2"
		dim i, cnt : cnt = 0
		dim rst

		rst = rst & "<tr class='table_row " & class_str &"'>"
		rst = rst & "<td width='6%' valign='middle'>" & rs("tid") & "</td>"
		rst = rst & "<td width='35%' valign='middle'>"
		
		for i = 1 to lay - 1
			rst = rst & "<span class='fl'>┇&nbsp;&nbsp;</span>"
		next
		if lay <> 0 then rst = rst & "<span class='fl'>" & lay & "__pendding__━&nbsp;</span>"
		
		rst = rst & "<div class='fl' style='text-align: left;'>[<input style='border-bottom: 1px solid #000;' type='text' name='type' value='" & rs("type") & "' />]</div><div class='cl'></div></td>"
		
		rst = rst & "<td width='15%' valign='middle'>"
		rst = rst & "<input onclick=""GoURL('admin_content_content.asp?action=add&tid=" & rs("tid") & "')"" style='border: none; cursor: pointer; background: none; color: #ff7800;' value='添加' type='button' />"
		rst = rst & "/"
		rst = rst & "<input onclick=""" & iif(not rs("page"), "type_edit", "type_edit_page") & "('" & rs("tid") & "')"" style='border: none; cursor: pointer; background: none; color: #ff7800;' value='编辑' type='button' />"
		rst = rst & "/" 
		rst = rst & "<input onclick=""type_del('" & rs("tid") & "', '" & rs("type") & "', '" & rs("count") & "');"" style='border: none; cursor: pointer; background: none; color: #ff7800;' value='删除' type='button' />"
		rst = rst & "</td>"
		rst = rst & "<td width='7%' valign='middle'>" & iif(rs("page") = true, "单页", "文章") & "</td>"
		rst = rst & "<td width='7%' valign='middle'>" & iif(rs("page") = true, "-", rs("count")) & "</td>"
		rst = rst & "<td width='22%' valign='middle'>" & rs("typeurl") & "</td>"
		rst = rst & "<td width='8%' valign='middle'>" & rs("ord") & "</td>"
		rst = rst & "</tr>"

		dim type_rs
		set type_rs = Easp.db.GR("type", "father=" & rs("tid"), "ord asc")
		while not type_rs.EOF
			rst = rst & AdminType_GetThisType(type_rs, lay + 1)
			cnt = cnt + 1
			type_rs.MoveNext()
			
			if not type_rs.EOF then
				rst = str_replace("(" & lay + 1 & "__pendding__)", rst, "┇")
			else
				rst = str_replace("(" & lay + 1 & "__pendding__)", rst, "┇")
			end if
		wend
		
		AdminType_GetThisType = rst
	end function
	
	' 递归获取栏目option
	function AdminType_GetThisType_Select(rs, lay, selected)
		dim class_str : class_str = "table_row_clr_2"
		dim i, cnt : cnt = 0
		dim rst
		
		rst = rst & "<!--" & selected & rs("tid") & "--><option count=" & rs("count") & " class='sel_" & rs("tid") & "' " & iif(cstr(rs("tid")) = cstr(selected), "selected", "") & " value='" & rs("tid") & "'>"
		
		for i = 1 to lay - 1
			rst = rst & "┇&nbsp;&nbsp;"
		next
		if lay <> 0 then rst = rst & "" & lay & "__pendding__━&nbsp;"
		
		rst = rst & rs("type")
		
		rst = rst & "</option>"
		
		dim type_rs
		set type_rs = Easp.db.GR("type", "father=" & rs("tid"), "ord asc")
		while not type_rs.EOF
			rst = rst & AdminType_GetThisType_Select(type_rs, lay + 1, selected)
			cnt = cnt + 1
			type_rs.MoveNext()
			
			if not type_rs.EOF then
				rst = str_replace("(" & lay + 1 & "__pendding__)", rst, "┇")
			else
				rst = str_replace("(" & lay + 1 & "__pendding__)", rst, "┇")
			end if
		wend
		
		AdminType_GetThisType_Select = rst
	end function
	
	sub AdminType_LineAction(tid, sField, operator)
		dim sqlstr
		' echo tid
		while cstr(tid) <> cstr(-1)
			sqlstr = "update [type] set [" & sField & "] = [" & sField & "] " & operator & " where tid=" & tid
			Easp.db.Exec sqlstr
			
			tid = Easp.db.RT("type", "tid=" & tid, "father")
		wend
	end sub
	
' 截取字符串
function gotTopic(str,strlen)
 if str="" then
  gotTopic=""
  exit function
 end if
 dim l,t,c, i
 str=replace(replace(replace(replace(str,"&nbsp;"," "),"&quot;",chr(34)),"&gt;",">"),"&lt;","<")
 l=len(str)
 t=0
 for i=1 to l
  c=Abs(Asc(Mid(str,i,1)))
  if c>255 then
   t=t+2
  else
   t=t+1
  end if
  if t>=strlen then
   gotTopic=left(str,i) & "..."
   exit for
  else
   gotTopic=str
  end if
 next
 gotTopic=replace(replace(replace(replace(gotTopic," ","&nbsp;"),chr(34),"&quot;"),">","&gt;"),"<","&lt;")
end function
%>
