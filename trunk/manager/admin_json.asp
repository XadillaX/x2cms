<%
	'--------------------------
	' * 获取JSON页面
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	if Easp.Get("action:s") = "type_get_info" then
		' 获取单个栏目JSON
		dim tid : tid = Easp.Get("tid:n")
		dim json_rs 
		set json_rs = Easp.db.GR("type", Array("tid:" & tid), "")
		if Easp.Has(json_rs) then
			echo Easp.db.Json(json_rs, "type")
		else
			echo "Wrong"
		end if
	end if
%>
