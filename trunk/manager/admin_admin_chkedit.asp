<%
	'--------------------------
	' * 管理员修改
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	dim action, id, un, pwd, cfmpwd, sup, code, ncode, flag
	action = Easp.CheckForm(Easp.Get("action:s"), "", 1, "错误的指向连接。")
	
	select case action
		case "add"							' 增加管理员
			' 验证输入合法性
			un = Easp.CheckForm(Easp.Post("username:s"), "username", 1, "错误的用户名！")
			pwd = Easp.CheckForm(Easp.Post("password:s"), "", 1, "请输入密码！")
			cfmpwd = Easp.CheckForm(Easp.Post("cfmpwd:s"), "", 1, "请输入确认密码！")
			sup = Easp.CheckForm(Easp.Post("RadioGroup1:s"), "", 1, "请选择正确权限组！")
			if str_len(pwd) < 5 or str_len(pwd) > 16 then Easp.Alert "密码长度必须介于5~16位！"
			if pwd <> cfmpwd then Easp.Alert "两次输入密码不同！"
			result = Easp.db.RT("admin", Array("username:" & un), "username")
			if result <> "" then
				Easp.Alert "已存在的管理员！"
			end if
			
			' 写入数据库
			result = Easp.db.AR("admin", Array("username:" & un, "password:" & md5(pwd), "superadmin:" & iif(sup = "Superadmin", true, false)))
			if result = 0 then 
				code = "数据库错误！"
				ncode = "添加管理员：数据库错误。"
				flag = false
			else
				code = "管理员添加成功！"
				ncode = "添加管理员 " & un & " ：成功。"
				flag = true
			end if
			
			SetLog Username, ncode, flag
			Easp.Alert code
			
		case "edit"							' 修改管理员
			' 验证输入合法性
			id = Easp.CheckForm(Easp.Post("aid:n"), "", 1, "非法提交！")
			un = Easp.CheckForm(Easp.Post("un:s"), "username", 1, "非法提交！" & Easp.Post("un:s"))
			
			' 若修改密码
			if str_len(pwd) <> 0 and str_len(cfmpwd) <> 0 then
				pwd = Easp.CheckForm(Easp.Post("password:s"), "", 1, "请输入密码！")
				cfmpwd = Easp.CheckForm(Easp.Post("cfmpwd:s"), "", 1, "请输入确认密码！")
				if str_len(pwd) < 5 or str_len(pwd) > 16 then Easp.Alert "密码长度必须介于5~16位！"
				if pwd <> cfmpwd then Easp.Alert "两次输入密码不同！"
			end if
			sup = Easp.CheckForm(Easp.Post("RadioGroup2:s"), "", 1, "请选择正确权限组！")
			
			if str_len(pwd) <> 0 and str_len(cfmpwd) <> 0 then
				result = Easp.db.UR("admin", "aid=" & id, Array("password:" & md5(pwd), "superadmin:" & iif(sup = "Superadmin", true, false)))
			else
				result = Easp.db.UR("admin", "aid=" & id, Array("superadmin:" & iif(sup = "Superadmin", true, false)))
			end if
			
			if result = 0 then 
				code = "数据库错误！"
				ncode = "修改管理员：数据库错误。"
				flag = false
			else
				code = "管理员修改成功！"
				ncode = "修改管理员 " & un & " ：成功。"
				flag = true
			end if
			
			SetLog Username, ncode, flag
			Easp.Alert code
			
		case "del"							' 删除管理员
			' 验证输入合法性
			id = Easp.CheckForm(Easp.Post("aid:n"), "", 1, "非法提交！")
			
			result = Easp.db.DR("admin", "aid=" & id)
			if result = 0 then
				code = "数据库错误！"
				ncode = "删除管理员：数据库错误。"
				flag = false
			else
				code = "管理员删除成功！"
				ncode = "删除管理员：ID" & id & "成功。"
				flag = true
			end if
			
			SetLog Username, ncode, flag
			Easp.Alert code
			
		case else
			Easp.Alert "错误的指令！"
	end select
%>