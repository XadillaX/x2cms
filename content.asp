<!--#include file="config.asp" -->
<%
    '--------------------------
    ' * 文章内容页
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
    
    dim cid, content_rs, pre_rs, next_rs
    cid = Easp.CheckForm(Easp.Get("id:n"), "", 1, "错误的文章！")
    
    ' 读取记录
    set content_rs = Easp.db.GRD("content", "cid=" & cid & " and cyc=false")
    if not Easp.Has(content_rs) then Easp.Alert "没有这篇文章！"
    if content_rs("url") <> "" then Easp.AlertUrl "这是一篇外链文章，点击确定以跳转。", content_rs("url")
    
    dim hit : set hit = content_rs("hit")
    hit = hit + 1
    
    Easp.Tpl.Load tpl_content
    
    ' 这篇文章
    Easp.Tpl "__tid__", content_rs("tid")
    Easp.Tpl "__title__", content_rs("title")
    Easp.Tpl "__content__", content_rs("content")
    Easp.Tpl "__source__", content_rs("source")
    Easp.Tpl "__publictime__", content_rs("time")
    Easp.Tpl "__hit__",  hit
    Easp.Tpl "__titlecolor__", content_rs("titlecolor")
    Easp.Tpl "__picurl__", content_rs("picurl")
    Easp.Tpl "__author__", content_rs("author")
    
    Easp.Tpl "__pre__.text", "上一篇没有了"
    Easp.Tpl "__next__.text", "下一篇没有了"
    
    ' 上一篇
    set pre_rs = Easp.db.GR("content", "cid<" & cid & " and cyc = false and tid=" & content_rs("tid"), "cid desc")
    if Easp.Has(pre_rs) then
        Easp.Tpl "__pre__.cid", pre_rs("cid")
        Easp.Tpl "__pre__.tid", pre_rs("tid")
        Easp.Tpl "__pre__.title", pre_rs("title")
        Easp.Tpl "__pre__.content", pre_rs("content")
        Easp.Tpl "__pre__.source", pre_rs("source")
        Easp.Tpl "__pre__.publictime", pre_rs("time")
        Easp.Tpl "__pre__.hit",  pre_rs("hit")
        Easp.Tpl "__pre__.titlecolor", pre_rs("titlecolor")
        Easp.Tpl "__pre__.picurl", pre_rs("picurl")
        Easp.Tpl "__pre__.author", pre_rs("author")
        Easp.Tpl "__pre__.text", "<a href=""" & Root & "content.asp?id=" & pre_rs("cid") & """>" & pre_rs("title") & "</a>"
    end if
    
    ' 下一篇
    set next_rs = Easp.db.GR("content", "cid>" & cid & " and cyc = false and tid=" & content_rs("tid"), "cid asc")
    if Easp.Has(next_rs) then
        Easp.Tpl "__next__.cid", next_rs("cid")
        Easp.Tpl "__next__.tid", next_rs("tid")
        Easp.Tpl "__next__.title", next_rs("title")
        Easp.Tpl "__next__.content", next_rs("content")
        Easp.Tpl "__next__.source", next_rs("source")
        Easp.Tpl "__next__.publictime", next_rs("time")
        Easp.Tpl "__next__.hit",  next_rs("hit")
        Easp.Tpl "__next__.titlecolor", next_rs("titlecolor")
        Easp.Tpl "__next__.picurl", next_rs("picurl")
        Easp.Tpl "__next__.author", next_rs("author")
        Easp.Tpl "__next__.text", "<a href=""" & Root & "content.asp?id=" & next_rs("cid") & """>" & next_rs("title") & "</a>"
    end if
    
    ' 导航字符串
    dim f_type_rs, map_str, type_rs
    set type_rs = Easp.db.GRD("type", "tid=" & content_rs("tid"))
    map_str = ""
    f_type_rs = type_rs
    while cstr(f_type_rs("father")) <> cstr(-1)
        map_str = " » <a href='" & Root & "\?p=" & f_type_rs("typeurl") & "'>" & f_type_rs("type") & "</a>" & map_str
        f_type_rs = Easp.db.GRD("type", "tid=" & f_type_rs("father"))
    wend
    map_str = "<a href='" & Root & "\?p=" & f_type_rs("typeurl") & "'>" & f_type_rs("type") & "</a>" & map_str
    Easp.Tpl "__mapstr__", map_str
    
    ' 特有标记
    Easp.Tpl "__typetitle__", type_rs("type")
    Easp.Tpl "__typeurl__", type_rs("typeurl")
    Easp.Tpl "__count__", type_rs("count")
    Easp.Tpl "__roottitle__", f_type_rs("type")
    Easp.Tpl "__roottid__", f_type_rs("tid")
    Easp.Tpl "__roottypeurl__", f_type_rs("typeurl")
    Easp.Tpl "__rootcount__", f_type_rs("count")
    
    result = Easp.db.UR("content", "cid=" & cid, array("hit:" & hit))
    
    CommonTags()
    Easp.Tpl.Show()
%>