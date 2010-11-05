<%
	'--------------------------
	' * 管理员通用页面
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="../config.asp" -->
<!--#include file="admin_func.asp" -->
<%
	dim SuperPages, PageName
	
	' 超级管理员相关设置
	SuperPages = Array()
	SuperPages = arr_push(SuperPages, AdminPath & "admin_admin.asp")
	SuperPages = arr_push(SuperPages, AdminPath & "admin_admin_chkedit.asp")
	SuperPages = arr_push(SuperPages, AdminPath & "admin_log.asp")
	SuperPages = arr_push(SuperPages, AdminPath & "admin_config.asp")
	SuperPages = arr_push(SuperPages, AdminPath & "admin_config_chk.asp")
	
	PageName = LCase(Easp.GetUrl(0))

	' 判断是否登录
	dim Logined, Username, LoginTime, LoginIP, aid, SuperAdmin
	SuperAdmin = Session(SessionPre & "admin_type")
	Logined = Session(SessionPre & "admin_logined")
	if not inull(Logined) then
		Username = Session(SessionPre & "admin_username")
		dim TempUsername, NowTime
		TempUsername = LCase(Easp.db.RT("admin", "username='" & Username & "'", "username"))
		aid = Easp.db.RT("admin", "username='" & Username & "'", "aid")
		if TempUsername <> Username or DateDiff("s", Now(), Session(SessionPre & "admin_acttime")) > AdminMaxTime then
			Logined = false
		end if
	else
		Logined = false
	end if
	
	' 如果未登录
	if Logined = false then
		if PageName <> AdminPath & "index.asp" and PageName <> AdminPath then
			Easp.db.AR "admin_log", Array("username:NULL", "logtext:" & "未登录用户尝试进入页面：<a href=" & Easp.GetUrl(1) & ">" & Easp.GetUrl(1) & "</a>。", "time:" & Now(), "ip:" & realip)
		end if
		
		Easp.AlertUrl "你尚未登录！", "login.asp"
	end if
	
	' 如果权限不足
	if arr_in(SuperPages, PageName) = True and Session(SessionPre & "admin_type") = False then
		' 写入日志
		Easp.db.AR "admin_log", Array("username:" & Username, "logtext:" & "尝试进入权限不足的页面：<a href=" & Easp.GetUrl(1) & ">" & Easp.GetUrl(1) & "</a>。", "time:" & Now(), "ip:" & realip)
		Easp.Alert "你不是超级管理员！"
	end if
	
	' 更新Session
	Session(SessionPre & "admin_acttime") = Now()
	
	' 遍历皮肤目录，并记录皮肤
	dim skin_folder : skin_folder = file_list(WebPath & SkinPath)
	dim fl
	dim SkinList(), SkinCount
	i = 0
	for each fl in split(skin_folder(0), "|")
		Redim Preserve SkinList(i)
		SkinList(i) = fl
		i = i + 1
	next
	SkinCount = i
	
	' 减少一个浏览量
	VisCount = Easp.db.RT("config", "id=1", "viscount") - 1
	result = Easp.db.UR("config", "id=1", Array("viscount:" & VisCount))
	if result = 0 Then
		VisCount = VisCount + 1
	End If
%>
