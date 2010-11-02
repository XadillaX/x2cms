<%
	'--------------------------
	' * 系统常量确定
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	' 检查数据来源，若不是则警告且返回
	Easp.CheckDataFromA()

	' 读取POST数据
	dim Pwebname, Proot, Pskin, Pviscount
	dim Pwebtitle, Pkeyword, Pdescription, Pcountcode
	dim sqlstr, sqlarr
	Pwebname = Easp.post("webname:s")
	Proot = Easp.post("root:s:http://localhost")
	Pskin = Easp.post("skin:s:default")
	Pviscount = Easp.post("viscount:n:0")
	Pwebtitle = Easp.post("webtitle:s")
	Pkeyword = Easp.post("keyword:s")
	Pdescription = Easp.post("description:s")
	Pcountcode = Easp.post("countcode:s")
	
	sqlarr = Array("webname:" & Pwebname, "root:" & Proot, "skin:" & Pskin, "viscount:" & Pviscount, "webtitle:" & Pwebtitle, "keyword:" & Pkeyword, "description:" & Pdescription, "countcode:" & Pcountcode)
	
	' 写入数据
	if Easp.db.UR("config", "id=1", sqlarr) = 1 then
		' 写入日志
		sqlstr = Easp.HtmlEncode(Easp.db.wUR("config", "id=1", sqlarr))
		Easp.db.AR "admin_log", Array("username:" & Username, "logtext:" & "更新站点配置：SQL(" & sqlstr & ")。", "time:" & Now(), "ip:" & realip, "right:true")
		
		Easp.Alert "配置修改成功！"
	else
		sqlstr = Easp.HtmlEncode(Easp.db.wUR("config", "id=1", sqlarr))
		Easp.db.AR "admin_log", Array("username:" & Username, "logtext:" & "更新站点配置：SQL(" & sqlstr & ")。", "time:" & Now(), "ip:" & realip)
		
		Easp.Alert "配置修改失败！"		
	end if
%>
