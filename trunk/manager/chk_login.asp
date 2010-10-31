<%
	'--------------------------
	' * 登录验证
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="../config.asp" -->
<%
	dim Username, Password, vCode, rs
	Username = Easp.CheckForm(Easp.Post("admin:s"), "username", 1, "会员名不能为空！:不是有效的会员名！")
	Password = Easp.CheckForm(Easp.Post("pwd:s"), "", 1, "密码不能为空！")
	vCode = Easp.CheckForm(Easp.Post("yzm:s"), "", 1, "验证码不能为空！")
	
	if Session(VCodeSession) <> vCode then
		Easp.Alert "错误的验证码！"
	end if
	
	Password = LCase(md5(Password))
	set rs = Easp.db.GRD("admin", "username='" & Username & "' AND password='" & Password & "'")
	if Easp.Has(rs) = false then
		' 写入日志
		Easp.db.AR "admin_log", Array("username:" & Username, "logtext:" & "以错误的用户名或者密码尝试登录。", "time:" & Now(), "ip:" & realip)
		Easp.Alert "错误的用户名或者密码！"
	else
		dim aid, LoginTime, LoginIP
		aid = rs("aid")
		LoginTime = Now()				' 获取时间
		LoginIP = realip				' realip是EasyIDE的全局变量
		result = Easp.db.UR("admin", "aid=" & aid, Array( "logintime:" & LoginTime, "loginip:" & LoginIP ))
		if result <> false then
			' 写入日志
			Easp.db.AR "admin_log", Array("username:" & Username, "logtext:" & "登录成功。", "time:" & Now(), "ip:" & realip, "right:true")
			Session(SessionPre & "admin_logined") = true
			Session(SessionPre & "admin_username") = Username
			Session(SessionPre & "admin_logintime") = rs("logintime")
			Session(SessionPre & "admin_acttime") = Now()
			Session(SessionPre & "admin_loginip") = rs("loginip")
			Session(SessionPre & "admin_type") = rs("superadmin")
			Easp.RR "index.asp"
		else
			Easp.Alert "数据库写入错误！"
		end if
	end if
%>