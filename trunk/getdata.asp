<!--#include file="config.asp" -->
<%
    '--------------------------
    ' * 获取数据
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
    
    dim action : action = Easp.CheckForm(Easp.Get("action:s"), "", 1, "错误的页面！")
    dim text : text = ""
    
    dim content_rs, ptid
    
    select case action
        case "flash_xml"
            ptid = Easp.CheckForm(Easp.Get("tid:n:-1"), "", 0, "错误的栏目！")
            
            set content_rs = get_art_list(ptid, 7, "幻灯")
            text = "<?xml version=""1.0"" encoding=""utf-8""?>" & enter
            text = text & "<bcaster autoPlayTime=""3"">" & enter
            while not content_rs.Eof
                text = text & "    <item link="""
                text = text & iif(content_rs("url") <> "", content_rs("url"), Root & "content.asp?id=" & content_rs("cid"))
                text = text & """ itemtitle="""
                text = text & content_rs("title")
                text = text & """ item_url="""
                text = text & content_rs("picurl")
                text = text & """>" & enter & "    </item>" & enter
            
                content_rs.MoveNext
            wend
            text = text & "</bcaster>"
            
            echo text
    end select
%>
