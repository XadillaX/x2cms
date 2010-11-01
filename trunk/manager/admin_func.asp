<%
	'--------------------------
	' * 管理员函数文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	sub SetLog(username, text, rt)
		Easp.db.AR "admin_log", Array("username:" & username, "logtext:" & text, "time:" & Now(), "ip:" & realip, "right:" & iif(rt = true, "true", "false"))
	end sub
%>