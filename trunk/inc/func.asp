<%
    '--------------------------
    ' * 通用函数
    ' * By XadillaX
    ' * http://xcoder.in
    '-------------------------
    
    ' 得到子目录
    function get_child_type_rs(tid)
        dim type_rs : set type_rs = Easp.db.GR("type", "father = " & tid, "ord asc")
        get_child_type_rs = type_rs
    end function
    
    ' 得到子目录ID并放进分割字符串
    function get_child_type_split(tid)
        dim type_rs : set type_rs = Easp.db.GR("type", "father = " & tid, "ord asc")
        while not type_rs.EOF
            get_child_type_split = get_child_type_split & type_rs("tid") & "|"
            get_child_type_split = get_child_type_split & get_child_type_split(type_rs("tid"))
            
            type_rs.MoveNext
        wend
    end function
    
    ' 得到目录下所有文章并且分页
    function get_art_list_by_page(tid, pgsize)
        ' 将所有子目录打散到一个数组中
        dim tid_str : tid_str = get_child_type_split(tid)
        dim tid_arr, tid_arr_size, i
        tid_arr = split(tid_str, "|")
        tid_arr_size = Ubound(tid_arr)
        
        ' 将SQL条件写入condition
        dim condition : condition = "(tid = " & tid
        for i = 0 to tid_arr_size - 1
            condition = condition & " or tid = " & tid_arr(i)
        next
        condition = condition & ") and cyc = false"
        
        Easp.db.PageSize = pgsize
        
        ' 获取结果
        dim tmp_list : set tmp_list = Easp.db.GetPageRecord(0, array("content", condition, "cid desc"))
        ' while not tmp_list.EOF
        '     echo tmp_list("title") & endl
        '     
        '     tmp_list.MoveNext
        ' wend
        
        set get_art_list_by_page = tmp_list
    end function
    
    ' 根据属性获取文章列表
    function get_art_list(tid, num, pro)
        ' 将所有子目录打散到一个数组中
        dim tid_str : tid_str = get_child_type_split(tid)
        dim tid_arr, tid_arr_size, i
        tid_arr = split(tid_str, "|")
        tid_arr_size = Ubound(tid_arr)
        
        ' 将条件写入condition
        dim condition : condition = "(tid = " & tid
        for i = 0 to tid_arr_size - 1
            condition = condition & " or tid = " & tid_arr(i)
        next
        condition = condition & ") "
        
        ' 获取属性数组
        dim pro_arr : pro_arr = split(pro, ",")
        if arr_in(pro_arr, "推荐") then condition = condition & "and istj = true "
        if arr_in(pro_arr, "图片") then condition = condition & "and ispic = true "
        if arr_in(pro_arr, "幻灯") then condition = condition & "and isflash = true "
        condition = condition & "and cyc = false "
        
        dim tmp_list
        set tmp_list = Easp.db.GR("content:" & num, condition, "cid desc")
        set get_art_list = tmp_list
    end function
    
    ' 生成幻灯代码
    function get_flash(tid, width, height)
        dim tmp_str
        tmp_str = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' id=scriptmain name=scriptmain codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0"" width=""" & width & """ height=""" & height & """>"
        tmp_str = tmp_str & "<param name=""movie"" value=""" & Root & "images/flash_news.swf?bcastr_xml_url=" & Root & "getdata.asp?action=flash_xml&tid=" & tid & """>"
        tmp_str = tmp_str & "<param name=""quality"" value=""high"">"
        tmp_str = tmp_str & "<param name='wmode' value='transparent' />"
        tmp_str = tmp_str & "<param name=scale value=noscale>"
		tmp_str = tmp_str & "<param name=""LOOP"" value=""false"">"
		tmp_str = tmp_str & "<param name=""menu"" value=""false"">"
        tmp_str = tmp_str & "<embed src='"
        tmp_str = tmp_str & Root & "images/flash_news.swf?bcastr_xml_url=" & Root & "getdata.asp?action=flash_xml&tid=" & tid
        tmp_str = tmp_str & "' quality='high' wmode='transparent' bgcolor='#ffffff' width='" & width & "' height='" & height & "' align='middle' allowScriptAccess='sameDomain' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"
        tmp_str = tmp_str & "</object>"
        
        get_flash = tmp_str
    end function
	
	' 截取字符串
	function gotTopic(str,strlen)
		if str="" then
			gotTopic=""
			exit function
		end if
		dim l,t,c, i
		str=replace(replace(replace(replace(str,"&nbsp;"," "),"&quot;",chr(34)),"&gt;",">"),"&lt;","<")
		l=len(str)
		t=0
		for i=1 to l
			c=Abs(Asc(Mid(str,i,1)))
			if c>255 then
				t=t+2
			else
				t=t+1
			end if
			if t>=strlen then
				gotTopic=left(str,i) & "..."
				exit for
			else
				gotTopic=str
			end if
		next
		gotTopic=replace(replace(replace(replace(gotTopic," ","&nbsp;"),chr(34),"&quot;"),">","&gt;"),"<","&lt;")
	end function
	
	' 设置文章标签
	sub set_art_detail_get(tid, num, pro, tag, cut)
		if cut = 0 then cut = 40
		dim tmp_rs : set tmp_rs = get_art_list(tid, num, pro)
		dim i : i = 0
		while (not tmp_rs.EOF) and (i < num)
			' echo tag & ".shorttitle"
			Easp.Tpl tag & ".shorttitle", gotTopic(tmp_rs("title"), cut)
			Easp.Tpl tag & ".title", tmp_rs("title")
			Easp.Tpl tag & ".content", tmp_rs("content")
			Easp.Tpl tag & ".time", tmp_rs("time")
			Easp.Tpl tag & ".source", tmp_rs("source")
			Easp.Tpl tag & ".hit", tmp_rs("hit")
			Easp.Tpl tag & ".url", iif(tmp_rs("url") <> "", tmp_rs("url"), "content.asp?id=" & tmp_rs("cid"))
			Easp.Tpl tag & ".picurl", tmp_rs("picurl")
			Easp.Tpl tag & ".author", tmp_rs("author")
			Easp.Tpl tag & ".istj", tmp_rs("istj")
			Easp.Tpl tag & ".ispic", tmp_rs("ispic")
			Easp.Tpl tag & ".isflash", tmp_rs("isflash")
			
			' Easp.W xsjl("title")
			i = i + 1
			
			tmp_rs.MoveNext
			Easp.Tpl.Update tag
		wend
	end sub
%>
