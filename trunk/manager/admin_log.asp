<%
	'--------------------------
	' * 操作日志
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	dim Page, rs, PageTitle
	PageTitle = "操作日志"	
	Easp.db.PageSize = 15							' 分页数量
	
	' 得到页码，默认为0
	Page = Easp.Get("page:n,:0")
	
	' 获取分页
	set rs = Easp.db.GetPageRecord(0, Array("admin_log", "", "time desc"))
%>
<!--#include file="admin_common_top.asp" -->

<div class="hint" style="margin-left: auto; margin-right: auto; width: 98%;">*注：红色为错误操作日志，绿色为正确操作日志。</div>
<table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <tr class="table_title">
        <td width="11%" valign="middle">编号</td>
        <td width="15%" valign="middle">用户名</td>
        <td width="41%" valign="middle">操作内容</td>
        <td width="16%" valign="middle">操作时间</td>
        <td width="17%" valign="middle">操作IP</td>
    </tr>
    <%	
		for i = 1 to rs.PageSize
			if rs.Eof then exit for
	%>
    <tr class="table_row <%=iif(i mod 2 = 1, "table_row_clr_1", "table_row_clr_2")%>">
        <td><%=rs("lid")%></td>
        <td><%=rs("username")%></td>
        <td><div style="-moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius: 5px;max-height: 60px; overflow-x: auto; overflow-y: auto; color: <%=iif(rs("right") = true, "#00cc00", " #ff0000")%>; padding: 5px 5px 5px 5px; border: #ddd 1px solid; background: #fff; margin: 2px 2px 2px 2px;"><%=rs("logtext")%></div></td>
        <td><%=rs("time")%></td>
        <td><%=rs("ip")%></td>
    </tr>
    <%
			rs.MoveNext()
		next
	%>
    <tr class="table_title">
        <td colspan="5"><%=Easp.db.GetPager("default")%></td>
    </tr>
</table>
<!--#include file="admin_common_footer.asp" -->