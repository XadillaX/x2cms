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
            
            set content_rs = get_art_list(ptid, 5, "幻灯")
            text = "<?xml version=""1.0"" encoding=""utf-8""?>"
            text = text & enter & "<data>" & enter & "    <channel>" & enter
            while not content_rs.Eof
                text = text & "        <item>" & enter & "            <link>"
                text = text & iif(content_rs("url") <> "", content_rs("url"), Root & "content.asp?id=" & content_rs("cid"))
                text = text & "</link>" & enter & "            <image>"
                text = text & content_rs("picurl")
                text = text & "</image>" & enter & "            <title>"
                text = text & content_rs("title")
                text = text & "</title>" & enter & "        </item>" & enter
            
                content_rs.MoveNext
            wend
            text = text & "    </channel>" & enter 
			text = text & "<config><roundCorner>0</roundCorner><autoPlayTime>8</autoPlayTime><isHeightQuality>false</isHeightQuality><blendMode>normal</blendMode><transDuration>1</transDuration><windowOpen>_self</windowOpen><btnSetMargin>auto 5 5 auto</btnSetMargin><btnDistance>20</btnDistance><titleBgColor>0xff6600</titleBgColor><titleTextColor>0xffffff</titleTextColor><titleBgAlpha>.75</titleBgAlpha><titleMoveDuration>1</titleMoveDuration><btnAlpha>.7</btnAlpha>	<btnTextColor>0xffffff</btnTextColor>	<btnDefaultColor>0x1B3433</btnDefaultColor><btnHoverColor>0xff9900</btnHoverColor><btnFocusColor>0xff6600</btnFocusColor><changImageMode>click</changImageMode>"
		    text = text & "<isShowBtn>true</isShowBtn><isShowTitle>true</isShowTitle><scaleMode>noBorder</scaleMode><transform>blur</transform><isShowAbout>true</isShowAbout><titleFont>微软雅黑</titleFont></config>"
			text = text & "</data>"
            
            echo text
    end select
%>
