<%
    '--------------------------
    ' * 通用变量
    ' * By XadillaX
    ' * http://xcoder.in
    '--------------------------
    
    Easp.Tpl.AspEnable = True
	Easp.Tpl.TagUnknown = "remove"
    
    ' 常用辅助常量
    dim endl, enter
    endl = "<br />"
	enter = Chr(13) & Chr(10)
    
    ' 模板默认设置
    dim tpl_index, tpl_contact, tpl_single_page, tpl_art_list, tpl_content
    tpl_index           = "index.tpl"
    tpl_contact         = "contact.tpl"
    tpl_single_page     = "single.tpl"
    tpl_art_list        = "artlist.tpl"
	tpl_content         = "content.tpl"
    
    dim i, j, k
    dim result
    dim WebName, Root, Skin, VisCount, BeiAn, Copyright, WebTitle, MetaKeyword, MetaDescription, CountCode
    dim g_config_rs
    dim Contact_Info
    g_config_rs         = Easp.db.GRD("config", "id=1")
    Contact_Info        = Easp.db.GRD("contact", "cid=1")
    
    WebName             =    g_config_rs("webname")
    Root                =    g_config_rs("root") & "/"
    Skin                =    g_config_rs("skin")
    BeiAn               =    "<a href='http://www.miibeian.gov.cn/' target='_blank'>" & g_config_rs("beian") & "</a>"
    Copyright           =    g_config_rs("copyright") & "<br />Powered by &copy;<a href='" & sys_web & "'>" & sys_name & "</a> " & sys_ver
    WebTitle            =    g_config_rs("webtitle")
    MetaKeyword         =    g_config_rs("keyword")
    MetaDescription     =    g_config_rs("description")
    CountCode           =    g_config_rs("countcode")
    
    VisCount            =    g_config_rs("viscount") + 1
    result = Easp.db.UR("config", "id=1", Array("viscount:" & VisCount))
    if result = 0 Then
        VisCount = VisCount - 1
    End If
    
    Easp.tpl.FilePath   =    WebPath & SkinPath & Skin
%>
