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
    dim type_tmp_rs, type_arr : set type_arr = Easp.List.new
    PageTitle = "内容列表"    
    Easp.db.PageSize = 15
    
    ' 分类数组
    j = 1
    set type_tmp_rs = Easp.db.GR("type", "", "tid asc")
    type_arr.push("-")
    while not type_tmp_rs.EOF
        for i = j to type_tmp_rs("tid") - 1
            type_arr.push("-")
        next
        type_arr.push(type_tmp_rs("type"))
        j = type_tmp_rs("tid") + 1
        type_tmp_rs.MoveNext
    wend
    'for i = 1 to j - 1
    '    echo type_arr(i) & endl
    'next    
    
    ' 设置分类
    ptid = Easp.Get("tid:n:-1")
    
    if cstr(ptid) <> cstr(-1) then SQLStr = "tid=" & ptid
    
    ' 获取分页
    set rs = Easp.db.GetPageRecord("array", Array("content", SQLStr, "time desc"))
%>
<!--#include file="admin_common_top.asp" -->
<script type="text/javascript">
$(function(){
    /* Init the dialog */
    $("#del_con").dialog();
    $("#del_con").dialog('close');    
});

function do_del_submit()
{
    $("#del_con_form").submit();
}

function cfm_del(cid, title)
{
    $("#del_con_cid").val(cid);
    
    /* Open dialog */
    $("#del_con").dialog({
        title: '删除文章 - ' + cid + ". " + title,
        buttons:[{
            text:'确定',
            iconCls:'icon-ok',
            handler:function(){
                setTimeout("do_del_submit()", 0);
            }
        },{
            text:'取消',
            handler:function(){
                $('#del_con').dialog('close');
            }
        }]
    });    
}
</script>
<table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <tr class="table_title">
        <td width="10%" valign="middle">编号</td>
        <td width="25%" valign="middle">标题(阅读) <a href="admin_content_content.asp?action=add&tid=<%=ptid%>">添加</a></td>
        <td width="15%" valign="middle">栏目</td>
        <td width="15%" valign="middle">加入时间</td>
        <td width="11%" valign="middle">发布者</td>
        <td width="24%" valign="middle">操作</td>
    </tr>
    <%    
        for i = 1 to rs.PageSize
            if rs.Eof then exit for
    %>
    <tr class="table_row <%=iif(i mod 2 = 1, "table_row_clr_1", "table_row_clr_2")%><%=iif(rs("cyc"), " table_content_cyc", "")%>">
        <td width="10%" valign="middle"><%=rs("cid")%></td>
        <td width="25%" valign="middle">
            <a href="admin_content_content.asp?action=edit&cid=<%=rs("cid")%>" <%=iif(rs("titlecolor") <> "", "style=""color: " & rs("titlecolor") & ";""", "")%> title="<%=rs("title")%>">
                <%=iif(rs("istj"), "<span class='hint'>[荐]</span>", "")%>
                <%=iif(rs("ispic"), "<span class='hint'>[图]</span>", "")%>
                <%=iif(rs("isflash"), "<span class='hint'>[幻]</span>", "")%>
                <%=GotTopic(rs("title"), 10)%>
            </a>
            (<%=rs("hit")%>)
        </td>
        <td width="15%" valign="middle"><a href="admin_content_list.asp?tid=<%=rs("tid")%>"><%=type_arr(rs("tid"))%></td>
        <td width="15%" valign="middle"><%=rs("time")%></td>
        <td width="11%" valign="middle"><%=rs("author")%></td>
        <td width="24%" valign="middle">
            <a href="admin_content_content.asp?action=edit&cid=<%=rs("cid")%>">编辑</a> /
            <a href="admin_content_content_chkedit.asp?action=cyc&cid=<%=rs("cid")%>"><%=iif(rs("cyc"), "还原", "回收")%></a> / 
            <a href="#" onclick="cfm_del(<%=rs("cid")%>, '<%=rs("title")%>')">删除</a>
        </td>
    </tr>
    <%
            rs.MoveNext()
        next
    %>
    <tr class="table_title">
        <td colspan="6"><%=Easp.db.GetPager("default")%></td>
    </tr>
</table>

<div id="del_con" icon="icon-save" style="width: 360px;">
<form action="admin_content_content_chkedit.asp?action=del" id="del_con_form" method="post">
<div style="margin: 5px 5px 5px 5px;">确定删除？</div>
<input type="hidden" id="del_con_cid" name="cid" value="" />
</form>
</div>
<!--#include file="admin_common_footer.asp" -->