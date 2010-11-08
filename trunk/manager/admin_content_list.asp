<%
	'--------------------------
	' * 内容列表
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	dim ptid, rs, PageTitle, SQLStr : SQLStr = ""
	dim type_arr : set type_arr = new EasyAsp_List
	PageTitle = "内容列表"	
	Easp.db.PageSize = 15
	
	' 设置分类
	ptid = Easp.Get("tid:n:-1")
	
	if cstr(ptid) <> cstr(-1) then SQLStr = "tid=" & ptid
	
	' 获取分页
	set rs = Easp.db.GetPageRecord("array", Array("content", SQLStr, "cid desc"))
%>
<!--#include file="admin_common_top.asp" -->
<table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <tr class="table_title">
        <td width="10%" valign="middle">编号</td>
        <td width="25%" valign="middle">标题(阅读)</td>
        <td width="15%" valign="middle">栏目</td>
        <td width="15%" valign="middle">加入时间</td>
        <td width="11%" valign="middle">发布者</td>
        <td width="24%" valign="middle">操作</td>
    </tr>
    <%	
		for i = 1 to rs.PageSize
			if rs.Eof then exit for
	%>
    <tr class="table_row <%=iif(i mod 2 = 1, "table_row_clr_1", "table_row_clr_2")%>">
        <td width="10%" valign="middle"><%=rs("cid")%></td>
        <td width="25%" valign="middle">
        	<a <%=iif(rs("titlecolor") <> "", "style=""color: " & rs("titlecolor") & ";""", "")%> title="<%=rs("title")%>">
				<%=iif(rs("istj"), "<span class='hint'>[荐]</span>", "")%>
                <%=iif(rs("ispic"), "<span class='hint'>[图]</span>", "")%>
                <%=iif(rs("isflash"), "<span class='hint'>[幻]</span>", "")%>
				<%=GotTopic(rs("title"), 10)%>
            </a>
            (<%=rs("hit")%>)
        </td>
        <td width="15%" valign="middle">栏目</td>
        <td width="15%" valign="middle">加入时间</td>
        <td width="11%" valign="middle">发布者</td>
        <td width="24%" valign="middle">操作</td>
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