<%
    '---------------------
    ' X2CMS 模板默认参数示例
    '---------------------
    
    ' 可在这个页面加上一些自己的默认变量，但不要与X2CMS变量冲突，如
    ' dim tpl_author : set tpl_author = "XadillaX"
	
	Easp.Tpl "__commflash__", get_flash(23, 166, 143)
	set_art_detail_get 23, 4, "", "__commlist__", 10
%>
