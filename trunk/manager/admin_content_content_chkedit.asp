<%
	'--------------------------
	' * 文章内容确定
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	' 检查数据来源，若不是则警告且返回
	Easp.CheckDataFromA()

	' 读取POST数据
	dim action, pcid, ptid, ptitle, pcontent, psource, ptime, phit, purl, ptitlecolor, ppicurl, pauthor, pistj, pisflash, pispic
	
	ptid = Easp.CheckForm(Easp.Post("tid:n"), "", 1, "请选择正确栏目！")
	ptitle = Easp.CheckForm(Easp.Post("title:s"), "", 1, "请输入文章标题！")
	pcontent = Easp.CheckForm(Easp.Post("content:s"), "", 0, "错误的文章内容！")
	psource = Easp.CheckForm(Easp.Post("source:s"), "", 0, "错误的来源。")
	ptime = Now()
	phit = 0
	purl = Easp.CheckForm(Easp.Post("url:s"), "url", 0, "错误的地址！")
	ptitlecolor = Easp.CheckForm(Easp.Post("titlecolor:s"), "", 0, "错误的颜色！")
	pistj = iif(Easp.CheckForm(Easp.Post("istj:s:off"), "", 1, "错误的推荐选项！") = "on", true, false)
	pisflash = iif(Easp.CheckForm(Easp.Post("isflash:s:off"), "", 1, "错误的幻灯选项！") = "on", true, false)
	pispic = iif(Easp.CheckForm(Easp.Post("ispic:s:off"), "", 1, "错误的图片选项！") = "on", true, false)s
	if pispic then
		ppicurl = Easp.CheckForm(Easp.Post("picurl:s"), "", 1, "请输入图片地址！")
	else
		ppicurl = ""
	end if
	pauthor = Username
	
	' 根据不同Action进行操作
	action = Easp.CheckForm(Easp.Get("action:s"), "", 1, "非法操作！")
	select case action
		case "add"
			
	end select
%>
