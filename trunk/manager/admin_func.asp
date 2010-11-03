<%
	'--------------------------
	' * 管理员函数文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	sub SetLog(username, text, rt)
		Easp.db.AR "admin_log", Array("username:" & username, "logtext:" & text, "time:" & Now(), "ip:" & realip, "right:" & iif(rt = true, "true", "false"))
	end sub
	
	function AdminType_GetThisType(rs, lay)
		dim class_str : class_str = "table_row_clr_2"
		dim i, cnt : cnt = 0
		dim rst
	
		rst = "<tr class='table_row " & class_str &"'>"
		rst = rst & "<td width='6%' valign='middle'>" & rs("tid") & "</td>"
		rst = rst & "<td width='35%' valign='middle'>"
		
		for i = 1 to lay - 1
			rst = rst & "<span class='fl'>┃&nbsp;&nbsp;</span>"
		next
		if lay <> 0 then rst = rst & "<span class='fl'>" & lay & "__pendding__━&nbsp;</span>"
		
		rst = rst & "<div class='fl' style='text-align: left;'>[" & rs("type") & "]</div><div class='cl'></div></td>"
		
		rst = rst & "<td width='15%' valign='middle'>编辑 / 删除</td>"
		rst = rst & "<td width='7%' valign='middle'>单页</td>"
		rst = rst & "<td width='7%' valign='middle'>统计</td>"
		rst = rst & "<td width='22%' valign='middle'>GET值</td>"
		rst = rst & "<td width='8%' valign='middle'>排序</td>"
		rst = rst & "</tr>"
		
		dim type_rs
		set type_rs = Easp.db.GR("type", "father=" & rs("tid"), "ord asc")
		while not type_rs.EOF
			rst = rst & AdminType_GetThisType(type_rs, lay + 1)
			cnt = cnt + 1
			type_rs.MoveNext()
			
			if not type_rs.EOF then
				rst = str_replace("(" & lay + 1 & "__pendding__)", rst, "┣")
			else
				rst = str_replace("(" & lay + 1 & "__pendding__)", rst, "┗")
			end if
		wend
		
		AdminType_GetThisType = rst
	end function
%>