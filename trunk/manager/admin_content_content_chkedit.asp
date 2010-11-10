<%
    '--------------------------
    ' * 文章内容确定
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
    dim action, pcid, ptid, ptitle, pcontent, psource, ptime, phit, purl, ptitlecolor, ppicurl, pauthor, pistj, pisflash, pispic, pistjstr, pisflashstr, pispicstr
    dim type_rs, data_arr, data_result
    dim cid, content_rs
    
    ' 检查数据来源，若不是则警告且返回
    Easp.CheckDataFromA()
    
    ' 根据不同Action进行操作
    action = Easp.CheckForm(Easp.Get("action:s"), "", 1, "非法操作！")
    
    if action = "cyc" then
        cid = Easp.CheckForm(Easp.Get("cid:n"), "", 1, "非法操作！")
        set content_rs = Easp.db.GRD("content", "cid=" & cid)
        if not Easp.Has(content_rs) then 
            Easp.Alert "没有此文章信息！"
        end if
        
        result = Easp.db.UR("content", "cid=" & cid, array("cyc:" & iif(content_rs("cyc"), false, true)))
        if result = 1 then
            SetLog Username, "文章" & cid & iif(content_rs("cyc"), "回收", "还原") & "成功。", true
            Easp.Alert "文章修改成功！"
        else
            SetLog Username, "文章" & cid & iif(content_rs("cyc"), "回收", "还原") & "失败：数据库错误。", false
            Easp.Alert "文章修改失败：数据库错误！"
        end if
    elseif action = "del" then
        cid = Easp.CheckForm(Easp.Post("cid:n"), "", 1, "非法操作！")
        set content_rs = Easp.db.GRD("content", "cid=" & cid)
        if not Easp.Has(content_rs) then 
            Easp.Alert "没有此文章信息！"
        end if
        
        AdminType_LineAction content_rs("tid"), "count", "- 1"
        result = Easp.db.DR("content", "cid=" & cid)
        if result = 1 then
            SetLog Username, "文章" & cid & "删除成功。", true
            Easp.Alert "文章删除成功！"
        else
            AdminType_LineAction content_rs("tid"), "count", "+ 1"
            SetLog Username, "文章" & cid & "删除失败：数据库错误。", false
            Easp.Alert "文章删除失败：数据库错误！"
        end if
    end if

    ' 读取POST数据    
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
    
    data_arr = array("tid:" & (ptid), "title:" & (ptitle), "content:" & (pcontent), "source:" & (psource), "time:" & (ptime), "hit:" & (phit), "url:" & (purl), "titlecolor:" & (ptitlecolor), "picurl:" & (ppicurl), "author:" & (pauthor), "istj:" & (pistj), "isflash:" & (pisflash), "ispic:" & (pispic))

    select case action
        case "add"        
            'echo ptid & endl & ptitle & endl & pcontent & endl & psource & endl & ptime & endl & phit & endl & purl & endl & ptitlecolor & endl & ppicurl & endl & pauthor & endl & pistj & endl & pisflash & endl & pispic & endl
            
            'dim w_w : w_w = Easp.db.wAR("type", data_arr)
            'echo w_w & endl
            
            data_result = Easp.db.AR("content", data_arr)
            
            if data_result = 1 then
                AdminType_LineAction ptid, "count", "+ 1"
            
                SetLog Username, "文章添加成功。", true
                Easp.Alert "文章添加成功！"
            else
                SetLog Username, "文章添加失败：数据库错误。", false
            end if
        case "edit"
            dim old_tid
            cid = Easp.CheckForm(Easp.Post("cid:n"), "", 1, "非法操作！")
            set content_rs = Easp.db.GRD("content", "cid=" & cid)
            if not Easp.Has(content_rs) then 
                Easp.Alert "没有此文章信息！"
            end if
            old_tid = content_rs("tid")
                        
            data_result = Easp.db.UR("content", "cid=" & cid, data_arr)
            
            if data_result = 1 then
                AdminType_LineAction old_tid, "count", "- 1"
                AdminType_LineAction ptid, "count", "+ 1"
                
                SetLog Username, "文章" & cid & "修改成功。", true
                Easp.Alert "文章修改成功！"
            else
                SetLog Username, "文章" & cid & "修改失败：数据库错误。", false
                Easp.Alert "文章修改失败：数据库错误！"
            end if
        case else
            Easp.Alert "非法操作！"
    end select
%>
