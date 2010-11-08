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
	dim action, pcid, ptid, ptitle, pcontent, psource, ptime, phit, purl, ptitlecolor, ppicurl, pauthor, pistj, pisflash, pispic, pistjstr, pisflashstr, pispicstr
	dim type_rs, data_arr, data_result
	
	ptid = Easp.CheckForm(Easp.Post("tid:n"), "", 1, "请选择正确栏目！")
	ptitle = Easp.CheckForm(Easp.Post("title:s"), "", 1, "请输入文章标题！")
	pcontent = Easp.CheckForm(Easp.Post("content:s"), "", 0, "错误的文章内容！")
	psource = Easp.CheckForm(Easp.Post("source:s"), "", 0, "错误的来源。")
	ptime = Now()
	phit = 0
	purl = Easp.CheckForm(Easp.Post("url:s"), "url", 0, "错误的地址！")
	ptitlecolor = Easp.CheckForm(Easp.Post("titlecolor:s"), "", 0, "错误的颜色！")
	
	pistjstr = Easp.CheckForm(Easp.Post("istj:s:off"), "", 1, "错误的推荐选项！")
	pisflashstr = Easp.CheckForm(Easp.Post("isflash:s:off"), "", 1, "错误的幻灯选项！")
	pispicstr = Easp.CheckForm(Easp.Post("ispic:s:off"), "", 1, "错误的图片选项！")
	
	pistj = iif(pistjstr = "on", "true", "false")
	pisflash = iif(pisflashstr = "on", "true", "false")
	pispic = iif(pispicstr = "on", "true", "false")
	if pispic then
		ppicurl = Easp.CheckForm(Easp.Post("picurl:s"), "", 1, "请输入图片地址！")
	else
		ppicurl = ""
	end if
	pauthor = Username
	
	' 判断数据正确性
	set type_rs = Easp.db.GRD("type", "tid=" & ptid)
	if not Easp.Has(type_rs) then Easp.Alert "错误的栏目！"
	
	' 根据不同Action进行操作
	action = Easp.CheckForm(Easp.Get("action:s"), "", 1, "非法操作！")
	select case action
		case "add"
			data_arr = array("tid:" & (ptid), "title:" & (ptitle), "content:" & (pcontent), "source:" & (psource), "time:" & (ptime), "hit:" & (phit), "url:" & (purl), "titlecolor:" & (ptitlecolor), "picurl:" & (ppicurl), "author:" & (pauthor), "istj:" & (pistj), "isflash:" & (pisflash), "ispic:" & (pispic))
			
			'echo ptid & endl & ptitle & endl & pcontent & endl & psource & endl & ptime & endl & phit & endl & purl & endl & ptitlecolor & endl & ppicurl & endl & pauthor & endl & pistj & endl & pisflash & endl & pispic & endl
			
			'dim w_w : w_w = Easp.db.wAR("type", data_arr)
			'echo w_w & endl
			
			data_result = Easp.db.AR("content", data_arr)
			
			if data_result = 1 then
				AdminType_LineAction ptid, "count", "+ 1"
			
				Easp.Alert "文章添加成功！"
				SetLog Username, "文章添加成功。", flag
			else
				SetLog Username, "文章添加失败：数据库错误。", flag
			end if
		case else
			Easp.Alert "非法操作！"
	end select
%>
