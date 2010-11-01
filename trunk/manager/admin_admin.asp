<%
	'--------------------------
	' * 管理员列表
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	dim Page, rs, PageTitle
	PageTitle = "管理员列表"	
	Easp.db.PageSize = 15							' 分页数量
	
	' 得到页码，默认为0
	Page = Easp.Get("page:n,:0")
	
	' 获取分页
	set rs = Easp.db.GetPageRecord(0, Array("admin", "", "aid desc"))
%>
<!--#include file="admin_common_top.asp" -->

<table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <tr class="table_title">
        <td width="8%" valign="middle">编号</td>
        <td width="27%" valign="middle">用户名</td>
        <td width="10%" valign="middle">编辑</td>
        <td width="9%" valign="middle">超管</td>
        <td width="23%" valign="middle">登录时间</td>
        <td width="23%" valign="middle">登录IP</td>
    </tr>
    <%	
		for i = 1 to rs.PageSize
			if rs.Eof then exit for
	%>
    <tr class="table_row <%=iif(i mod 2 = 1, "table_row_clr_1", "table_row_clr_2")%>">
        <td><%=rs("aid")%></td>
        <td><%=rs("username")%></td>
        <td><a href="admin_admin_edit.asp?aid=<%=rs("aid")%>">编辑</a></td>
        <td><span class="hint"><%=iif(rs("superadmin") = true, "√", "×")%></span></td>
        <td><%=rs("logintime")%></td>
        <td><%=rs("loginip")%></td>
    </tr>
    <%
			rs.MoveNext()
		next
	%>
    <tr class="table_title">
        <td colspan="6"><%=Easp.db.GetPager("default")%></td>
    </tr>
</table>
<!--#include file="admin_common_footer.asp" -->