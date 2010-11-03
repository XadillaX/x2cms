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
	PageTitle = "栏目列表"	
	
	' 获取数据
	set rs = Easp.db.GR("type", "father=-1", "ord asc")
%>
<!--#include file="admin_common_top.asp" -->

<script type="text/javascript">
</script>

<table class="mytable" border="0" cellspacing="0" cellpadding="0">
    <tr class="table_title">
        <td width="6%" valign="middle">编号</td>
        <td width="35%" valign="middle">栏目名称</td>
        <td width="15%" valign="middle">编辑 / 删除</td>
        <td width="7%" valign="middle">单页</td>
        <td width="7%" valign="middle">统计</td>
        <td width="22%" valign="middle">GET值</td>
        <td width="8%" valign="middle">排序</td>
    </tr>
    <%	
		for i = 1 to rs.PageSize
			if rs.Eof then exit for
				echo AdminType_GetThisType(rs, 0)
			rs.MoveNext()
		next
	%>
</table><!--
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
    	        <td colspan="3"><input class="btn" type="submit" name="submit" id="submit" value="确认修改" />
            <input class="btn" type="reset" name="reset" id="reset" value="重新填写" /></td>
   	        </tr>
	    </table>
</form>
    </div>
</fieldset>-->
<!--#include file="admin_common_footer.asp" -->