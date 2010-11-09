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
	
	' 得到目录下所有文章
	function get_art_list_by_page(tid, pgsize)
		' 将所有子目录打散到一个数组中
		dim tid_str : tid_str = get_child_type_split(tid)
		dim tid_arr, tid_arr_size, i
		tid_arr = split(tid_str, "|")
		tid_arr_size = Ubound(tid_arr)
		
		' 将SQL条件写入condition
		dim condition : condition = "tid = " & tid
		for i = 0 to tid_arr_size - 1
			condition = condition & " or tid = " & tid_arr(i)
		next
		
		Easp.db.PageSize = pgsize
		
		' 获取结果
		dim tmp_list : set tmp_list = Easp.db.GetPageRecord(0, array("content", condition, "cid desc"))
		' while not tmp_list.EOF
		' 	echo tmp_list("title") & endl
		' 	
		' 	tmp_list.MoveNext
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
		
		dim tmp_list
		set tmp_list = Easp.db.GR("content:" & num, condition, "cid desc")
		set get_art_list = tmp_list
	end function
	
	' 生成幻灯代码
	function get_flash(tid, width, height)
				
	end function
%>