<%
	'--------------------------
	' * 通用变量
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	' 模板默认设置
	dim tpl_index, tpl_contact
	tpl_index = "index.tpl"
	tpl_contact = "contact.tpl"
	
	dim i, j, k
	dim result
	dim WebName, Root, Skin, VisCount, BeiAn, Copyright, WebTitle, MetaKeyword, MetaDescription, CountCode
	dim g_config_rs
	dim Contact_Info
	g_config_rs = Easp.db.GRD("config", "id=1")
	Contact_Info = Easp.db.GRD("contact", "cid=1")
	
	Easp.Tpl.AspEnable	=	true
	
	WebName				=	g_config_rs("webname")
	Root				=	g_config_rs("root")
	Skin				=	g_config_rs("skin")
	BeiAn				=	"<a href='http://www.miibeian.gov.cn/' target='_blank'>" & g_config_rs("beian") & "</a>"
	Copyright			=	g_config_rs("copyright") & "Powered by &copy;<a href='" & sys_web & "'>" & sys_name & "</a> " & sys_ver
	WebTitle			=	g_config_rs("webtitle")
	MetaKeyword			=	g_config_rs("keyword")
	MetaDescription		=	g_config_rs("description")
	CountCode			=	g_config_rs("countcode")
	
	VisCount			=	g_config_rs("viscount") + 1
	result = Easp.db.UR("config", "id=1", Array("viscount:" & VisCount))
	if result = 0 Then
		VisCount = VisCount - 1
	End If
	
	Easp.tpl.FilePath	=	WebPath & SkinPath & Skin
%>

<%
	' 模板设置
	if Easp.Fso.IsFile(Easp.tpl.FilePath & "define.asp") = true then
		ob_get_contents Easp.tpl.FilePath & "define.asp"
	end if
%>