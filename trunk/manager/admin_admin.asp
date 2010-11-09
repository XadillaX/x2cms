<%
	'--------------------------
	' * 管理员列表
	' * By XadillaX
	' * http://xcoder.in
	'--------------------------
%>
<!--#include file="admin_common.asp" -->
<%
	dim rs, PageTitle
	PageTitle = "管理员列表"	
	Easp.db.PageSize = 15							' 分页数量
	
	' 获取分页
	set rs = Easp.db.GetPageRecord(0, Array("admin", "", "aid desc"))
%>
<!--#include file="admin_common_top.asp" -->

<script type="text/javascript">
$(function(){
	/* Init the dialog */
	$("#edit_admin").dialog();
	$("#edit_admin").dialog('close');
	$("#del_admin").dialog();
	$("#del_admin").dialog('close');
});

function open_del_dialog(username, aid)
{
	$("#del_admin_aid").val(aid);
	
	/* Open dialog */
	$("#del_admin").dialog({
		title: '删除管理员 - ' + username,
		buttons:[{
			text:'确定',
			iconCls:'icon-ok',
			handler:function(){
				$("#del_admin_form").submit();
			}
		},{
			text:'取消',
			handler:function(){
				$('#del_admin').dialog('close');
			}
		}]
	});	
}

function open_edit_dialog(username, aid, issuper)
{
	/* Change the value of text or inputs */
	$("#edit_acmin_username").html(username);
	$("#edit_admin_un").val(username);
	$("#edit_admin_aid").val(aid);
	if(issuper) 
	{
		$("#RadioGroup1_2").attr("checked", " "); 
		$("#RadioGroup1_3").removeAttr("checked"); 
	}
	else
	{
		$("#RadioGroup1_3").attr("checked", " "); 
		$("#RadioGroup1_2").removeAttr("checked"); 
	}
	
	/* Open dialog */
	$("#edit_admin").dialog({
		title: '修改管理员 - ' + username,
		buttons:[{
			text:'修改',
			iconCls:'icon-ok',
			handler:function(){
				$("#edit_admin_form").submit();
			}
		},{
			text:'取消',
			handler:function(){
				$('#edit_admin').dialog('close');
			}
		}]
	});	
}
</script>

<table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <tr class="table_title">
        <td width="6%" valign="middle">编号</td>
        <td width="21%" valign="middle">用户名</td>
        <td width="10%" valign="middle">编辑 / 删除</td>
        <td width="5%" valign="middle">超管</td>
        <td width="13%" valign="middle">登录次数</td>
        <td width="23%" valign="middle">登录时间</td>
        <td width="22%" valign="middle">登录IP</td>
    </tr>
    <%	
		for i = 1 to rs.PageSize
			if rs.Eof then exit for
	%>
    <tr class="table_row <%=iif(i mod 2 = 1, "table_row_clr_1", "table_row_clr_2")%>">
        <td><%=rs("aid")%></td>
        <td><%=rs("username")%></td>
        <td><a href="#" onclick="open_edit_dialog('<%=rs("username")%>', '<%=rs("aid")%>', <%=iif(rs("superadmin") = true, "true", "false")%>)">编辑</a> / 
        <a href="#" onclick="open_del_dialog('<%=rs("username")%>', '<%=rs("aid")%>')">删除</a></td>
        <td><span class="hint"><%=iif(rs("superadmin") = true, "√", "×")%></span></td>
        <td><%=rs("logintimes")%></td>
        <td><%=rs("logintime")%></td>
        <td><%=rs("loginip")%></td>
    </tr>
    <%
			rs.MoveNext()
		next
	%>
    <tr class="table_title">
        <td colspan="7"><%=Easp.db.GetPager("default")%></td>
    </tr>
</table>
<div class="hr"></div>
<fieldset class="admin_fieldset">
	<legend class="admin_legend">添加管理员</legend>
    <div>
    <form action="admin_admin_chkedit.asp?action=add" method="post">
    	<table style="border-top: 1px #ccc solid; margin-top: 10px; margin-bottom: 10px;" class="mytable"  border="0" cellspacing="0" cellpadding="0">
    <tr class="table_ipt_tr">
        <td width="19%" class="t_r">用户名：</td>
        <td width="3%">&nbsp;</td>
        <td width="78%"><input type="text" name="username" id="username" class="ipt" /></td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">密码：</td>
        <td>&nbsp;</td>
        <td><input type="password" name="password" id="password" class="ipt" /></td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">重复密码：</td>
        <td>&nbsp;</td>
        <td><input type="password" name="cfmpwd" id="cfmpwd" class="ipt" /></td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">权限：</td>
        <td>&nbsp;</td>
        <td>
        	<label><input type="radio" name="RadioGroup1" value="Superadmin" id="RadioGroup1_0" />超级管理员</label>
    	    <label><input type="radio" checked name="RadioGroup1" value="Normaladmin" id="RadioGroup1_1" />普通录入员</label>
        </td>
    </tr>
    	    <tr class="table_ipt_tr"> </tr>
    	    <tr class="table_btn_tr">
    	        <td colspan="3"><input class="btn" type="submit" name="submit" id="submit" value="确认添加" />
            <input class="btn" type="reset" name="reset" id="reset" value="重新填写" /></td>
   	        </tr>
	    </table>
</form>
    </div>
</fieldset>

<div id="del_admin" icon="icon-save" style="width: 360px;">
<form action="admin_admin_chkedit.asp?action=del" id="del_admin_form" method="post">
<div style="margin: 5px 5px 5px 5px;">确定删除？</div>
<input type="hidden" id="del_admin_aid" name="aid" value="" />
</form>
</div>

<div id="edit_admin" icon="icon-save">
    <form action="admin_admin_chkedit.asp?action=edit" id="edit_admin_form" method="post">
    	<table style="border-top: 1px #ccc solid; margin-top: 10px; margin-bottom: 10px;" class="mytable"  border="0" cellspacing="0" cellpadding="0">
    <tr class="table_ipt_tr">
        <td width="19%" class="t_r">用户名：</td>
        <td width="2%">
        	<input type="hidden" id="edit_admin_aid" name="aid" value="" />
            <input type="hidden" id="edit_admin_un" name="un" value="xxx" />
        	&nbsp;
        </td>
        <td width="79%" id="edit_acmin_username">&nbsp;</td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">密码：</td>
        <td>&nbsp;</td>
        <td><input type="password" name="password" id="password" class="ipt" /></td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">重复：</td>
        <td>&nbsp;</td>
        <td><input type="password" name="cfmpwd" id="cfmpwd" class="ipt" /></td>
    </tr>
    <tr class="table_ipt_tr">
        <td class="t_r">权限：</td>
        <td>&nbsp;</td>
        <td>
        	<label><input type="radio" name="RadioGroup2" value="Superadmin" id="RadioGroup1_2" />超级管理员</label>
    	    <label><input type="radio" name="RadioGroup2" value="Normaladmin" id="RadioGroup1_3" />普通录入员</label>
        </td>
    </tr>
	    </table>
       </form>

</div>
<!--#include file="admin_common_footer.asp" -->