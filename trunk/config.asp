<%
	'--------------------------
	' * 主配置文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include virtual="inc/easp/easp.asp" -->
<!--#include virtual="inc/easyide.asp" -->
<%
	Easp.Use "tpl"
	Easp.Use "Xml"
	
	dim WebPath, DBFile, SkinPath, VCodeSession, SessionPre, AdminPath
	WebPath		=	"/"											' 网站绝对路径
	DBFile		=	"data/database.mdb"							' 数据库相对路径
	SkinPath	=	"templates/"								' 模板文件夹相对路径
	VCodeSession=	"x2cms_vcode"								' 验证码Session
	SessionPre	=	"x2cms_xcoder_"								' Session前缀
	AdminPath	=	WebPath & "manager/"						' 管理员目录
%>
<!--#include virtual="conn.asp" -->
<!--#include virtual="inc/commonvar.asp" -->
<!--#include virtual="inc/commontag.asp" -->
