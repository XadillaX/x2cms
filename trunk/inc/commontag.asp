<%
	'--------------------------
	' * 通用标签文件
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
	
	Sub CommonTags()
		' 系统信息
		Easp.Tpl "__sysname__", sys_name					' 系统名称
		Easp.Tpl "__sysver__", sys_ver						' 系统版本
		Easp.Tpl "__sysauthor__", sys_author				' 系统作者
		Easp.Tpl "__sysweb__", sys_web						' 系统官网
		Easp.Tpl "__syspubdate__", sys_pubdate				' 系统发布时间
	
		' 站点配置
		Easp.Tpl "__webname__", WebName						' 网站名称
		Easp.Tpl "__root__", Root							' 网站根目录
		Easp.Tpl "__skinpath__", Easp.tpl.FilePath			' 皮肤目录
		Easp.Tpl "__viscount__", VisCount					' 站点计数器
		Easp.Tpl "__beian__", BeiAn							' 备案信息
		Easp.Tpl "__copyright__", Copyright					' 版权信息
		Easp.Tpl "__webtitle__", WebTitle					' 网站标题标签
		Easp.Tpl "__keyword__", MetaKeyword					' 关键字
		Easp.Tpl "__description__", MetaDescription			' 描述
		Easp.Tpl "__countcode__", CountCode					' 流量代码
		
		' 联系信息
		Easp.Tpl "__cname__", Contact_Info("cname")			' 公司名称
		Easp.Tpl "__zip__", Contact_Info("czip")			' 公司邮编
		Easp.Tpl "__phone__", Contact_Info("cphone")		' 公司电话
		Easp.Tpl "__fax__", Contact_Info("cfax")			' 公司传真
		Easp.Tpl "__email__", Contact_Info("cemail")		' 公司电子邮箱
		Easp.Tpl "__qq__", Contact_Info("cqq")				' 公司邮编
		Easp.Tpl "__qqname__", Contact_Info("cqqname")		' 客服QQ
		Easp.Tpl "__address__", Contact_Info("caddress")	' 公司地址
		
		' 主栏目
		dim type_rs
		set type_rs = Easp.db.GR("type", "father=-1", "ord asc")
		while not type_rs.EOF
			Easp.Tpl "__mainnav__.type", type_rs("type")
			Easp.Tpl "__mainnav__.count", type_rs("count")
			Easp.Tpl "__mainnav__.ord", type_rs("ord")
			Easp.Tpl "__mainnav__.pagecode", type_rs("pagecode")
			Easp.Tpl "__mainnav__.url", Root & "\?p=" & type_rs("typeurl")
			
			type_rs.MoveNext
			Easp.Tpl.Update "__mainnav__"
		wend
	End Sub
%>
